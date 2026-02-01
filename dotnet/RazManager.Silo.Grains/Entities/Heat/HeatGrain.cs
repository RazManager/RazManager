using Microsoft.Extensions.Logging;
using Orleans.Streams;
using Razmanager.Protobuf.Internal.Repository.Silo.SystemServices.TrackConfiguration;
using Razmanager.Protobuf.Internal.Silo.UserServices.Event;
using Razmanager.Protobuf.Public.V1;
using System.Diagnostics;
using System.Globalization;
using System.Resources;


namespace RazManager.Silo.Grains.Entities.Heat
{
    public class HeatGrain : Grain, IHeatGrain
    {
        private readonly Razmanager.Protobuf.Internal.Repository.SystemServices.Race.RaceService.RaceServiceClient _raceServiceClient;
        private readonly Razmanager.Protobuf.Internal.Repository.SystemServices.Heat.HeatService.HeatServiceClient _serviceClient;
        private readonly Razmanager.Protobuf.Internal.Repository.SystemServices.HeatIndicatorStint.HeatIndicatorStintService.HeatIndicatorStintServiceClient _heatIndicatorStintServiceClient;
        private Razmanager.Protobuf.Public.V1.Race? _race;
        private Razmanager.Protobuf.Public.V1.Heat? _heat;
        private byte _trackLaptimeDecimals;
        private string _trackLaptimeDecimalsFormat = "F2";
        private const double _totalEnergyLevel = 10000000;

        private Razmanager.Protobuf.Internal.Repository.SystemServices.Heat.HeatJournalState _heatJournalState = new Razmanager.Protobuf.Internal.Repository.SystemServices.Heat.HeatJournalState { HeatStateTypeId = HeatStateTypeId.Pending, TimerElapsed = Google.Protobuf.WellKnownTypes.Duration.FromTimeSpan(new TimeSpan()) };
        private Dictionary<byte, HeatStateIndicator> _indicators = [];
        private Dictionary<HeatIndicatorTimeTypeId, (byte? IndicatorId, double? Time)> _timeTypeFastestTimes = [];
        private HeatAnalyses _heatAnalyses = new();
        private HeatAnalyses _heatAnalysesDelta = new();
        private Dictionary<byte, Dictionary<byte, Queue<HeatAnalysisGap>>> _heatAnalysesGaps = [];
        private Dictionary<byte, List<HeatStintAnalysisIndicatorStintLap>> _allHeatStintAnalysisIndicatorStintLaps = [];
        private Dictionary<byte, HeatStintAnalysisIndicatorStints> _heatStintAnalysisIndicatorStints = [];
        private Dictionary<byte, HeatStintAnalysisIndicatorStints> _heatStintAnalysisIndicatorStintsDelta = [];

        private Guid? _correlationId ;
        private bool _unsubscribe = false;

        private IDisposable? _startLightDisposable;
        private IDisposable? _offDisposable;

        private IAsyncStream<TrackConfigurationDeviceConfigurationInputs>? _trackConfigurationDeviceConfigurationInputsStream;
        private IAsyncStream<HeatState>? _heatStateStream;
        private IAsyncStream<HeatLeaderboard>? _heatLeaderboardStream;
        private IAsyncStream<HeatAnalyses>? _heatAnalysesStream;
        private Dictionary<byte, IAsyncStream<HeatStintAnalysis>?> _heatStintAnalysisStreams = [];

        private readonly ILogger<HeatGrain> _logger;


        public HeatGrain(Razmanager.Protobuf.Internal.Repository.SystemServices.Race.RaceService.RaceServiceClient raceServiceClient,
                         Razmanager.Protobuf.Internal.Repository.SystemServices.Heat.HeatService.HeatServiceClient serviceClient,
                         Razmanager.Protobuf.Internal.Repository.SystemServices.HeatIndicatorStint.HeatIndicatorStintService.HeatIndicatorStintServiceClient heatIndicatorStintServiceClient,
                         ILogger<HeatGrain> logger)
        {
            _raceServiceClient = raceServiceClient;
            _serviceClient = serviceClient;
            _heatIndicatorStintServiceClient = heatIndicatorStintServiceClient;
            _logger = logger;
        }


        public override async Task OnActivateAsync(CancellationToken cancellationToken)
        {
            try
            {
                _heat = await _serviceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });
                _race = await _raceServiceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = _heat.RaceId });

                _trackLaptimeDecimals = 2;
                _trackLaptimeDecimalsFormat = "F" + _trackLaptimeDecimals;

                var stopwatch = new Stopwatch();
                stopwatch.Restart();
                InitializeIndicators();
                var heatJournalsResponse = await _serviceClient.ListHeatJournalsAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });

                if (heatJournalsResponse.HeatJournals.Any())
                {
                    foreach (var heatJournal in heatJournalsResponse.HeatJournals)
                    {
                        _heatJournalState = heatJournal.HeatJournalState;

                        switch (heatJournal.UpdateTypeCase)
                        {
                            case Razmanager.Protobuf.Internal.Repository.SystemServices.Heat.HeatJournal.UpdateTypeOneofCase.HeatStateTypeId:
                                TransitionStateHeateStateType(heatJournal.HeatStateTypeId);
                                break;

                            case Razmanager.Protobuf.Internal.Repository.SystemServices.Heat.HeatJournal.UpdateTypeOneofCase.DeviceConfigurationInputs:
                                TransitionStateDeviceConfigurationInputs(heatJournal.DeviceConfigurationInputs, true);
                                break;

                            default:
                                throw new ArgumentException($"Unhandled journal update type: {heatJournal.UpdateTypeCase.GetType()}", nameof(heatJournal.UpdateTypeCase));
                        }
                    }
                }
                else
                {
                    _heatJournalState = new Razmanager.Protobuf.Internal.Repository.SystemServices.Heat.HeatJournalState
                    {
                        Timestamp = Google.Protobuf.WellKnownTypes.Timestamp.FromDateTime(DateTime.UtcNow),
                        HeatStateTypeId = Razmanager.Protobuf.Public.V1.HeatStateTypeId.Pending,
                        Ended = false,
                    };
                }

                _heatAnalysesDelta = new();

                _heat!.HeatStateType = new Razmanager.Protobuf.Public.V1.HeatStateType
                {
                    Id = _heatJournalState.HeatStateTypeId,
                    Name = new ResourceManager(typeof(RazManager.Resources.HeatStateType)).GetString(_heatJournalState.HeatStateTypeId.ToString())
                };

                _logger.LogInformation($"{this.GetType().Name} {this.GetPrimaryKey()} OnActivateAsync {stopwatch.Elapsed.TotalSeconds}s");

                var streamProvider = this.GetStreamProvider(Constants.StreamProvider);
                _trackConfigurationDeviceConfigurationInputsStream = streamProvider.GetStream<TrackConfigurationDeviceConfigurationInputs>(Constants.StreamName.TrackConfigurationDeviceConfigurationInputs.ToString(), new Guid(_race.TrackConfiguration.Id));
                _heatStateStream = streamProvider.GetStream<HeatState>(Constants.StreamName.HeatState.ToString(), this.GetPrimaryKey());
                _heatLeaderboardStream = streamProvider.GetStream<HeatLeaderboard>(Constants.StreamName.HeatLeaderboard.ToString(), this.GetPrimaryKey());
                _heatAnalysesStream = streamProvider.GetStream<HeatAnalyses>(Constants.StreamName.HeatAnalyses.ToString(), this.GetPrimaryKey());
                foreach (var item in _heat!.HeatIndicators)
                {
                    _heatStintAnalysisStreams.Add(Convert.ToByte(item.IndicatorId), streamProvider.GetStream<HeatStintAnalysis>(Constants.StreamName.HeatStintAnalysis.ToString(), $"{this.GetPrimaryKey()}:{item.IndicatorId}"));
                    //Console.WriteLine($"-------------- OnActivateAsync {this.GetPrimaryKey()}:{item.IndicatorId}");
                }

                await TrackConfigurationDeviceInputStreamSubscriptionStateAsync();

                if (_heatJournalState.HeatStateTypeId == HeatStateTypeId.Countdown ||
                    _heatJournalState.HeatStateTypeId == HeatStateTypeId.CountdownYellow ||
                    _heatJournalState.HeatStateTypeId == HeatStateTypeId.CountdownRed)
                {
                    //Console.WriteLine($"++++++++++++++++++++++++++++++++++++++++++{this.GetType().Name} OnActivateAsync Countdown");
                }
            }
            catch (Grpc.Core.RpcException exception)
            {
                if (exception.StatusCode == Grpc.Core.StatusCode.NotFound)
                {
                    _unsubscribe = true;

                    //var streamProvider = this.GetStreamProvider(Constants.StreamProvider);
                    //var x = streamProvider.TryGetStreamSubscriptionManager(out var s);

                    //var subscriptionHandles = await _trackConfigurationDeviceConfigurationInputsStream!.GetAllSubscriptionHandles();
                    //foreach (var subscriptionHandle in subscriptionHandles)
                    //{
                    //    await subscriptionHandle.UnsubscribeAsync();
                    //}
                }
            }
        }


        public async Task RefreshHeatIndicatorStintsAsync(Guid heatIndicatorId)
        {
            var newHeat = await _serviceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });
            if (newHeat is not null) {
                var newHeatIndicator = newHeat.HeatIndicators.SingleOrDefault(x => new Guid(x.Id) == heatIndicatorId);
                var heatIndicator = _heat!.HeatIndicators.SingleOrDefault(x => new Guid(x.Id) == heatIndicatorId);
                if (heatIndicator is not null && newHeatIndicator is not null)
                {
                    heatIndicator.HeatIndicatorStints.Clear();
                    heatIndicator.HeatIndicatorStints.AddRange(newHeatIndicator.HeatIndicatorStints);

                    var heatStintAnalysisIndicatorStints = new HeatStintAnalysisIndicatorStints();
                    heatStintAnalysisIndicatorStints.Items.AddRange(heatIndicator.HeatIndicatorStints.Select(x => new HeatStintAnalysisIndicatorStint
                    {
                        Id = x.Id,
                        Lap = x.Lap,
                        EventUserId = x.EventUserId,
                        Comments = x.Comments
                    }));

                    _heatStintAnalysisIndicatorStints[Convert.ToByte(heatIndicator.IndicatorId)] = heatStintAnalysisIndicatorStints;

                    foreach (var heatStintAnalysisIndicatorStintLap in _allHeatStintAnalysisIndicatorStintLaps[Convert.ToByte(heatIndicator.IndicatorId)])
                    {
                        var heatStintAnalysisIndicatorStint = heatStintAnalysisIndicatorStints.Items.LastOrDefault(x => x.Lap <= heatStintAnalysisIndicatorStintLap.Lap && heatStintAnalysisIndicatorStintLap.Lap >= 1);

                        if (heatStintAnalysisIndicatorStint is not null && heatStintAnalysisIndicatorStint.Lap >= 1)
                        {
                            HeatStintAnalysisIndicatorStintUpdate(heatStintAnalysisIndicatorStint, heatStintAnalysisIndicatorStintLap);
                        }
                    }

                    await _heatStintAnalysisStreams[Convert.ToByte(heatIndicator.IndicatorId)]!.OnNextAsync(new HeatStintAnalysis
                    {
                        Refresh = true,
                        HeatStintAnalysisIndicatorStints = heatStintAnalysisIndicatorStints
                    });
                    //Console.WriteLine($"-------------- RefreshHeatIndicatorStintsAsync {this.GetPrimaryKey()}  {heatIndicator.IndicatorId}");
                }
            }
        }


        private async Task TrackConfigurationDeviceInputStreamSubscriptionStateAsync()
        {
            var subscriptionHandles = await _trackConfigurationDeviceConfigurationInputsStream!.GetAllSubscriptionHandles();
            var subscriptionHandle = subscriptionHandles.FirstOrDefault();

            switch (_heatJournalState.HeatStateTypeId)
            {
                case HeatStateTypeId.Opened:
                case HeatStateTypeId.Countdown:
                case HeatStateTypeId.Running:
                case HeatStateTypeId.Yellow:
                case HeatStateTypeId.CountdownYellow:
                case HeatStateTypeId.Red:
                case HeatStateTypeId.CountdownRed:
                case HeatStateTypeId.Ended:
                case HeatStateTypeId.Off:
                    if (subscriptionHandle is null)
                    {
                        await _trackConfigurationDeviceConfigurationInputsStream.SubscribeAsync(TrackConfigurationDeviceConfigurationInputsAsync);
                    }
                    else
                    {
                        await subscriptionHandle.ResumeAsync(TrackConfigurationDeviceConfigurationInputsAsync);
                    }
                    break;

                case HeatStateTypeId.Pending:
                case HeatStateTypeId.Closed:
                    if (subscriptionHandle is not null)
                    {
                        await subscriptionHandle.UnsubscribeAsync();
                    }
                    break;

                default:
                    throw new ArgumentException($"Unhandled HeatStateTypeId: {_heatJournalState.HeatStateTypeId}", nameof(_heatJournalState.HeatStateTypeId));
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


        private void InitializeIndicators()
        {
            _timeTypeFastestTimes.Clear();
            foreach (var heatIndicatorTimeTypeId in System.Enum.GetValues<HeatIndicatorTimeTypeId>())
            {
                _timeTypeFastestTimes[heatIndicatorTimeTypeId] = (null, double.MaxValue);
            }

            _indicators.Clear();
            _heatAnalysesGaps.Clear();
            _allHeatStintAnalysisIndicatorStintLaps.Clear();
            _heatStintAnalysisIndicatorStints.Clear();
            _heatStintAnalysisIndicatorStintsDelta.Clear();
            foreach (var item in _heat!.HeatIndicators.OrderBy(x => x.IndicatorId).Select((indicator, index) => new { indicator, index }))
            {
                var heatStateIndicator = new HeatStateIndicator
                {
                    Id = item.indicator.Id,
                    Position = Convert.ToUInt32(item.index + 1)
                };

                foreach (var heatIndicatorTimeTypeId in System.Enum.GetValues<HeatIndicatorTimeTypeId>())
                {
                    heatStateIndicator.LatestTimeTypeTimes[heatIndicatorTimeTypeId] = new HeatIndicatorTimeTypeTime();
                    heatStateIndicator.AllTimeTypeTimes[heatIndicatorTimeTypeId] = [];
                }

                _indicators.Add(Convert.ToByte(item.indicator.IndicatorId), heatStateIndicator);

                Dictionary<byte, Queue<HeatAnalysisGap>> indicatorHeatAnalysisGaps = [];
                foreach (var otherItem in _heat!.HeatIndicators.OrderBy(x => x.IndicatorId).Where(x => x.IndicatorId != item.indicator.IndicatorId))
                {
                    indicatorHeatAnalysisGaps.Add(Convert.ToByte(otherItem.IndicatorId), new Queue<HeatAnalysisGap>());
                }
                _heatAnalysesGaps.Add(Convert.ToByte(item.indicator.IndicatorId), indicatorHeatAnalysisGaps);

                _allHeatStintAnalysisIndicatorStintLaps.Add(Convert.ToByte(item.indicator.IndicatorId), []);

                var heatStintAnalysisIndicatorStints = new HeatStintAnalysisIndicatorStints();
                heatStintAnalysisIndicatorStints.Items.AddRange(item.indicator.HeatIndicatorStints.Select(x => new HeatStintAnalysisIndicatorStint
                    {
                        Id = x.Id,
                        IndicatorId = item.indicator.IndicatorId,
                        Lap = x.Lap,
                        EventUserId = x.EventUserId,
                        Comments = x.Comments
                    }));
                _heatStintAnalysisIndicatorStints.Add(Convert.ToByte(item.indicator.IndicatorId), heatStintAnalysisIndicatorStints);

                _heatStintAnalysisIndicatorStintsDelta.Add(Convert.ToByte(item.indicator.IndicatorId), new());
            }

            _heatAnalyses = new();
            _heatAnalysesDelta = new();
        }


        public Task<Razmanager.Protobuf.Public.V1.Heat> ReadAsync()
        {
            return Task.FromResult(_heat!);
        }


        public Task<Razmanager.Protobuf.Public.V1.HeatState> ReadHeatStateAsync()
        {
            _heatJournalState.Timestamp = Google.Protobuf.WellKnownTypes.Timestamp.FromDateTime(DateTime.UtcNow);
            return Task.FromResult(HeatState());
        }


        public Task<Razmanager.Protobuf.Public.V1.HeatLeaderboard> ReadHeatLeaderboardAsync()
        {
            return Task.FromResult(HeatLeaderboard());
        }


        public Task<Razmanager.Protobuf.Public.V1.HeatAnalyses> ReadHeatAnalysesAsync()
        {
            return Task.FromResult(_heatAnalyses);
        }


        public Task<HeatStintAnalysisIndicatorStints> ReadHeatStintAnalysisIndicatorStintsAsync(byte indicatorId)
        {
            return Task.FromResult(_heatStintAnalysisIndicatorStints[indicatorId]);
        }


        public Task CommandAsync(Razmanager.Protobuf.Public.V1.HeatCommandTypeId heatCommandTypeId)
        {
            switch (heatCommandTypeId)
            {
                case HeatCommandTypeId.Open:
                    return RaiseHeatStateTypeAsync(HeatStateTypeId.Opened);

                case HeatCommandTypeId.Start:
                    if (!(_heatJournalState.HeatStateTypeId == HeatStateTypeId.Opened ||
                          _heatJournalState.HeatStateTypeId == HeatStateTypeId.Yellow ||
                          _heatJournalState.HeatStateTypeId == HeatStateTypeId.Red))
                    {
                        return Task.CompletedTask;
                    }

                    switch (_heatJournalState.HeatStateTypeId)
                    {
                        case HeatStateTypeId.Yellow:
                            return RaiseHeatStateTypeAsync(HeatStateTypeId.CountdownYellow);
                        case HeatStateTypeId.Red:
                            return RaiseHeatStateTypeAsync(HeatStateTypeId.CountdownRed);
                        default:
                            return RaiseHeatStateTypeAsync(HeatStateTypeId.Countdown);
                    }

                case HeatCommandTypeId.Yellow:
                    if (!(_heatJournalState.HeatStateTypeId == HeatStateTypeId.Running ||
                          _heatJournalState.HeatStateTypeId == HeatStateTypeId.Ended))
                    {
                        return Task.CompletedTask;
                    }

                    return RaiseHeatStateTypeAsync(HeatStateTypeId.Yellow);

                case HeatCommandTypeId.Red:
                    if (!(_heatJournalState.HeatStateTypeId == HeatStateTypeId.Running ||
                          _heatJournalState.HeatStateTypeId == HeatStateTypeId.Countdown ||
                          _heatJournalState.HeatStateTypeId == HeatStateTypeId.Yellow ||
                          _heatJournalState.HeatStateTypeId == HeatStateTypeId.CountdownYellow ||
                          _heatJournalState.HeatStateTypeId == HeatStateTypeId.CountdownRed ||
                          _heatJournalState.HeatStateTypeId == HeatStateTypeId.Ended))
                    {
                        return Task.CompletedTask;
                    }

                    return RaiseHeatStateTypeAsync(HeatStateTypeId.Red);

                case HeatCommandTypeId.End:
                    if (!(_heatJournalState.HeatStateTypeId == HeatStateTypeId.Running ||
                          _heatJournalState.HeatStateTypeId == HeatStateTypeId.Yellow ||
                          _heatJournalState.HeatStateTypeId == HeatStateTypeId.Red))
                    {
                        return Task.CompletedTask;
                    }

                    return RaiseHeatStateTypeAsync(HeatStateTypeId.Ended);

                case HeatCommandTypeId.Reopen:
                    if (!(_heatJournalState.HeatStateTypeId == HeatStateTypeId.Off))
                    {
                        return Task.CompletedTask;
                    }

                    return CommandAsync(HeatCommandTypeId.Open);

                case HeatCommandTypeId.Close:
                    if (!(_heatJournalState.HeatStateTypeId == HeatStateTypeId.Opened ||
                          _heatJournalState.HeatStateTypeId == HeatStateTypeId.Off))
                    {
                        return Task.CompletedTask;
                    }

                    return RaiseHeatStateTypeAsync(HeatStateTypeId.Closed);

                case HeatCommandTypeId.Reset:
                    if (_heatJournalState.HeatStateTypeId == HeatStateTypeId.Pending)
                    {
                        return Task.CompletedTask;
                    }

                    return RaiseHeatStateTypeAsync(HeatStateTypeId.Pending);

                default:
                    throw new ArgumentException($"Unhandled HeatCommandTypeId: {heatCommandTypeId}", nameof(heatCommandTypeId));
            }
        }


        public async Task RaiseHeatStateTypeAsync(Razmanager.Protobuf.Public.V1.HeatStateTypeId heatStateTypeId)
        {
            if (_heatJournalState.HeatStateTypeId == HeatStateTypeId.Pending ||
                _heatJournalState.HeatStateTypeId == HeatStateTypeId.Opened)
            {
                await _serviceClient.DeleteStintsAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });
                await _serviceClient.DeleteHeatJournalsAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });
                
                // Refresh stints
                _heat = await _serviceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });
            }

            _heatJournalState.Timestamp = Google.Protobuf.WellKnownTypes.Timestamp.FromDateTime(DateTime.UtcNow);

            var proto = new Razmanager.Protobuf.Internal.Repository.SystemServices.Heat.HeatJournalCreateRequest
            {
                HeatId = this.GetPrimaryKey().ToString(),
                //SequenceNumber
                HeatJournal = new Razmanager.Protobuf.Internal.Repository.SystemServices.Heat.HeatJournal
                {
                    HeatJournalState = _heatJournalState,
                    HeatStateTypeId = heatStateTypeId
                }
            };
            await _serviceClient.CreateHeatJournalAsync(proto);

            TransitionStateHeateStateType(heatStateTypeId);

            _heat!.HeatStateType = new Razmanager.Protobuf.Public.V1.HeatStateType
            {
                Id = _heatJournalState.HeatStateTypeId,
                Name = new ResourceManager(typeof(RazManager.Resources.HeatStateType)).GetString(_heatJournalState.HeatStateTypeId.ToString())
            };

            await TrackConfigurationDeviceInputStreamSubscriptionStateAsync();

            if (_offDisposable != null)
            {
                _offDisposable.Dispose();
                _offDisposable = null;
            }
            if (_heatJournalState.HeatStateTypeId == HeatStateTypeId.Ended)
            {
                _offDisposable = this.RegisterGrainTimer(() => RaiseHeatStateTypeAsync(HeatStateTypeId.Off), TimeSpan.FromSeconds(30), TimeSpan.FromDays(1));
            }

            switch (_heatJournalState.HeatStateTypeId)
            {
                case HeatStateTypeId.Pending:
                case HeatStateTypeId.Opened:
                case HeatStateTypeId.Countdown:
                case HeatStateTypeId.Running:
                case HeatStateTypeId.Yellow:
                case HeatStateTypeId.CountdownYellow:
                case HeatStateTypeId.Red:
                case HeatStateTypeId.CountdownRed:
                case HeatStateTypeId.Ended:
                case HeatStateTypeId.Off:
                    _ = GrainFactory.GetGrain<Race.IRaceGrain>(new Guid(_heat.RaceId)).RefreshAsync(true);

                    break;

                case HeatStateTypeId.Closed:
                    _ = GrainFactory.GetGrain<Race.IRaceGrain>(new Guid(_heat!.RaceId)).HeatClosedAsync();
                    break;

                default:
                    throw new ArgumentException($"Unhandled HeatStateTypeId: {_heatJournalState.HeatStateTypeId}", nameof(_heatJournalState.HeatStateTypeId));
            }

            var deviceConfigurationOutputs = new DeviceConfigurationOutputs();
            switch (_heatJournalState.HeatStateTypeId)
            {
                case HeatStateTypeId.Pending:
                    deviceConfigurationOutputs.Items.AddRange
                    ([
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.PowerOff },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.HeatOff },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.CountdownOff }
                    ]);
                    break;

                case HeatStateTypeId.Opened:
                    deviceConfigurationOutputs.Items.AddRange
                    ([
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.PowerOn },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.HeatOff },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.CountdownOff }
                    ]);
                    break;

                case HeatStateTypeId.Countdown:
                    deviceConfigurationOutputs.Items.AddRange
                    ([
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.PowerOn },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.HeatOff },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.CountdownOff }
                    ]);
                    _ = GrainFactory.GetGrain<Heat.IHeatGrain>(this.GetPrimaryKey()).StartLightAsync();
                    break;

                case HeatStateTypeId.Running:
                    deviceConfigurationOutputs.Items.AddRange
                    ([
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.PowerOn },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.HeatGreen },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.CountdownOff }
                    ]);
                    break;

                case HeatStateTypeId.Yellow:
                    deviceConfigurationOutputs.Items.AddRange
                    ([
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.PowerYellow },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.HeatYellow },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.CountdownOff }
                    ]);
                    break;

                case HeatStateTypeId.CountdownYellow:
                    deviceConfigurationOutputs.Items.AddRange
                    ([
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.PowerYellow },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.HeatYellow },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.CountdownOff }
                    ]);
                    _ = GrainFactory.GetGrain<Heat.IHeatGrain>(this.GetPrimaryKey()).StartLightAsync();
                    break;

                case HeatStateTypeId.Red:
                    deviceConfigurationOutputs.Items.AddRange
                    ([
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.PowerOff },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.HeatRed },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.CountdownOff }
                    ]);
                    break;

                case HeatStateTypeId.CountdownRed:
                    deviceConfigurationOutputs.Items.AddRange
                    ([
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.PowerOff },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.HeatRed },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.CountdownOff }
                    ]);
                    _ = GrainFactory.GetGrain<Heat.IHeatGrain>(this.GetPrimaryKey()).StartLightAsync();
                    break;

                case HeatStateTypeId.Ended:
                    deviceConfigurationOutputs.Items.AddRange
                    ([
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.PowerOn },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.HeatOff },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.CountdownOff }
                    ]);
                    break;

                case HeatStateTypeId.Off:
                    deviceConfigurationOutputs.Items.AddRange
                    ([
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.PowerYellow },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.HeatOff },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.CountdownOff }
                    ]);
                    break;

                case HeatStateTypeId.Closed:
                    deviceConfigurationOutputs.Items.AddRange
                    ([
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.PowerOff },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.HeatOff },
                        new DeviceConfigurationOutput { DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.CountdownOff }
                    ]);
                    break;

                default:
                    throw new ArgumentException($"Unhandled HeatStateTypeId: {_heatJournalState.HeatStateTypeId}", nameof(_heatJournalState.HeatStateTypeId));
            }

            _ = GrainFactory.GetGrain<TrackConfiguration.ITrackConfigurationGrain>(new Guid(_race!.TrackConfiguration.Id)).DeviceConfigurationOutputsAsync(deviceConfigurationOutputs);

            _ = PublishStateAsync();
        }


        public Task StartLightAsync()
        {
            if (_heatJournalState.StartLightId >= 5)
            {
                if (_startLightDisposable is not null)
                {
                    _startLightDisposable.Dispose();
                    _startLightDisposable = null;
                }

                if (_heatJournalState.Ended)
                {
                    _ = RaiseHeatStateTypeAsync(HeatStateTypeId.Ended);
                }
                else
                {
                    _ = RaiseHeatStateTypeAsync(HeatStateTypeId.Running);
                }
            }
            else
            {
                _heatJournalState.StartLightId++;

                var deviceConfigurationOutputs = new DeviceConfigurationOutputs();
                deviceConfigurationOutputs.Items.AddRange
                ([
                    new DeviceConfigurationOutput
                    {
                        DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.CountdownOn,
                        DeviceConfigurationOutputId = _heatJournalState.StartLightId
                    },
                ]);
                _ = GrainFactory.GetGrain<TrackConfiguration.ITrackConfigurationGrain>(new Guid(_race!.TrackConfiguration.Id)).DeviceConfigurationOutputsAsync(deviceConfigurationOutputs);

                _ = PublishStateAsync();

                if (_heatJournalState.StartLightId <= 4)
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
                    switch (_heatJournalState.HeatStateTypeId)
                    {
                        case HeatStateTypeId.CountdownYellow:
                        case HeatStateTypeId.CountdownRed:
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
                        _trackConfigurationDeviceConfigurationInputsStream = streamProvider.GetStream<TrackConfigurationDeviceConfigurationInputs>(Constants.StreamName.TrackConfigurationDeviceConfigurationInputs.ToString(), new Guid(sequentialItem.Item.TrackConfigurationId));
                        var subscriptionHandles = await _trackConfigurationDeviceConfigurationInputsStream!.GetAllSubscriptionHandles();
                        var subscriptionHandle = subscriptionHandles.FirstOrDefault();
                        if (subscriptionHandle is not null)
                        {
                            await subscriptionHandle.UnsubscribeAsync();
                        }
                        return;
                    };

                    if ((int)_heatJournalState.HeatStateTypeId <= (int)HeatStateTypeId.Opened || (int)_heatJournalState.HeatStateTypeId >= (int)HeatStateTypeId.Closed)
                    {
                        break;
                    }

                    if (sequentialItem.Item.Simulated &&
                        _heatJournalState.HeatStateTypeId != HeatStateTypeId.Running &&
                        _heatJournalState.HeatStateTypeId != HeatStateTypeId.Ended)
                    {
                        break;
                    }

                    if (deviceConfigurationInput.DeviceConfigurationInputId.HasValue)
                    {
                        if (!_heat!.HeatIndicators.Any(x => x.IndicatorId == deviceConfigurationInput.DeviceConfigurationInputId.Value))
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
                _heatJournalState.Timestamp = Google.Protobuf.WellKnownTypes.Timestamp.FromDateTime(DateTime.UtcNow);

                var proto = new Razmanager.Protobuf.Internal.Repository.SystemServices.Heat.HeatJournalCreateRequest
                {
                    HeatId = this.GetPrimaryKey().ToString(),
                    //SequenceNumber
                    HeatJournal = new Razmanager.Protobuf.Internal.Repository.SystemServices.Heat.HeatJournal
                    {
                        HeatJournalState = _heatJournalState,
                        DeviceConfigurationInputs = deviceConfigurationInputs,
                    }
                };
                await _serviceClient.CreateHeatJournalAsync(proto);

                TransitionStateDeviceConfigurationInputs(deviceConfigurationInputs, false);

                if (_heatJournalState.HeatStateTypeId != HeatStateTypeId.Off &&
                     _heatJournalState.HeatStateTypeId != HeatStateTypeId.Closed &&
                     _indicators.All(x => x.Value.Finished))
                {
                    _ = RaiseHeatStateTypeAsync(HeatStateTypeId.Off);
                }
                else
                {
                    _ = PublishStateAsync();
                }
            }
        }


        private void TransitionStateHeateStateType(HeatStateTypeId heatStateTypeId)
        {
            var previousHeatStateTypeId = _heatJournalState.HeatStateTypeId;
            _correlationId = null;
            _heatJournalState.HeatStateTypeId = heatStateTypeId;

            switch (heatStateTypeId)
            {
                case HeatStateTypeId.Pending:
                case HeatStateTypeId.Opened:
                    _heatJournalState.Ended = false;
                    _heatJournalState.TimerElapsed = Google.Protobuf.WellKnownTypes.Duration.FromTimeSpan(new TimeSpan());
                    _heatJournalState.TimerStartedAt = null;
                    _heatJournalState.StartLightId = 0;

                    InitializeIndicators();

                    break;

                case HeatStateTypeId.Countdown:
                case HeatStateTypeId.CountdownYellow:
                case HeatStateTypeId.CountdownRed:
                    _heatJournalState.StartLightId = 0;
                    break;

                case HeatStateTypeId.Running:
                    if (previousHeatStateTypeId != HeatStateTypeId.CountdownYellow)
                    {
                        _heatJournalState.TimerStartedAt = _heatJournalState.Timestamp;
                    }
                    break;

                case HeatStateTypeId.Yellow:
                    foreach (var item in _indicators)
                    {
                        item.Value.IgnoreLapTime = true;
                    }
                    break;

                case HeatStateTypeId.Red:
                    foreach (var item in _indicators)
                    {
                        item.Value.IgnoreLapTime = true;
                    }
                    if (_heatJournalState.TimerStartedAt is not null && !_heatJournalState.Ended)
                    {
                        _heatJournalState.TimerElapsed = Google.Protobuf.WellKnownTypes.Duration.FromTimeSpan(_heatJournalState.TimerElapsed.ToTimeSpan().Add((_heatJournalState.Timestamp - _heatJournalState.TimerStartedAt).ToTimeSpan()));
                    }
                    break;

                case HeatStateTypeId.Ended:
                    _heatJournalState.Ended = true;
                    if (_heatJournalState.TimerStartedAt is not null)
                    {
                        _heatJournalState.TimerElapsed = Google.Protobuf.WellKnownTypes.Duration.FromTimeSpan(_heatJournalState.TimerElapsed.ToTimeSpan().Add((_heatJournalState.Timestamp - _heatJournalState.TimerStartedAt).ToTimeSpan()));
                        _heatJournalState.TimerStartedAt = _heatJournalState.Timestamp;
                    }
                    else
                    {
                        _logger.LogWarning("Heat clock timestamp not set when reporting clock as not running.");
                    }
                    break;

                case HeatStateTypeId.Off:
                    _heatJournalState.Ended = true;

                    foreach (var item in _indicators)
                    {
                        item.Value.Finished = true;
                    }

                    break;

                case HeatStateTypeId.Closed:
                    // Save state positions and points

                    _heatJournalState.Ended = true;
                    break;

                default:
                    throw new ArgumentException($"Unhandled HeatStateTypeId: {_heatJournalState.HeatStateTypeId}", nameof(_heatJournalState.HeatStateTypeId));
            }

            if (heatStateTypeId == HeatStateTypeId.Running && previousHeatStateTypeId == HeatStateTypeId.CountdownYellow || heatStateTypeId == HeatStateTypeId.Yellow || heatStateTypeId == HeatStateTypeId.Red)
            {
                var heatAnalysis = new HeatAnalysis
                {
                    TimerElapsed = Google.Protobuf.WellKnownTypes.Duration.FromTimeSpan(ClockElapsedNow),
                    HeatStateTypeId = heatStateTypeId
                };

                _heatAnalyses.Items.Add(heatAnalysis);
                _heatAnalysesDelta.Items.Add(heatAnalysis);
            }
        }


        private void TransitionStateDeviceConfigurationInputs(DeviceConfigurationInputs deviceConfigurationInputs, bool replay)
        {
            foreach (var deviceConfigurationInput in deviceConfigurationInputs.Items.OrderBy(x => x.Timestamp))
            {
                TransitionStateDeviceConfigurationInput(deviceConfigurationInput, replay);
            }
        }


        private void TransitionStateDeviceConfigurationInput(DeviceConfigurationInput deviceConfigurationInput, bool replay)
        {
            if (string.IsNullOrEmpty(deviceConfigurationInput.CorrelationId))
            {
                _correlationId = null;
            }
            else
            {
                _correlationId = new Guid(deviceConfigurationInput.CorrelationId);
            }

            if (deviceConfigurationInput.DeviceConfigurationInputId.HasValue)
            {
                if (!_indicators.ContainsKey(Convert.ToByte(deviceConfigurationInput.DeviceConfigurationInputId.Value)))
                {
                    // Input from an indicator that is not a part of the heat.
                    return;
                }

                if (_heatJournalState.TimerStartedAt is null)
                {
                    // Timer not started yet.
                    return;
                }

                var indicatorId = Convert.ToByte(deviceConfigurationInput.DeviceConfigurationInputId.Value);
                var heatStateIndicator = _indicators[indicatorId];

                switch (deviceConfigurationInput.DeviceConfigurationInputTypeId)
                {
                    case DeviceConfigurationInputTypeId.StartFinishIndicator:
                    case DeviceConfigurationInputTypeId.StartFinishIndicatorIgnoreLapTime:

                        if (deviceConfigurationInput.DeviceConfigurationInputTypeId == DeviceConfigurationInputTypeId.StartFinishIndicatorIgnoreLapTime)
                        {
                            heatStateIndicator.IgnoreLapTime = true;
                        }

                        if (!heatStateIndicator.Finished)
                        {
                            //if (_heat.DeviceConfigurationFeatures.Any(x => x == DeviceConfigurationFeatureTypeId.Sector3))
                            //{
                            //    var deviceConfigurationInputSector2FinishPrevious = indicator.DeviceConfigurationInputs.LastOrDefault(x => x.DeviceConfigurationInputTypeId == DeviceConfigurationInputTypeId.Sector2FinishIndicator);
                            //    CalculateTime(indicator, deviceConfigurationInputSector2FinishPrevious, deviceConfigurationInput, HeatOutputTimeTypeId.Sector3);
                            //}
                            //else if (_heat.DeviceConfigurationFeatures.Any(x => x == DeviceConfigurationFeatureTypeId.Sector2))
                            //{
                            //    var deviceConfigurationInputSector1FinishPrevious = indicator.DeviceConfigurationInputs.LastOrDefault(x => x.DeviceConfigurationInputTypeId == DeviceConfigurationInputTypeId.Sector1FinishIndicator);
                            //    CalculateTime(indicator, deviceConfigurationInputSector1FinishPrevious, deviceConfigurationInput, HeatOutputTimeTypeId.Sector2);
                            //}

                            if (!heatStateIndicator.Laps.HasValue)
                            {
                                heatStateIndicator.Laps = 0;
                            }
                            else
                            {
                                heatStateIndicator.Laps++;
                            }

                            heatStateIndicator.LastTimeTypeId = HeatIndicatorTimeTypeId.Lap;
                            heatStateIndicator.LastTimestamp = deviceConfigurationInput.Timestamp.ToDateTime();

                            var deviceConfigurationInputStartFinishPrevious = heatStateIndicator.DeviceConfigurationInputs.LastOrDefault(x => x.DeviceConfigurationInputTypeId == DeviceConfigurationInputTypeId.StartFinishIndicator || x.DeviceConfigurationInputTypeId == DeviceConfigurationInputTypeId.StartFinishIndicatorIgnoreLapTime);
                            CalculateTime(indicatorId, heatStateIndicator, deviceConfigurationInputStartFinishPrevious, deviceConfigurationInput, HeatIndicatorTimeTypeId.Lap);

                            if ((_race!.RaceHeatEndTypeId == HeatEndTypeId.Lap && _race.RaceHeatEndLapLaps <= heatStateIndicator.Laps.Value ||
                                _race!.RaceHeatEndTypeId == HeatEndTypeId.Duration && _race.RaceHeatEndDurationDuration.ToTimeSpan() <=
                                    Google.Protobuf.WellKnownTypes.Duration.FromTimeSpan(_heatJournalState.TimerElapsed.ToTimeSpan().Add((_heatJournalState.Timestamp - _heatJournalState.TimerStartedAt).ToTimeSpan())).ToTimeSpan()))
                            {
                                heatStateIndicator.Finished = true;
                            }
                            else if (_heatJournalState.Ended)
                            {
                                heatStateIndicator.Finished = true;
                            }

                            HeatStateIndicator? leaderIndicator = null;
                            HeatStateIndicator? intervalIndicator = null;

                            foreach (var item in _indicators
                                .OrderByDescending(x => x.Value.Laps)
                                .ThenByDescending(x => x.Value.LastTimeTypeId)
                                .ThenBy(x => x.Value.LastTimestamp)
                                .ThenBy(x => x.Key)
                                .Select((indicatorKv, index) => new { indicatorKv, index }))
                            {
                                var previousPosition = item.indicatorKv.Value.Position;
                                item.indicatorKv.Value.Position = Convert.ToUInt32(item.index + 1);

                                if (!replay && item.indicatorKv.Value.Position > 0 && item.indicatorKv.Value.Position != previousPosition)
                                {
                                    var eventUserId = _heat!.HeatIndicators.SingleOrDefault(x => x.Id == item.indicatorKv.Value.Id)?.EventUserId;
                                    if (eventUserId is not null)
                                    {
                                        EventSpeechTypeId eventSpeechTypeId;
                                        string text;

                                        if (item.indicatorKv.Value.Position == 1)
                                        {
                                            eventSpeechTypeId = EventSpeechTypeId.PositionLeader;
                                            text = $"You are now in the lead";
                                        }
                                        else if (item.indicatorKv.Value.Position < previousPosition)
                                        {
                                            eventSpeechTypeId = EventSpeechTypeId.PositionGained;
                                            text = $"You have gained {previousPosition - item.indicatorKv.Value.Position} position";
                                            if (previousPosition - item.indicatorKv.Value.Position >= 2)
                                            {
                                                text += "s";
                                            }
                                        }
                                        else
                                        {
                                            eventSpeechTypeId = EventSpeechTypeId.PositionLost;
                                            text = $"You have lost {item.indicatorKv.Value.Position - previousPosition} position";
                                            if (item.indicatorKv.Value.Position - previousPosition >= 2)
                                            {
                                                text += "s";
                                            }
                                        }

                                        _ = GrainFactory.GetGrain<Event.IEventGrain>(new Guid(_race.EventId)).EventUserSpeechData(new Guid(eventUserId), eventSpeechTypeId, text);
                                        item.indicatorKv.Value.Speech = true;
                                    }
                                }

                                item.indicatorKv.Value.GapLeaderTime = null;
                                item.indicatorKv.Value.GapLeaderLaps = null;
                                item.indicatorKv.Value.GapIntervalTime = null;
                                item.indicatorKv.Value.GapIntervalLaps = null;

                                var heatStateIndicatorTime = item.indicatorKv.Value.AllTimeTypeTimes[HeatIndicatorTimeTypeId.Lap].LastOrDefault();
                                if (heatStateIndicatorTime is not null)
                                {
                                    if (leaderIndicator is not null)
                                    {
                                        (item.indicatorKv.Value.GapLeaderTime, item.indicatorKv.Value.GapLeaderLaps) = CalculateGap(heatStateIndicatorTime, leaderIndicator);
                                    }

                                    if (intervalIndicator is not null)
                                    {
                                        (item.indicatorKv.Value.GapIntervalTime, item.indicatorKv.Value.GapIntervalLaps) = CalculateGap(heatStateIndicatorTime, intervalIndicator);
                                    }
                                }

                                if (item.index == 0)
                                {
                                    leaderIndicator = item.indicatorKv.Value;
                                }
                                intervalIndicator = item.indicatorKv.Value;

                                //if (indicator.Position.HasValue && indicator.Laps.HasValue)
                                //{
                                //    //var _heatStatisticsLap = new HeatStatisticsLapMessage
                                //    //{
                                //    //    IndicatorId = deviceConfigurationInput.DeviceConfigurationInputId.Value,
                                //    //    Position = indicator.Position.Value,
                                //    //    Lap = indicator.Laps.Value
                                //    //};
                                //    //_statisticsLapAll.Add(_heatStatisticsLap);
                                //    //_statisticsLapDelta.Add(_heatStatisticsLap);
                                //}

                            }

                            //Console.WriteLine($"{deviceConfigurationInput.DeviceConfigurationInputId} {indicator.Laps!.Value} {time.Value} {state.TimerElapsed.Seconds}");

                            if (heatStateIndicator.Laps.HasValue)
                            {
                                var timerElapsed = Google.Protobuf.WellKnownTypes.Duration.FromTimeSpan(_heatJournalState.TimerElapsed.ToTimeSpan().Add((deviceConfigurationInput.Timestamp - _heatJournalState.TimerStartedAt!).ToTimeSpan()));
                                double? heatStateIndicatorTimeDisplay = heatStateIndicator.LatestTimeTypeTimes[HeatIndicatorTimeTypeId.Lap].Time.HasValue ? Math.Round(heatStateIndicator.LatestTimeTypeTimes[HeatIndicatorTimeTypeId.Lap].Time!.Value, _trackLaptimeDecimals) : null;
                                var heatStateIndicatorTimePrevious = heatStateIndicator.AllTimeTypeTimes[HeatIndicatorTimeTypeId.Lap].SkipLast(1).LastOrDefault()?.Time;

                                var heatAnalysis = new HeatAnalysis
                                {
                                    TimerElapsed = timerElapsed,
                                    IndicatorId = indicatorId,
                                    Lap = new HeatAnalysisLap
                                    {
                                        Position = heatStateIndicator.Position,
                                        Lap = heatStateIndicator.Laps!.Value,
                                        Time = heatStateIndicatorTimeDisplay,
                                    }
                                };

                                var heatStateIndicatorTime = heatStateIndicator.AllTimeTypeTimes[HeatIndicatorTimeTypeId.Lap].LastOrDefault();
                                if (heatStateIndicatorTime is not null)
                                {
                                    heatAnalysis.Lap.Pitlanes = heatStateIndicatorTime.Pitlanes;
                                    heatAnalysis.Lap.CarOffTracks = heatStateIndicatorTime.CarOffTracks;
                                }

                                _heatAnalyses.Items.Add(heatAnalysis);
                                _heatAnalysesDelta.Items.Add(heatAnalysis);
                                heatStateIndicator.LapWarning = false;

                                var heatStintAnalysisIndicatorStintLap = new HeatStintAnalysisIndicatorStintLap
                                {
                                    IndicatorId = indicatorId,
                                    TimerElapsed = heatAnalysis.TimerElapsed,
                                    Lap = heatAnalysis.Lap.Lap,
                                    Time = heatAnalysis.Lap.Time,
                                    Pitlanes = heatAnalysis.Lap.Pitlanes,
                                    CarOffTracks = heatAnalysis.Lap.CarOffTracks,

                                };
                                _allHeatStintAnalysisIndicatorStintLaps[indicatorId].Add(heatStintAnalysisIndicatorStintLap);

                                var heatStintAnalysisIndicatorStint = _heatStintAnalysisIndicatorStints[indicatorId].Items.LastOrDefault(x => x.Lap <= heatStateIndicator.Laps && heatStateIndicator.Laps >= 1);

                                if (heatStintAnalysisIndicatorStint is not null && heatStintAnalysisIndicatorStint.Lap >= 1)
                                {
                                    HeatStintAnalysisIndicatorStintUpdate(heatStintAnalysisIndicatorStint, heatStintAnalysisIndicatorStintLap);
                                    // _heatStintAnalysisIndicatorStints is already updated.

                                    var heatStintAnalysisIndicatorStintDelta = new HeatStintAnalysisIndicatorStint
                                    {
                                        Id = heatStintAnalysisIndicatorStint.Id,
                                        IndicatorId = heatStintAnalysisIndicatorStint.IndicatorId,
                                        Duration = heatStintAnalysisIndicatorStint.Duration,
                                        AverageTime = heatStintAnalysisIndicatorStint.AverageTime
                                    };
                                    heatStintAnalysisIndicatorStintDelta.Laps.Add(heatStintAnalysisIndicatorStintLap);
                                    _heatStintAnalysisIndicatorStintsDelta[indicatorId].Items.Add(heatStintAnalysisIndicatorStintDelta);
                                }

                                foreach (var otherItem in _indicators.Where(x => x.Key != deviceConfigurationInput.DeviceConfigurationInputId.Value))
                                {
                                    var gap = CalculateGap2(heatStateIndicator, otherItem.Value);
                                    if (gap.GapTime.HasValue)
                                    {
                                        heatAnalysis = new HeatAnalysis
                                        {
                                            TimerElapsed = timerElapsed,
                                            IndicatorId = deviceConfigurationInput.DeviceConfigurationInputId,
                                            Gap = new HeatAnalysisGap
                                            {
                                                IndicatorId = otherItem.Key,
                                                Value = Math.Round(gap.GapTime.Value, _trackLaptimeDecimals),
                                                DisplayValue = gap.GapLaps.HasValue ? $"{gap.GapLaps.Value}L" : gap.GapTime.Value.ToString(_trackLaptimeDecimalsFormat, CultureInfo.InvariantCulture)
                                            }
                                        };

                                        var heatAnalysesGapsQueue = _heatAnalysesGaps[Convert.ToByte(heatAnalysis.IndicatorId)][Convert.ToByte(heatAnalysis.Gap.IndicatorId)];
                                        var previousGap = heatAnalysesGapsQueue.LastOrDefault();
                                        heatAnalysesGapsQueue.Enqueue(heatAnalysis.Gap);
                                        while (heatAnalysesGapsQueue.Count > 5)
                                        {
                                            heatAnalysesGapsQueue.Dequeue();
                                        }

                                        if (previousGap is not null)
                                        {
                                            heatAnalysis.Gap.DeltaValue = heatAnalysis.Gap.Value - previousGap.Value;

                                            var time = heatStateIndicator.LatestTimeTypeTimes[HeatIndicatorTimeTypeId.Lap].Time;
                                            if (time.HasValue)
                                            {
                                                heatAnalysis.Gap.DeltaFraction = heatAnalysis.Gap.DeltaValue / time.Value;
                                            }
                                        }

                                        _heatAnalyses.Items.Add(heatAnalysis);
                                        _heatAnalysesDelta.Items.Add(heatAnalysis);

                                        heatAnalysis = new HeatAnalysis
                                        {
                                            TimerElapsed = timerElapsed,
                                            IndicatorId = otherItem.Key,
                                            Gap = new HeatAnalysisGap
                                            {
                                                IndicatorId = deviceConfigurationInput.DeviceConfigurationInputId.Value,
                                                Value = Math.Round(-gap.GapTime.Value, _trackLaptimeDecimals),
                                                DisplayValue = gap.GapLaps.HasValue ? $"-{gap.GapLaps.Value}L" : (-gap.GapTime.Value).ToString(_trackLaptimeDecimalsFormat, CultureInfo.InvariantCulture)
                                            }
                                        };

                                        heatAnalysesGapsQueue = _heatAnalysesGaps[Convert.ToByte(heatAnalysis.IndicatorId)][Convert.ToByte(heatAnalysis.Gap.IndicatorId)];
                                        previousGap = heatAnalysesGapsQueue.LastOrDefault();
                                        heatAnalysesGapsQueue.Enqueue(heatAnalysis.Gap);
                                        while (heatAnalysesGapsQueue.Count > 5)
                                        {
                                            heatAnalysesGapsQueue.Dequeue();
                                        }

                                        if (previousGap is not null)
                                        {
                                            heatAnalysis.Gap.DeltaValue = heatAnalysis.Gap.Value - previousGap.Value;

                                            var time = otherItem.Value.LatestTimeTypeTimes[HeatIndicatorTimeTypeId.Lap].Time;
                                            if (time.HasValue)
                                            {
                                                heatAnalysis.Gap.DeltaFraction = heatAnalysis.Gap.DeltaValue / time.Value;
                                            }
                                        }

                                        _heatAnalyses.Items.Add(heatAnalysis);
                                        _heatAnalysesDelta.Items.Add(heatAnalysis);
                                    }
                                }

                                //foreach (var otherItem in _indicators.Where(x => x.Key != deviceConfigurationInput.DeviceConfigurationInputId.Value))
                                //{
                                //    var gap = CalculateGap2(otherItem.Value, indicator);
                                //    if (gap.GapTime.HasValue)
                                //    {
                                //        heatAnalysis = new HeatAnalysis
                                //        {
                                //            TimerElapsed = timerElapsed,
                                //            IndicatorId = otherItem.Key,                                            
                                //            Gap = new HeatAnalysisGap
                                //            {
                                //                IndicatorId = deviceConfigurationInput.DeviceConfigurationInputId.Value,
                                //                GapValue = Math.Round(gap.GapTime.Value, _trackLaptimeDecimals),
                                //                GapString = gap.GapLaps.HasValue ? $"{gap.GapLaps.Value}L" : gap.GapTime.Value.ToString(_trackLaptimeDecimalsFormat, CultureInfo.InvariantCulture)
                                //            }
                                //        };

                                //        _heatAnalyses.Items.Add(heatAnalysis);
                                //        _heatAnalysesDelta.Items.Add(heatAnalysis);
                                //    }
                                //}

                                if (heatStateIndicator.LastEnergyTimestamp is not null)
                                {
                                    var deltaEnergyMilliseconds = heatStateIndicator.Motor * (deviceConfigurationInput.Timestamp - heatStateIndicator.LastEnergyTimestamp).ToTimeSpan().TotalMilliseconds;
                                    heatStateIndicator.TotalEnergyLevel = Math.Max(0, heatStateIndicator.TotalEnergyLevel - deltaEnergyMilliseconds);
                                    heatStateIndicator.CurrentEnergyLapLevel += deltaEnergyMilliseconds;
                                    if (heatStateIndicator.CurrentEnergyLapLevel > 0)
                                    {
                                        heatStateIndicator.LastEnergyLapLevels.Enqueue(heatStateIndicator.CurrentEnergyLapLevel);
                                        while (heatStateIndicator.LastEnergyLapLevels.Count > 10)
                                        {
                                            heatStateIndicator.LastEnergyLapLevels.Dequeue();
                                        }
                                    }
                                    heatStateIndicator.CurrentEnergyLapLevel = 0;
                                    //Console.WriteLine($"deltaEnergyMilliseconds={deltaEnergyMilliseconds} TotalEnergyMilliseconds={heatStateIndicator.TotalEnergyMilliseconds}");
                                }
                                heatStateIndicator.LastEnergyTimestamp = deviceConfigurationInput.Timestamp;


                                if (!replay && !heatStateIndicator.Speech && heatStateIndicator.Position > 0 && (heatStateIndicator.GapIntervalTime.HasValue || heatStateIndicator.GapIntervalLaps.HasValue))
                                {
                                    if (heatStateIndicator.GapIntervalCount <= 5)
                                    {
                                        heatStateIndicator.GapIntervalCount++;
                                    }
                                    else
                                    {
                                        heatStateIndicator.GapIntervalCount = 0;

                                        var eventUserId = _heat!.HeatIndicators.SingleOrDefault(x => x.Id == heatStateIndicator.Id)?.EventUserId;
                                        if (eventUserId is not null)
                                        {
                                            EventSpeechTypeId eventSpeechTypeId;
                                            string text;

                                            if (heatStateIndicator.GapIntervalLaps.HasValue && heatStateIndicator.GapIntervalLaps.Value >= 1)
                                            {
                                                eventSpeechTypeId = EventSpeechTypeId.GapAfter;
                                                text = $"You are {heatStateIndicator.GapIntervalLaps.Value} lap";
                                                if (heatStateIndicator.GapIntervalLaps.Value >= 2)
                                                {
                                                    text += "s";
                                                }
                                                text += " behind";
                                            }
                                            else
                                            {
                                                var gapSeconds = Math.Round(heatStateIndicator.GapIntervalTime.Value, 0);
                                                eventSpeechTypeId = EventSpeechTypeId.GapAfter;
                                                text = $"You are {gapSeconds} second";
                                                if (gapSeconds != 1)
                                                {
                                                    text += "s";
                                                }
                                                text += " behind";
                                            }

                                            _ = GrainFactory.GetGrain<Event.IEventGrain>(new Guid(_race.EventId)).EventUserSpeechData(new Guid(eventUserId), eventSpeechTypeId, text);
                                            heatStateIndicator.Speech = true;
                                        }
                                    }
                                }




                                if (!replay && !heatStateIndicator.Speech && heatStateIndicatorTimeDisplay.HasValue && heatStateIndicatorTimeDisplay!.Value > 0)
                                {
                                    var eventUserId = _heat!.HeatIndicators.SingleOrDefault(x => x.Id == heatStateIndicator.Id)?.EventUserId;
                                    if (eventUserId is not null)
                                    {
                                        var latestTimeTypeTimeLap = heatStateIndicator.LatestTimeTypeTimes.SingleOrDefault(x => x.Key == HeatIndicatorTimeTypeId.Lap).Value;
                                        if (latestTimeTypeTimeLap is not null && heatStateIndicatorTimeDisplay.HasValue)
                                        {
                                            EventSpeechTypeId eventSpeechTypeId;
                                            string text;
                                            switch (latestTimeTypeTimeLap.FastestTimeTypeId)
                                            {
                                                case HeatIndicatorFastestTimeTypeId.Indicator:
                                                    eventSpeechTypeId = EventSpeechTypeId.Fastest;
                                                    text = $"You set a new personal fastest lap  {heatStateIndicatorTimeDisplay}";
                                                    break;
                                                case HeatIndicatorFastestTimeTypeId.AllIndicators:
                                                    eventSpeechTypeId = EventSpeechTypeId.Faster;
                                                    text = $"You set the new overall fastest lap  {heatStateIndicatorTimeDisplay}";
                                                    break;

                                                default:
                                                    if (heatStateIndicatorTimePrevious.HasValue && heatStateIndicatorTimeDisplay.Value - heatStateIndicatorTimePrevious.Value < -1)
                                                    {
                                                        eventSpeechTypeId = EventSpeechTypeId.BadLap;
                                                    }
                                                    else
                                                    {
                                                        eventSpeechTypeId = EventSpeechTypeId.Undefined;
                                                    }
                                                    text = heatStateIndicatorTimeDisplay.Value.ToString();
                                                    break;
                                            }
                                            _ = GrainFactory.GetGrain<Event.IEventGrain>(new Guid(_race.EventId)).EventUserSpeechData(new Guid(eventUserId), eventSpeechTypeId, text);
                                        }
                                    }
                                }
                            }

                            heatStateIndicator.Speech = false;

                            if (heatStateIndicator.Finished && !_heatJournalState.Ended && !replay)
                            {
                                _ = RaiseHeatStateTypeAsync(HeatStateTypeId.Ended);
                            }
                        }

                        break;

                    case DeviceConfigurationInputTypeId.Sector1FinishIndicator:
                        heatStateIndicator.LastTimeTypeId = HeatIndicatorTimeTypeId.Sector1;
                        heatStateIndicator.LastTimestamp = deviceConfigurationInput.Timestamp.ToDateTime();

                        var deviceConfigurationInputSector1StartFinishPrevious = heatStateIndicator.DeviceConfigurationInputs.LastOrDefault(x => x.DeviceConfigurationInputTypeId == DeviceConfigurationInputTypeId.StartFinishIndicator);
                        CalculateTime(indicatorId, heatStateIndicator, deviceConfigurationInputSector1StartFinishPrevious, deviceConfigurationInput, HeatIndicatorTimeTypeId.Sector1);
                        break;

                    case DeviceConfigurationInputTypeId.Sector2FinishIndicator:
                        heatStateIndicator.LastTimeTypeId = HeatIndicatorTimeTypeId.Sector2;
                        heatStateIndicator.LastTimestamp = deviceConfigurationInput.Timestamp.ToDateTime();

                        var deviceConfigurationInputSector1Previous = heatStateIndicator.DeviceConfigurationInputs.LastOrDefault(x => x.DeviceConfigurationInputTypeId == DeviceConfigurationInputTypeId.Sector1FinishIndicator);
                        CalculateTime(indicatorId, heatStateIndicator, deviceConfigurationInputSector1Previous, deviceConfigurationInput, HeatIndicatorTimeTypeId.Sector2);
                        break;

                    case DeviceConfigurationInputTypeId.SpeedTrapFinishIndicator:
                        //var speedTrapStart = indicator.IndicatorMessages.LastOrDefault(x => x.DeviceInputTypeId == DeviceInputTypeId.SpeedTrapStartIndicator);
                        //var speedTrapFinish = indicator.IndicatorMessages.LastOrDefault(x => x.DeviceInputTypeId == DeviceInputTypeId.SpeedTrapFinishIndicator);
                        //if (speedTrapStart != null && speedTrapFinish != null)
                        //{
                        //    var timeSpan = speedTrapFinish.Timestamp - speedTrapStart.Timestamp;
                        //    if (timeSpan.TotalSeconds > 0)
                        //    {
                        //        //heatMessageIndicatorCalculations.SpeedTrapTime = timeSpan.TotalSeconds;
                        //    }
                        //}
                        break;

                    case DeviceConfigurationInputTypeId.Energy:
                        if (heatStateIndicator.LastEnergyTimestamp is not null)
                        {
                            var deltaEnergyMilliseconds = heatStateIndicator.Motor * (deviceConfigurationInput.Timestamp - heatStateIndicator.LastEnergyTimestamp).ToTimeSpan().TotalMilliseconds;
                            heatStateIndicator.TotalEnergyLevel = Math.Max(0, heatStateIndicator.TotalEnergyLevel - deltaEnergyMilliseconds);
                            heatStateIndicator.CurrentEnergyLapLevel += deltaEnergyMilliseconds;
                        }
                        heatStateIndicator.Motor = deviceConfigurationInput.IntValue;
                        heatStateIndicator.LastEnergyTimestamp = deviceConfigurationInput.Timestamp;

                        break;

                    case DeviceConfigurationInputTypeId.Tainted:
                        heatStateIndicator.LapWarning = true;
                        break;

                    case DeviceConfigurationInputTypeId.PitlaneEntry:
                        if (!heatStateIndicator.Finished)
                        {
                            heatStateIndicator.Pitlane = true;
                            heatStateIndicator.LapPitlanes++;
                            if (!replay)
                            {
                                //_logger.LogInformation($"Creating stint for indicatorId={indicatorId} HeatIndicatorId={heatStateIndicator.Id} Lap={heatStateIndicator.Laps!.Value}");
                                _heatIndicatorStintServiceClient.Create(new Razmanager.Protobuf.Internal.Repository.SystemServices.HeatIndicatorStint.HeatIndicatorStintCreate
                                {
                                    HeatIndicatorId = heatStateIndicator.Id,
                                    Lap = heatStateIndicator.Laps!.Value
                                });
                                _ = RefreshHeatIndicatorStintsAsync(new Guid(heatStateIndicator.Id));
                            }
                        }
                        break;

                    case DeviceConfigurationInputTypeId.PitlaneExit:
                        heatStateIndicator.Pitlane = false;
                        break;

                    case DeviceConfigurationInputTypeId.CarOnTrack:
                        if (deviceConfigurationInput.BoolValue)
                        {
                            heatStateIndicator.CarOffTrack = true;
                            heatStateIndicator.LapCarOffTracks++;
                        }
                        else
                        {
                            heatStateIndicator.CarOffTrack = false;
                        }
                        break;

                    //case DeviceConfigurationInputTypeId.Yellow:
                    //    if (!replay)
                    //    {
                    //        _ = RaiseHeatStateTypeAsync(HeatStateTypeId.Running);
                    //    }
                    //    break;

                    case DeviceConfigurationInputTypeId.Red:
                        if (!replay)
                        {
                            _ = RaiseHeatStateTypeAsync(HeatStateTypeId.Ended);
                        }
                        break;

                    default:
                        break;
                }

                if (deviceConfigurationInput.DeviceConfigurationInputTypeId == DeviceConfigurationInputTypeId.StartFinishIndicator ||
                    deviceConfigurationInput.DeviceConfigurationInputTypeId == DeviceConfigurationInputTypeId.StartFinishIndicatorIgnoreLapTime ||
                    deviceConfigurationInput.DeviceConfigurationInputTypeId == DeviceConfigurationInputTypeId.Sector1FinishIndicator ||
                    deviceConfigurationInput.DeviceConfigurationInputTypeId == DeviceConfigurationInputTypeId.Sector2FinishIndicator ||
                    deviceConfigurationInput.DeviceConfigurationInputTypeId == DeviceConfigurationInputTypeId.SpeedTrapStartIndicator ||
                    deviceConfigurationInput.DeviceConfigurationInputTypeId == DeviceConfigurationInputTypeId.SpeedTrapFinishIndicator)
                {
                    heatStateIndicator.DeviceConfigurationInputs.Add(deviceConfigurationInput);
                    while (heatStateIndicator.DeviceConfigurationInputs.Count > 10)
                    {
                        heatStateIndicator.DeviceConfigurationInputs.RemoveAt(0);
                    }
                }
            }
        }


        private void CalculateTime(byte indicatorId,
                                   HeatStateIndicator heatStateIndicator,
                                   DeviceConfigurationInput? previousDeviceConfigurationInput,
                                   DeviceConfigurationInput deviceConfigurationInput,
                                   HeatIndicatorTimeTypeId heatIndicatorTimeTypeId)
        {
            var heatIndicatorTimeTypeTime = heatStateIndicator.LatestTimeTypeTimes[heatIndicatorTimeTypeId];
            var previousTime = heatIndicatorTimeTypeTime.Time;
            heatIndicatorTimeTypeTime.Time = null;

            if (previousDeviceConfigurationInput is not null)
            {
                if (!heatStateIndicator.IgnoreLapTime)
                {
                    if (deviceConfigurationInput.LapTime.HasValue)
                    {
                        heatIndicatorTimeTypeTime.Time = deviceConfigurationInput.LapTime.Value;
                    }
                    else
                    {
                        heatIndicatorTimeTypeTime.Time = (deviceConfigurationInput.Timestamp - previousDeviceConfigurationInput.Timestamp).ToTimeSpan().TotalSeconds;
                    }
                    heatIndicatorTimeTypeTime.FastestTimeTypeId = HeatIndicatorFastestTimeTypeId.None;

                    if (!heatIndicatorTimeTypeTime.FastestTime.HasValue)
                    {
                        // No previous fastest time
                        heatIndicatorTimeTypeTime.FastestTime = heatIndicatorTimeTypeTime.Time;
                    }
                    else
                    {
                        if (heatIndicatorTimeTypeTime.FastestTime > heatIndicatorTimeTypeTime.Time)
                        {
                            // New indicator fastest time
                            heatIndicatorTimeTypeTime.FastestTime = heatIndicatorTimeTypeTime.Time;
                            heatIndicatorTimeTypeTime.FastestTimeTypeId = HeatIndicatorFastestTimeTypeId.Indicator;
                        }
                    }

                    if (_timeTypeFastestTimes[heatIndicatorTimeTypeId].Time > heatIndicatorTimeTypeTime.Time)
                    {
                        // New overall fastest time

                        // Reset all indicators AllIndicators flags to Indicator flag
                        foreach (var i in _indicators)
                        {
                            if (i.Value.LatestTimeTypeTimes[heatIndicatorTimeTypeId].FastestTimeTypeId == HeatIndicatorFastestTimeTypeId.AllIndicators)
                            {
                                i.Value.LatestTimeTypeTimes[heatIndicatorTimeTypeId].FastestTimeTypeId = HeatIndicatorFastestTimeTypeId.Indicator;
                            }
                        }

                        // Add new time and set the indicator's AllIndicators flag
                        _timeTypeFastestTimes[heatIndicatorTimeTypeId] = (indicatorId, heatIndicatorTimeTypeTime.Time.Value);
                        heatIndicatorTimeTypeTime.FastestTimeTypeId = HeatIndicatorFastestTimeTypeId.AllIndicators;
                    }
                }
                heatStateIndicator.AllTimeTypeTimes[HeatIndicatorTimeTypeId.Lap].Add(new HeatStateIndicatorTime
                {
                    Timestamp = deviceConfigurationInput.Timestamp.ToDateTime(),
                    Lap = heatStateIndicator.Laps!.Value,
                    Time = heatIndicatorTimeTypeTime.Time,
                    Pitlanes = heatStateIndicator.LapPitlanes,
                    CarOffTracks = heatStateIndicator.LapCarOffTracks
                });
                heatStateIndicator.LapPitlanes = 0;
                heatStateIndicator.LapCarOffTracks = 0;
            }
            if (heatIndicatorTimeTypeId == HeatIndicatorTimeTypeId.Lap && _heatJournalState.HeatStateTypeId == HeatStateTypeId.Running)
            {
                heatStateIndicator.IgnoreLapTime = false;
            }
        }


        private (double? GapTime, short? GapLaps) CalculateGap(HeatStateIndicatorTime heatStateIndicatorTime, HeatStateIndicator otherIndicator)
        {
            var otherHeatStateIndicatorTime = otherIndicator.AllTimeTypeTimes[HeatIndicatorTimeTypeId.Lap].LastOrDefault();
            if (otherHeatStateIndicatorTime is null)
            {
                return (null, null);
            }

            if (heatStateIndicatorTime.Timestamp > otherHeatStateIndicatorTime.Timestamp)
            {
                if (heatStateIndicatorTime.Lap == otherHeatStateIndicatorTime.Lap)
                {
                    return ((heatStateIndicatorTime.Timestamp - otherHeatStateIndicatorTime.Timestamp).TotalSeconds, null);
                }
                else
                {
                    return (null, Convert.ToInt16(otherHeatStateIndicatorTime.Lap - heatStateIndicatorTime.Lap));
                }
            }
            else
            {
                otherHeatStateIndicatorTime = otherIndicator
                    .AllTimeTypeTimes[HeatIndicatorTimeTypeId.Lap]
                    .SingleOrDefault(x => x.Lap == otherHeatStateIndicatorTime.Lap - 1);
                if (otherHeatStateIndicatorTime is null)
                {
                    return (null, null);
                }

                if (heatStateIndicatorTime.Lap == otherHeatStateIndicatorTime.Lap)
                {
                    return ((heatStateIndicatorTime.Timestamp - otherHeatStateIndicatorTime.Timestamp).TotalSeconds, null);
                }
                else
                {
                    return (null, Convert.ToInt16(otherHeatStateIndicatorTime.Lap - heatStateIndicatorTime.Lap));
                }
            }
        }


        private (double? GapTime, short? GapLaps) CalculateGap2(HeatStateIndicator indicator, HeatStateIndicator otherIndicator)
        {
            var heatStateIndicatorTime = indicator.AllTimeTypeTimes[HeatIndicatorTimeTypeId.Lap].LastOrDefault();
            if (heatStateIndicatorTime is null)
            {
                return (null, null);
            }

            var otherHeatStateIndicatorTime = otherIndicator.AllTimeTypeTimes[HeatIndicatorTimeTypeId.Lap].LastOrDefault();
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
                        .AllTimeTypeTimes[HeatIndicatorTimeTypeId.Lap]
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
                        .AllTimeTypeTimes[HeatIndicatorTimeTypeId.Lap]
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
                    //    .AllTimeTypeTimes[HeatIndicatorTimeTypeId.Lap]
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


        private void HeatStintAnalysisIndicatorStintUpdate(HeatStintAnalysisIndicatorStint heatStintAnalysisIndicatorStint, HeatStintAnalysisIndicatorStintLap heatStintAnalysisIndicatorStintLap)
        {
            if (heatStintAnalysisIndicatorStint.Lap >= 1)
            {
                heatStintAnalysisIndicatorStint.Laps.Add(heatStintAnalysisIndicatorStintLap);

                var heatIndicatorStintLapFirst = heatStintAnalysisIndicatorStint.Laps.FirstOrDefault();
                var heatIndicatorStintLapLast = heatStintAnalysisIndicatorStint.Laps.LastOrDefault(x => x.Time.HasValue);
                if (heatIndicatorStintLapFirst is not null && heatIndicatorStintLapLast is not null)
                {
                    heatStintAnalysisIndicatorStint.Duration = heatIndicatorStintLapLast.TimerElapsed + Google.Protobuf.WellKnownTypes.Duration.FromTimeSpan(TimeSpan.FromSeconds(heatIndicatorStintLapLast.Time!.Value)) - heatIndicatorStintLapFirst.TimerElapsed;
                }

                if (heatStintAnalysisIndicatorStint.Laps.Count >= 3)
                {
                    var heatIndicatorStintLapSecondFirst = heatStintAnalysisIndicatorStint.Laps.Skip(1).FirstOrDefault();
                    var heatIndicatorStintLapSecondLast = heatStintAnalysisIndicatorStint.Laps.Reverse().Skip(1).FirstOrDefault(x => x.Time.HasValue);
                    if (heatIndicatorStintLapSecondFirst is not null && heatIndicatorStintLapSecondLast is not null)
                    {
                        var duration = heatIndicatorStintLapSecondLast.TimerElapsed + Google.Protobuf.WellKnownTypes.Duration.FromTimeSpan(TimeSpan.FromSeconds(heatIndicatorStintLapSecondLast.Time!.Value)) - heatIndicatorStintLapSecondFirst.TimerElapsed;
                        heatStintAnalysisIndicatorStint.AverageTime = Math.Round(duration.ToTimeSpan().TotalSeconds / (heatStintAnalysisIndicatorStint.Laps.Count - 2), _trackLaptimeDecimals);
                    }
                }
            }
        }


        private async Task PublishStateAsync()
        {
            _ = _heatStateStream!.OnNextAsync(HeatState());
            _ = _heatLeaderboardStream!.OnNextAsync(HeatLeaderboard());

            await _heatAnalysesStream!.OnNextAsync(_heatAnalysesDelta);
            _heatAnalysesDelta = new();

            foreach (var item in _heat!.HeatIndicators)
            {
                var delta = _heatStintAnalysisIndicatorStintsDelta[Convert.ToByte(item.IndicatorId)];
                if (delta.Items.Count != 0)
                {
                    await _heatStintAnalysisStreams[Convert.ToByte(item.IndicatorId)]!.OnNextAsync(new HeatStintAnalysis
                        {
                            Refresh = false,
                            HeatStintAnalysisIndicatorStints = _heatStintAnalysisIndicatorStintsDelta[Convert.ToByte(item.IndicatorId)]
                        });
                    delta.Items.Clear();
                }
            }
        }


        private Razmanager.Protobuf.Public.V1.HeatState HeatState()
        {
            var lapsCurrent = _indicators.Max(x => x.Value.Laps);
            if (lapsCurrent.HasValue && !_heatJournalState.Ended)
            {
                lapsCurrent++;
            }

            var heatState = new Razmanager.Protobuf.Public.V1.HeatState
            {
                HeatStateType = new Razmanager.Protobuf.Public.V1.HeatStateType
                {
                    Id = _heatJournalState.HeatStateTypeId,
                    Name = new ResourceManager(typeof(RazManager.Resources.HeatStateType)).GetString(_heatJournalState.HeatStateTypeId.ToString())
                },
                LapsCurrent = lapsCurrent,
                TimerIsRunning = ClockIsRunning,
                TimerElapsed = Google.Protobuf.WellKnownTypes.Duration.FromTimeSpan(ClockElapsedNow),
                StartLightId = _heatJournalState.StartLightId,
            };

            return heatState;
        }


        private HeatLeaderboard HeatLeaderboard()
        {
            var heatLeaderboard = new HeatLeaderboard
            {
                CorrelationId = _correlationId.HasValue ? _correlationId.ToString() : null,
            };

            foreach (var heatStateInternalIndicatorKv in _indicators)
            {
                var heatLeaderboardIndicator = new HeatLeaderboardIndicator
                {
                    IndicatorId = heatStateInternalIndicatorKv.Key,
                    Position = heatStateInternalIndicatorKv.Value.Position,
                    Laps = heatStateInternalIndicatorKv.Value.Laps,
                };

                if (heatStateInternalIndicatorKv.Value.Finished)
                {
                    heatLeaderboardIndicator.Flags.Add(HeatIndicatorFlag.Finished);
                }

                if (heatStateInternalIndicatorKv.Value.GapLeaderTime.HasValue)
                {
                    heatLeaderboardIndicator.GapLeader = heatStateInternalIndicatorKv.Value.GapLeaderTime.Value.ToString(_trackLaptimeDecimalsFormat, CultureInfo.InvariantCulture);
                }
                else if (heatStateInternalIndicatorKv.Value.GapLeaderLaps.HasValue)
                {
                    heatLeaderboardIndicator.GapLeader = $"{heatStateInternalIndicatorKv.Value.GapLeaderLaps.Value}L";
                }
                if (heatStateInternalIndicatorKv.Value.GapIntervalTime.HasValue)
                {
                    heatLeaderboardIndicator.GapInterval = heatStateInternalIndicatorKv.Value.GapIntervalTime.Value.ToString(_trackLaptimeDecimalsFormat, CultureInfo.InvariantCulture);
                }
                else if (heatStateInternalIndicatorKv.Value.GapIntervalLaps.HasValue)
                {
                    heatLeaderboardIndicator.GapInterval = $"{heatStateInternalIndicatorKv.Value.GapIntervalLaps.Value}L";
                }

                if (_timeTypeFastestTimes[HeatIndicatorTimeTypeId.Lap].IndicatorId == heatStateInternalIndicatorKv.Key)
                {
                    heatLeaderboardIndicator.Flags.Add(HeatIndicatorFlag.FastestLap);
                }
                if (heatStateInternalIndicatorKv.Value.LapWarning)
                {
                    heatLeaderboardIndicator.Flags.Add(HeatIndicatorFlag.Warning);
                }
                if (heatStateInternalIndicatorKv.Value.Pitlane)
                {
                    heatLeaderboardIndicator.Flags.Add(HeatIndicatorFlag.Pitlane);
                }
                if (heatStateInternalIndicatorKv.Value.CarOffTrack)
                {
                    heatLeaderboardIndicator.Flags.Add(HeatIndicatorFlag.CarOffTrack);
                }

                foreach (var heatIndicatorTimeTypeTime in heatStateInternalIndicatorKv.Value.LatestTimeTypeTimes)
                {
                    heatLeaderboardIndicator.TimeTypeTimes.Add(new HeatIndicatorTimeTypeTime
                    {
                        TimeTypeId = heatIndicatorTimeTypeTime.Key,
                        Time = heatIndicatorTimeTypeTime.Value.Time.HasValue ? Math.Round(heatIndicatorTimeTypeTime.Value.Time.Value, _trackLaptimeDecimals) : null,
                        FastestTimeTypeId = heatIndicatorTimeTypeTime.Value.FastestTimeTypeId,
                        FastestTime = heatIndicatorTimeTypeTime.Value.FastestTime.HasValue ? Math.Round(heatIndicatorTimeTypeTime.Value.FastestTime.Value, _trackLaptimeDecimals) : null,                        
                        //Times = heatStateIndicatorTimeTypeTime
                        //    .Times.OrderByDescending(x => x.Lap)
                        //    .Select(x => new HeatOutputIndicatorCorrelationIdTimeMessage
                        //    {
                        //        CorrelationId = new Guid(x.CorrelationId),
                        //        Lap = x.Lap,
                        //        Time = x.Time.ToString(_trackLaptimeDecimalsSecondsFormat, CultureInfo.InvariantCulture)

                        //    })
                        //    .ToArray()
                    });
                }

                heatLeaderboardIndicator.EnergyPercent = Convert.ToUInt32(Math.Round(100 * heatStateInternalIndicatorKv.Value.TotalEnergyLevel / _totalEnergyLevel, 0));
                if (heatStateInternalIndicatorKv.Value.LastEnergyLapLevels.Count > 0)
                {
                    heatLeaderboardIndicator.EnergyLapsLeft = Convert.ToUInt32(Math.Round(heatStateInternalIndicatorKv.Value.TotalEnergyLevel / heatStateInternalIndicatorKv.Value.LastEnergyLapLevels.Average(), 0));
                }

                heatLeaderboard.Indicators.Add(heatLeaderboardIndicator);

                if (heatLeaderboardIndicator.EnergyPercent <= 0)
                {
                    heatStateInternalIndicatorKv.Value.TotalEnergyLevel = _totalEnergyLevel;
                }


                if (_heatStintAnalysisIndicatorStints.TryGetValue(Convert.ToByte(heatStateInternalIndicatorKv.Key), out var heatStintAnalysisIndicatorStints))
                {
                    var lastStint = heatStintAnalysisIndicatorStints.Items.LastOrDefault();
                    if (lastStint is not null)
                    {
                        heatLeaderboardIndicator.TeamEventUserId = lastStint.EventUserId;
                    }
                }
            }

            return heatLeaderboard;
        }


        private bool ClockIsRunning => _heatJournalState.HeatStateTypeId == HeatStateTypeId.Running || _heatJournalState.HeatStateTypeId == HeatStateTypeId.Yellow || _heatJournalState.HeatStateTypeId == HeatStateTypeId.CountdownYellow;


        private TimeSpan ClockElapsedNow
        {
            get
            {
                switch (_heatJournalState.HeatStateTypeId)
                {
                    case HeatStateTypeId.Pending:
                    case HeatStateTypeId.Opened:
                        return new TimeSpan();

                    case HeatStateTypeId.Running:
                    case HeatStateTypeId.Yellow:
                    case HeatStateTypeId.CountdownYellow:
                        return _heatJournalState.TimerStartedAt is null ?
                                new TimeSpan() :
                                (_heatJournalState.Timestamp - _heatJournalState.TimerStartedAt).ToTimeSpan() + _heatJournalState.TimerElapsed.ToTimeSpan();

                    default:
                        return _heatJournalState.TimerElapsed.ToTimeSpan();
                }
            }
        }


        private class StartLightMessage
        {
        }


        private class HeatStateIndicator
        {
            public required string Id { get; set; }
            public uint Position { get; set; }
            public ushort? Laps { get; set; }
            public HeatIndicatorTimeTypeId? LastTimeTypeId { get; set; }
            public DateTime? LastTimestamp { get; set; }
            public double? GapLeaderTime { get; set; }
            public short? GapLeaderLaps { get; set; }
            public double? GapIntervalTime { get; set; }
            public short? GapIntervalLaps { get; set; }
            public double GapIntervalCount { get; set; }
            public bool Finished { get; set; }
            public bool LapWarning { get; set; }
            public bool Pitlane { get; set; }
            public ushort LapPitlanes { get; set; }
            public bool CarOffTrack { get; set; }
            public ushort LapCarOffTracks { get; set; }
            public bool IgnoreLapTime { get; set; } = true;
            public bool Speech { get; set; }
            public Dictionary<HeatIndicatorTimeTypeId, HeatIndicatorTimeTypeTime> LatestTimeTypeTimes = [];
            public Dictionary<HeatIndicatorTimeTypeId, List<HeatStateIndicatorTime>> AllTimeTypeTimes = [];
            public List<DeviceConfigurationInput> DeviceConfigurationInputs { get; set; } = [];

            public uint Motor { get; set; }
            public Google.Protobuf.WellKnownTypes.Timestamp? LastEnergyTimestamp { get; set; }
            public double CurrentEnergyLapLevel { get; set; }
            public double TotalEnergyLevel { get; set; } = _totalEnergyLevel;
            public Queue<double> LastEnergyLapLevels = new();
        }


        private class HeatStateIndicatorTime
        {
            public required DateTime Timestamp { get; set; }
            public required ushort Lap { get; set; }
            public required double? Time { get; set; }
            public required ushort Pitlanes { get; set; }
            public required ushort CarOffTracks { get; set; }
        }
    }
}
