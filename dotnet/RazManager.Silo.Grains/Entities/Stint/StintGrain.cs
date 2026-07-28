using Microsoft.Extensions.Logging;
using Razmanager.Protobuf.Internal.Silo.SystemServices.EventUser;
using Razmanager.Protobuf.Internal.Silo.UserServices.Event;
using Razmanager.Protobuf.Public.V1;
using RazManager.Silo.Grains.Entities.HeatStint;
using System.Resources;


namespace RazManager.Silo.Grains.Entities.Stint
{
    public class StintGrain : HeatStintGrainBase, IStintGrain
    {
        private readonly Razmanager.Protobuf.Internal.Repository.SystemServices.HeatWithStint.HeatWithStintService.HeatWithStintServiceClient _heatWithStintServiceClient;
        private readonly Razmanager.Protobuf.Internal.Repository.SystemServices.Stint.StintService.StintServiceClient _serviceClient;
        private Razmanager.Protobuf.Public.V1.HeatWithStint? _heatWithStint;
        private Razmanager.Protobuf.Public.V1.Stint? _stint;

        //private HeatAnalyses _heatAnalyses = new();
        //private HeatAnalyses _heatAnalysesDelta = new();
        //private Dictionary<byte, Dictionary<byte, Queue<HeatAnalysisGap>>> _heatAnalysesGaps = [];
        //private Dictionary<byte, List<HeatStintAnalysisIndicatorStintLap>> _allHeatStintAnalysisIndicatorStintLaps = [];
        //private Dictionary<byte, HeatStintAnalysisIndicatorStints> _heatStintAnalysisIndicatorStints = [];
        //private Dictionary<byte, HeatStintAnalysisIndicatorStints> _heatStintAnalysisIndicatorStintsDelta = [];

        //private IAsyncStream<HeatState>? _heatStateStream;
        //private IAsyncStream<HeatLeaderboard>? _heatLeaderboardStream;
        //private IAsyncStream<HeatAnalyses>? _heatAnalysesStream;
        //private Dictionary<byte, IAsyncStream<HeatStintAnalysis>?> _heatStintAnalysisStreams = [];

        private readonly ILogger<StintGrain> _logger;


        public StintGrain(Razmanager.Protobuf.Internal.Repository.SystemServices.Event.EventService.EventServiceClient eventServiceClient, 
                          Razmanager.Protobuf.Internal.Repository.SystemServices.Race.RaceService.RaceServiceClient raceServiceClient,
                          Razmanager.Protobuf.Internal.Repository.SystemServices.RaceSession.RaceSessionService.RaceSessionServiceClient raceSessionServiceClient,
                          Razmanager.Protobuf.Internal.Repository.SystemServices.HeatWithStint.HeatWithStintService.HeatWithStintServiceClient heatWithStintServiceClient,
                          Razmanager.Protobuf.Internal.Repository.SystemServices.Stint.StintService.StintServiceClient serviceClient,
                          ILogger<StintGrain> logger) : base(eventServiceClient, raceServiceClient, raceSessionServiceClient, logger)
        {
            _heatWithStintServiceClient = heatWithStintServiceClient;
            _serviceClient = serviceClient;
            _logger = logger;
        }


        public override async Task OnActivateAsync(CancellationToken cancellationToken)
        {
            try
            {
                _stint = await _serviceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });
                _heatWithStint = await _heatWithStintServiceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = _stint.HeatWithStintId });
                raceSession = await raceSessionServiceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = _heatWithStint.RaceSessionId });
                race = await raceServiceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = raceSession.RaceId });
                @event = await eventServiceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = race.EventId });

                var heatStintJournalsResponse = await _serviceClient.ListStintJournalsAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });

                await OnActivateBaseAsync(2, heatStintJournalsResponse.HeatStintJournals);

                InitializeIndicators();

                var stintJournalsResponse = await _serviceClient.ListStintJournalsAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });

                await OnActivateBaseAsync(2, heatStintJournalsResponse.HeatStintJournals);

                _stint!.StintStateType = new Razmanager.Protobuf.Public.V1.DetailStateType
                {
                    Id = heatStintJournalState!.HeatStintStateTypeId,
                    Name = new ResourceManager(typeof(RazManager.Resources.DetailStateType)).GetString(heatStintJournalState.HeatStintStateTypeId.ToString())
                };


                //var streamProvider = this.GetStreamProvider(Constants.StreamProvider);
                //_heatStateStream = streamProvider.GetStream<HeatState>(Constants.StreamName.HeatState.ToString(), this.GetPrimaryKey());
                //_heatLeaderboardStream = streamProvider.GetStream<HeatLeaderboard>(Constants.StreamName.HeatLeaderboard.ToString(), this.GetPrimaryKey());
                //_heatAnalysesStream = streamProvider.GetStream<HeatAnalyses>(Constants.StreamName.HeatAnalyses.ToString(), this.GetPrimaryKey());
                //foreach (var item in _stint!.StintIndicators)
                //{
                //    _heatStintAnalysisStreams.Add(Convert.ToByte(item.IndicatorId), streamProvider.GetStream<HeatStintAnalysis>(Constants.StreamName.HeatStintAnalysis.ToString(), $"{this.GetPrimaryKey()}:{item.IndicatorId}"));
                //    //Console.WriteLine($"-------------- OnActivateAsync {this.GetPrimaryKey()}:{item.IndicatorId}");
                //}

            }
            catch (Grpc.Core.RpcException exception)
            {
                if (exception.StatusCode == Grpc.Core.StatusCode.NotFound)
                {
                    _unsubscribe = true;
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
            //_heatAnalysesGaps.Clear();
            //_allHeatStintAnalysisIndicatorStintLaps.Clear();
            //_heatStintAnalysisIndicatorStints.Clear();
            //_heatStintAnalysisIndicatorStintsDelta.Clear();
            foreach (var item in _stint!.StintIndicators.OrderBy(x => x.IndicatorId).Select((indicator, index) => new { indicator, index }))
            {
                var indicatorState = new IndicatorState
                {
                    Id = item.indicator.Id,
                    EventUserId = _stint!.StintIndicators.SingleOrDefault(x => x.Id == item.indicator.Id)?.EventUserId,
                    Position = Convert.ToUInt32(item.index + 1)
                };

                foreach (var indicatorTimeTypeId in System.Enum.GetValues<IndicatorTimeTypeId>())
                {
                    indicatorState.LatestTimeTypeTimes[indicatorTimeTypeId] = new IndicatorTimeTypeTime();
                    indicatorState.AllTimeTypeTimes[indicatorTimeTypeId] = [];
                }

                indicators.Add(Convert.ToByte(item.indicator.IndicatorId), indicatorState);

                //Dictionary<byte, Queue<HeatAnalysisGap>> indicatorHeatAnalysisGaps = [];
                //foreach (var otherItem in _heatWithStint!.HeatIndicators.OrderBy(x => x.IndicatorId).Where(x => x.IndicatorId != item.indicator.IndicatorId))
                //{
                //    indicatorHeatAnalysisGaps.Add(Convert.ToByte(otherItem.IndicatorId), new Queue<HeatAnalysisGap>());
                //}
                //_heatAnalysesGaps.Add(Convert.ToByte(item.indicator.IndicatorId), indicatorHeatAnalysisGaps);

                //_allHeatStintAnalysisIndicatorStintLaps.Add(Convert.ToByte(item.indicator.IndicatorId), []);

                //var heatStintAnalysisIndicatorStints = new HeatStintAnalysisIndicatorStints();
                //heatStintAnalysisIndicatorStints.Items.AddRange(item.indicator.HeatIndicatorStints.Select(x => new HeatStintAnalysisIndicatorStint
                //    {
                //        Id = x.Id,
                //        IndicatorId = item.indicator.IndicatorId,
                //        Lap = x.Lap,
                //        EventUserId = x.EventUserId,
                //        Comments = x.Comments
                //    }));
                //_heatStintAnalysisIndicatorStints.Add(Convert.ToByte(item.indicator.IndicatorId), heatStintAnalysisIndicatorStints);

                //_heatStintAnalysisIndicatorStintsDelta.Add(Convert.ToByte(item.indicator.IndicatorId), new());
            }

            //_heatAnalyses = new();
            //_heatAnalysesDelta = new();
        }


        public Task<Razmanager.Protobuf.Public.V1.Stint> ReadAsync()
        {
            return Task.FromResult(_stint!);
        }


        public Task<Razmanager.Protobuf.Public.V1.DetailState> ReadStintStateAsync()
        {
            heatStintJournalState!.Timestamp = Google.Protobuf.WellKnownTypes.Timestamp.FromDateTime(DateTime.UtcNow);
            return Task.FromResult(HeatStintState());
        }


        protected override async Task RaiseHeatStintStateTypeAsync(Razmanager.Protobuf.Public.V1.DetailStateTypeId heatStintStateTypeId)
        {
            if (heatStintStateTypeId == DetailStateTypeId.Pending ||
                heatStintStateTypeId == DetailStateTypeId.Opened)
            {
                await _serviceClient.DeleteStintJournalsAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });
                
                // Refresh stints
                //_heatWithStint = await _serviceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });
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
            await _serviceClient.CreateStintJournalAsync(proto);

            TransitionStateHeatStintStateType(heatStintStateTypeId);

            _stint!.StintStateType = new Razmanager.Protobuf.Public.V1.DetailStateType
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

            _ = GrainFactory.GetGrain<HeatWithStint.IHeatWithStintGrain>(new Guid(_stint.HeatWithStintId)).StintStateTypeUpdatedAsync(_stint);

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

                            if ((raceSession!.HeatStintEndTypeId == HeatStintEndTypeId.Lap && raceSession.HeatStintEndLapLaps <= indicatorState.Laps.Value ||
                                raceSession!.HeatStintEndTypeId == HeatStintEndTypeId.Duration && raceSession.HeatStintEndDurationDuration.ToTimeSpan() <=
                                    Google.Protobuf.WellKnownTypes.Duration.FromTimeSpan(heatStintJournalState.TimerElapsed.ToTimeSpan().Add((heatStintJournalState.Timestamp - heatStintJournalState.TimerStartedAt).ToTimeSpan())).ToTimeSpan()))
                            {
                                indicatorState.Finished = true;
                            }
                            else if (heatStintJournalState.Ended)
                            {
                                indicatorState.Finished = true;
                            }

                            var eventUsersEventSpeechTexts = new Dictionary<Guid, EventSpeechTexts>();

                            var timerElapsed = Google.Protobuf.WellKnownTypes.Duration.FromTimeSpan(heatStintJournalState.TimerElapsed.ToTimeSpan().Add((deviceConfigurationInput.Timestamp - heatStintJournalState.TimerStartedAt!).ToTimeSpan()));
                            _ = GrainFactory.GetGrain<HeatWithStint.IHeatWithStintGrain>(new Guid(_stint!.HeatWithStintId))
                                .EventUserUpdateAsync(new EventUserUpdate
                                {
                                    Id = this.GetPrimaryKey().ToString(),
                                    EventUserId = indicatorState.EventUserId,
                                    TimerElapsed = timerElapsed,
                                    Laps = indicatorState.Laps
                                });

                            //Console.WriteLine($"{deviceConfigurationInput.DeviceConfigurationInputId} {indicator.Laps!.Value} {time.Value} {state.TimerElapsed.Seconds}");

                            if (indicatorState.Laps.HasValue)
                            {
                                double? stintStateIndicatorTimeDisplay = indicatorState.LatestTimeTypeTimes[IndicatorTimeTypeId.Lap].Time.HasValue ? Math.Round(indicatorState.LatestTimeTypeTimes[IndicatorTimeTypeId.Lap].Time!.Value, trackLaptimeDecimals) : null;
                                var stintStateIndicatorTimePrevious = indicatorState.AllTimeTypeTimes[IndicatorTimeTypeId.Lap].SkipLast(1).LastOrDefault()?.Time;

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

                                if (!replay && stintStateIndicatorTimeDisplay.HasValue && stintStateIndicatorTimeDisplay!.Value > 0)
                                {
                                    var eventUserId = _stint!.StintIndicators.SingleOrDefault(x => x.Id == indicatorState.Id)?.EventUserId;
                                    if (eventUserId is not null)
                                    {
                                        var latestTimeTypeTimeLap = indicatorState.LatestTimeTypeTimes.SingleOrDefault(x => x.Key == IndicatorTimeTypeId.Lap).Value;
                                        if (latestTimeTypeTimeLap is not null && stintStateIndicatorTimeDisplay.HasValue)
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
                                                        Text = $"You set a new personal fastest lap  {stintStateIndicatorTimeDisplay.Value}",
                                                    });
                                                    break;

                                                case IndicatorFastestTimeTypeId.AllIndicators:
                                                    eventSpeechTexts.Items.Add(new EventSpeechText
                                                    {
                                                        EventSpeechTypeId = EventSpeechTypeId.Fastest,
                                                        Text = $"You set the new overall fastest lap  {stintStateIndicatorTimeDisplay.Value}",
                                                    });
                                                    break;

                                                default:
                                                    if (stintStateIndicatorTimePrevious.HasValue && stintStateIndicatorTimeDisplay.Value - stintStateIndicatorTimePrevious.Value > 1)
                                                    {
                                                        eventSpeechTexts.Items.Add(new EventSpeechText
                                                        {
                                                            EventSpeechTypeId = EventSpeechTypeId.Lap,
                                                            Text = stintStateIndicatorTimeDisplay.Value.ToString(),
                                                            Slow = true
                                                        });
                                                    }
                                                    else
                                                    {
                                                        eventSpeechTexts.Items.Add(new EventSpeechText
                                                        {
                                                            EventSpeechTypeId = EventSpeechTypeId.Lap,
                                                            Text = stintStateIndicatorTimeDisplay.Value.ToString(),
                                                        });
                                                    }
                                                    break;
                                            }

                                            eventSpeechTexts.Items.Add(new EventSpeechText
                                            {
                                                EventSpeechTypeId = EventSpeechTypeId.AverageLap,
                                                Time = stintStateIndicatorTimeDisplay
                                            });
                                        }
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
                    //        _ = RaiseHeatStateTypeAsync(HeatStateTypeId.Running);
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
    }
}
