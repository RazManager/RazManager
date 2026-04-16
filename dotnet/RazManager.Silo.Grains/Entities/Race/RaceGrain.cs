using Google.Protobuf;
using Orleans.Streams;
using Razmanager.Protobuf.Internal.Repository.SystemServices.Heat;
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
        private IEnumerable<IGrouping<string, EventUserHeatIndicator>> _eventUserHeatIndicatorGrouping = [];
        private Dictionary<SessionTypeId, Dictionary<Guid, RaceLeaderboardEventUser>> _sessionRaceEventUsers = [];
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
            _raceLeaderboardStream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.RaceLeaderboard>(Constants.StreamName.RaceLeaderboard.ToString(), this.GetPrimaryKey());
            await RefreshAsync();
        }


        public async Task RefreshAsync()
        {
            if (this.GetPrimaryKey().ToString() == "019d8ae8-85c3-7626-9a89-9434afff67d7")
            {
                Console.WriteLine("RefreshAsync");
            }


            _race = await _serviceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });
            _eventUserHeatIndicatorGrouping = _race.Heats
                .SelectMany(x => x.HeatIndicators, (heat, heatIndicator) => new EventUserHeatIndicator
                    {
                        EventUserId = heatIndicator.EventUserId,
                        HeatId = heat.Id,
                        IndicatorId = heatIndicator.IndicatorId })
                .GroupBy(x => x.EventUserId);

            _sessionRaceEventUsers.Clear();
            foreach (var sessionTypeId in Enum.GetValues<SessionTypeId>())
            {
                var raceEventUsers = new Dictionary<Guid, RaceLeaderboardEventUser>();
                foreach (var raceEventUserKv in _race.RaceEventUsers.Select((id, index) => new { id, index }))
                {
                    raceEventUsers.Add(new Guid(raceEventUserKv.id), new RaceLeaderboardEventUser { Position = Convert.ToUInt32(raceEventUserKv.index + 1)});
                }

                _sessionRaceEventUsers.Add(sessionTypeId, raceEventUsers);
            }

            var tasks = _race.Heats.Select(heat => GrainFactory.GetGrain<Heat.IHeatGrain>(new Guid(heat.Id)).ReadAsync());
            var results = await Task.WhenAll(tasks);

            foreach (var heat in _race.Heats)
            {
                var result = results.SingleOrDefault(x => x.Id == heat.Id);
                if (result is not null)
                {
                    heat.HeatStateType = result.HeatStateType;

                    if (heat.HeatStateType.Id != HeatStateTypeId.Pending && heat.HeatStateType.Id != HeatStateTypeId.Closed)
                    {
                        _heatId = new Guid(heat.Id);
                        _heatState = await GrainFactory.GetGrain<Heat.IHeatGrain>(new Guid(heat.Id)).ReadHeatStateAsync();
                        _ = _raceStateStream!.OnNextAsync(RaceState(heat.SessionType.Id));
                    }
                }
            }

            _ = _raceStream!.OnNextAsync(_race);

            _ = GrainFactory.GetGrain<Event.IEventGrain>(new Guid(_race.EventId)).RefreshAsync(true);
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

                    foreach (var heat in _race!.Heats)
                    {
                        _ = GrainFactory.GetGrain<Heat.IHeatGrain>(new Guid(heat.Id)).CommandAsync(HeatCommandTypeId.Reset);
                    }

                    await RaceStateSetAsync(RaceStateTypeId.Pending);
                    break;

                default:
                    break;
            }
        }


        private async Task RaceStateSetAsync(RaceStateTypeId raceStateTypeId)
        {
            _race!.RaceStateType.Id = raceStateTypeId;

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
                var heatId = _race!.Heats.OrderBy(x => x.Number).First().Id;
                _ = GrainFactory.GetGrain<Heat.IHeatGrain>(new Guid(heatId)).CommandAsync(HeatCommandTypeId.Open);
                return;
            }

            _ = _raceStream!.OnNextAsync(_race);
        }


        public Task HeatStateTypeUpdatedAsync(Guid id, Razmanager.Protobuf.Public.V1.HeatStateType heatStateType)
        {
            var h = _race.Heats.SingleOrDefault(x => x.Id == id.ToString());
            if (h is not null)
            {
                h.HeatStateType = heatStateType;

                switch (heatStateType.Id)
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
                        break;

                    case HeatStateTypeId.Closed:
                        foreach (var heat in _race!.Heats.OrderBy(x => x.Number))
                        {
                            if (heat.HeatStateType.Id == HeatStateTypeId.Pending)
                            {
                                _ = GrainFactory.GetGrain<Heat.IHeatGrain>(new Guid(heat.Id)).CommandAsync(HeatCommandTypeId.Open);
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
            var heat = _race?.Heats.SingleOrDefault(x => x.Id == id.ToString());
            _heatState = heatState;
            _ = _raceStateStream!.OnNextAsync(RaceState(heat.SessionType.Id));
            return Task.CompletedTask;
        }


        public async Task RaceLeaderboardHeatEventUserUpdateAsync(RaceLeaderboardHeatEventUserUpdate update)
        {
            if (update.HeatId == "019d9145-f183-7545-8669-894129cf72bb")
            {
                Console.WriteLine($"HeatStateTypeUpdatedAsync {update.ValueCase} {update.EventUserId} {update.TimerElapsed.ToTimeSpan().TotalSeconds}");
            }

            var heat = _race?.Heats.SingleOrDefault(x => x.Id == update.HeatId);

            var raceEventUsers = _sessionRaceEventUsers[heat.SessionType.Id];
            if (!raceEventUsers.TryGetValue(new Guid(update.EventUserId), out var raceEventUser))
            {
                return;
            }

            if (!raceEventUser.HeatEventUserUpdates.ContainsKey(update.HeatId))
            {
                raceEventUser.HeatEventUserUpdates.Add(update.HeatId, new Dictionary<RaceLeaderboardHeatEventUserUpdate.ValueOneofCase, RaceLeaderboardHeatEventUserUpdate> { { update.ValueCase, update } });
            }
            else
            {
                var heatHeatEventUserUpdates = raceEventUser.HeatEventUserUpdates[update.HeatId];
                if (!heatHeatEventUserUpdates.ContainsKey(update.ValueCase))
                {
                    heatHeatEventUserUpdates.Add(update.ValueCase, update);
                }
                else
                {
                    heatHeatEventUserUpdates[update.ValueCase] = update;
                }
            }

            switch (update.ValueCase)
            {
                case RaceLeaderboardHeatEventUserUpdate.ValueOneofCase.Laps:

                    raceEventUser.LapsCompleted = raceEventUser.HeatEventUserUpdates[update.HeatId].Values.Where(x => x.ValueCase == RaceLeaderboardHeatEventUserUpdate.ValueOneofCase.Laps).Sum(x => x.Laps);

                    if (_race.RaceHeatEndTypeId == HeatEndTypeId.Duration)
                    {
                        raceEventUser.PreviousTimerElapsed = raceEventUser.TimerElapsed;
                        raceEventUser.TimerElapsed = TimeSpan.FromTicks(raceEventUser.HeatEventUserUpdates.Sum(x =>
                        {
                            var finished = raceEventUser.HeatEventUserUpdates[x.Key].Values.Any(x => x.ValueCase == RaceLeaderboardHeatEventUserUpdate.ValueOneofCase.Finished);
                            if (finished)
                            {
                                return _race.RaceHeatEndDurationDuration.ToTimeSpan().Ticks;
                            }
                            else
                            {
                                return update.TimerElapsed.ToTimeSpan().Ticks;
                            }
                        }));

                        if (raceEventUser.TimerElapsed.Ticks == 0)
                        {
                            raceEventUser.LapsPredicted = null;
                        }
                        else
                        {
                            raceEventUser.LapsPredicted = raceEventUser.LapsCompleted * _race.RaceIndicators.Count() * _race.RaceHeatEndDurationDuration.ToTimeSpan().Ticks / raceEventUser.TimerElapsed.Ticks;
                        }

                        KeyValuePair<Guid, RaceLeaderboardEventUser>? leaderRaceEventUserKv = null;
                        KeyValuePair<Guid, RaceLeaderboardEventUser>? intervalRaceEventUserKv = null;

                        foreach (var item in raceEventUsers
                            .OrderByDescending(x => x.Value.LapsPredicted)
                            .ThenBy(x => x.Value.TimerElapsed)
                            .Select((raceEventUserKv, index) => new { raceEventUserKv, index }))
                        {
                            //var previousPosition = item.raceEventUserKv.Value.Position;
                            item.raceEventUserKv.Value.Position = Convert.ToUInt32(item.index + 1);

                            item.raceEventUserKv.Value.GapLapsPredictedLeader = null;
                            item.raceEventUserKv.Value.GapLapsPredictedInterval = null;
                            //item.raceEventUserKv.Value.GapLapsEstimatedIntervalFraction = null;

                            if (item.raceEventUserKv.Value.LapsPredicted.HasValue)
                            {
                                if (leaderRaceEventUserKv is not null &&
                                    leaderRaceEventUserKv.Value.Value.LapsPredicted.HasValue)
                                {
                                    item.raceEventUserKv.Value.GapLapsPredictedLeader = leaderRaceEventUserKv.Value.Value.LapsPredicted.Value - item.raceEventUserKv.Value.LapsPredicted.Value;
                                }
                                if (intervalRaceEventUserKv is not null &&
                                    intervalRaceEventUserKv.Value.Value.LapsPredicted.HasValue)
                                {
                                    item.raceEventUserKv.Value.GapLapsPredictedInterval = intervalRaceEventUserKv.Value.Value.LapsPredicted.Value - item.raceEventUserKv.Value.LapsPredicted.Value;

                                    if (item.raceEventUserKv.Value.PreviousIntervalRaceEventUserId == intervalRaceEventUserKv.Value.Key)
                                    {
                                        if (item.raceEventUserKv.Key == new Guid(update.EventUserId))
                                        {
                                            item.raceEventUserKv.Value.GapLapsPredictedIntervalFraction = (item.raceEventUserKv.Value.GapLapsPredictedInterval - item.raceEventUserKv.Value.PreviousGapLapsEstimatedInterval) / item.raceEventUserKv.Value.LapsPredicted;
                                            item.raceEventUserKv.Value.PreviousGapLapsEstimatedInterval = item.raceEventUserKv.Value.GapLapsPredictedInterval;
                                            Console.WriteLine($"PreviousGapLapsEstimatedInterval updated: {item.raceEventUserKv.Value.PreviousGapLapsEstimatedInterval}");
                                        }
                                    }

                                    item.raceEventUserKv.Value.PreviousIntervalRaceEventUserId = intervalRaceEventUserKv.Value.Key;
                                }
                            }

                            if (item.index == 0)
                            {
                                leaderRaceEventUserKv = item.raceEventUserKv;
                            }
                            intervalRaceEventUserKv = item.raceEventUserKv;
                        }
                    }

                    _ = _raceLeaderboardStream!.OnNextAsync(RaceLeaderboard(heat.SessionType.Id));

                    break;

                case RaceLeaderboardHeatEventUserUpdate.ValueOneofCase.Finished:
                    _ = _raceStateStream!.OnNextAsync(RaceState(heat.SessionType.Id));
                    break;

                case RaceLeaderboardHeatEventUserUpdate.ValueOneofCase.Flags:
                    break;

                default:
                    break;
            }

        }


        private (double? GapTime, short? GapLaps) CalculateGap(RaceLeaderboardEventUser raceEventUser, RaceLeaderboardEventUser otherRaceEventUser)
        {
            if (raceEventUser.TimerElapsed > otherRaceEventUser.TimerElapsed)
            {
                return ((raceEventUser.TimerElapsed - otherRaceEventUser.TimerElapsed).TotalSeconds, raceEventUser.LapsCompleted == otherRaceEventUser.LapsCompleted ? null : Convert.ToInt16(otherRaceEventUser.LapsCompleted - raceEventUser.LapsCompleted));
            }
            else
            {
                return ((raceEventUser.TimerElapsed - otherRaceEventUser.PreviousTimerElapsed).TotalSeconds, raceEventUser.LapsCompleted == otherRaceEventUser.LapsCompleted - 1 ? null : Convert.ToInt16(otherRaceEventUser.LapsCompleted - 1 - raceEventUser.LapsCompleted));
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
                var heat = _race.Heats.SingleOrDefault(x => x.Id == _heatId.ToString());
                if (heat is not null)
                {
                    raceState.HeatNumber = heat.Number;
                }
            }

            foreach (var item in _eventUserHeatIndicatorGrouping.Where(x => x.Any(x => x.HeatId == _heatId.ToString())))
            {
                raceState.RaceEventUserStates.Add(new Razmanager.Protobuf.Public.V1.RaceEventUserState
                {
                    EventUserId = item.Key,
                    IndicatorIdCurrent = item.SingleOrDefault(x => x.HeatId == _heatId.ToString())?.IndicatorId
                });
            }

            var raceEventUserHeatEventUserUpdatesFinished = _sessionRaceEventUsers[sessionTypeId]
                .SelectMany(x => x.Value.HeatEventUserUpdates)
                .Where(x => x.Value.ContainsKey(RaceLeaderboardHeatEventUserUpdate.ValueOneofCase.Finished))
                .Select(x => new { x.Value[RaceLeaderboardHeatEventUserUpdate.ValueOneofCase.Finished].EventUserId, x.Value[RaceLeaderboardHeatEventUserUpdate.ValueOneofCase.Finished].HeatId })
                .Distinct()
                .GroupBy(x => x.EventUserId);
            foreach (var raceEventUserHeatEventUserUpdateFinished in raceEventUserHeatEventUserUpdatesFinished)
            {
                var raceEventUserState = raceState.RaceEventUserStates.SingleOrDefault(x => x.EventUserId == raceEventUserHeatEventUserUpdateFinished.Key);
                if (raceEventUserState is null)
                {
                    raceEventUserState = new RaceEventUserState { EventUserId = raceEventUserHeatEventUserUpdateFinished.Key };
                    raceState.RaceEventUserStates.Add(raceEventUserState);
                }

                var indicatorIdsFinished = _eventUserHeatIndicatorGrouping
                    .SingleOrDefault(x => x.Key == raceEventUserState.EventUserId)?
                    .Where(x => raceEventUserHeatEventUserUpdateFinished
                    .Any(f => f.HeatId == x.HeatId))
                    .Select(x => x.IndicatorId);
                raceEventUserState.IndicatorIdsFinished.AddRange(indicatorIdsFinished);
            }

            return raceState;
        }


        private RaceLeaderboard RaceLeaderboard(SessionTypeId sessionTypeId)
        {
            var raceLeaderboard = new RaceLeaderboard { SessionTypeId = sessionTypeId };

            foreach (var raceEventUserKv in _sessionRaceEventUsers[sessionTypeId])
            {
                var raceLeaderboardEventUser = new Razmanager.Protobuf.Public.V1.RaceLeaderboardEventUser
                {
                    EventUserId = raceEventUserKv.Key.ToString(),
                    Position = raceEventUserKv.Value.Position,
                    GapLapsPredictedIntervalFraction = raceEventUserKv.Value.GapLapsPredictedIntervalFraction
                };
                if (raceEventUserKv.Value.LapsCompleted.HasValue)
                {
                    raceLeaderboardEventUser.LapsCompleted = raceEventUserKv.Value.LapsCompleted.Value.ToString(_trackLaptimeDecimalsFormat, CultureInfo.InvariantCulture);
                }
                if (raceEventUserKv.Value.LapsPredicted.HasValue)
                {
                    raceLeaderboardEventUser.LapsPredicted = raceEventUserKv.Value.LapsPredicted.Value.ToString(_trackLaptimeDecimalsFormat, CultureInfo.InvariantCulture);
                }
                //Points = raceEventUserKv.Value.Points,
                //PointsEstimate = raceEventUserKv.Value.PointsEstimate,
                if (raceEventUserKv.Value.GapLapsPredictedLeader.HasValue)
                {
                    raceLeaderboardEventUser.GapLapsPredictedLeader = raceEventUserKv.Value.GapLapsPredictedLeader.Value.ToString(_trackLaptimeDecimalsFormat, CultureInfo.InvariantCulture);
                }
                if (raceEventUserKv.Value.GapLapsPredictedInterval.HasValue)
                {
                    raceLeaderboardEventUser.GapLapsPredictedInterval = raceEventUserKv.Value.GapLapsPredictedInterval.Value.ToString(_trackLaptimeDecimalsFormat, CultureInfo.InvariantCulture);
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

                if (raceEventUserKv.Value.Finished)
                {
                    raceLeaderboardEventUser.Flags.Add(HeatIndicatorFlag.Finished);
                }
                //if (_timeTypeFastestTimes[HeatIndicatorTimeTypeId.Lap].IndicatorId == heatStateInternalIndicatorKv.Key)
                //{
                //    raceLeaderboardEventUser.Flags.Add(HeatIndicatorFlag.FastestLap);
                //}
                //if (raceEventUserKv.Value.LapWarning)
                //{
                //    heatLeaderboardIndicator.Flags.Add(HeatIndicatorFlag.Warning);
                //}
                if (raceEventUserKv.Value.Pitlane)
                {
                    raceLeaderboardEventUser.Flags.Add(HeatIndicatorFlag.Pitlane);
                }
                if (raceEventUserKv.Value.Deslot)
                {
                    raceLeaderboardEventUser.Flags.Add(HeatIndicatorFlag.Deslot);
                }

                raceLeaderboard.EventUsers.Add(raceLeaderboardEventUser);
            }

            return raceLeaderboard;
        }


        public class RaceLeaderboardEventUser
        {
            //public required string EventUserId { get; set; }
            public required uint Position { get; set; }
            public TimeSpan TimerElapsed { get; set; }
            public TimeSpan PreviousTimerElapsed { get; set; }
            //public uint PositionEstimate { get; set; }
            public double? LapsCompleted { get; set; }
            public double? LapsPredicted { get; set; }
            //public ushort? Points { get; set; }
            //public ushort? PointsEstimate { get; set; }

            public double? GapLapsPredictedLeader { get; set; }
            public double? GapLapsPredictedInterval { get; set; }
            public double? GapLapsPredictedIntervalFraction { get; set; }
            public Guid? PreviousIntervalRaceEventUserId { get; set; } = null;
            public double? PreviousGapLapsEstimatedInterval { get; set; }

            //public double? GapLeaderTime { get; set; }
            //public short? GapLeaderLaps { get; set; }
            //public double? GapIntervalTime { get; set; }
            //public short? GapIntervalLaps { get; set; }
            //public double? GapIntervalFraction { get; set; }
            public bool Finished { get; set; }
            //public bool LapWarning { get; set; }
            public bool Pitlane { get; set; }
            //public ushort LapPitlanes { get; set; }
            public bool Deslot { get; set; }
            //public ushort LapCarOffTracks { get; set; }
            public Dictionary<string, Dictionary<RaceLeaderboardHeatEventUserUpdate.ValueOneofCase, RaceLeaderboardHeatEventUserUpdate>> HeatEventUserUpdates { get; set; } = [];
        }


        public class EventUserHeatIndicator
        {
            public required string EventUserId { get; set; }
            public required string HeatId { get; set; }
            public required uint IndicatorId { get; set; }
        }
    }
}
