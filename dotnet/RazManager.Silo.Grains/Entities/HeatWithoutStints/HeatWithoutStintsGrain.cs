using Microsoft.Extensions.Logging;
using Orleans.Streams;
using Razmanager.Protobuf.Internal.Silo.UserServices.Event;
using Razmanager.Protobuf.Public.V1;
using RazManager.Silo.Grains.Entities.HeatStint;
using System.Globalization;
using System.Resources;


namespace RazManager.Silo.Grains.Entities.HeatWithoutStints
{
    public class HeatWithoutStintsGrain : HeatStintGrainBase, IHeatWithoutStintsGrain
    {
        private readonly Razmanager.Protobuf.Internal.Repository.SystemServices.RaceSessionWithoutStints.RaceSessionWithoutStintsService.RaceSessionWithoutStintsServiceClient _raceSessionWithoutStintsServiceClient;
        private readonly Razmanager.Protobuf.Internal.Repository.SystemServices.HeatWithoutStints.HeatWithoutStintsService.HeatWithoutStintsServiceClient _serviceClient;
        private readonly Razmanager.Protobuf.Internal.Repository.SystemServices.HeatIndicatorStint.HeatIndicatorStintService.HeatIndicatorStintServiceClient _heatIndicatorStintServiceClient;
        private Razmanager.Protobuf.Public.V1.RaceSessionWithoutStints? _raceSessionWithoutStints;
        private Razmanager.Protobuf.Public.V1.HeatWithoutStints? _heatWithoutStints;

        private const double _totalEnergyLevel = 10000000;

        //private Dictionary<IndicatorTimeTypeId, (byte? IndicatorId, double? Time)> _timeTypeFastestTimes = [];
        //private HeatAnalyses _heatAnalyses = new();
        //private HeatAnalyses _heatAnalysesDelta = new();
        //private Dictionary<byte, Dictionary<byte, Queue<HeatAnalysisGap>>> _heatAnalysesGaps = [];
        private Dictionary<byte, List<HeatStintAnalysisIndicatorStintLap>> _allHeatStintAnalysisIndicatorStintLaps = [];
        private Dictionary<byte, HeatStintAnalysisIndicatorStints> _heatStintAnalysisIndicatorStints = [];
        private Dictionary<byte, HeatStintAnalysisIndicatorStints> _heatStintAnalysisIndicatorStintsDelta = [];

        //private Guid? _correlationId ;
        //private bool _unsubscribe = false;

        //private IDisposable? _startLightDisposable;
        //private IDisposable? _offDisposable;

        private IAsyncStream<DetailState>? _heatWithoutStintsStateStream;
        private IAsyncStream<HeatWithoutStintsLeaderboard>? _heatWithoutStintsLeaderboardStream;
        private IAsyncStream<HeatAnalyses>? _heatAnalysesStream;
        private Dictionary<byte, IAsyncStream<HeatStintAnalysis>?> _heatStintAnalysisStreams = [];

        private readonly ILogger<HeatWithoutStintsGrain> _logger;

        public HeatWithoutStintsGrain(Razmanager.Protobuf.Internal.Repository.SystemServices.Event.EventService.EventServiceClient eventServiceClient, 
                                     Razmanager.Protobuf.Internal.Repository.SystemServices.Race.RaceService.RaceServiceClient raceServiceClient,
                                     Razmanager.Protobuf.Internal.Repository.SystemServices.RaceSessionWithoutStints.RaceSessionWithoutStintsService.RaceSessionWithoutStintsServiceClient raceSessionWithoutStintsServiceClient,
                                     Razmanager.Protobuf.Internal.Repository.SystemServices.HeatWithoutStints.HeatWithoutStintsService.HeatWithoutStintsServiceClient serviceClient,
                                     Razmanager.Protobuf.Internal.Repository.SystemServices.HeatIndicatorStint.HeatIndicatorStintService.HeatIndicatorStintServiceClient heatIndicatorStintServiceClient,
                                     ILogger<HeatWithoutStintsGrain> logger) : base(eventServiceClient, raceServiceClient, logger)
        {
            _raceSessionWithoutStintsServiceClient = raceSessionWithoutStintsServiceClient;
            _serviceClient = serviceClient;
            _heatIndicatorStintServiceClient = heatIndicatorStintServiceClient;
            _logger = logger;
        }


        public override async Task OnActivateAsync(CancellationToken cancellationToken)
        {
            try
            {
                _heatWithoutStints = await _serviceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });
                _raceSessionWithoutStints = await _raceSessionWithoutStintsServiceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = _heatWithoutStints.RaceSessionId });
                race = await raceServiceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = _raceSessionWithoutStints.RaceId });
                @event = await eventServiceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = race.EventId });

                var heatStintJournalsResponse = await _serviceClient.ListHeatJournalsAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });

                await OnActivateBaseAsync(2, heatStintJournalsResponse.HeatStintJournals);

                _heatWithoutStints!.StateType = new Razmanager.Protobuf.Public.V1.DetailStateType
                {
                    Id = heatStintJournalState!.HeatStintStateTypeId,
                    Name = new ResourceManager(typeof(RazManager.Resources.DetailStateType)).GetString(heatStintJournalState.HeatStintStateTypeId.ToString())
                };

                var streamProvider = this.GetStreamProvider(Constants.StreamProvider);
                _heatWithoutStintsStateStream = streamProvider.GetStream<DetailState>(Constants.StreamName.HeatWithoutStintsState.ToString(), this.GetPrimaryKey());
                _heatWithoutStintsLeaderboardStream = streamProvider.GetStream<HeatWithoutStintsLeaderboard>(Constants.StreamName.HeatWithoutStintsLeaderboard.ToString(), this.GetPrimaryKey());
                _heatAnalysesStream = streamProvider.GetStream<HeatAnalyses>(Constants.StreamName.HeatAnalyses.ToString(), this.GetPrimaryKey());
                foreach (var item in _heatWithoutStints!.HeatIndicators)
                {
                    _heatStintAnalysisStreams.Add(Convert.ToByte(item.IndicatorId), streamProvider.GetStream<HeatStintAnalysis>(Constants.StreamName.HeatStintAnalysis.ToString(), $"{this.GetPrimaryKey()}:{item.IndicatorId}"));
                }
            }
            catch (Grpc.Core.RpcException exception)
            {
                if (exception.StatusCode == Grpc.Core.StatusCode.NotFound)
                {
                    _unsubscribe = true;
                }
            }
        }


        public async Task RefreshHeatIndicatorStintsAsync(Guid heatIndicatorId)
        {
            var newHeat = await _serviceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });
            if (newHeat is not null) {
                var newHeatIndicator = newHeat.HeatIndicators.SingleOrDefault(x => new Guid(x.Id) == heatIndicatorId);
                var heatIndicator = _heatWithoutStints!.HeatIndicators.SingleOrDefault(x => new Guid(x.Id) == heatIndicatorId);
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
                }
            }
        }


        protected override void InitializeIndicators()
        {
            _timeTypeFastestTimes.Clear();
            foreach (var indicatorTimeTypeId in System.Enum.GetValues<IndicatorTimeTypeId>())
            {
                _timeTypeFastestTimes[indicatorTimeTypeId] = (null, double.MaxValue);
            }

            indicators.Clear();
            _heatAnalysesGaps.Clear();
            _allHeatStintAnalysisIndicatorStintLaps.Clear();
            _heatStintAnalysisIndicatorStints.Clear();
            _heatStintAnalysisIndicatorStintsDelta.Clear();
            foreach (var item in _heatWithoutStints!.HeatIndicators.OrderBy(x => x.IndicatorId).Select((indicator, index) => new { indicator, index }))
            {
                var heatStateIndicator = new IndicatorState
                {
                    Id = item.indicator.Id,
                    EventUserId = _heatWithoutStints!.HeatIndicators.SingleOrDefault(x => x.Id == item.indicator.Id)?.EventUserId,
                    Position = Convert.ToUInt32(item.index + 1)
                };

                foreach (var indicatorTimeTypeId in System.Enum.GetValues<IndicatorTimeTypeId>())
                {
                    heatStateIndicator.LatestTimeTypeTimes[indicatorTimeTypeId] = new IndicatorTimeTypeTime();
                    heatStateIndicator.AllTimeTypeTimes[indicatorTimeTypeId] = [];
                }

                indicators.Add(Convert.ToByte(item.indicator.IndicatorId), heatStateIndicator);

                Dictionary<byte, Queue<HeatAnalysisGap>> indicatorHeatAnalysisGaps = [];
                foreach (var otherItem in _heatWithoutStints!.HeatIndicators.OrderBy(x => x.IndicatorId).Where(x => x.IndicatorId != item.indicator.IndicatorId))
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

            heatAnalyses = new();
            heatAnalysesDelta = new();
        }


        public Task<Razmanager.Protobuf.Public.V1.HeatWithoutStints> ReadAsync()
        {
            return Task.FromResult(_heatWithoutStints!);
        }


        public Task<Razmanager.Protobuf.Public.V1.DetailState> ReadStateAsync()
        {
            heatStintJournalState!.Timestamp = Google.Protobuf.WellKnownTypes.Timestamp.FromDateTime(DateTime.UtcNow);
            return Task.FromResult(HeatStintState());
        }


        public Task<Razmanager.Protobuf.Public.V1.HeatWithoutStintsLeaderboard> ReadLeaderboardAsync()
        {
            return Task.FromResult(HeatWithoutStintsLeaderboard());
        }


        public Task<HeatStintAnalysisIndicatorStints> ReadHeatStintAnalysisIndicatorStintsAsync(byte indicatorId)
        {
            return Task.FromResult(_heatStintAnalysisIndicatorStints[indicatorId]);
        }


        public Task<HeatStintEventUsers> ReadHeatStintEventUsersAsync()
        {
            var result = new HeatStintEventUsers();

            foreach (var heatIndicator in _heatWithoutStints!.HeatIndicators)
            {
                var heatStintEventUsersIndicator = new HeatStintEventUsersIndicator { IndicatorId = heatIndicator.IndicatorId };
                heatStintEventUsersIndicator.Laps.AddRange(heatIndicator.HeatIndicatorStints
                    .Where(x => !string.IsNullOrEmpty(x.EventUserId))
                    .Select(x => new HeatStintEventUsersIndicatorLap { Lap = x.Lap, EventUserId = x.EventUserId }));
                result.Indicators.Add(heatStintEventUsersIndicator);
            }
            return Task.FromResult(result);
        }


        protected override async Task RaiseHeatStintStateTypeAsync(Razmanager.Protobuf.Public.V1.DetailStateTypeId heatStintStateTypeId)
        {
            if (heatStintStateTypeId == DetailStateTypeId.Pending ||
                heatStintStateTypeId == DetailStateTypeId.Opened)
            {
                await _serviceClient.DeleteStintsAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });
                await _serviceClient.DeleteHeatJournalsAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });
                
                // Refresh stints
                _heatWithoutStints = await _serviceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });
            }

            heatStintJournalState!.Timestamp = Google.Protobuf.WellKnownTypes.Timestamp.FromDateTime(DateTime.UtcNow);

            var proto = new Razmanager.Protobuf.Internal.Repository.SystemServices.HeatStintJournal.HeatStintJournalCreateRequest
            {
                HeatStintId = this.GetPrimaryKey().ToString(),
                //SequenceNumber
                HeatStintJournal = new Razmanager.Protobuf.Internal.Repository.SystemServices.HeatStintJournal.HeatStintJournal
                {
                    HeatStintJournalState = heatStintJournalState,
                    HeatStintStateTypeId = heatStintStateTypeId
                }
            };

            await CreateHeatStintJournalAsync(proto);

            TransitionStateHeatStintStateType(heatStintStateTypeId);

            _heatWithoutStints!.StateType = new Razmanager.Protobuf.Public.V1.DetailStateType
            {
                Id = heatStintJournalState.HeatStintStateTypeId,
                Name = new ResourceManager(typeof(RazManager.Resources.DetailStateType)).GetString(heatStintJournalState.HeatStintStateTypeId.ToString())
            };

            await TrackConfigurationDeviceInputStreamSubscriptionStateAsync();

            if (_offDisposable != null)
            {
                _offDisposable.Dispose();
                _offDisposable = null;
            }
            if (heatStintJournalState.HeatStintStateTypeId == DetailStateTypeId.Ended)
            {
                _offDisposable = this.RegisterGrainTimer(() => RaiseHeatStintStateTypeAsync(DetailStateTypeId.Off), TimeSpan.FromSeconds(30), TimeSpan.FromDays(1));
            }

            _ = GrainFactory.GetGrain<RaceSessionWithoutStints.IRaceSessionWithoutStintsGrain>(
                new Guid(_heatWithoutStints!.RaceSessionId)).HeatWithoutStintsStateTypeUpdatedAsync(_heatWithoutStints!);

            _ = PublishStateAsync();

            _ = RaisedHeatStintStateTypeAsync(heatStintStateTypeId);
        }


        protected override void TransitionStateDeviceConfigurationInput(DeviceConfigurationInput deviceConfigurationInput, bool replay)
        {
            if (string.IsNullOrEmpty(deviceConfigurationInput.CorrelationId))
            {
                correlationId = null;
            }
            else
            {
                correlationId = new Guid(deviceConfigurationInput.CorrelationId);
            }

            if (deviceConfigurationInput.DeviceConfigurationInputId.HasValue)
            {
                if (!indicators.ContainsKey(Convert.ToByte(deviceConfigurationInput.DeviceConfigurationInputId.Value)))
                {
                    // Input from an indicator that is not a part of the heat.
                    return;
                }

                if (heatStintJournalState!.TimerStartedAt is null)
                {
                    // Timer not started yet.
                    return;
                }

                var indicatorId = Convert.ToByte(deviceConfigurationInput.DeviceConfigurationInputId.Value);
                var indicatorState = indicators[indicatorId];

                switch (deviceConfigurationInput.DeviceConfigurationInputTypeId)
                {
                    case DeviceConfigurationInputTypeId.StartFinishIndicator:
                    case DeviceConfigurationInputTypeId.StartFinishIndicatorIgnoreLapTime:

                        if (deviceConfigurationInput.DeviceConfigurationInputTypeId == DeviceConfigurationInputTypeId.StartFinishIndicatorIgnoreLapTime)
                        {
                            indicatorState.IgnoreLapTime = true;
                        }

                        if (!indicatorState.Finished)
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

                            if (!indicatorState.Laps.HasValue)
                            {
                                indicatorState.Laps = 0;
                            }
                            else
                            {
                                indicatorState.Laps++;
                            }

                            indicatorState.LastTimeTypeId = IndicatorTimeTypeId.Lap;
                            indicatorState.LastTimestamp = deviceConfigurationInput.Timestamp.ToDateTime();

                            var deviceConfigurationInputStartFinishPrevious = indicatorState.DeviceConfigurationInputs.LastOrDefault(x => x.DeviceConfigurationInputTypeId == DeviceConfigurationInputTypeId.StartFinishIndicator || x.DeviceConfigurationInputTypeId == DeviceConfigurationInputTypeId.StartFinishIndicatorIgnoreLapTime);
                            CalculateTime(indicatorId, indicatorState, deviceConfigurationInputStartFinishPrevious, deviceConfigurationInput, IndicatorTimeTypeId.Lap);

                            if ((_raceSessionWithoutStints!.HeatStintEndTypeId == HeatStintEndTypeId.Lap && _raceSessionWithoutStints.HeatStintEndLapLaps <= indicatorState.Laps.Value ||
                                _raceSessionWithoutStints!.HeatStintEndTypeId == HeatStintEndTypeId.Duration && _raceSessionWithoutStints.HeatStintEndDurationDuration.ToTimeSpan() <=
                                    Google.Protobuf.WellKnownTypes.Duration.FromTimeSpan(heatStintJournalState.TimerElapsed.ToTimeSpan().Add((heatStintJournalState.Timestamp - heatStintJournalState.TimerStartedAt).ToTimeSpan())).ToTimeSpan()))
                            {
                                indicatorState.Finished = true;
                            }
                            else if (heatStintJournalState.Ended)
                            {
                                indicatorState.Finished = true;
                            }

                            var eventUsersEventSpeechTexts = new Dictionary<Guid, EventSpeechTexts>();

                            IndicatorState? leaderIndicator = null;
                            IndicatorState? intervalIndicator = null;

                            foreach (var item in indicators
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
                                    if (item.indicatorKv.Value.EventUserId is not null)
                                    {
                                        if (!eventUsersEventSpeechTexts.TryGetValue(new Guid(item.indicatorKv.Value.EventUserId), out var eventSpeechTexts))
                                        {
                                            eventSpeechTexts = new EventSpeechTexts();
                                            eventUsersEventSpeechTexts.Add(new Guid(item.indicatorKv.Value.EventUserId), eventSpeechTexts);
                                        }

                                        if (item.indicatorKv.Value.Position == 1)
                                        {
                                            eventSpeechTexts.Items.Add(new EventSpeechText
                                            {
                                                EventSpeechTypeId = EventSpeechTypeId.PositionLeader,
                                                Text = $"You are now in the lead"
                                            });
                                        }
                                        else if (item.indicatorKv.Value.Position < previousPosition)
                                        {
                                            var text = $"You have gained {previousPosition - item.indicatorKv.Value.Position} position";
                                            if (previousPosition - item.indicatorKv.Value.Position >= 2)
                                            {
                                                text += "s";
                                            }
                                            eventSpeechTexts.Items.Add(new EventSpeechText
                                            {
                                                EventSpeechTypeId = EventSpeechTypeId.PositionGained,
                                                Text = text
                                            });
                                        }
                                        else
                                        {
                                            var text = $"You have lost {item.indicatorKv.Value.Position - previousPosition} position";
                                            if (item.indicatorKv.Value.Position - previousPosition >= 2)
                                            {
                                                text += "s";
                                            }
                                            eventSpeechTexts.Items.Add(new EventSpeechText
                                            {
                                                EventSpeechTypeId = EventSpeechTypeId.PositionLost,
                                                Text = text
                                            });
                                        }
                                    }
                                }

                                item.indicatorKv.Value.GapLeaderTime = null;
                                item.indicatorKv.Value.GapLeaderLaps = null;
                                item.indicatorKv.Value.GapIntervalTime = null;
                                item.indicatorKv.Value.GapIntervalLaps = null;

                                if (item.indicatorKv.Value.Position == 1)
                                {
                                    item.indicatorKv.Value.GapIntervalFraction = null;
                                }

                                var heatStateIndicatorTime = item.indicatorKv.Value.AllTimeTypeTimes[IndicatorTimeTypeId.Lap].LastOrDefault();
                                if (heatStateIndicatorTime is not null)
                                {
                                    if (leaderIndicator is not null)
                                    {
                                        (item.indicatorKv.Value.GapLeaderTime, item.indicatorKv.Value.GapLeaderLaps) = CalculateGap(heatStateIndicatorTime, leaderIndicator);
                                    }

                                    if (intervalIndicator is not null)
                                    {
                                        (item.indicatorKv.Value.GapIntervalTime, item.indicatorKv.Value.GapIntervalLaps) = CalculateGap(heatStateIndicatorTime, intervalIndicator);

                                        if (item.indicatorKv.Value.GapIntervalTime.HasValue && item.indicatorKv.Value.GapIntervalTime.Value < 0)
                                        {
                                            item.indicatorKv.Value.GapIntervalTime = null;
                                        }
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

                            if (indicatorState.Laps.HasValue)
                            {
                                var timerElapsed = Google.Protobuf.WellKnownTypes.Duration.FromTimeSpan(heatStintJournalState.TimerElapsed.ToTimeSpan().Add((deviceConfigurationInput.Timestamp - heatStintJournalState.TimerStartedAt!).ToTimeSpan()));
                                double? heatStateIndicatorTimeDisplay = indicatorState.LatestTimeTypeTimes[IndicatorTimeTypeId.Lap].Time.HasValue ? Math.Round(indicatorState.LatestTimeTypeTimes[IndicatorTimeTypeId.Lap].Time!.Value, trackLaptimeDecimals) : null;
                                var heatStateIndicatorTimePrevious = indicatorState.AllTimeTypeTimes[IndicatorTimeTypeId.Lap].SkipLast(1).LastOrDefault()?.Time;

                                var heatAnalysis = new HeatAnalysis
                                {
                                    TimerElapsed = timerElapsed,
                                    IndicatorId = indicatorId,
                                    Lap = new HeatAnalysisLap
                                    {
                                        Position = indicatorState.Position,
                                        Lap = indicatorState.Laps!.Value,
                                        Time = heatStateIndicatorTimeDisplay,
                                    }
                                };

                                var heatStateIndicatorTime = indicatorState.AllTimeTypeTimes[IndicatorTimeTypeId.Lap].LastOrDefault();
                                if (heatStateIndicatorTime is not null)
                                {
                                    heatAnalysis.Lap.Pitlanes = heatStateIndicatorTime.Pitlanes;
                                    heatAnalysis.Lap.Deslots = heatStateIndicatorTime.Deslots;
                                }

                                var heatIndicatorStints = _heatWithoutStints?.HeatIndicators.SingleOrDefault(x => x.IndicatorId == indicatorId)?.HeatIndicatorStints;
                                if (heatIndicatorStints is not null)
                                {
                                    heatAnalysis.Lap.TeamEventUserId = heatIndicatorStints.SingleOrDefault(x => x.Lap == indicatorState.Laps!.Value)?.EventUserId;
                                }

                                heatAnalyses.Items.Add(heatAnalysis);
                                heatAnalysesDelta.Items.Add(heatAnalysis);
                                indicatorState.LapWarning = false;

                                var heatStintAnalysisIndicatorStintLap = new HeatStintAnalysisIndicatorStintLap
                                {
                                    IndicatorId = indicatorId,
                                    TimerElapsed = heatAnalysis.TimerElapsed,
                                    Lap = heatAnalysis.Lap.Lap,
                                    Time = heatAnalysis.Lap.Time,
                                    Pitlanes = heatAnalysis.Lap.Pitlanes,
                                    Deslots = heatAnalysis.Lap.Deslots,
                                };
                                _allHeatStintAnalysisIndicatorStintLaps[indicatorId].Add(heatStintAnalysisIndicatorStintLap);

                                var heatStintAnalysisIndicatorStint = _heatStintAnalysisIndicatorStints[indicatorId].Items.LastOrDefault(x => x.Lap <= indicatorState.Laps && indicatorState.Laps >= 1);

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

                                foreach (var otherItem in indicators.Where(x => x.Key != deviceConfigurationInput.DeviceConfigurationInputId.Value))
                                {
                                    var gap = CalculateGap2(indicatorState, otherItem.Value);
                                    if (gap.GapTime.HasValue)
                                    {
                                        heatAnalysis = new HeatAnalysis
                                        {
                                            TimerElapsed = timerElapsed,
                                            IndicatorId = deviceConfigurationInput.DeviceConfigurationInputId,
                                            Gap = new HeatAnalysisGap
                                            {
                                                IndicatorId = otherItem.Key,
                                                Value = Math.Round(gap.GapTime.Value, trackLaptimeDecimals),
                                                DisplayValue = gap.GapLaps.HasValue ? $"{gap.GapLaps.Value}L" : gap.GapTime.Value.ToString(trackLaptimeDecimalsFormat, CultureInfo.InvariantCulture)
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

                                            var time = indicatorState.LatestTimeTypeTimes[IndicatorTimeTypeId.Lap].Time;
                                            if (time.HasValue)
                                            {
                                                heatAnalysis.Gap.DeltaFraction = heatAnalysis.Gap.DeltaValue / time.Value;
                                            }
                                        }

                                        heatAnalyses.Items.Add(heatAnalysis);
                                        heatAnalysesDelta.Items.Add(heatAnalysis);

                                        heatAnalysis = new HeatAnalysis
                                        {
                                            TimerElapsed = timerElapsed,
                                            IndicatorId = otherItem.Key,
                                            Gap = new HeatAnalysisGap
                                            {
                                                IndicatorId = deviceConfigurationInput.DeviceConfigurationInputId.Value,
                                                Value = Math.Round(-gap.GapTime.Value, trackLaptimeDecimals),
                                                DisplayValue = gap.GapLaps.HasValue ? $"-{gap.GapLaps.Value}L" : (-gap.GapTime.Value).ToString(trackLaptimeDecimalsFormat, CultureInfo.InvariantCulture)
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

                                            var time = otherItem.Value.LatestTimeTypeTimes[IndicatorTimeTypeId.Lap].Time;
                                            if (time.HasValue)
                                            {
                                                heatAnalysis.Gap.DeltaFraction = heatAnalysis.Gap.DeltaValue / time.Value;

                                                if (otherItem.Value.Position == indicatorState.Position - 1)
                                                {
                                                    indicatorState.GapIntervalFraction = heatAnalysis.Gap.DeltaFraction;
                                                }
                                            }
                                        }

                                        heatAnalyses.Items.Add(heatAnalysis);
                                        heatAnalysesDelta.Items.Add(heatAnalysis);
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

                                if (indicatorState.LastEnergyTimestamp is not null)
                                {
                                    var deltaEnergyMilliseconds = indicatorState.Motor * (deviceConfigurationInput.Timestamp - indicatorState.LastEnergyTimestamp).ToTimeSpan().TotalMilliseconds;
                                    indicatorState.TotalEnergyLevel = Math.Max(0, indicatorState.TotalEnergyLevel - deltaEnergyMilliseconds);
                                    indicatorState.CurrentEnergyLapLevel += deltaEnergyMilliseconds;
                                    if (indicatorState.CurrentEnergyLapLevel > 0)
                                    {
                                        indicatorState.LastEnergyLapLevels.Enqueue(indicatorState.CurrentEnergyLapLevel);
                                        while (indicatorState.LastEnergyLapLevels.Count > 10)
                                        {
                                            indicatorState.LastEnergyLapLevels.Dequeue();
                                        }
                                    }
                                    indicatorState.CurrentEnergyLapLevel = 0;
                                    //Console.WriteLine($"deltaEnergyMilliseconds={deltaEnergyMilliseconds} TotalEnergyMilliseconds={heatStateIndicator.TotalEnergyMilliseconds}");
                                }
                                indicatorState.LastEnergyTimestamp = deviceConfigurationInput.Timestamp;

                                if (!replay)
                                {
                                    var eventUserId = _heatWithoutStints!.HeatIndicators.SingleOrDefault(x => x.Id == indicatorState.Id)?.EventUserId;
                                    if (eventUserId is not null)
                                    {
                                        var heatStateIndicatorBehind = indicators.SingleOrDefault(x => x.Value.Position == indicatorState.Position - 1).Value;
                                        var eventUserIdBehind = _heatWithoutStints!.HeatIndicators.SingleOrDefault(x => x.Id == heatStateIndicatorBehind?.Id)?.EventUserId;
                                        var eventUserBehind = @event!.EventUsers.SingleOrDefault(x => x.Id == eventUserIdBehind);
                                        var heatStateIndicatorAhead = indicators.SingleOrDefault(x => x.Value.Position == indicatorState.Position + 1).Value;
                                        var eventUserIdAhead = _heatWithoutStints!.HeatIndicators.SingleOrDefault(x => x.Id == heatStateIndicatorAhead?.Id)?.EventUserId;
                                        var eventUserAhead = @event!.EventUsers.SingleOrDefault(x => x.Id == eventUserIdAhead);

                                        string? behindMessage = null;
                                        if (eventUserBehind is not null && (indicatorState.GapIntervalTime.HasValue || indicatorState.GapIntervalLaps.HasValue))
                                        {
                                            if (indicatorState.GapIntervalLaps.HasValue && indicatorState.GapIntervalLaps.Value >= 1)
                                            {
                                                behindMessage = $"{indicatorState.GapIntervalLaps.Value} lap";
                                                if (indicatorState.GapIntervalLaps.Value >= 2)
                                                {
                                                    behindMessage += "s";
                                                }
                                                behindMessage += $" behind {eventUserBehind.Name}";
                                            }
                                            else
                                            {
                                                var gapSeconds = Math.Round(indicatorState.GapIntervalTime.Value, 0);
                                                behindMessage = $"{gapSeconds} second";
                                                if (gapSeconds != 1)
                                                {
                                                    behindMessage += "s";
                                                }
                                                behindMessage += $" behind {eventUserBehind.Name}";
                                            }
                                        }

                                        string? aheadMessage = null;
                                        if (eventUserAhead is not null && (heatStateIndicatorAhead.GapIntervalTime.HasValue || heatStateIndicatorAhead.GapIntervalLaps.HasValue))
                                        {
                                            if (heatStateIndicatorAhead.GapIntervalLaps.HasValue && heatStateIndicatorAhead.GapIntervalLaps.Value >= 1)
                                            {
                                                aheadMessage = $"{heatStateIndicatorAhead.GapIntervalLaps.Value} lap";
                                                if (heatStateIndicatorAhead.GapIntervalLaps.Value >= 2)
                                                {
                                                    aheadMessage += "s";
                                                }
                                                aheadMessage += $" ahead of {eventUserAhead.Name}";
                                            }
                                            else
                                            {
                                                var gapSeconds = Math.Round(heatStateIndicatorAhead.GapIntervalTime.Value, 0);
                                                aheadMessage = $"{gapSeconds} second";
                                                if (gapSeconds != 1)
                                                {
                                                    aheadMessage += "s";
                                                }
                                                aheadMessage += $" ahead of {eventUserAhead.Name}";
                                            }
                                        }

                                        if (behindMessage is not null || aheadMessage is not null)
                                        {
                                            if (!eventUsersEventSpeechTexts.TryGetValue(new Guid(eventUserId), out var eventSpeechTexts))
                                            {
                                                eventSpeechTexts = new EventSpeechTexts();
                                                eventUsersEventSpeechTexts.Add(new Guid(eventUserId), eventSpeechTexts);
                                            }

                                            string? nearestMessage = null;

                                            if (behindMessage is not null)
                                            {
                                                eventSpeechTexts.Items.Add(new EventSpeechText
                                                {
                                                    EventSpeechTypeId = EventSpeechTypeId.GapAfter,
                                                    Text = "You are " + behindMessage
                                                });

                                                nearestMessage = "You are " + behindMessage;
                                            }

                                            if (aheadMessage is not null)
                                            {
                                                eventSpeechTexts.Items.Add(new EventSpeechText
                                                {
                                                    EventSpeechTypeId = EventSpeechTypeId.GapBefore,
                                                    Text = "You are " + aheadMessage
                                                });

                                                if (nearestMessage is null)
                                                {
                                                    nearestMessage = "You are " + aheadMessage;
                                                }
                                                else
                                                {
                                                    nearestMessage += " and " + aheadMessage;
                                                }
                                            }

                                            if (nearestMessage is not null)
                                            {
                                                eventSpeechTexts.Items.Add(new EventSpeechText
                                                {
                                                    EventSpeechTypeId = EventSpeechTypeId.GapNearest,
                                                    Text = nearestMessage
                                                });
                                            }
                                        }
                                    }
                                }

                                if (!replay && heatStateIndicatorTimeDisplay.HasValue && heatStateIndicatorTimeDisplay!.Value > 0)
                                {
                                    var eventUserId = _heatWithoutStints!.HeatIndicators.SingleOrDefault(x => x.Id == indicatorState.Id)?.EventUserId;
                                    if (eventUserId is not null)
                                    {
                                        var latestTimeTypeTimeLap = indicatorState.LatestTimeTypeTimes.SingleOrDefault(x => x.Key == IndicatorTimeTypeId.Lap).Value;
                                        if (latestTimeTypeTimeLap is not null && heatStateIndicatorTimeDisplay.HasValue)
                                        {
                                            if (!eventUsersEventSpeechTexts.TryGetValue(new Guid(eventUserId), out var eventSpeechTexts))
                                            {
                                                eventSpeechTexts = new EventSpeechTexts();
                                                eventUsersEventSpeechTexts.Add(new Guid(eventUserId), eventSpeechTexts);
                                            }

                                            switch (latestTimeTypeTimeLap.FastestTimeTypeId)
                                            {
                                                case IndicatorFastestTimeTypeId.Indicator:
                                                    eventSpeechTexts.Items.Add(new EventSpeechText
                                                    {
                                                        EventSpeechTypeId = EventSpeechTypeId.Faster,
                                                        Text = $"You set a new personal fastest lap  {heatStateIndicatorTimeDisplay.Value}",
                                                    });
                                                    break;

                                                case IndicatorFastestTimeTypeId.AllIndicators:
                                                    eventSpeechTexts.Items.Add(new EventSpeechText
                                                    {
                                                        EventSpeechTypeId = EventSpeechTypeId.Fastest,
                                                        Text = $"You set the new overall fastest lap  {heatStateIndicatorTimeDisplay.Value}",
                                                    });
                                                    break;

                                                default:
                                                    if (heatStateIndicatorTimePrevious.HasValue && heatStateIndicatorTimeDisplay.Value - heatStateIndicatorTimePrevious.Value > 1)
                                                    {
                                                        eventSpeechTexts.Items.Add(new EventSpeechText
                                                        {
                                                            EventSpeechTypeId = EventSpeechTypeId.Lap,
                                                            Text = heatStateIndicatorTimeDisplay.Value.ToString(),
                                                            Slow = true
                                                        });
                                                    }
                                                    else
                                                    {
                                                        eventSpeechTexts.Items.Add(new EventSpeechText
                                                        {
                                                            EventSpeechTypeId = EventSpeechTypeId.Lap,
                                                            Text = heatStateIndicatorTimeDisplay.Value.ToString(),
                                                        });
                                                    }
                                                    break;
                                            }

                                            eventSpeechTexts.Items.Add(new EventSpeechText
                                            {
                                                EventSpeechTypeId = EventSpeechTypeId.AverageLap,
                                                Time = heatStateIndicatorTimeDisplay
                                            });
                                        }
                                    }
                                }

                                foreach (var eventUserEventSpeechTexts in eventUsersEventSpeechTexts)
                                {
                                    _ = GrainFactory.GetGrain<Event.IEventGrain>(new Guid(race.EventId)).EventSpeechTexts(eventUserEventSpeechTexts.Key, eventUserEventSpeechTexts.Value);
                                }

                                if (indicatorState.Finished && !heatStintJournalState.Ended && !replay)
                                {
                                    _ = RaiseHeatStintStateTypeAsync(DetailStateTypeId.Ended);
                                }

                                if (!replay)
                                {
                                    var heatIndicator = _heatWithoutStints!.HeatIndicators.SingleOrDefault(x => x.IndicatorId == indicatorId);
                                    if (heatIndicator is not null && heatIndicator.PreconfiguredLaps.Any())
                                    {
                                        var preconfiguredStint = heatIndicator.PreconfiguredLaps.SingleOrDefault(x => x.Lap == indicatorState.Laps);
                                        if (preconfiguredStint is not null)
                                        {
                                            _logger.LogInformation($"Creating stint for indicatorId={indicatorId} HeatIndicatorId={indicatorState.Id} Lap={indicatorState.Laps!.Value}");
                                            _heatIndicatorStintServiceClient.Create(new Razmanager.Protobuf.Internal.Repository.SystemServices.HeatIndicatorStint.HeatIndicatorStintCreate
                                            {
                                                HeatIndicatorId = indicatorState.Id,
                                                Lap = indicatorState.Laps!.Value,
                                                EventUserId = preconfiguredStint.EventUserId
                                            });
                                            _ = RefreshHeatIndicatorStintsAsync(new Guid(indicatorState.Id));
                                        }
                                    }
                                }
                            }
                        }

                        break;

                    case DeviceConfigurationInputTypeId.Sector1FinishIndicator:
                        indicatorState.LastTimeTypeId = IndicatorTimeTypeId.Sector1;
                        indicatorState.LastTimestamp = deviceConfigurationInput.Timestamp.ToDateTime();

                        var deviceConfigurationInputSector1StartFinishPrevious = indicatorState.DeviceConfigurationInputs.LastOrDefault(x => x.DeviceConfigurationInputTypeId == DeviceConfigurationInputTypeId.StartFinishIndicator);
                        CalculateTime(indicatorId, indicatorState, deviceConfigurationInputSector1StartFinishPrevious, deviceConfigurationInput, IndicatorTimeTypeId.Sector1);
                        break;

                    case DeviceConfigurationInputTypeId.Sector2FinishIndicator:
                        indicatorState.LastTimeTypeId = IndicatorTimeTypeId.Sector2;
                        indicatorState.LastTimestamp = deviceConfigurationInput.Timestamp.ToDateTime();

                        var deviceConfigurationInputSector1Previous = indicatorState.DeviceConfigurationInputs.LastOrDefault(x => x.DeviceConfigurationInputTypeId == DeviceConfigurationInputTypeId.Sector1FinishIndicator);
                        CalculateTime(indicatorId, indicatorState, deviceConfigurationInputSector1Previous, deviceConfigurationInput, IndicatorTimeTypeId.Sector2);
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
                        if (indicatorState.LastEnergyTimestamp is not null)
                        {
                            var deltaEnergyMilliseconds = indicatorState.Motor * (deviceConfigurationInput.Timestamp - indicatorState.LastEnergyTimestamp).ToTimeSpan().TotalMilliseconds;
                            indicatorState.TotalEnergyLevel = Math.Max(0, indicatorState.TotalEnergyLevel - deltaEnergyMilliseconds);
                            indicatorState.CurrentEnergyLapLevel += deltaEnergyMilliseconds;
                        }
                        indicatorState.Motor = deviceConfigurationInput.IntValue;
                        indicatorState.LastEnergyTimestamp = deviceConfigurationInput.Timestamp;

                        break;

                    case DeviceConfigurationInputTypeId.Tainted:
                        indicatorState.LapWarning = true;
                        break;

                    case DeviceConfigurationInputTypeId.PitlaneEntry:
                        if (!indicatorState.Finished)
                        {
                            indicatorState.Pitlane = true;
                            indicatorState.LapPitlanes++;
                            //if (!replay)
                            //{
                            //    //_logger.LogInformation($"Creating stint for indicatorId={indicatorId} HeatIndicatorId={heatStateIndicator.Id} Lap={heatStateIndicator.Laps!.Value}");
                            //    _heatIndicatorStintServiceClient.Create(new Razmanager.Protobuf.Internal.Repository.SystemServices.HeatIndicatorStint.HeatIndicatorStintCreate
                            //    {
                            //        HeatIndicatorId = heatStateIndicator.Id,
                            //        Lap = heatStateIndicator.Laps!.Value
                            //    });
                            //    _ = RefreshHeatIndicatorStintsAsync(new Guid(heatStateIndicator.Id));
                            //}
                        }
                        break;

                    case DeviceConfigurationInputTypeId.PitlaneExit:
                        indicatorState.Pitlane = false;
                        break;

                    case DeviceConfigurationInputTypeId.CarOnTrack:
                        if (deviceConfigurationInput.BoolValue)
                        {
                            indicatorState.Deslot = true;
                            indicatorState.LapDeslots++;
                        }
                        else
                        {
                            indicatorState.Deslot = false;
                        }
                        break;

                    //case DeviceConfigurationInputTypeId.Yellow:
                    //    if (!replay)
                    //    {
                    //        _ = RaiseHeatWithoutStintStateTypeAsync(DetailStateTypeId.Running);
                    //    }
                    //    break;

                    case DeviceConfigurationInputTypeId.Red:
                        if (!replay)
                        {
                            _ = RaiseHeatStintStateTypeAsync(DetailStateTypeId.Ended);
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
                    indicatorState.DeviceConfigurationInputs.Add(deviceConfigurationInput);
                    while (indicatorState.DeviceConfigurationInputs.Count > 10)
                    {
                        indicatorState.DeviceConfigurationInputs.RemoveAt(0);
                    }
                }
            }
        }


        protected override async Task CreateHeatStintJournalAsync(Razmanager.Protobuf.Internal.Repository.SystemServices.HeatStintJournal.HeatStintJournalCreateRequest proto)
        {
            await _serviceClient.CreateHeatJournalAsync(proto);
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
                        var pitlanes = heatStintAnalysisIndicatorStint.Laps
                            .Where(x => x.Lap > heatIndicatorStintLapSecondFirst.Lap &&
                                        x.Lap < heatIndicatorStintLapSecondLast.Lap &&
                                        x.Pitlanes > 0 &&
                                        x.Time.HasValue);
                        var duration = heatIndicatorStintLapSecondLast.TimerElapsed +
                                       Google.Protobuf.WellKnownTypes.Duration.FromTimeSpan(TimeSpan.FromSeconds(heatIndicatorStintLapSecondLast.Time!.Value)) -
                                       heatIndicatorStintLapSecondFirst.TimerElapsed -
                                       Google.Protobuf.WellKnownTypes.Duration.FromTimeSpan(TimeSpan.FromSeconds(pitlanes.Sum(x => x.Time.Value)));
                        heatStintAnalysisIndicatorStint.AverageTime = Math.Round(duration.ToTimeSpan().TotalSeconds / (heatStintAnalysisIndicatorStint.Laps.Count - 2 - pitlanes.Count()), trackLaptimeDecimals);
                    }
                }
            }
        }


        protected override async Task PublishStateAsync()
        {
            var heatState = HeatStintState();
            //_ = GrainFactory.GetGrain<Race.IRaceGrain>(new Guid(_heatWithoutStint!.RaceId)).HeatWithoutStintStateUpdatedAsync(this.GetPrimaryKey(), heatState);
            _ = _heatWithoutStintsStateStream!.OnNextAsync(heatState);
            _ = _heatWithoutStintsLeaderboardStream!.OnNextAsync(HeatWithoutStintsLeaderboard());

            await _heatAnalysesStream!.OnNextAsync(heatAnalysesDelta);
            heatAnalysesDelta = new();

            foreach (var item in _heatWithoutStints!.HeatIndicators)
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


        private HeatWithoutStintsLeaderboard HeatWithoutStintsLeaderboard()
        {
            var heatWithoutStintsLeaderboard = new HeatWithoutStintsLeaderboard
            {
                CorrelationId = correlationId.HasValue ? correlationId.ToString() : null,
            };

            foreach (var indicatorStateKv in indicators)
            {
                var heatLeaderboardIndicator = new HeatWithoutStintsLeaderboardIndicator
                {
                    IndicatorId = indicatorStateKv.Key,
                    Position = indicatorStateKv.Value.Position,
                    Laps = indicatorStateKv.Value.Laps,
                    GapIntervalFraction = indicatorStateKv.Value.GapIntervalFraction
                };

                if (indicatorStateKv.Value.GapLeaderLaps.HasValue)
                {
                    heatLeaderboardIndicator.GapLeader = $"{indicatorStateKv.Value.GapLeaderLaps.Value}L";
                }
                else if (indicatorStateKv.Value.GapLeaderTime.HasValue)
                {
                    heatLeaderboardIndicator.GapLeader = indicatorStateKv.Value.GapLeaderTime.Value.ToString(trackLaptimeDecimalsFormat, CultureInfo.InvariantCulture);
                }

                if (indicatorStateKv.Value.GapIntervalLaps.HasValue)
                {
                    heatLeaderboardIndicator.GapInterval = $"{indicatorStateKv.Value.GapIntervalLaps.Value}L";
                }
                else if (indicatorStateKv.Value.GapIntervalTime.HasValue)
                {
                    heatLeaderboardIndicator.GapInterval = indicatorStateKv.Value.GapIntervalTime.Value.ToString(trackLaptimeDecimalsFormat, CultureInfo.InvariantCulture);
                }

                if (indicatorStateKv.Value.Finished)
                {
                    heatLeaderboardIndicator.Flags.Add(IndicatorFlag.Finished);
                }
                if (_timeTypeFastestTimes[IndicatorTimeTypeId.Lap].IndicatorId == indicatorStateKv.Key)
                {
                    heatLeaderboardIndicator.Flags.Add(IndicatorFlag.FastestLap);
                }
                if (indicatorStateKv.Value.LapWarning)
                {
                    heatLeaderboardIndicator.Flags.Add(IndicatorFlag.Warning);
                }
                if (indicatorStateKv.Value.Pitlane)
                {
                    heatLeaderboardIndicator.Flags.Add(IndicatorFlag.Pitlane);
                }
                if (indicatorStateKv.Value.Deslot)
                {
                    heatLeaderboardIndicator.Flags.Add(IndicatorFlag.Deslot);
                }

                foreach (var heatIndicatorTimeTypeTime in indicatorStateKv.Value.LatestTimeTypeTimes)
                {
                    heatLeaderboardIndicator.TimeTypeTimes.Add(new IndicatorTimeTypeTime
                    {
                        TimeTypeId = heatIndicatorTimeTypeTime.Key,
                        Time = heatIndicatorTimeTypeTime.Value.Time.HasValue ? Math.Round(heatIndicatorTimeTypeTime.Value.Time.Value, trackLaptimeDecimals) : null,
                        FastestTimeTypeId = heatIndicatorTimeTypeTime.Value.FastestTimeTypeId,
                        FastestTime = heatIndicatorTimeTypeTime.Value.FastestTime.HasValue ? Math.Round(heatIndicatorTimeTypeTime.Value.FastestTime.Value, trackLaptimeDecimals) : null,                        
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

                heatLeaderboardIndicator.EnergyPercent = Convert.ToUInt32(Math.Round(100 * indicatorStateKv.Value.TotalEnergyLevel / _totalEnergyLevel, 0));
                if (indicatorStateKv.Value.LastEnergyLapLevels.Count > 0)
                {
                    heatLeaderboardIndicator.EnergyLapsLeft = Convert.ToUInt32(Math.Round(indicatorStateKv.Value.TotalEnergyLevel / indicatorStateKv.Value.LastEnergyLapLevels.Average(), 0));
                }

                heatWithoutStintsLeaderboard.Indicators.Add(heatLeaderboardIndicator);

                if (heatLeaderboardIndicator.EnergyPercent <= 0)
                {
                    indicatorStateKv.Value.TotalEnergyLevel = _totalEnergyLevel;
                }


                if (_heatStintAnalysisIndicatorStints.TryGetValue(Convert.ToByte(indicatorStateKv.Key), out var heatStintAnalysisIndicatorStints))
                {
                    var lastStint = heatStintAnalysisIndicatorStints.Items.LastOrDefault();
                    if (lastStint is not null)
                    {
                        heatLeaderboardIndicator.TeamEventUserId = lastStint.EventUserId;
                    }
                }
            }

            return heatWithoutStintsLeaderboard;
        }
    }
}
