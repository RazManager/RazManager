using Orleans.Streams;
using Razmanager.Protobuf.Internal.Silo.SystemServices.EventUser;
using Razmanager.Protobuf.Public.V1;
using System.Globalization;
using System.Resources;


namespace RazManager.Silo.Grains.Entities.HeatWithStint
{
    public class HeatWithStintGrain : Grain, IHeatWithStintGrain
    {
        private readonly Razmanager.Protobuf.Internal.Repository.SystemServices.Race.RaceService.RaceServiceClient _raceServiceClient;
        private readonly Razmanager.Protobuf.Internal.Repository.SystemServices.RaceSession.RaceSessionService.RaceSessionServiceClient _raceSessionServiceClient;
        private readonly Razmanager.Protobuf.Internal.Repository.SystemServices.HeatWithStint.HeatWithStintService.HeatWithStintServiceClient _serviceClient;
        private Razmanager.Protobuf.Public.V1.Race? _race;
        private Razmanager.Protobuf.Public.V1.RaceSession? _raceSession;
        private Razmanager.Protobuf.Public.V1.HeatWithStint? _heatWithStint;
        private IAsyncStream<Razmanager.Protobuf.Public.V1.HeatWithStint>? _heatWithStintStream;
        private IAsyncStream<Razmanager.Protobuf.Public.V1.HeatWithStintState>? _HeatWithStintStateStream;
        private IAsyncStream<Razmanager.Protobuf.Public.V1.HeatWithStintLeaderboard>? _heatWithStintLeaderboardStream;
        private Guid? _currentStintId = null;
        private Dictionary<(Guid EventUserId, Guid StintId), uint> _eventUserStintIndicators = [];
        private Dictionary<Guid, HeatWithStintLeaderboardEventUser> _heatWithStintLeaderboardEventUsers = [];
        private string _trackLaptimeDecimalsFormat = "F2";


        public HeatWithStintGrain(Razmanager.Protobuf.Internal.Repository.SystemServices.Race.RaceService.RaceServiceClient raceServiceClient,
                                  Razmanager.Protobuf.Internal.Repository.SystemServices.RaceSession.RaceSessionService.RaceSessionServiceClient raceSessionServiceClient,
                                  Razmanager.Protobuf.Internal.Repository.SystemServices.HeatWithStint.HeatWithStintService.HeatWithStintServiceClient serviceClient)
        {
            _raceServiceClient = raceServiceClient;
            _raceSessionServiceClient = raceSessionServiceClient;
            _serviceClient = serviceClient;
        }


        public override async Task OnActivateAsync(CancellationToken cancellationToken)
        {
            var streamProvider = this.GetStreamProvider(Constants.StreamProvider);
            _heatWithStintStream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.HeatWithStint>(Constants.StreamName.HeatWithStint.ToString(), this.GetPrimaryKey());
            _HeatWithStintStateStream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.HeatWithStintState>(Constants.StreamName.HeatWithStintState.ToString(), this.GetPrimaryKey());
            _heatWithStintLeaderboardStream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.HeatWithStintLeaderboard>(Constants.StreamName.HeatWithStintLeaderboard.ToString(), this.GetPrimaryKey());
            await RefreshAsync();
        }


        public async Task RefreshAsync()
        {
            _heatWithStint = await _serviceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });
            _raceSession = await _raceSessionServiceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = _heatWithStint.RaceSessionId });
            _race = await _raceServiceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = _raceSession.RaceId });

            foreach (var item in _heatWithStint.Stints.SelectMany(x => x.StintIndicators, (Stint, StintIndicator) => new { Stint, StintIndicator }))
            {
                _eventUserStintIndicators.Add((new Guid(item.StintIndicator.EventUserId), new Guid(item.Stint.Id)), item.StintIndicator.IndicatorId); // For quick lookup of the current indicator for each event user in a stint
            }

            Initialize();

            var tasks = _heatWithStint.Stints
                .Select(x => GrainFactory.GetGrain<Stint.IStintGrain>(new Guid(x.Id)).ReadAsync());
            var results = await Task.WhenAll(tasks);

            foreach (var result in results)
            {
                var stint = _heatWithStint.Stints.SingleOrDefault(x => x.Id == result.Id);
                if (stint is not null)
                {
                    stint = result;

                    if (stint.StintStateType.Id != DetailStateTypeId.Pending && stint.StintStateType.Id != DetailStateTypeId.Closed)
                    {
                        _currentStintId = new Guid(stint.Id);
                        _ = _HeatWithStintStateStream!.OnNextAsync(HeatWithStintState());
                    }
                }
            }

            _ = _heatWithStintStream!.OnNextAsync(_heatWithStint);

            _ = GrainFactory.GetGrain<RaceSessionWithStint.IRaceSessionWithStintGrain>(new Guid(_heatWithStint.RaceSessionId)).RefreshAsync();
        }


        private void Initialize()
        {
            _currentStintId = null;

            _heatWithStintLeaderboardEventUsers.Clear();
            foreach (var heatEventUserIndex in _heatWithStint!.Stints
                .SelectMany(x => x.StintIndicators, (Stint, StintIndicator) => new { Stint, StintIndicator })
                .Where(x => x.Stint.HeatWithStintId == this.GetPrimaryKey().ToString())
                .Select((x, index) => new { x.StintIndicator.EventUserId, index }))
            {
                _heatWithStintLeaderboardEventUsers.Add(new Guid(heatEventUserIndex.EventUserId), new HeatWithStintLeaderboardEventUser { Position = Convert.ToUInt32(heatEventUserIndex.index + 1) });
            }
        }

            
        public Task<Razmanager.Protobuf.Public.V1.HeatWithStint> ReadAsync()
        {
            return Task.FromResult(_heatWithStint!);
        }


        public Task<HeatWithStintState> ReadHeatWithStateAsync()
        {
            return Task.FromResult(HeatWithStintState());
        }


        public Task<HeatWithStintLeaderboard> ReadHeatWithStintLeaderboardAsync()
        {
            return Task.FromResult(HeatWithStintLeaderboard());
        }


        public async Task CommandAsync(Razmanager.Protobuf.Public.V1.SummaryCommandTypeId heatWithStintCommandTypeId)
        {
            switch (heatWithStintCommandTypeId)
            {
                case SummaryCommandTypeId.Start:
                    if (!(_heatWithStint!.HeatWithStintStateType.Id == SummaryStateTypeId.Pending))
                    {
                        return;
                    }

                    await HeatWithStintStateSetAsync(SummaryStateTypeId.Started);
                    break;

                case SummaryCommandTypeId.End:
                    if (!(_heatWithStint!.HeatWithStintStateType.Id == SummaryStateTypeId.Started))
                    {
                        return;
                    }

                    await HeatWithStintStateSetAsync(SummaryStateTypeId.Ended);
                    break;

                case SummaryCommandTypeId.Reset:
                    if (!(_heatWithStint!.HeatWithStintStateType.Id == SummaryStateTypeId.Started || _heatWithStint.HeatWithStintStateType.Id == SummaryStateTypeId.Ended))
                    {
                        return;
                    }

                    Initialize();

                    foreach (var stint in _heatWithStint!.Stints)
                    {
                        _ = GrainFactory.GetGrain<Stint.IStintGrain>(new Guid(stint.Id)).CommandAsync(DetailCommandTypeId.Reset);
                    }

                    await HeatWithStintStateSetAsync(SummaryStateTypeId.Pending);
                    break;

                default:
                    break;
            }
        }


        private async Task HeatWithStintStateSetAsync(SummaryStateTypeId heatWithStintStateTypeId)
        {
            _heatWithStint!.HeatWithStintStateType = new Razmanager.Protobuf.Public.V1.SummaryStateType
            {
                Id = heatWithStintStateTypeId,
                Name = new ResourceManager(typeof(RazManager.Resources.SummaryStateType)).GetString(heatWithStintStateTypeId.ToString())
            };

            await _serviceClient.UpdateStateAsync(new Razmanager.Protobuf.Internal.Repository.SystemServices.HeatWithStint.HeatWithStintStateUpdateRequest
            {
                Id = this.GetPrimaryKey().ToString(),
                HeatWithStintStateTypeId = heatWithStintStateTypeId
            });

            if (heatWithStintStateTypeId == SummaryStateTypeId.Started)
            {
                var stintId = _heatWithStint.Stints
                    .OrderBy(x => x.Number)
                    .First().Id;
                _ = GrainFactory.GetGrain<Stint.IStintGrain>(new Guid(stintId)).CommandAsync(DetailCommandTypeId.Open);
                return;
            }

            _ = _heatWithStintStream!.OnNextAsync(_heatWithStint);
        }


        public Task StintStateTypeUpdatedAsync(Razmanager.Protobuf.Public.V1.Stint stint)
        {
            var oldStint = _heatWithStint!.Stints
                    .SingleOrDefault(x => x.Id == stint.Id.ToString());
            if (oldStint is not null)
            {
                oldStint = stint;

                switch (stint.StintStateType.Id)
                {
                    case DetailStateTypeId.Pending:
                    case DetailStateTypeId.Opened:
                        foreach (var heatWithStintLeaderboardEventUser in _heatWithStintLeaderboardEventUsers)
                        {
                            heatWithStintLeaderboardEventUser.Value.EventUserStints.Remove(new Guid(stint.Id));
                            CalculateLaps(heatWithStintLeaderboardEventUser.Value, null);
                        }

                        CalculatePositions(null);

                        _ = _heatWithStintLeaderboardStream!.OnNextAsync(HeatWithStintLeaderboard());

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
                        foreach (var s in _heatWithStint.Stints
                            .OrderBy(x => x.Number))
                        {
                            if (s.StintStateType.Id == DetailStateTypeId.Pending)
                            {
                                _ = GrainFactory.GetGrain<Stint.IStintGrain>(new Guid(s.Id)).CommandAsync(DetailCommandTypeId.Open);
                                break;
                            }
                        }
                        break;

                    default:
                        throw new ArgumentException($"Unhandled stintStateType: {stint.StintStateType.Id}", nameof(stint.StintStateType.Id));
                }
            }

            _ = _heatWithStintStream!.OnNextAsync(_heatWithStint);

            return Task.CompletedTask;
        }


        public Task StintStateUpdatedAsync(Razmanager.Protobuf.Public.V1.Stint stint)
        {
            var oldStint = _heatWithStint!.Stints
                    .SingleOrDefault(x => x.Id == stint.Id.ToString());
            if (oldStint is not null)
            {
                oldStint = stint;
                _ = _HeatWithStintStateStream!.OnNextAsync(HeatWithStintState());
            }

            return Task.CompletedTask;
        }


        public async Task EventUserUpdateAsync(EventUserUpdate update)
        {
            var stint = _heatWithStint!.Stints
                    .SingleOrDefault(x => x.Id == update.Id);
            if (stint is null)
            {
                return;
            }

            if (!_heatWithStintLeaderboardEventUsers.TryGetValue(new Guid(update.EventUserId), out var heatWithStintLeaderboardEventUser))
            {
                return;
            }

            if (!heatWithStintLeaderboardEventUser.EventUserStints.TryGetValue(new Guid(update.Id), out var heatWithStintLeaderboardEventUserStint))
            {
                heatWithStintLeaderboardEventUserStint = new HeatWithStintLeaderboardEventUserStint();
                heatWithStintLeaderboardEventUser.EventUserStints[new Guid(update.Id)] = heatWithStintLeaderboardEventUserStint;
            }

            switch (update.ValueCase)
            {
                case EventUserUpdate.ValueOneofCase.Laps:
                    heatWithStintLeaderboardEventUserStint.EventUserUpdatesLap = update;
                    heatWithStintLeaderboardEventUser.PreviousGapLapsPredictedInterval = heatWithStintLeaderboardEventUser.GapLapsPredictedInterval;
                    CalculateLaps(heatWithStintLeaderboardEventUser, update);
                    CalculatePositions(update);
                    _ = _heatWithStintLeaderboardStream!.OnNextAsync(HeatWithStintLeaderboard());

                    break;

                case EventUserUpdate.ValueOneofCase.Finished:
                    heatWithStintLeaderboardEventUserStint.Finished = true;
                    _ = _heatWithStintLeaderboardStream!.OnNextAsync(HeatWithStintLeaderboard());
                    break;

                //case RaceLeaderboardHeatEventUserUpdate.ValueOneofCase.Flags:
                //    break;

                default:
                    break;
            }

        }


        private void CalculateLaps(HeatWithStintLeaderboardEventUser raceLeaderboardEventUser, EventUserUpdate? update)
        {
            var stint = _heatWithStint?.Stints.SingleOrDefault(x => x.Id == update?.Id);
            if (stint is null)
            {
                return;
            }

            raceLeaderboardEventUser.LapsCompleted = raceLeaderboardEventUser.EventUserStints.Values.Sum(x => x.EventUserUpdatesLap?.Laps);

            if (_raceSession!.HeatStintEndTypeId == HeatStintEndTypeId.Duration)
            {
                raceLeaderboardEventUser.PreviousTimerElapsed = raceLeaderboardEventUser.TimerElapsed;
                var first = true;
                raceLeaderboardEventUser.TimerElapsed = TimeSpan.FromTicks(_heatWithStint!.Stints!
                        .Where(x => raceLeaderboardEventUser.EventUserStints.ContainsKey(new Guid(x.Id)))
                    .OrderByDescending(x => x.Number).Sum(x =>
                    {
                        if (first)
                        {
                            first = false;
                            return update?.TimerElapsed.ToTimeSpan().Ticks ?? 0;
                        }
                        else
                        {
                            return _raceSession!.HeatStintEndDurationDuration.ToTimeSpan().Ticks;
                        }
                    }));

                if (raceLeaderboardEventUser.TimerElapsed.Ticks == 0 || raceLeaderboardEventUser.LapsCompleted == 0)
                {
                    raceLeaderboardEventUser.LapsPredicted = null;
                }
                else
                {
                    raceLeaderboardEventUser.LapsPredicted =
                        raceLeaderboardEventUser.LapsCompleted * _race!.RaceIndicators.Count() * _raceSession!.HeatStintEndDurationDuration.ToTimeSpan().Ticks / raceLeaderboardEventUser.TimerElapsed.Ticks;
                }
            }
        }


        private void CalculatePositions(EventUserUpdate? update)
        {
            if (_raceSession!.HeatStintEndTypeId == HeatStintEndTypeId.Duration)
            {
                KeyValuePair<Guid, HeatWithStintLeaderboardEventUser>? leaderRaceLeaderboardEventUserKv = null;
                KeyValuePair<Guid, HeatWithStintLeaderboardEventUser>? intervalRaceLeaderboardEventUserKv = null;

                foreach (var item in _heatWithStintLeaderboardEventUsers
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
                        if (leaderRaceLeaderboardEventUserKv is not null &&
                            leaderRaceLeaderboardEventUserKv.Value.Value.LapsPredicted.HasValue)
                        {
                            item.raceEventUserKv.Value.GapLapsPredictedLeader = leaderRaceLeaderboardEventUserKv.Value.Value.LapsPredicted.Value - item.raceEventUserKv.Value.LapsPredicted.Value;
                        }
                        if (intervalRaceLeaderboardEventUserKv is not null &&
                            intervalRaceLeaderboardEventUserKv.Value.Value.LapsPredicted.HasValue)
                        {
                            item.raceEventUserKv.Value.GapLapsPredictedInterval = intervalRaceLeaderboardEventUserKv.Value.Value.LapsPredicted.Value - item.raceEventUserKv.Value.LapsPredicted.Value;

                            if (item.raceEventUserKv.Value.PreviousIntervalRaceEventUserId == intervalRaceLeaderboardEventUserKv.Value.Key)
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

                            item.raceEventUserKv.Value.PreviousIntervalRaceEventUserId = intervalRaceLeaderboardEventUserKv.Value.Key;
                        }
                    }

                    if (item.index == 0)
                    {
                        leaderRaceLeaderboardEventUserKv = item.raceEventUserKv;
                    }
                    intervalRaceLeaderboardEventUserKv = item.raceEventUserKv;
                }
            }
        }


        private HeatWithStintState HeatWithStintState()
        {
            var heatWithStintState = new HeatWithStintState
            {
                HeatWithStintStateType = _heatWithStint!.HeatWithStintStateType,
            };

            var currentStint = _heatWithStint?.Stints.SingleOrDefault(x => x.Id == _currentStintId.ToString());
            if (currentStint is not null)
            {
                heatWithStintState.CurrentStint = currentStint;
                heatWithStintState.HeatWithStintEventUserStates.AddRange(currentStint.StintIndicators.Select(x => new Razmanager.Protobuf.Public.V1.HeatWithStintEventUserState
                {
                    EventUserId = x.EventUserId,
                    IndicatorIdCurrent = x.IndicatorId
                }));
            }

            //var raceEventUserHeatEventUserUpdatesFinished = _sessionRaceEventUsers[sessionTypeId]
            //    .SelectMany(x => x.Value.HeatEventUserUpdatesFinished, (sessionRaceEventUser, heatEventUserUpdatesFinished) => new { sessionRaceEventUser.Key, x.Value.raceEventUserHeatEventUserUpdateFinished.key })
            //    .Distinct()
            //    .GroupBy(x => x.EventUserId);
            foreach (var heatWithStintLeaderboardEventUsersFinished in _heatWithStintLeaderboardEventUsers.Where(x => x.Value.EventUserStints.Any(x => x.Value.Finished)))
            {
                var heatWithStintEventUserState = heatWithStintState.HeatWithStintEventUserStates.SingleOrDefault(x => x.EventUserId == heatWithStintLeaderboardEventUsersFinished.Key.ToString());
                if (heatWithStintEventUserState is null)
                {
                    heatWithStintEventUserState = new HeatWithStintEventUserState { EventUserId = heatWithStintLeaderboardEventUsersFinished.Key.ToString() };
                    heatWithStintState.HeatWithStintEventUserStates.Add(heatWithStintEventUserState);
                }

                foreach (var EventUserUpdatesFinishedHeats in heatWithStintLeaderboardEventUsersFinished.Value.EventUserStints.Where(x => x.Value.Finished))
                {
                    if (_eventUserStintIndicators.TryGetValue((heatWithStintLeaderboardEventUsersFinished.Key, EventUserUpdatesFinishedHeats.Key), out var indicatorId))
                    {
                        heatWithStintEventUserState.IndicatorIdsFinished.Add(indicatorId);
                    }
                }
            }

            return heatWithStintState;
        }


        private HeatWithStintLeaderboard HeatWithStintLeaderboard()
        {
            var heatWithStintLeaderboard = new HeatWithStintLeaderboard();

            foreach (var heatWithStintLeaderboardEventUserKv in _heatWithStintLeaderboardEventUsers)
            {
                var heatWithStintLeaderboardEventUser = new Razmanager.Protobuf.Public.V1.HeatWithStintLeaderboardEventUser
                {
                    EventUserId = heatWithStintLeaderboardEventUserKv.Key.ToString(),
                    Position = heatWithStintLeaderboardEventUserKv.Value.Position,
                    GapLapsPredictedIntervalFraction = heatWithStintLeaderboardEventUserKv.Value.GapLapsPredictedIntervalFraction
                };
                if (heatWithStintLeaderboardEventUserKv.Value.LapsCompleted.HasValue)
                {
                    heatWithStintLeaderboardEventUser.LapsCompleted = heatWithStintLeaderboardEventUserKv.Value.LapsCompleted.Value.ToString("F0", CultureInfo.InvariantCulture);
                }
                if (heatWithStintLeaderboardEventUserKv.Value.LapsPredicted.HasValue)
                {
                    heatWithStintLeaderboardEventUser.LapsPredicted = heatWithStintLeaderboardEventUserKv.Value.LapsPredicted.Value.ToString(_trackLaptimeDecimalsFormat, CultureInfo.InvariantCulture);
                }
                //Points = raceEventUserKv.Value.Points,
                //PointsEstimate = raceEventUserKv.Value.PointsEstimate,
                if (heatWithStintLeaderboardEventUserKv.Value.GapLapsPredictedLeader.HasValue)
                {
                    heatWithStintLeaderboardEventUser.GapLapsPredictedLeader = heatWithStintLeaderboardEventUserKv.Value.GapLapsPredictedLeader.Value.ToString(_trackLaptimeDecimalsFormat, CultureInfo.InvariantCulture);
                }
                if (heatWithStintLeaderboardEventUserKv.Value.GapLapsPredictedInterval.HasValue)
                {
                    heatWithStintLeaderboardEventUser.GapLapsPredictedInterval = heatWithStintLeaderboardEventUserKv.Value.GapLapsPredictedInterval.Value.ToString(_trackLaptimeDecimalsFormat, CultureInfo.InvariantCulture);
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
                    if (heatWithStintLeaderboardEventUserKv.Value.EventUserStints.TryGetValue(_currentStintId.Value, out var raceLeaderboardEventUserHeat))
                    {
                        if (raceLeaderboardEventUserHeat.Finished)
                        {
                            heatWithStintLeaderboardEventUser.Flags.Add(IndicatorFlag.Finished);
                        }
                        //if (_timeTypeFastestTimes[HeatIndicatorTimeTypeId.Lap].IndicatorId == heatStateInternalIndicatorKv.Key)
                        //{
                        //    raceLeaderboardEventUser.Flags.Add(HeatIndicatorFlag.FastestLap);
                        //}
                        //if (raceEventUserKv.Value.LapWarning)
                        //{
                        //    heatLeaderboardIndicator.Flags.Add(HeatIndicatorFlag.Warning);
                        //}
                        if (raceLeaderboardEventUserHeat.Pitlane)
                        {
                            heatWithStintLeaderboardEventUser.Flags.Add(IndicatorFlag.Pitlane);
                        }
                        if (raceLeaderboardEventUserHeat.Deslot)
                        {
                            heatWithStintLeaderboardEventUser.Flags.Add(IndicatorFlag.Deslot);
                        }
                    }
                }

                heatWithStintLeaderboard.EventUsers.Add(heatWithStintLeaderboardEventUser);
            }

            return heatWithStintLeaderboard;
        }


        public class HeatWithStintLeaderboardEventUser
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
            public Dictionary<Guid, HeatWithStintLeaderboardEventUserStint> EventUserStints { get; set; } = [];

            //public ushort? Points { get; set; }
            //public ushort? PointsEstimate { get; set; }
        }


        public class HeatWithStintLeaderboardEventUserStint
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
