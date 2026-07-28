using Orleans.Streams;
using Razmanager.Protobuf.Public.V1;
using System.Globalization;
using System.Resources;


namespace RazManager.Silo.Grains.Entities.Race
{
    public class RaceGrain : Grain, IRaceGrain
    {
        private readonly Razmanager.Protobuf.Internal.Repository.SystemServices.Race.RaceService.RaceServiceClient _serviceClient;
        private Razmanager.Protobuf.Public.V1.Race? _race;
        private IAsyncStream<Razmanager.Protobuf.Public.V1.Race>? _raceStream;
        private IAsyncStream<Razmanager.Protobuf.Public.V1.RaceState>? _raceStateStream;
        private IAsyncStream<Razmanager.Protobuf.Public.V1.RaceLeaderboard>? _raceLeaderboardStream;
        private Guid? _heatId = null;
        private Razmanager.Protobuf.Public.V1.HeatState? _heatState = null;
        private Dictionary<(Guid EventUserId, Guid HeatId), uint> _eventUserHeatIndicators = [];
        private Dictionary<SessionTypeId, Dictionary<Guid, RaceLeaderboardEventUser>> _sessionRaceLeaderboardEventUsers = [];
        private string _trackLaptimeDecimalsFormat = "F2";


        public RaceGrain(Razmanager.Protobuf.Internal.Repository.SystemServices.Race.RaceService.RaceServiceClient serviceClient)
        {
            _serviceClient = serviceClient;
        }


        public override async Task OnActivateAsync(CancellationToken cancellationToken)
        {
            var streamProvider = this.GetStreamProvider(Constants.StreamProvider);
            _raceStream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.Race> (Constants.StreamName.Race.ToString(), this.GetPrimaryKey());
            _raceStateStream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.RaceState>(Constants.StreamName.RaceState.ToString(), this.GetPrimaryKey());
            _raceLeaderboardStream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.RaceLeaderboard>(Constants.StreamName.RaceSessionLeaderboard.ToString(), this.GetPrimaryKey());
            await RefreshAsync();
        }


        public async Task RefreshAsync()
        {
            _race = await _serviceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });

            foreach (var item in _race.RaceSessionGroups
                .SelectMany(x => x.Heats
                    .SelectMany(x => x.HeatIndicators, (Heat, HeatIndicator) => new { Heat, HeatIndicator }), (RaceSessionGroup, HeatHeatIndicator) =>
                new { RaceSessionGroup, HeatHeatIndicator.Heat, HeatHeatIndicator.HeatIndicator }))
            {
                _eventUserHeatIndicators.Add((new Guid(item.HeatIndicator.EventUserId), new Guid(item.Heat.Id)), item.HeatIndicator.IndicatorId); // For quick lookup of the current indicator for each event user in a heat
            }

            Initialize();

            var tasks = _race.RaceSessionGroups
                .SelectMany(x => x.Heats, (RaceSessionGroup, Heat) => new { RaceSessionGroup, Heat })
                .Select(raceSessionGroupHeat => GrainFactory.GetGrain<Heat.IHeatWithoutStintGrain>(new Guid(raceSessionGroupHeat.Heat.Id)).ReadAsync());
            var results = await Task.WhenAll(tasks);

            foreach (var raceSessionGroupHeat in _race.RaceSessionGroups
                .SelectMany(x => x.Heats, (RaceSessionGroup, Heat) => new { RaceSessionGroup, Heat }))
            {
                var result = results.SingleOrDefault(x => x.Id == raceSessionGroupHeat.Heat.Id);
                if (result is not null)
                {
                    raceSessionGroupHeat.Heat.HeatStateType = result.HeatStateType;

                    if (raceSessionGroupHeat.Heat.HeatStateType.Id != HeatStateTypeId.Pending && raceSessionGroupHeat.Heat.HeatStateType.Id != HeatStateTypeId.Closed)
                    {
                        _heatId = new Guid(raceSessionGroupHeat.Heat.Id);
                        _heatState = await GrainFactory.GetGrain<Heat.IHeatWithoutStintGrain>(new Guid(raceSessionGroupHeat.Heat.Id)).ReadHeatStateAsync();
                        _ = _raceStateStream!.OnNextAsync(RaceState(raceSessionGroupHeat.RaceSessionGroup.SessionType.Id));
                    }
                }
            }

            _ = _raceStream!.OnNextAsync(_race);

            _ = GrainFactory.GetGrain<Event.IEventGrain>(new Guid(_race.EventId)).RefreshAsync(true);
        }


        private void Initialize()
        {
            _heatId = null;
            _heatState = null;

            _sessionRaceLeaderboardEventUsers.Clear();
            foreach (var sessionTypeId in Enum.GetValues<SessionTypeId>())
            {
                var raceEventUsers = new Dictionary<Guid, RaceLeaderboardEventUser>();
                foreach (var raceEventUserKv in _race.RaceEventUsers.Select((id, index) => new { id, index }))
                {
                    raceEventUsers.Add(new Guid(raceEventUserKv.id), new RaceLeaderboardEventUser { Position = Convert.ToUInt32(raceEventUserKv.index + 1) });
                }

                _sessionRaceLeaderboardEventUsers.Add(sessionTypeId, raceEventUsers);
            }
        }


        public Task<Razmanager.Protobuf.Public.V1.Race> ReadAsync()
        {
            return Task.FromResult(_race!);
        }


        public Task<Guid?> CurrentHeatAsync()
        {
            return Task.FromResult(_heatId);
        }


        public Task<RaceState> ReadRaceStateAsync(SessionTypeId sessionTypeId)
        {
            return Task.FromResult(RaceState(sessionTypeId));
        }


        public Task<RaceLeaderboard> ReadRaceLeaderboardAsync(SessionTypeId sessionTypeId)
        {
            return Task.FromResult(RaceLeaderboard(sessionTypeId));
        }


        public async Task CommandAsync(Razmanager.Protobuf.Public.V1.RaceCommandTypeId raceCommandTypeId)
        {
            switch (raceCommandTypeId)
            {
                case RaceCommandTypeId.Start:
                    if (!(_race!.RaceStateType.Id == RaceStateTypeId.Pending || _race!.RaceStateType.Id == RaceStateTypeId.Paused))
                    {
                        return;
                    }

                    await RaceStateSetAsync(RaceStateTypeId.Started);
                    break;

                case RaceCommandTypeId.Pause:
                    if (!(_race!.RaceStateType.Id == RaceStateTypeId.Started))
                    {
                        return;
                    }

                    await RaceStateSetAsync(RaceStateTypeId.Paused);
                    break;

                case RaceCommandTypeId.End:
                    if (!(_race!.RaceStateType.Id == RaceStateTypeId.Started || _race.RaceStateType.Id == RaceStateTypeId.Paused))
                    {
                        return;
                    }

                    await RaceStateSetAsync(RaceStateTypeId.Ended);
                    break;

                case RaceCommandTypeId.Reset:
                    if (!(_race.RaceStateType.Id == RaceStateTypeId.Started || _race.RaceStateType.Id == RaceStateTypeId.Paused || _race.RaceStateType.Id == RaceStateTypeId.Ended))
                    {
                        return;
                    }

                    Initialize();

                    foreach (var raceSessionGroupHeat in _race!.RaceSessionGroups
                                            .SelectMany(x => x.Heats, (RaceSessionGroup, Heat) => new { RaceSessionGroup, Heat }))
                    {
                        _ = GrainFactory.GetGrain<Heat.IHeatWithoutStintGrain>(new Guid(raceSessionGroupHeat.Heat.Id)).CommandAsync(HeatCommandTypeId.Reset);
                    }

                    await RaceStateSetAsync(RaceStateTypeId.Pending);
                    break;

                default:
                    break;
            }
       }


        private async Task RaceStateSetAsync(RaceStateTypeId raceStateTypeId)
        {
            _race!.RaceStateType = new Razmanager.Protobuf.Public.V1.RaceStateType
            {
                Id = raceStateTypeId,
                Name = new ResourceManager(typeof(RazManager.Resources.RaceStateType)).GetString(raceStateTypeId.ToString())
            };

            await _serviceClient.UpdateStateAsync(new Razmanager.Protobuf.Internal.Repository.SystemServices.Race.RaceStateUpdateRequest
            {
                Id = this.GetPrimaryKey().ToString(),
                RaceStateTypeId = raceStateTypeId
            });

            if (raceStateTypeId == RaceStateTypeId.Started)
            {
                var heatId = _race.RaceSessionGroups
                    .SelectMany(x => x.Heats, (RaceSessionGroup, Heat) => new { RaceSessionGroup, Heat })
                    .OrderBy(x => x.RaceSessionGroup.SessionType.Id)
                    .ThenBy(x => x.Heat.Number)
                    .First().Heat.Id;
                _ = GrainFactory.GetGrain<Heat.IHeatWithoutStintGrain>(new Guid(heatId)).CommandAsync(HeatCommandTypeId.Open);
                return;
            }

            _ = _raceStream!.OnNextAsync(_race);
        }


        public Task HeatStateTypeUpdatedAsync(Guid id, Razmanager.Protobuf.Public.V1.HeatStateType heatStateType)
        {
            var raceSessionGroupHeat = _race.RaceSessionGroups
                    .SelectMany(x => x.Heats, (RaceSessionGroup, Heat) => new { RaceSessionGroup, Heat })
                    .SingleOrDefault(x => x.Heat.Id == id.ToString());
            if (raceSessionGroupHeat is not null)
            {
                raceSessionGroupHeat.Heat.HeatStateType = heatStateType;

                switch (heatStateType.Id)
                {
                    case HeatStateTypeId.Pending:
                    case HeatStateTypeId.Opened:
                        var raceLeaderboardEventUsers = _sessionRaceLeaderboardEventUsers[raceSessionGroupHeat.RaceSessionGroup.SessionType.Id];
                        foreach (var raceLeaderboardEventUser in raceLeaderboardEventUsers)
                        {
                            raceLeaderboardEventUser.Value.RaceLeaderboardEventUserHeats.Remove(id);
                            CalculateLaps(raceLeaderboardEventUser.Value, null);
                        }

                        CalculatePositions(raceLeaderboardEventUsers, null);

                        _ = _raceLeaderboardStream!.OnNextAsync(RaceLeaderboard(raceSessionGroupHeat.RaceSessionGroup.SessionType.Id));

                        break;

                    case HeatStateTypeId.Countdown:
                    case HeatStateTypeId.Running:
                    case HeatStateTypeId.Yellow:
                    case HeatStateTypeId.CountdownYellow:
                    case HeatStateTypeId.Red:
                    case HeatStateTypeId.CountdownRed:
                    case HeatStateTypeId.Ended:
                    case HeatStateTypeId.Off:
                        break;

                    case HeatStateTypeId.Closed:
                        foreach (var rsgh in _race.RaceSessionGroups
                            .SelectMany(x => x.Heats, (RaceSessionGroup, Heat) => new { RaceSessionGroup, Heat })
                            .OrderBy(x => x.RaceSessionGroup.SessionType.Id)
                            .ThenBy(x => x.Heat.Number))
                        {
                            if (rsgh.Heat.HeatStateType.Id == HeatStateTypeId.Pending)
                            {
                                _ = GrainFactory.GetGrain<Heat.IHeatWithoutStintGrain>(new Guid(rsgh.Heat.Id)).CommandAsync(HeatCommandTypeId.Open);
                                break;
                            }
                        }
                        break;

                    default:
                        throw new ArgumentException($"Unhandled HeatStateTypeId: {heatStateType.Id}", nameof(heatStateType.Id));
                }
            }

            _ = _raceStream!.OnNextAsync(_race);

            return Task.CompletedTask;
        }


        public Task HeatStateUpdatedAsync(Guid id, Razmanager.Protobuf.Public.V1.HeatState heatState)
        {
            var raceSessionGroupHeat = _race?.RaceSessionGroups
                    .SelectMany(x => x.Heats, (RaceSessionGroup, Heat) => new { RaceSessionGroup, Heat })
                    .SingleOrDefault(x => x.Heat.Id == id.ToString());
            if (raceSessionGroupHeat?.Heat is not null)
            {
                _heatState = heatState;
                _ = _raceStateStream!.OnNextAsync(RaceState(raceSessionGroupHeat.RaceSessionGroup.SessionType.Id));
            }

            return Task.CompletedTask;
        }


        public async Task RaceLeaderboardHeatEventUserUpdateAsync(RaceLeaderboardHeatEventUserUpdate update)
        {
            var raceSessionGroupHeat = _race?.RaceSessionGroups
                    .SelectMany(x => x.Heats, (RaceSessionGroup, Heat) => new { RaceSessionGroup, Heat })
                    .SingleOrDefault(x => x.Heat.Id == update.HeatId);
            if (raceSessionGroupHeat?.Heat is null)
            {
                return;
            }

            var raceLeaderboardEventUsers = _sessionRaceLeaderboardEventUsers[raceSessionGroupHeat.RaceSessionGroup.SessionType.Id];
            if (!raceLeaderboardEventUsers.TryGetValue(new Guid(update.EventUserId), out var raceLeaderboardEventUser))
            {
                return;
            }

            if (!raceLeaderboardEventUser.RaceLeaderboardEventUserHeats.TryGetValue(new Guid(update.HeatId), out var raceLeaderboardEventUserHeat))
            {
                raceLeaderboardEventUserHeat = new RaceLeaderboardEventUserHeat();
                raceLeaderboardEventUser.RaceLeaderboardEventUserHeats[new Guid(update.HeatId)] = raceLeaderboardEventUserHeat;
            }

            switch (update.ValueCase)
            {
                case RaceLeaderboardHeatEventUserUpdate.ValueOneofCase.Laps:
                    raceLeaderboardEventUserHeat.HeatEventUserUpdatesLap = update;
                    raceLeaderboardEventUser.PreviousGapLapsPredictedInterval = raceLeaderboardEventUser.GapLapsPredictedInterval;
                    CalculateLaps(raceLeaderboardEventUser, update);
                    CalculatePositions(raceLeaderboardEventUsers, update);
                    _ = _raceLeaderboardStream!.OnNextAsync(RaceLeaderboard(raceSessionGroupHeat.RaceSessionGroup.SessionType.Id));

                    break;

                case RaceLeaderboardHeatEventUserUpdate.ValueOneofCase.Finished:
                    raceLeaderboardEventUserHeat.Finished = true;
                    _ = _raceLeaderboardStream!.OnNextAsync(RaceLeaderboard(raceSessionGroupHeat.RaceSessionGroup.SessionType.Id));
                    break;

                //case RaceLeaderboardHeatEventUserUpdate.ValueOneofCase.Flags:
                //    break;

                default:
                    break;
            }

        }


        private void CalculateLaps(RaceLeaderboardEventUser raceLeaderboardEventUser, RaceLeaderboardHeatEventUserUpdate? update)
        {
            var raceSessionGroupHeats = _race?.RaceSessionGroups
                    .SelectMany(x => x.Heats, (RaceSessionGroup, Heat) => new { RaceSessionGroup, Heat });
            var raceSessionGroupHeat = raceSessionGroupHeats?.SingleOrDefault(x => x.Heat.Id == update?.HeatId);
            if (raceSessionGroupHeat is null)
            {
                return;
            }

            raceLeaderboardEventUser.LapsCompleted = raceLeaderboardEventUser.RaceLeaderboardEventUserHeats.Values.Sum(x => x.HeatEventUserUpdatesLap?.Laps);

            if (_race?.RaceHeatEndTypeId == HeatEndTypeId.Duration)
            {
                raceLeaderboardEventUser.PreviousTimerElapsed = raceLeaderboardEventUser.TimerElapsed;
                var first = true;
                raceLeaderboardEventUser.TimerElapsed = TimeSpan.FromTicks(raceSessionGroupHeats!.Where(x => raceLeaderboardEventUser.RaceLeaderboardEventUserHeats.ContainsKey(new Guid(x.Heat.Id)))
                    .OrderByDescending(x => x.Heat.Number).Sum(x =>
                    {
                        if (first)
                        {
                            first = false;
                            return update?.TimerElapsed.ToTimeSpan().Ticks ?? 0;
                        }
                        else
                        {
                            return _race.RaceHeatEndDurationDuration.ToTimeSpan().Ticks;
                        }
                    }));

                if (raceLeaderboardEventUser.TimerElapsed.Ticks == 0 || raceLeaderboardEventUser.LapsCompleted == 0)
                {
                    raceLeaderboardEventUser.LapsPredicted = null;
                }
                else
                {
                    raceLeaderboardEventUser.LapsPredicted = raceLeaderboardEventUser.LapsCompleted * _race.RaceIndicators.Count() * _race.RaceHeatEndDurationDuration.ToTimeSpan().Ticks / raceLeaderboardEventUser.TimerElapsed.Ticks;
                }
            }
        }


        private void CalculatePositions(Dictionary<Guid, RaceLeaderboardEventUser> raceLeaderboardEventUsers, RaceLeaderboardHeatEventUserUpdate? update)
        {
            if (_race.RaceHeatEndTypeId == HeatEndTypeId.Duration)
            {
                KeyValuePair<Guid, RaceLeaderboardEventUser>? leaderRaceLeaderboardEventUserKv = null;
                KeyValuePair<Guid, RaceLeaderboardEventUser>? intervalRaceLeaderboardEventUserKv = null;

                foreach (var item in raceLeaderboardEventUsers
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


        private RaceState RaceState(SessionTypeId sessionTypeId)
        {
            var raceState = new RaceState
            {
                RaceStateType = _race.RaceStateType,
                HeatState = _heatState
            };
            if (_heatId is not null)
            {
                raceState.HeatId = _heatId.ToString();

                var raceSessionGroupHeat = _race?.RaceSessionGroups
                        .SelectMany(x => x.Heats, (RaceSessionGroup, Heat) => new { RaceSessionGroup, Heat })
                        .SingleOrDefault(x => x.Heat.Id == _heatId.ToString());
                if (raceSessionGroupHeat?.Heat is not null)
                {
                    raceState.HeatNumber = raceSessionGroupHeat.Heat.Number;
                    raceState.RaceEventUserStates.AddRange(raceSessionGroupHeat.Heat.HeatIndicators.Select(x => new Razmanager.Protobuf.Public.V1.RaceEventUserState
                    {
                        EventUserId = x.EventUserId,
                        IndicatorIdCurrent = x.IndicatorId
                    }));
                }
            }

            //var raceEventUserHeatEventUserUpdatesFinished = _sessionRaceEventUsers[sessionTypeId]
            //    .SelectMany(x => x.Value.HeatEventUserUpdatesFinished, (sessionRaceEventUser, heatEventUserUpdatesFinished) => new { sessionRaceEventUser.Key, x.Value.raceEventUserHeatEventUserUpdateFinished.key })
            //    .Distinct()
            //    .GroupBy(x => x.EventUserId);
            foreach (var sessionRaceLeaderboardEventUserKv in _sessionRaceLeaderboardEventUsers[sessionTypeId].Where(x => x.Value.RaceLeaderboardEventUserHeats.Any(x => x.Value.Finished)))
            {
                var raceEventUserState = raceState.RaceEventUserStates.SingleOrDefault(x => x.EventUserId == sessionRaceLeaderboardEventUserKv.Key.ToString());
                if (raceEventUserState is null)
                {
                    raceEventUserState = new RaceEventUserState { EventUserId = sessionRaceLeaderboardEventUserKv.Key.ToString() };
                    raceState.RaceEventUserStates.Add(raceEventUserState);
                }

                foreach (var EventUserUpdatesFinishedHeats in sessionRaceLeaderboardEventUserKv.Value.RaceLeaderboardEventUserHeats.Where(x => x.Value.Finished))
                {
                    if (_eventUserHeatIndicators.TryGetValue((sessionRaceLeaderboardEventUserKv.Key, EventUserUpdatesFinishedHeats.Key), out var indicatorId))
                    {
                        raceEventUserState.IndicatorIdsFinished.Add(indicatorId);
                    }
                }
            }

            return raceState;
        }


        private RaceLeaderboard RaceLeaderboard(SessionTypeId sessionTypeId)
        {
            var raceLeaderboard = new RaceLeaderboard { SessionTypeId = sessionTypeId };

            foreach (var raceLeaderboardEventUserKv in _sessionRaceLeaderboardEventUsers[sessionTypeId])
            {
                var raceLeaderboardEventUser = new Razmanager.Protobuf.Public.V1.RaceLeaderboardEventUser
                {
                    EventUserId = raceLeaderboardEventUserKv.Key.ToString(),
                    Position = raceLeaderboardEventUserKv.Value.Position,
                    GapLapsPredictedIntervalFraction = raceLeaderboardEventUserKv.Value.GapLapsPredictedIntervalFraction
                };
                if (raceLeaderboardEventUserKv.Value.LapsCompleted.HasValue)
                {
                    raceLeaderboardEventUser.LapsCompleted = raceLeaderboardEventUserKv.Value.LapsCompleted.Value.ToString("F0", CultureInfo.InvariantCulture);
                }
                if (raceLeaderboardEventUserKv.Value.LapsPredicted.HasValue)
                {
                    raceLeaderboardEventUser.LapsPredicted = raceLeaderboardEventUserKv.Value.LapsPredicted.Value.ToString(_trackLaptimeDecimalsFormat, CultureInfo.InvariantCulture);
                }
                //Points = raceEventUserKv.Value.Points,
                //PointsEstimate = raceEventUserKv.Value.PointsEstimate,
                if (raceLeaderboardEventUserKv.Value.GapLapsPredictedLeader.HasValue)
                {
                    raceLeaderboardEventUser.GapLapsPredictedLeader = raceLeaderboardEventUserKv.Value.GapLapsPredictedLeader.Value.ToString(_trackLaptimeDecimalsFormat, CultureInfo.InvariantCulture);
                }
                if (raceLeaderboardEventUserKv.Value.GapLapsPredictedInterval.HasValue)
                {
                    raceLeaderboardEventUser.GapLapsPredictedInterval = raceLeaderboardEventUserKv.Value.GapLapsPredictedInterval.Value.ToString(_trackLaptimeDecimalsFormat, CultureInfo.InvariantCulture);
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

                if (_heatId.HasValue)
                {
                    if (raceLeaderboardEventUserKv.Value.RaceLeaderboardEventUserHeats.TryGetValue(_heatId.Value, out var raceLeaderboardEventUserHeat))
                    {
                        if (raceLeaderboardEventUserHeat.Finished)
                        {
                            raceLeaderboardEventUser.Flags.Add(IndicatorFlag.Finished);
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
                            raceLeaderboardEventUser.Flags.Add(IndicatorFlag.Pitlane);
                        }
                        if (raceLeaderboardEventUserHeat.Deslot)
                        {
                            raceLeaderboardEventUser.Flags.Add(IndicatorFlag.Deslot);
                        }
                    }
                }

                raceLeaderboard.EventUsers.Add(raceLeaderboardEventUser);
            }

            return raceLeaderboard;
        }


        public class RaceLeaderboardEventUser
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
            public Dictionary<Guid, RaceLeaderboardEventUserHeat> RaceLeaderboardEventUserHeats { get; set; } = [];

            //public ushort? Points { get; set; }
            //public ushort? PointsEstimate { get; set; }
        }


        public class RaceLeaderboardEventUserHeat
        {
            public bool Finished { get; set; }
            //public bool LapWarning { get; set; }
            public bool Pitlane { get; set; }
            //public ushort LapPitlanes { get; set; }
            public bool Deslot { get; set; }
            //public ushort LapCarOffTracks { get; set; }
            public RaceLeaderboardHeatEventUserUpdate? HeatEventUserUpdatesLap { get; set; }
        }
    }
}
