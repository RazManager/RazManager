using Orleans.Streams;
using Razmanager.Protobuf.Internal.Silo.SystemServices.EventUser;
using Razmanager.Protobuf.Public.V1;
using System.Globalization;
using System.Resources;


namespace RazManager.Silo.Grains.Entities.HeatWithStints
{
    public class HeatWithStintsGrain : Grain, IHeatWithStintsGrain
    {
        private readonly Razmanager.Protobuf.Internal.Repository.SystemServices.Race.RaceService.RaceServiceClient _raceServiceClient;
        private readonly Razmanager.Protobuf.Internal.Repository.SystemServices.RaceSessionWithStints.RaceSessionWithStintsService.RaceSessionWithStintsServiceClient _raceSessionWithStintsServiceClient;
        private readonly Razmanager.Protobuf.Internal.Repository.SystemServices.HeatWithStints.HeatWithStintsService.HeatWithStintsServiceClient _serviceClient;
        private Razmanager.Protobuf.Public.V1.Race? _race;
        private Razmanager.Protobuf.Public.V1.RaceSessionWithStints? _raceSessionWithStints;
        private Razmanager.Protobuf.Public.V1.HeatWithStints? _heatWithStints;
        private IAsyncStream<Razmanager.Protobuf.Public.V1.HeatWithStints>? _heatWithStintsStream;
        private IAsyncStream<Razmanager.Protobuf.Public.V1.HeatWithStintsState>? _HeatWithStintsStateStream;
        private IAsyncStream<Razmanager.Protobuf.Public.V1.HeatWithStintsLeaderboard>? _heatWithStintsLeaderboardStream;
        private Guid? _currentStintId = null;
        private Dictionary<(Guid EventUserId, Guid StintId), uint> _eventUserStintIndicators = [];
        private Dictionary<Guid, HeatWithStintsLeaderboardEventUser> _heatWithStintsLeaderboardEventUsers = [];
        private string _trackLaptimeDecimalsFormat = "F2";


        public HeatWithStintsGrain(Razmanager.Protobuf.Internal.Repository.SystemServices.Race.RaceService.RaceServiceClient raceServiceClient,
                                  Razmanager.Protobuf.Internal.Repository.SystemServices.RaceSessionWithStints.RaceSessionWithStintsService.RaceSessionWithStintsServiceClient raceSessionWithStintsServiceClient,
                                  Razmanager.Protobuf.Internal.Repository.SystemServices.HeatWithStints.HeatWithStintsService.HeatWithStintsServiceClient serviceClient)
        {
            _raceServiceClient = raceServiceClient;
            _raceSessionWithStintsServiceClient = raceSessionWithStintsServiceClient;
            _serviceClient = serviceClient;
        }


        public override async Task OnActivateAsync(CancellationToken cancellationToken)
        {
            var streamProvider = this.GetStreamProvider(Constants.StreamProvider);
            _heatWithStintsStream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.HeatWithStints>(Constants.StreamName.HeatWithStints.ToString(), this.GetPrimaryKey());
            _HeatWithStintsStateStream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.HeatWithStintsState>(Constants.StreamName.HeatWithStintsState.ToString(), this.GetPrimaryKey());
            _heatWithStintsLeaderboardStream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.HeatWithStintsLeaderboard>(Constants.StreamName.HeatWithStintsLeaderboard.ToString(), this.GetPrimaryKey());
            await RefreshAsync();
        }


        public async Task RefreshAsync()
        {
            _heatWithStints = await _serviceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });
            _raceSessionWithStints = await _raceSessionWithStintsServiceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = _heatWithStints.RaceSessionId });
            _race = await _raceServiceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = _raceSessionWithStints.RaceId });

            _eventUserStintIndicators.Clear();
            foreach (var item in _heatWithStints.Stints.SelectMany(x => x.StintIndicators, (Stint, StintIndicator) => new { Stint, StintIndicator }))
            {
                _eventUserStintIndicators.Add((new Guid(item.StintIndicator.EventUserId), new Guid(item.Stint.Id)), item.StintIndicator.IndicatorId); // For quick lookup of the current indicator for each event user in a stint
            }

            Initialize();

            var tasks = _heatWithStints.Stints
                .Select(x => GrainFactory.GetGrain<Stint.IStintGrain>(new Guid(x.Id)).ReadAsync());
            var results = await Task.WhenAll(tasks);

            foreach (var result in results)
            {
                var stint = _heatWithStints.Stints.SingleOrDefault(x => x.Id == result.Id);
                if (stint is not null)
                {
                    stint = result;

                    if (stint.StateType.Id != DetailStateTypeId.Pending && stint.StateType.Id != DetailStateTypeId.Closed)
                    {
                        _currentStintId = new Guid(stint.Id);
                        _ = _HeatWithStintsStateStream!.OnNextAsync(HeatWithStintsState());
                    }
                }
            }

            _ = _heatWithStintsStream!.OnNextAsync(_heatWithStints);

            _ = GrainFactory.GetGrain<RaceSessionWithStints.IRaceSessionWithStintsGrain>(new Guid(_heatWithStints.RaceSessionId)).RefreshAsync();
        }


        private void Initialize()
        {
            _currentStintId = null;

            _heatWithStintsLeaderboardEventUsers.Clear();
            foreach (var heatEventUserIndex in _heatWithStints!.Stints
                .SelectMany(x => x.StintIndicators, (Stint, StintIndicator) => new { Stint, StintIndicator })
                .Where(x => x.Stint.HeatWithStintId == this.GetPrimaryKey().ToString())
                .Select((x, index) => new { x.StintIndicator.EventUserId, index }))
            {
                _heatWithStintsLeaderboardEventUsers.Add(new Guid(heatEventUserIndex.EventUserId), new HeatWithStintsLeaderboardEventUser { Position = Convert.ToUInt32(heatEventUserIndex.index + 1) });
            }
        }

            
        public Task<Razmanager.Protobuf.Public.V1.HeatWithStints> ReadAsync()
        {
            return Task.FromResult(_heatWithStints!);
        }


        public Task<HeatWithStintsState> ReadStateAsync()
        {
            return Task.FromResult(HeatWithStintsState());
        }


        public Task<HeatWithStintsLeaderboard> ReadLeaderboardAsync()
        {
            return Task.FromResult(HeatWithStintsLeaderboard());
        }


        public async Task CommandAsync(Razmanager.Protobuf.Public.V1.SummaryCommandTypeId heatWithStintsCommandTypeId)
        {
            switch (heatWithStintsCommandTypeId)
            {
                case SummaryCommandTypeId.Start:
                    if (!(_heatWithStints!.StateType.Id == SummaryStateTypeId.Pending))
                    {
                        return;
                    }

                    await HeatWithStintStateSetAsync(SummaryStateTypeId.Started);
                    break;

                case SummaryCommandTypeId.End:
                    if (!(_heatWithStints!.StateType.Id == SummaryStateTypeId.Started))
                    {
                        return;
                    }

                    await HeatWithStintStateSetAsync(SummaryStateTypeId.Ended);
                    break;

                case SummaryCommandTypeId.Reset:
                    if (!(_heatWithStints!.StateType.Id == SummaryStateTypeId.Started || _heatWithStints.StateType.Id == SummaryStateTypeId.Ended))
                    {
                        return;
                    }

                    Initialize();

                    foreach (var stint in _heatWithStints!.Stints)
                    {
                        _ = GrainFactory.GetGrain<Stint.IStintGrain>(new Guid(stint.Id)).CommandAsync(DetailCommandTypeId.Reset);
                    }

                    await HeatWithStintStateSetAsync(SummaryStateTypeId.Pending);
                    break;

                default:
                    break;
            }
        }


        private async Task HeatWithStintStateSetAsync(SummaryStateTypeId heatWithStintsStateTypeId)
        {
            _heatWithStints!.StateType = new Razmanager.Protobuf.Public.V1.SummaryStateType
            {
                Id = heatWithStintsStateTypeId,
                Name = new ResourceManager(typeof(RazManager.Resources.SummaryStateType)).GetString(heatWithStintsStateTypeId.ToString())
            };

            await _raceSessionWithStintsServiceClient.UpdateStateAsync(new Razmanager.Protobuf.Internal.Repository.SystemServices.RaceSessionWithStints.RaceSessionWithStintsStateUpdateRequest
            {
                Id = this.GetPrimaryKey().ToString(),
                StateTypeId = heatWithStintsStateTypeId
            });

            if (heatWithStintsStateTypeId == SummaryStateTypeId.Started)
            {
                var stintId = _heatWithStints.Stints
                    .OrderBy(x => x.Number)
                    .First().Id;
                _ = GrainFactory.GetGrain<Stint.IStintGrain>(new Guid(stintId)).CommandAsync(DetailCommandTypeId.Open);
                return;
            }

            _ = _heatWithStintsStream!.OnNextAsync(_heatWithStints);
        }


        public Task StintStateTypeUpdatedAsync(Razmanager.Protobuf.Public.V1.Stint stint)
        {
            var oldStint = _heatWithStints!.Stints
                    .SingleOrDefault(x => x.Id == stint.Id.ToString());
            if (oldStint is not null)
            {
                oldStint = stint;

                switch (stint.StateType.Id)
                {
                    case DetailStateTypeId.Pending:
                    case DetailStateTypeId.Opened:
                        foreach (var heatWithStintsLeaderboardEventUser in _heatWithStintsLeaderboardEventUsers)
                        {
                            heatWithStintsLeaderboardEventUser.Value.EventUserStints.Remove(new Guid(stint.Id));
                            CalculateLaps(heatWithStintsLeaderboardEventUser.Value, null);
                        }

                        CalculatePositions(null);

                        _ = _heatWithStintsLeaderboardStream!.OnNextAsync(HeatWithStintsLeaderboard());

                        break;

                    case DetailStateTypeId.Countdown:
                    case DetailStateTypeId.Running:
                    case DetailStateTypeId.Yellow:
                    case DetailStateTypeId.CountdownYellow:
                    case DetailStateTypeId.Red:
                    case DetailStateTypeId.CountdownRed:
                    case DetailStateTypeId.Ended:
                    case DetailStateTypeId.Off:
                        break;

                    case DetailStateTypeId.Closed:
                        foreach (var s in _heatWithStints.Stints
                            .OrderBy(x => x.Number))
                        {
                            if (s.StateType.Id == DetailStateTypeId.Pending)
                            {
                                _ = GrainFactory.GetGrain<Stint.IStintGrain>(new Guid(s.Id)).CommandAsync(DetailCommandTypeId.Open);
                                break;
                            }
                        }
                        break;

                    default:
                        throw new ArgumentException($"Unhandled StateType: {stint.StateType.Id}", nameof(stint.StateType.Id));
                }
            }

            _ = _heatWithStintsStream!.OnNextAsync(_heatWithStints);

            return Task.CompletedTask;
        }


        public Task StintStateUpdatedAsync(Razmanager.Protobuf.Public.V1.Stint stint)
        {
            var oldStint = _heatWithStints!.Stints
                    .SingleOrDefault(x => x.Id == stint.Id.ToString());
            if (oldStint is not null)
            {
                oldStint = stint;
                _ = _HeatWithStintsStateStream!.OnNextAsync(HeatWithStintsState());
            }

            return Task.CompletedTask;
        }


        public async Task EventUserUpdateAsync(EventUserUpdate update)
        {
            var stint = _heatWithStints!.Stints
                    .SingleOrDefault(x => x.Id == update.Id);
            if (stint is null)
            {
                return;
            }

            if (!_heatWithStintsLeaderboardEventUsers.TryGetValue(new Guid(update.EventUserId), out var heatWithStintsLeaderboardEventUser))
            {
                return;
            }

            if (!heatWithStintsLeaderboardEventUser.EventUserStints.TryGetValue(new Guid(update.Id), out var heatWithStintsLeaderboardEventUserStint))
            {
                heatWithStintsLeaderboardEventUserStint = new HeatWithStintsLeaderboardEventUserStint();
                heatWithStintsLeaderboardEventUser.EventUserStints[new Guid(update.Id)] = heatWithStintsLeaderboardEventUserStint;
            }

            switch (update.ValueCase)
            {
                case EventUserUpdate.ValueOneofCase.Laps:
                    heatWithStintsLeaderboardEventUserStint.EventUserUpdatesLap = update;
                    heatWithStintsLeaderboardEventUser.PreviousGapLapsPredictedInterval = heatWithStintsLeaderboardEventUser.GapLapsPredictedInterval;
                    CalculateLaps(heatWithStintsLeaderboardEventUser, update);
                    CalculatePositions(update);
                    _ = _heatWithStintsLeaderboardStream!.OnNextAsync(HeatWithStintsLeaderboard());

                    break;

                case EventUserUpdate.ValueOneofCase.Finished:
                    heatWithStintsLeaderboardEventUserStint.Finished = true;
                    _ = _heatWithStintsLeaderboardStream!.OnNextAsync(HeatWithStintsLeaderboard());
                    break;

                //case RaceLeaderboardHeatEventUserUpdate.ValueOneofCase.Flags:
                //    break;

                default:
                    break;
            }

        }


        private void CalculateLaps(HeatWithStintsLeaderboardEventUser heatWithStintsLeaderboardEventUser, EventUserUpdate? update)
        {
            var stint = _heatWithStints?.Stints.SingleOrDefault(x => x.Id == update?.Id);
            if (stint is null)
            {
                return;
            }

            heatWithStintsLeaderboardEventUser.LapsCompleted = heatWithStintsLeaderboardEventUser.EventUserStints.Values.Sum(x => x.EventUserUpdatesLap?.Laps);

            if (_raceSessionWithStints!.HeatStintEndTypeId == HeatStintEndTypeId.Duration)
            {
                heatWithStintsLeaderboardEventUser.PreviousTimerElapsed = heatWithStintsLeaderboardEventUser.TimerElapsed;
                var first = true;
                heatWithStintsLeaderboardEventUser.TimerElapsed = TimeSpan.FromTicks(_heatWithStints!.Stints!
                        .Where(x => heatWithStintsLeaderboardEventUser.EventUserStints.ContainsKey(new Guid(x.Id)))
                    .OrderByDescending(x => x.Number).Sum(x =>
                    {
                        if (first)
                        {
                            first = false;
                            return update?.TimerElapsed.ToTimeSpan().Ticks ?? 0;
                        }
                        else
                        {
                            return _raceSessionWithStints!.HeatStintEndDurationDuration.ToTimeSpan().Ticks;
                        }
                    }));

                if (heatWithStintsLeaderboardEventUser.TimerElapsed.Ticks == 0 || heatWithStintsLeaderboardEventUser.LapsCompleted == 0)
                {
                    heatWithStintsLeaderboardEventUser.LapsPredicted = null;
                }
                else
                {
                    heatWithStintsLeaderboardEventUser.LapsPredicted =
                        heatWithStintsLeaderboardEventUser.LapsCompleted * _race!.RaceIndicators.Count() * _raceSessionWithStints!.HeatStintEndDurationDuration.ToTimeSpan().Ticks / heatWithStintsLeaderboardEventUser.TimerElapsed.Ticks;
                }
            }
        }


        private void CalculatePositions(EventUserUpdate? update)
        {
            if (_raceSessionWithStints!.HeatStintEndTypeId == HeatStintEndTypeId.Duration)
            {
                KeyValuePair<Guid, HeatWithStintsLeaderboardEventUser>? leaderLeaderboardEventUserKv = null;
                KeyValuePair<Guid, HeatWithStintsLeaderboardEventUser>? intervalLeaderboardEventUserKv = null;

                foreach (var item in _heatWithStintsLeaderboardEventUsers
                    .OrderByDescending(x => x.Value.LapsPredicted)
                    .ThenBy(x => x.Value.TimerElapsed)
                    .Select((raceEventUserKv, index) => new { raceEventUserKv, index }))
                {
                    item.raceEventUserKv.Value.Position = Convert.ToUInt32(item.index + 1);

                    item.raceEventUserKv.Value.GapLapsPredictedLeader = null;
                    item.raceEventUserKv.Value.GapLapsPredictedInterval = null;
                    item.raceEventUserKv.Value.GapLapsPredictedIntervalFraction = null;

                    if (item.raceEventUserKv.Value.LapsPredicted.HasValue)
                    {
                        if (leaderLeaderboardEventUserKv is not null &&
                            leaderLeaderboardEventUserKv.Value.Value.LapsPredicted.HasValue)
                        {
                            item.raceEventUserKv.Value.GapLapsPredictedLeader = leaderLeaderboardEventUserKv.Value.Value.LapsPredicted.Value - item.raceEventUserKv.Value.LapsPredicted.Value;
                        }
                        if (intervalLeaderboardEventUserKv is not null &&
                            intervalLeaderboardEventUserKv.Value.Value.LapsPredicted.HasValue)
                        {
                            item.raceEventUserKv.Value.GapLapsPredictedInterval = intervalLeaderboardEventUserKv.Value.Value.LapsPredicted.Value - item.raceEventUserKv.Value.LapsPredicted.Value;

                            if (item.raceEventUserKv.Value.PreviousIntervalRaceEventUserId == intervalLeaderboardEventUserKv.Value.Key)
                            {
                                if (update is not null && item.raceEventUserKv.Value.PreviousGapLapsPredictedInterval is not null)
                                {
                                    item.raceEventUserKv.Value.GapLapsPredictedIntervalFraction = (item.raceEventUserKv.Value.PreviousGapLapsPredictedInterval - item.raceEventUserKv.Value.GapLapsPredictedInterval);
                                    //Console.WriteLine($"PreviousGapLapsEstimatedInterval updated: {item.raceEventUserKv.Value.PreviousGapLapsEstimatedInterval}");
                                }
                            }
                            else
                            {
                                item.raceEventUserKv.Value.PreviousGapLapsPredictedInterval = null;
                            }

                            item.raceEventUserKv.Value.PreviousIntervalRaceEventUserId = intervalLeaderboardEventUserKv.Value.Key;
                        }
                    }

                    if (item.index == 0)
                    {
                        leaderLeaderboardEventUserKv = item.raceEventUserKv;
                    }
                    intervalLeaderboardEventUserKv = item.raceEventUserKv;
                }
            }
        }


        private HeatWithStintsState HeatWithStintsState()
        {
            var heatWithStintsState = new HeatWithStintsState
            {
                StateType = _heatWithStints!.StateType,
            };

            var currentStint = _heatWithStints?.Stints.SingleOrDefault(x => x.Id == _currentStintId.ToString());
            if (currentStint is not null)
            {
                heatWithStintsState.CurrentStint = currentStint;
                heatWithStintsState.HeatWithStintsEventUserStates.AddRange(currentStint.StintIndicators.Select(x => new Razmanager.Protobuf.Public.V1.HeatWithStintsEventUserState
                {
                    EventUserId = x.EventUserId,
                    IndicatorIdCurrent = x.IndicatorId
                }));
            }

            //var raceEventUserHeatEventUserUpdatesFinished = _sessionRaceEventUsers[sessionTypeId]
            //    .SelectMany(x => x.Value.HeatEventUserUpdatesFinished, (sessionRaceEventUser, heatEventUserUpdatesFinished) => new { sessionRaceEventUser.Key, x.Value.raceEventUserHeatEventUserUpdateFinished.key })
            //    .Distinct()
            //    .GroupBy(x => x.EventUserId);
            foreach (var heatWithStintsLeaderboardEventUsersFinished in _heatWithStintsLeaderboardEventUsers.Where(x => x.Value.EventUserStints.Any(x => x.Value.Finished)))
            {
                var heatWithStintEventUserState = heatWithStintsState.HeatWithStintsEventUserStates.SingleOrDefault(x => x.EventUserId == heatWithStintsLeaderboardEventUsersFinished.Key.ToString());
                if (heatWithStintEventUserState is null)
                {
                    heatWithStintEventUserState = new HeatWithStintsEventUserState { EventUserId = heatWithStintsLeaderboardEventUsersFinished.Key.ToString() };
                    heatWithStintsState.HeatWithStintsEventUserStates.Add(heatWithStintEventUserState);
                }

                foreach (var EventUserUpdatesFinishedHeats in heatWithStintsLeaderboardEventUsersFinished.Value.EventUserStints.Where(x => x.Value.Finished))
                {
                    if (_eventUserStintIndicators.TryGetValue((heatWithStintsLeaderboardEventUsersFinished.Key, EventUserUpdatesFinishedHeats.Key), out var indicatorId))
                    {
                        heatWithStintEventUserState.IndicatorIdsFinished.Add(indicatorId);
                    }
                }
            }

            return heatWithStintsState;
        }


        private HeatWithStintsLeaderboard HeatWithStintsLeaderboard()
        {
            var heatWithStintsLeaderboard = new HeatWithStintsLeaderboard();

            foreach (var heatWithStintsLeaderboardEventUserKv in _heatWithStintsLeaderboardEventUsers)
            {
                var heatWithStintsLeaderboardEventUser = new Razmanager.Protobuf.Public.V1.HeatWithStintsLeaderboardEventUser
                {
                    EventUserId = heatWithStintsLeaderboardEventUserKv.Key.ToString(),
                    Position = heatWithStintsLeaderboardEventUserKv.Value.Position,
                    GapLapsPredictedIntervalFraction = heatWithStintsLeaderboardEventUserKv.Value.GapLapsPredictedIntervalFraction
                };
                if (heatWithStintsLeaderboardEventUserKv.Value.LapsCompleted.HasValue)
                {
                    heatWithStintsLeaderboardEventUser.LapsCompleted = heatWithStintsLeaderboardEventUserKv.Value.LapsCompleted.Value.ToString("F0", CultureInfo.InvariantCulture);
                }
                if (heatWithStintsLeaderboardEventUserKv.Value.LapsPredicted.HasValue)
                {
                    heatWithStintsLeaderboardEventUser.LapsPredicted = heatWithStintsLeaderboardEventUserKv.Value.LapsPredicted.Value.ToString(_trackLaptimeDecimalsFormat, CultureInfo.InvariantCulture);
                }
                //Points = raceEventUserKv.Value.Points,
                //PointsEstimate = raceEventUserKv.Value.PointsEstimate,
                if (heatWithStintsLeaderboardEventUserKv.Value.GapLapsPredictedLeader.HasValue)
                {
                    heatWithStintsLeaderboardEventUser.GapLapsPredictedLeader = heatWithStintsLeaderboardEventUserKv.Value.GapLapsPredictedLeader.Value.ToString(_trackLaptimeDecimalsFormat, CultureInfo.InvariantCulture);
                }
                if (heatWithStintsLeaderboardEventUserKv.Value.GapLapsPredictedInterval.HasValue)
                {
                    heatWithStintsLeaderboardEventUser.GapLapsPredictedInterval = heatWithStintsLeaderboardEventUserKv.Value.GapLapsPredictedInterval.Value.ToString(_trackLaptimeDecimalsFormat, CultureInfo.InvariantCulture);
                }

                //if (raceEventUserKv.Value.GapLeaderLaps.HasValue)
                //{
                //    raceLeaderboardEventUser.GapLeader = $"{raceEventUserKv.Value.GapLeaderLaps.Value}L";
                //}
                //else if (raceEventUserKv.Value.GapLeaderTime.HasValue)
                //{
                //    raceLeaderboardEventUser.GapLeader = raceEventUserKv.Value.GapLeaderTime.Value.ToString(_trackLaptimeDecimalsFormat, CultureInfo.InvariantCulture);
                //}

                //if (raceEventUserKv.Value.GapIntervalLaps.HasValue)
                //{
                //    raceLeaderboardEventUser.GapInterval = $"{raceEventUserKv.Value.GapIntervalLaps.Value}L";
                //}
                //else if (raceEventUserKv.Value.GapIntervalTime.HasValue)
                //{
                //    raceLeaderboardEventUser.GapInterval = raceEventUserKv.Value.GapIntervalTime.Value.ToString(_trackLaptimeDecimalsFormat, CultureInfo.InvariantCulture);
                //}

                if (_currentStintId.HasValue)
                {
                    if (heatWithStintsLeaderboardEventUserKv.Value.EventUserStints.TryGetValue(_currentStintId.Value, out var heatWithStintsLeaderboardEventUserStint))
                    {
                        if (heatWithStintsLeaderboardEventUserStint.Finished)
                        {
                            heatWithStintsLeaderboardEventUser.Flags.Add(IndicatorFlag.Finished);
                        }
                        //if (_timeTypeFastestTimes[HeatIndicatorTimeTypeId.Lap].IndicatorId == heatStateInternalIndicatorKv.Key)
                        //{
                        //    raceLeaderboardEventUser.Flags.Add(HeatIndicatorFlag.FastestLap);
                        //}
                        //if (raceEventUserKv.Value.LapWarning)
                        //{
                        //    heatLeaderboardIndicator.Flags.Add(HeatIndicatorFlag.Warning);
                        //}
                        if (heatWithStintsLeaderboardEventUserStint.Pitlane)
                        {
                            heatWithStintsLeaderboardEventUser.Flags.Add(IndicatorFlag.Pitlane);
                        }
                        if (heatWithStintsLeaderboardEventUserStint.Deslot)
                        {
                            heatWithStintsLeaderboardEventUser.Flags.Add(IndicatorFlag.Deslot);
                        }
                    }
                }

                heatWithStintsLeaderboard.EventUsers.Add(heatWithStintsLeaderboardEventUser);
            }

            return heatWithStintsLeaderboard;
        }


        public class HeatWithStintsLeaderboardEventUser
        {
            public required uint Position { get; set; }
            public TimeSpan TimerElapsed { get; set; }
            public TimeSpan PreviousTimerElapsed { get; set; }
            public double? LapsCompleted { get; set; }
            public double? LapsPredicted { get; set; }
            public double? GapLapsPredictedLeader { get; set; }
            public double? GapLapsPredictedInterval { get; set; }
            public double? GapLapsPredictedIntervalFraction { get; set; }
            public Guid? PreviousIntervalRaceEventUserId { get; set; } = null;
            public double? PreviousGapLapsPredictedInterval { get; set; }
            public Dictionary<Guid, HeatWithStintsLeaderboardEventUserStint> EventUserStints { get; set; } = [];

            //public ushort? Points { get; set; }
            //public ushort? PointsEstimate { get; set; }
        }


        public class HeatWithStintsLeaderboardEventUserStint
        {
            public bool Finished { get; set; }
            //public bool LapWarning { get; set; }
            public bool Pitlane { get; set; }
            //public ushort LapPitlanes { get; set; }
            public bool Deslot { get; set; }
            //public ushort LapCarOffTracks { get; set; }
            public EventUserUpdate? EventUserUpdatesLap { get; set; }
        }
    }
}
