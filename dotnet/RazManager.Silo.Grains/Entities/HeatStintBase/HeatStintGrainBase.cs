using Microsoft.Extensions.Logging;
using Orleans.Streams;
using Razmanager.Protobuf.Internal.Repository.Silo.SystemServices.TrackConfiguration;
using Razmanager.Protobuf.Public.V1;
using System.Diagnostics;
using System.Resources;


namespace RazManager.Silo.Grains.Entities.HeatStint
{
    public abstract class HeatStintGrainBase : Grain
    {
        protected readonly Razmanager.Protobuf.Internal.Repository.SystemServices.Event.EventService.EventServiceClient eventServiceClient;
        protected readonly Razmanager.Protobuf.Internal.Repository.SystemServices.Race.RaceService.RaceServiceClient raceServiceClient;
        protected Razmanager.Protobuf.Public.V1.Event? @event;
        protected Razmanager.Protobuf.Public.V1.Race? race;
        protected byte trackLaptimeDecimals;
        protected string trackLaptimeDecimalsFormat = "F2";

        protected Razmanager.Protobuf.Internal.Repository.SystemServices.HeatStintJournal.HeatStintJournalState? heatStintJournalState;
        protected Dictionary<byte, IndicatorState> indicators = [];
        protected Dictionary<IndicatorTimeTypeId, (byte? IndicatorId, double? Time)> _timeTypeFastestTimes = [];
        protected HeatAnalyses heatAnalyses = new();
        protected HeatAnalyses heatAnalysesDelta = new();
        protected Dictionary<byte, Dictionary<byte, Queue<HeatAnalysisGap>>> _heatAnalysesGaps = [];

        protected Guid? correlationId;
        protected bool _unsubscribe = false;

        protected IDisposable? _startLightDisposable;
        protected IDisposable? _offDisposable;

        protected IAsyncStream<TrackConfigurationDeviceConfigurationInputs>? trackConfigurationDeviceConfigurationInputsStream;
        //private IAsyncStream<DetailState>? _heatWithoutStintStateStream;
        //private IAsyncStream<HeatWithoutStintLeaderboard>? _heatWithoutStintLeaderboardStream;
        //private IAsyncStream<HeatAnalyses>? _heatAnalysesStream;
        private Dictionary<byte, IAsyncStream<HeatStintAnalysis>?> _heatStintAnalysisStreams = [];

        private readonly ILogger<HeatStintGrainBase> _logger;


        public HeatStintGrainBase(Razmanager.Protobuf.Internal.Repository.SystemServices.Event.EventService.EventServiceClient eventServiceClient, 
                                  Razmanager.Protobuf.Internal.Repository.SystemServices.Race.RaceService.RaceServiceClient raceServiceClient,                                    
                                  ILogger<HeatStintGrainBase> logger)
        {
            this.eventServiceClient = eventServiceClient;
            this.raceServiceClient = raceServiceClient;
            _logger = logger;
        }


        protected async Task OnActivateBaseAsync(
            byte trackLaptimeDecimals,
            IEnumerable<Razmanager.Protobuf.Internal.Repository.SystemServices.HeatStintJournal.HeatStintJournal> heatStintJournals
        )
        {
            var stopwatch = new Stopwatch();
            stopwatch.Restart();

            this.trackLaptimeDecimals = trackLaptimeDecimals;
            this.trackLaptimeDecimalsFormat = "F" + this.trackLaptimeDecimals;

            InitializeIndicators();

            if (heatStintJournals.Any())
            {
                foreach (var heatStintJournal in heatStintJournals)
                {
                    heatStintJournalState = heatStintJournal.HeatStintJournalState;

                    switch (heatStintJournal.UpdateTypeCase)
                    {
                        case Razmanager.Protobuf.Internal.Repository.SystemServices.HeatStintJournal.HeatStintJournal.UpdateTypeOneofCase.HeatStintStateTypeId:
                            TransitionStateHeatStintStateType(heatStintJournal.HeatStintStateTypeId);
                            break;

                        case Razmanager.Protobuf.Internal.Repository.SystemServices.HeatStintJournal.HeatStintJournal.UpdateTypeOneofCase.DeviceConfigurationInputs:
                            TransitionStateDeviceConfigurationInputs(heatStintJournal.DeviceConfigurationInputs, true);
                            break;

                        default:
                            throw new ArgumentException($"Unhandled heatStintJournal.UpdateTypeCase: {heatStintJournal.UpdateTypeCase.GetType()}", nameof(heatStintJournal.UpdateTypeCase));
                    }
                }
            }
            else
            {
                heatStintJournalState = new Razmanager.Protobuf.Internal.Repository.SystemServices.HeatStintJournal.HeatStintJournalState
                {
                    Timestamp = Google.Protobuf.WellKnownTypes.Timestamp.FromDateTime(DateTime.UtcNow),
                    HeatStintStateTypeId = Razmanager.Protobuf.Public.V1.DetailStateTypeId.Pending,
                    Ended = false,
                };
            }

            heatAnalysesDelta = new();

            var streamProvider = this.GetStreamProvider(Constants.StreamProvider);
            trackConfigurationDeviceConfigurationInputsStream = streamProvider.GetStream<TrackConfigurationDeviceConfigurationInputs>(Constants.StreamName.TrackConfigurationDeviceConfigurationInputs.ToString(), new Guid(race.TrackConfiguration.Id));

            await TrackConfigurationDeviceInputStreamSubscriptionStateAsync();

            if (heatStintJournalState!.HeatStintStateTypeId == DetailStateTypeId.Countdown ||
                heatStintJournalState!.HeatStintStateTypeId == DetailStateTypeId.CountdownYellow ||
                heatStintJournalState!.HeatStintStateTypeId == DetailStateTypeId.CountdownRed)
            {
                //Console.WriteLine($"++++++++++++++++++++++++++++++++++++++++++{this.GetType().Name} OnActivateAsync Countdown");
            }

            _logger.LogInformation($"{this.GetType().Name} {this.GetPrimaryKey()} OnActivateInternalAsync {stopwatch.Elapsed.TotalSeconds}s");

        }


        protected async Task TrackConfigurationDeviceInputStreamSubscriptionStateAsync()
        {
            var subscriptionHandles = await trackConfigurationDeviceConfigurationInputsStream!.GetAllSubscriptionHandles();
            var subscriptionHandle = subscriptionHandles.FirstOrDefault();

            switch (heatStintJournalState!.HeatStintStateTypeId)
            {
                case DetailStateTypeId.Opened:
                case DetailStateTypeId.Countdown:
                case DetailStateTypeId.Running:
                case DetailStateTypeId.Yellow:
                case DetailStateTypeId.CountdownYellow:
                case DetailStateTypeId.Red:
                case DetailStateTypeId.CountdownRed:
                case DetailStateTypeId.Ended:
                case DetailStateTypeId.Off:
                    if (subscriptionHandle is null)
                    {
                        await trackConfigurationDeviceConfigurationInputsStream.SubscribeAsync(TrackConfigurationDeviceConfigurationInputsAsync);
                    }
                    else
                    {
                        await subscriptionHandle.ResumeAsync(TrackConfigurationDeviceConfigurationInputsAsync);
                    }
                    break;

                case DetailStateTypeId.Pending:
                case DetailStateTypeId.Closed:
                    if (subscriptionHandle is not null)
                    {
                        await subscriptionHandle.UnsubscribeAsync();
                    }
                    break;

                default:
                    throw new ArgumentException($"Unhandled HeatStintStateTypeId: {heatStintJournalState.HeatStintStateTypeId}", nameof(heatStintJournalState.HeatStintStateTypeId));
            }
        }


        //public async Task OnActivateStateAsync()
        //{
        //    await TrackConfigurationDeviceInputStreamSubscriptionStateAsync();

        //    if (State.HeatStateTypeId == HeatStateTypeId.Ended)
        //    {
        //        //_offDisposable = RegisterTimer(_ => Task.Factory.StartNew(() => RaiseEvent(HeatStateTypeId.Off)), null, TimeSpan.FromSeconds(_heat!.TrackLaptimeMaxSeconds), TimeSpan.MaxValue);
        //    }
        //}


        protected abstract void InitializeIndicators();


        public Task<Razmanager.Protobuf.Public.V1.HeatAnalyses> ReadHeatAnalysesAsync()
        {
            return Task.FromResult(heatAnalyses);
        }


        public Task CommandAsync(Razmanager.Protobuf.Public.V1.DetailCommandTypeId heatStintCommandTypeId)
        {
            switch (heatStintCommandTypeId)
            {
                case DetailCommandTypeId.Open:
                    return RaiseHeatStintStateTypeAsync(DetailStateTypeId.Opened);

                case DetailCommandTypeId.Start:
                    if (!(heatStintJournalState!.HeatStintStateTypeId == DetailStateTypeId.Opened ||
                          heatStintJournalState!.HeatStintStateTypeId == DetailStateTypeId.Yellow ||
                          heatStintJournalState!.HeatStintStateTypeId == DetailStateTypeId.Red))
                    {
                        return Task.CompletedTask;
                    }

                    switch (heatStintJournalState!.HeatStintStateTypeId)
                    {
                        case DetailStateTypeId.Yellow:
                            return RaiseHeatStintStateTypeAsync(DetailStateTypeId.CountdownYellow);
                        case DetailStateTypeId.Red:
                            return RaiseHeatStintStateTypeAsync(DetailStateTypeId.CountdownRed);
                        default:
                            return RaiseHeatStintStateTypeAsync(DetailStateTypeId.Countdown);
                    }

                case DetailCommandTypeId.Yellow:
                    if (!(heatStintJournalState!.HeatStintStateTypeId == DetailStateTypeId.Running ||
                          heatStintJournalState!.HeatStintStateTypeId == DetailStateTypeId.Ended))
                    {
                        return Task.CompletedTask;
                    }

                    return RaiseHeatStintStateTypeAsync(DetailStateTypeId.Yellow);

                case DetailCommandTypeId.Red:
                    if (!(heatStintJournalState!.HeatStintStateTypeId == DetailStateTypeId.Running ||
                          heatStintJournalState!.HeatStintStateTypeId == DetailStateTypeId.Countdown ||
                          heatStintJournalState!.HeatStintStateTypeId == DetailStateTypeId.Yellow ||
                          heatStintJournalState!.HeatStintStateTypeId == DetailStateTypeId.CountdownYellow ||
                          heatStintJournalState!.HeatStintStateTypeId == DetailStateTypeId.CountdownRed ||
                          heatStintJournalState!.HeatStintStateTypeId == DetailStateTypeId.Ended))
                    {
                        return Task.CompletedTask;
                    }

                    return RaiseHeatStintStateTypeAsync(DetailStateTypeId.Red);

                case DetailCommandTypeId.End:
                    if (!(heatStintJournalState!.HeatStintStateTypeId == DetailStateTypeId.Running ||
                          heatStintJournalState!.HeatStintStateTypeId == DetailStateTypeId.Yellow ||
                          heatStintJournalState!.HeatStintStateTypeId == DetailStateTypeId.Red))
                    {
                        return Task.CompletedTask;
                    }

                    return RaiseHeatStintStateTypeAsync(DetailStateTypeId.Ended);

                case DetailCommandTypeId.Reopen:
                    if (!(heatStintJournalState!.HeatStintStateTypeId == DetailStateTypeId.Off))
                    {
                        return Task.CompletedTask;
                    }

                    return CommandAsync(DetailCommandTypeId.Open);

                case DetailCommandTypeId.Close:
                    if (!(heatStintJournalState!.HeatStintStateTypeId == DetailStateTypeId.Opened ||
                          heatStintJournalState!.HeatStintStateTypeId == DetailStateTypeId.Off))
                    {
                        return Task.CompletedTask;
                    }

                    return RaiseHeatStintStateTypeAsync(DetailStateTypeId.Closed);

                case DetailCommandTypeId.Reset:
                    return RaiseHeatStintStateTypeAsync(DetailStateTypeId.Pending);

                default:
                    throw new ArgumentException($"Unhandled heatWithoutStintCommandTypeId: {heatStintCommandTypeId}", nameof(heatStintCommandTypeId));
            }
        }


        protected abstract Task RaiseHeatStintStateTypeAsync(Razmanager.Protobuf.Public.V1.DetailStateTypeId heatStintStateTypeId);


        protected async Task RaisedHeatStintStateTypeAsync(Razmanager.Protobuf.Public.V1.DetailStateTypeId heatStintStateTypeId)
        {
            var deviceConfigurationOutputs = new DeviceConfigurationOutputs();
            switch (heatStintJournalState!.HeatStintStateTypeId)
            {
                case DetailStateTypeId.Pending:
                    deviceConfigurationOutputs.Items.AddRange
                    ([
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.PowerOff },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.HeatOff },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.CountdownOff }
                    ]);
                    break;

                case DetailStateTypeId.Opened:
                    deviceConfigurationOutputs.Items.AddRange
                    ([
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.PowerOn },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.HeatOff },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.CountdownOff }
                    ]);
                    break;

                case DetailStateTypeId.Countdown:
                    deviceConfigurationOutputs.Items.AddRange
                    ([
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.PowerOn },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.HeatOff },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.CountdownOff }
                    ]);
                    _ = GrainFactory.GetGrain<HeatWithoutStints.IHeatWithoutStintsGrain>(this.GetPrimaryKey()).StartLightAsync();
                    break;

                case DetailStateTypeId.Running:
                    deviceConfigurationOutputs.Items.AddRange
                    ([
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.PowerOn },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.HeatGreen },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.CountdownOff }
                    ]);
                    break;

                case DetailStateTypeId.Yellow:
                    deviceConfigurationOutputs.Items.AddRange
                    ([
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.PowerYellow },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.HeatYellow },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.CountdownOff }
                    ]);
                    break;

                case DetailStateTypeId.CountdownYellow:
                    deviceConfigurationOutputs.Items.AddRange
                    ([
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.PowerYellow },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.HeatYellow },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.CountdownOff }
                    ]);
                    _ = GrainFactory.GetGrain<HeatWithoutStints.IHeatWithoutStintsGrain>(this.GetPrimaryKey()).StartLightAsync();
                    break;

                case DetailStateTypeId.Red:
                    deviceConfigurationOutputs.Items.AddRange
                    ([
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.PowerOff },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.HeatRed },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.CountdownOff }
                    ]);
                    break;

                case DetailStateTypeId.CountdownRed:
                    deviceConfigurationOutputs.Items.AddRange
                    ([
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.PowerOff },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.HeatRed },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.CountdownOff }
                    ]);
                    _ = GrainFactory.GetGrain<HeatWithoutStints.IHeatWithoutStintsGrain>(this.GetPrimaryKey()).StartLightAsync();
                    break;

                case DetailStateTypeId.Ended:
                    deviceConfigurationOutputs.Items.AddRange
                    ([
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.PowerOn },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.HeatOff },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.CountdownOff }
                    ]);
                    break;

                case DetailStateTypeId.Off:
                    deviceConfigurationOutputs.Items.AddRange
                    ([
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.PowerYellow },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.HeatOff },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.CountdownOff }
                    ]);
                    break;

                case DetailStateTypeId.Closed:
                    deviceConfigurationOutputs.Items.AddRange
                    ([
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.PowerOff },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.HeatOff },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.CountdownOff }
                    ]);
                    break;

                default:
                    throw new ArgumentException($"Unhandled HeatStintStateTypeId: {heatStintJournalState.HeatStintStateTypeId}", nameof(heatStintJournalState.HeatStintStateTypeId));
            }

            _ = GrainFactory.GetGrain<TrackConfiguration.ITrackConfigurationGrain>(new Guid(race!.TrackConfiguration.Id)).DeviceConfigurationOutputsAsync(deviceConfigurationOutputs);
        }


        public Task StartLightAsync()
        {
            if (heatStintJournalState!.StartLightId >= 5)
            {
                if (_startLightDisposable is not null)
                {
                    _startLightDisposable.Dispose();
                    _startLightDisposable = null;
                }

                if (heatStintJournalState.Ended)
                {
                    _ = RaiseHeatStintStateTypeAsync(DetailStateTypeId.Ended);
                }
                else
                {
                    _ = RaiseHeatStintStateTypeAsync(DetailStateTypeId.Running);
                }
            }
            else
            {
                heatStintJournalState.StartLightId++;

                var deviceConfigurationOutputs = new DeviceConfigurationOutputs();
                deviceConfigurationOutputs.Items.AddRange
                ([
                    new DeviceConfigurationOutput
                    {
                        DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.CountdownOn,
                        DeviceConfigurationOutputId = heatStintJournalState.StartLightId
                    },
                ]);
                _ = GrainFactory.GetGrain<TrackConfiguration.ITrackConfigurationGrain>(new Guid(race!.TrackConfiguration.Id)).DeviceConfigurationOutputsAsync(deviceConfigurationOutputs);

                _ = PublishStateAsync();

                if (heatStintJournalState.StartLightId <= 4)
                {
                    if (_startLightDisposable is null)
                    {
                        //_startLightDisposable = this.RegisterGrainTimer(GrainFactory.GetGrain<Heat.IHeatGrain>(this.GetPrimaryKey()).StartLightAsync, TimeSpan.FromSeconds(1), TimeSpan.FromSeconds(1));

                        //_startLightDisposable = this.RegisterGrainTimer(this.AsReference<Heat.IHeatGrain>().StartLightAsync, TimeSpan.FromSeconds(1), TimeSpan.FromSeconds(5));
                        _startLightDisposable = this.RegisterGrainTimer(StartLightAsync, TimeSpan.FromSeconds(1), TimeSpan.FromSeconds(1));
                    }
                }
                else
                {
                    TimeSpan timeSpanFinal;
                    switch (heatStintJournalState.HeatStintStateTypeId)
                    {
                        case DetailStateTypeId.CountdownYellow:
                        case DetailStateTypeId.CountdownRed:
                            timeSpanFinal = TimeSpan.FromSeconds(1);
                            break;

                        default:
                            timeSpanFinal = TimeSpan.FromSeconds(2.0 + new Random().NextDouble() * 2.0);
                            break;
                    }

                    if (_startLightDisposable is not null)
                    {
                        _startLightDisposable.Dispose();
                    }
                    _startLightDisposable = this.RegisterGrainTimer(StartLightAsync, timeSpanFinal, TimeSpan.FromSeconds(10));
                }
            }

            return Task.CompletedTask;
        }


        private async Task TrackConfigurationDeviceConfigurationInputsAsync(IList<SequentialItem<TrackConfigurationDeviceConfigurationInputs>> sequentialItemList)
        {
            var deviceConfigurationInputs = new DeviceConfigurationInputs();

            foreach (var sequentialItem in sequentialItemList)
            {
                foreach (var deviceConfigurationInput in sequentialItem.Item.DeviceConfigurationInputs.Items)
                {
                    if (_unsubscribe)
                    {
                        var streamProvider = this.GetStreamProvider(Constants.StreamProvider);
                        trackConfigurationDeviceConfigurationInputsStream = streamProvider.GetStream<TrackConfigurationDeviceConfigurationInputs>(Constants.StreamName.TrackConfigurationDeviceConfigurationInputs.ToString(), new Guid(sequentialItem.Item.TrackConfigurationId));
                        var subscriptionHandles = await trackConfigurationDeviceConfigurationInputsStream!.GetAllSubscriptionHandles();
                        var subscriptionHandle = subscriptionHandles.FirstOrDefault();
                        if (subscriptionHandle is not null)
                        {
                            await subscriptionHandle.UnsubscribeAsync();
                        }
                        return;
                    }
                    ;

                    if ((int)heatStintJournalState!.HeatStintStateTypeId <= (int)DetailStateTypeId.Opened || (int)heatStintJournalState!.HeatStintStateTypeId >= (int)DetailStateTypeId.Closed)
                    {
                        break;
                    }

                    if (sequentialItem.Item.Simulated &&
                        heatStintJournalState!.HeatStintStateTypeId != DetailStateTypeId.Running &&
                        heatStintJournalState!.HeatStintStateTypeId != DetailStateTypeId.Ended)
                    {
                        break;
                    }

                    if (deviceConfigurationInput.DeviceConfigurationInputId.HasValue)
                    {
                        if (!indicators.ContainsKey(Convert.ToByte(deviceConfigurationInput.DeviceConfigurationInputId.Value)))
                        {
                            // Input from an indicator that is not a part of the heat.
                            break;
                        }
                    }

                    deviceConfigurationInputs.Items.Add(deviceConfigurationInput);
                }
            }
            if (deviceConfigurationInputs.Items.Any())
            {
                heatStintJournalState!.Timestamp = Google.Protobuf.WellKnownTypes.Timestamp.FromDateTime(DateTime.UtcNow);

                var proto = new Razmanager.Protobuf.Internal.Repository.SystemServices.HeatStintJournal.HeatStintJournalCreateRequest
                {
                    HeatStintId = this.GetPrimaryKey().ToString(),
                    //SequenceNumber
                    HeatStintJournal = new Razmanager.Protobuf.Internal.Repository.SystemServices.HeatStintJournal.HeatStintJournal
                    {
                        HeatStintJournalState = heatStintJournalState,
                        DeviceConfigurationInputs = deviceConfigurationInputs,
                    }
                };
                await CreateHeatStintJournalAsync(proto);

                TransitionStateDeviceConfigurationInputs(deviceConfigurationInputs, false);

                if (heatStintJournalState.HeatStintStateTypeId != DetailStateTypeId.Off &&
                     heatStintJournalState.HeatStintStateTypeId != DetailStateTypeId.Closed &&
                     indicators.All(x => x.Value.Finished))
                {
                    _ = RaiseHeatStintStateTypeAsync(DetailStateTypeId.Off);
                }
                else
                {
                    _ = PublishStateAsync();
                }
            }
        }


        protected void TransitionStateHeatStintStateType(DetailStateTypeId heatStintStateTypeId)
        {
            var previousHeatStateTypeId = heatStintJournalState!.HeatStintStateTypeId;
            correlationId = null;
            heatStintJournalState!.HeatStintStateTypeId = heatStintStateTypeId;

            switch (heatStintStateTypeId)
            {
                case DetailStateTypeId.Pending:
                case DetailStateTypeId.Opened:
                    heatStintJournalState.Ended = false;
                    heatStintJournalState.TimerElapsed = Google.Protobuf.WellKnownTypes.Duration.FromTimeSpan(new TimeSpan());
                    heatStintJournalState.TimerStartedAt = null;
                    heatStintJournalState.StartLightId = 0;

                    InitializeIndicators();

                    break;

                case DetailStateTypeId.Countdown:
                case DetailStateTypeId.CountdownYellow:
                case DetailStateTypeId.CountdownRed:
                    heatStintJournalState.StartLightId = 0;
                    break;

                case DetailStateTypeId.Running:
                    if (previousHeatStateTypeId != DetailStateTypeId.CountdownYellow)
                    {
                        heatStintJournalState.TimerStartedAt = heatStintJournalState.Timestamp;
                    }
                    break;

                case DetailStateTypeId.Yellow:
                    foreach (var item in indicators)
                    {
                        item.Value.IgnoreLapTime = true;
                    }
                    break;

                case DetailStateTypeId.Red:
                    foreach (var item in indicators)
                    {
                        item.Value.IgnoreLapTime = true;
                    }
                    if (heatStintJournalState.TimerStartedAt is not null && !heatStintJournalState.Ended)
                    {
                        heatStintJournalState.TimerElapsed = Google.Protobuf.WellKnownTypes.Duration.FromTimeSpan(heatStintJournalState.TimerElapsed.ToTimeSpan().Add((heatStintJournalState.Timestamp - heatStintJournalState.TimerStartedAt).ToTimeSpan()));
                    }
                    break;

                case DetailStateTypeId.Ended:
                    heatStintJournalState.Ended = true;
                    if (heatStintJournalState.TimerStartedAt is not null)
                    {
                        heatStintJournalState.TimerElapsed = Google.Protobuf.WellKnownTypes.Duration.FromTimeSpan(heatStintJournalState.TimerElapsed.ToTimeSpan().Add((heatStintJournalState.Timestamp - heatStintJournalState.TimerStartedAt).ToTimeSpan()));
                        heatStintJournalState.TimerStartedAt = heatStintJournalState.Timestamp;
                    }
                    else
                    {
                        _logger.LogWarning("Heat clock timestamp not set when reporting clock as not running.");
                    }
                    break;

                case DetailStateTypeId.Off:
                    heatStintJournalState.Ended = true;

                    //foreach (var item in _indicators)
                    //{
                    //    item.Value.Finished = true;
                    //    _ = GrainFactory.GetGrain<RaceWithoutStint.IRaceWithoutStintGrain>(new Guid(_heatWithoutStint!.RaceId))
                    //        .RaceLeaderboardHeatEventUserUpdateAsync(new RaceLeaderboardHeatEventUserUpdate
                    //        {
                    //            HeatId = this.GetPrimaryKey().ToString(),
                    //            EventUserId = item.Value.EventUserId,
                    //            TimerElapsed = Google.Protobuf.WellKnownTypes.Duration.FromTimeSpan(ClockElapsedNow),
                    //            Finished = true
                    //        });
                    //}

                    break;

                case DetailStateTypeId.Closed:
                    // Save state positions and points

                    heatStintJournalState.Ended = true;
                    break;

                default:
                    throw new ArgumentException($"Unhandled heatStintStateTypeId: {heatStintJournalState.HeatStintStateTypeId}", nameof(heatStintJournalState.HeatStintStateTypeId));
            }

            if (heatStintStateTypeId == DetailStateTypeId.Running && previousHeatStateTypeId == DetailStateTypeId.CountdownYellow || heatStintStateTypeId == DetailStateTypeId.Yellow || heatStintStateTypeId == DetailStateTypeId.Red)
            {
                var heatAnalysis = new HeatAnalysis
                {
                    TimerElapsed = Google.Protobuf.WellKnownTypes.Duration.FromTimeSpan(ClockElapsedNow),
                    StateTypeId = heatStintStateTypeId
                };

                heatAnalyses.Items.Add(heatAnalysis);
                heatAnalysesDelta.Items.Add(heatAnalysis);
            }
        }


        private void TransitionStateDeviceConfigurationInputs(DeviceConfigurationInputs deviceConfigurationInputs, bool replay)
        {
            foreach (var deviceConfigurationInput in deviceConfigurationInputs.Items.OrderBy(x => x.Timestamp))
            {
                TransitionStateDeviceConfigurationInput(deviceConfigurationInput, replay);
            }
        }


        protected abstract void TransitionStateDeviceConfigurationInput(DeviceConfigurationInput deviceConfigurationInput, bool replay);


        protected void CalculateTime(byte indicatorId,
                                   IndicatorState heatStateIndicator,
                                   DeviceConfigurationInput? previousDeviceConfigurationInput,
                                   DeviceConfigurationInput deviceConfigurationInput,
                                   IndicatorTimeTypeId indicatorTimeTypeId)
        {
            var indicatorTimeTypeTime = heatStateIndicator.LatestTimeTypeTimes[indicatorTimeTypeId];
            var previousTime = indicatorTimeTypeTime.Time;
            indicatorTimeTypeTime.Time = null;

            if (previousDeviceConfigurationInput is not null)
            {
                if (!heatStateIndicator.IgnoreLapTime)
                {
                    if (deviceConfigurationInput.LapTime.HasValue)
                    {
                        indicatorTimeTypeTime.Time = deviceConfigurationInput.LapTime.Value;
                    }
                    else
                    {
                        indicatorTimeTypeTime.Time = (deviceConfigurationInput.Timestamp - previousDeviceConfigurationInput.Timestamp).ToTimeSpan().TotalSeconds;
                    }
                    indicatorTimeTypeTime.FastestTimeTypeId = IndicatorFastestTimeTypeId.None;

                    if (!indicatorTimeTypeTime.FastestTime.HasValue)
                    {
                        // No previous fastest time
                        indicatorTimeTypeTime.FastestTime = indicatorTimeTypeTime.Time;
                    }
                    else
                    {
                        if (indicatorTimeTypeTime.FastestTime > indicatorTimeTypeTime.Time)
                        {
                            // New indicator fastest time
                            indicatorTimeTypeTime.FastestTime = indicatorTimeTypeTime.Time;
                            indicatorTimeTypeTime.FastestTimeTypeId = IndicatorFastestTimeTypeId.Indicator;
                        }
                    }

                    if (_timeTypeFastestTimes[indicatorTimeTypeId].Time > indicatorTimeTypeTime.Time)
                    {
                        // New overall fastest time

                        // Reset all indicators AllIndicators flags to Indicator flag
                        foreach (var i in indicators)
                        {
                            if (i.Value.LatestTimeTypeTimes[indicatorTimeTypeId].FastestTimeTypeId == IndicatorFastestTimeTypeId.AllIndicators)
                            {
                                i.Value.LatestTimeTypeTimes[indicatorTimeTypeId].FastestTimeTypeId = IndicatorFastestTimeTypeId.Indicator;
                            }
                        }

                        // Add new time and set the indicator's AllIndicators flag
                        _timeTypeFastestTimes[indicatorTimeTypeId] = (indicatorId, indicatorTimeTypeTime.Time.Value);
                        indicatorTimeTypeTime.FastestTimeTypeId = IndicatorFastestTimeTypeId.AllIndicators;
                    }
                }
                heatStateIndicator.AllTimeTypeTimes[IndicatorTimeTypeId.Lap].Add(new IndicatorTimeState
                {
                    Timestamp = deviceConfigurationInput.Timestamp.ToDateTime(),
                    Lap = heatStateIndicator.Laps!.Value,
                    Time = indicatorTimeTypeTime.Time,
                    Pitlanes = heatStateIndicator.LapPitlanes,
                    Deslots = heatStateIndicator.LapDeslots
                });
                heatStateIndicator.LapPitlanes = 0;
                heatStateIndicator.LapDeslots = 0;
            }
            if (indicatorTimeTypeId == IndicatorTimeTypeId.Lap && heatStintJournalState!.HeatStintStateTypeId == DetailStateTypeId.Running)
            {
                heatStateIndicator.IgnoreLapTime = false;
            }
        }


        protected (double? GapTime, short? GapLaps) CalculateGap(IndicatorTimeState heatStateIndicatorTime, IndicatorState otherIndicator)
        {
            var otherHeatStateIndicatorTime = otherIndicator.AllTimeTypeTimes[IndicatorTimeTypeId.Lap].LastOrDefault();
            if (otherHeatStateIndicatorTime is null)
            {
                return (null, null);
            }

            if (heatStateIndicatorTime.Timestamp > otherHeatStateIndicatorTime.Timestamp)
            {
                return ((heatStateIndicatorTime.Timestamp - otherHeatStateIndicatorTime.Timestamp).TotalSeconds, heatStateIndicatorTime.Lap == otherHeatStateIndicatorTime.Lap ? null : Convert.ToInt16(otherHeatStateIndicatorTime.Lap - heatStateIndicatorTime.Lap));
            }
            else
            {
                otherHeatStateIndicatorTime = otherIndicator
                    .AllTimeTypeTimes[IndicatorTimeTypeId.Lap]
                    .SingleOrDefault(x => x.Lap == otherHeatStateIndicatorTime.Lap - 1);
                if (otherHeatStateIndicatorTime is null)
                {
                    return (null, null);
                }

                return ((heatStateIndicatorTime.Timestamp - otherHeatStateIndicatorTime.Timestamp).TotalSeconds, heatStateIndicatorTime.Lap == otherHeatStateIndicatorTime.Lap ? null : Convert.ToInt16(otherHeatStateIndicatorTime.Lap - heatStateIndicatorTime.Lap));
            }
        }


        protected (double? GapTime, short? GapLaps) CalculateGap2(IndicatorState indicator, IndicatorState otherIndicator)
        {
            var heatStateIndicatorTime = indicator.AllTimeTypeTimes[IndicatorTimeTypeId.Lap].LastOrDefault();
            if (heatStateIndicatorTime is null)
            {
                return (null, null);
            }

            var otherHeatStateIndicatorTime = otherIndicator.AllTimeTypeTimes[IndicatorTimeTypeId.Lap].LastOrDefault();
            if (otherHeatStateIndicatorTime is null)
            {
                return (null, null);
            }

            if (heatStateIndicatorTime.Timestamp > otherHeatStateIndicatorTime.Timestamp)
            {
                if (heatStateIndicatorTime.Lap <= otherHeatStateIndicatorTime.Lap)
                {
                    short? gapLap = null; ;
                    if (heatStateIndicatorTime.Lap < otherHeatStateIndicatorTime.Lap)
                    {
                        gapLap = Convert.ToInt16(otherHeatStateIndicatorTime.Lap - heatStateIndicatorTime.Lap);
                    }

                    otherHeatStateIndicatorTime = otherIndicator
                        .AllTimeTypeTimes[IndicatorTimeTypeId.Lap]
                        .SingleOrDefault(x => x.Lap == heatStateIndicatorTime.Lap);
                    if (otherHeatStateIndicatorTime is null)
                    {
                        return (null, null);
                    }

                    var gapTime = (heatStateIndicatorTime.Timestamp - otherHeatStateIndicatorTime.Timestamp).TotalSeconds;

                    return (gapTime, gapLap);
                }
                else
                {
                    //heatStateIndicatorTime = indicator
                    //    .AllTimeTypeTimes[HeatIndicatorTimeTypeId.Lap]
                    //    .SingleOrDefault(x => x.Lap == otherHeatStateIndicatorTime.Lap);
                    //if (heatStateIndicatorTime is null)
                    //{
                    //    return (null, null);
                    //}

                    //var gapTime = (heatStateIndicatorTime.Timestamp - otherHeatStateIndicatorTime.Timestamp).TotalSeconds;
                    //return (gapTime, null);
                    return (null, null);
                }
            }
            else
            {
                if (heatStateIndicatorTime.Lap <= otherHeatStateIndicatorTime.Lap)
                {
                    short? gapLap = null;
                    if (heatStateIndicatorTime.Lap < otherHeatStateIndicatorTime.Lap)
                    {
                        gapLap = Convert.ToInt16(otherHeatStateIndicatorTime.Lap - heatStateIndicatorTime.Lap);
                    }

                    otherHeatStateIndicatorTime = otherIndicator
                        .AllTimeTypeTimes[IndicatorTimeTypeId.Lap]
                        .SingleOrDefault(x => x.Lap == heatStateIndicatorTime.Lap - 1);
                    if (otherHeatStateIndicatorTime is null)
                    {
                        return (null, null);
                    }

                    var gapTime = (heatStateIndicatorTime.Timestamp - otherHeatStateIndicatorTime.Timestamp).TotalSeconds;

                    return (gapTime, gapLap);
                }
                else
                {
                    //heatStateIndicatorTime = indicator
                    //    .AllTimeTypeTimes[IndicatorTimeTypeId.Lap]
                    //    .SingleOrDefault(x => x.Lap == otherHeatStateIndicatorTime.Lap - 1);
                    //if (heatStateIndicatorTime is null)
                    //{
                    //    return (null, null);
                    //}

                    //var gapTime = (heatStateIndicatorTime.Timestamp - otherHeatStateIndicatorTime.Timestamp).TotalSeconds;
                    //return (gapTime, null);
                    return (null, null);
                }
            }
        }


        protected abstract Task CreateHeatStintJournalAsync(Razmanager.Protobuf.Internal.Repository.SystemServices.HeatStintJournal.HeatStintJournalCreateRequest proto);


        protected Razmanager.Protobuf.Public.V1.DetailState HeatStintState()
        {
            var lapsCurrent = indicators.Max(x => x.Value.Laps);
            if (lapsCurrent.HasValue && !heatStintJournalState!.Ended)
            {
                lapsCurrent++;
            }

            var heatState = new Razmanager.Protobuf.Public.V1.DetailState
            {
                DetailStateType = new Razmanager.Protobuf.Public.V1.DetailStateType
                {
                    Id = heatStintJournalState!.HeatStintStateTypeId,
                    Name = new ResourceManager(typeof(RazManager.Resources.DetailStateType)).GetString(heatStintJournalState.HeatStintStateTypeId.ToString())
                },
                LapsCurrent = lapsCurrent,
                TimerIsRunning = ClockIsRunning,
                TimerElapsed = Google.Protobuf.WellKnownTypes.Duration.FromTimeSpan(ClockElapsedNow),
                StartLightId = heatStintJournalState.StartLightId,
            };

            return heatState;
        }


        private bool ClockIsRunning => heatStintJournalState!.HeatStintStateTypeId == DetailStateTypeId.Running ||
                                       heatStintJournalState!.HeatStintStateTypeId == DetailStateTypeId.Yellow ||
                                       heatStintJournalState!.HeatStintStateTypeId == DetailStateTypeId.CountdownYellow;


        private TimeSpan ClockElapsedNow
        {
            get
            {
                switch (heatStintJournalState!.HeatStintStateTypeId)
                {
                    case DetailStateTypeId.Pending:
                    case DetailStateTypeId.Opened:
                        return new TimeSpan();

                    case DetailStateTypeId.Running:
                    case DetailStateTypeId.Yellow:
                    case DetailStateTypeId.CountdownYellow:
                        return heatStintJournalState.TimerStartedAt is null ?
                                new TimeSpan() :
                                (heatStintJournalState.Timestamp - heatStintJournalState.TimerStartedAt).ToTimeSpan() + heatStintJournalState.TimerElapsed.ToTimeSpan();

                    default:
                        return heatStintJournalState.TimerElapsed.ToTimeSpan();
                }
            }
        }


        protected abstract Task PublishStateAsync();



        private class StartLightMessage
        {
        }


        public class IndicatorState
        {
            public required string Id { get; set; }
            public required string? EventUserId { get; set; }
            public required uint Position { get; set; }
            public ushort? Laps { get; set; }
            public IndicatorTimeTypeId? LastTimeTypeId { get; set; }
            public DateTime? LastTimestamp { get; set; }
            public double? GapLeaderTime { get; set; }
            public short? GapLeaderLaps { get; set; }
            public double? GapIntervalTime { get; set; }
            public short? GapIntervalLaps { get; set; }
            public double? GapIntervalFraction { get; set; }
            public bool Finished { get; set; }
            public bool LapWarning { get; set; }
            public bool Pitlane { get; set; }
            public ushort LapPitlanes { get; set; }
            public bool Deslot { get; set; }
            public ushort LapDeslots { get; set; }
            public bool IgnoreLapTime { get; set; } = true;
            public Dictionary<IndicatorTimeTypeId, IndicatorTimeTypeTime> LatestTimeTypeTimes = [];
            public Dictionary<IndicatorTimeTypeId, List<IndicatorTimeState>> AllTimeTypeTimes = [];
            public List<DeviceConfigurationInput> DeviceConfigurationInputs { get; set; } = [];

            public uint Motor { get; set; }
            public Google.Protobuf.WellKnownTypes.Timestamp? LastEnergyTimestamp { get; set; }
            public double CurrentEnergyLapLevel { get; set; }
            public double TotalEnergyLevel { get; set; }  //= totalEnergyLevel;
            public Queue<double> LastEnergyLapLevels = new();
        }


        public class IndicatorTimeState
        {
            public required DateTime Timestamp { get; set; }
            public required ushort Lap { get; set; }
            public required double? Time { get; set; }
            public required ushort Pitlanes { get; set; }
            public required ushort Deslots { get; set; }
        }
    }
}
