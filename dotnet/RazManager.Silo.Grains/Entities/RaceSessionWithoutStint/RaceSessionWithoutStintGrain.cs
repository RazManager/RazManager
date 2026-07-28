using Orleans.Streams;
using Razmanager.Protobuf.Internal.Silo.SystemServices.EventUser;
using Razmanager.Protobuf.Public.V1;
using System.Globalization;
using System.Resources;


namespace RazManager.Silo.Grains.Entities.RaceSessionWithoutStint
{
    public class RaceSessionWithoutStintGrain : Grain, IRaceSessionWithoutStintGrain
    {
        private readonly Razmanager.Protobuf.Internal.Repository.SystemServices.RaceSession.RaceSessionService.RaceSessionServiceClient _serviceClient;
        private Razmanager.Protobuf.Public.V1.RaceSession? _raceSession;
        private IAsyncStream<Razmanager.Protobuf.Public.V1.RaceSession>? _raceSessionStream;
        private IAsyncStream<Razmanager.Protobuf.Public.V1.RaceSessionWithoutStintState>? _raceSessionWithoutStintStateStream;
        private IAsyncStream<Razmanager.Protobuf.Public.V1.RaceSessionLeaderboard>? _raceSessionLeaderboardStream;
        private Guid? _currentHeatWithoutStintId = null;
        private Dictionary<(Guid EventUserId, Guid HeatId), uint> _eventUserHeatIndicators = [];
        private Dictionary<Guid, RaceSessionLeaderboardEventUser> _raceSessionLeaderboardEventUsers = [];
        private string _trackLaptimeDecimalsFormat = "F2";


        public RaceSessionWithoutStintGrain(Razmanager.Protobuf.Internal.Repository.SystemServices.RaceSession.RaceSessionService.RaceSessionServiceClient serviceClient)
        {
            _serviceClient = serviceClient;
        }


        public override async Task OnActivateAsync(CancellationToken cancellationToken)
        {
            var streamProvider = this.GetStreamProvider(Constants.StreamProvider);
            _raceSessionStream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.RaceSession> (Constants.StreamName.race .RaceSession.ToString(), this.GetPrimaryKey());
            _raceSessionWithoutStintStateStream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.RaceSessionWithoutStintState>(Constants.StreamName.RaceSessionWithoutStintState.ToString(), this.GetPrimaryKey());
            _raceSessionLeaderboardStream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.RaceSessionLeaderboard>(Constants.StreamName.RaceSessionLeaderboard.ToString(), this.GetPrimaryKey());
            await RefreshAsync();
        }


        public async Task RefreshAsync()
        {
            _raceSession = await _serviceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });

            foreach (var item in _raceSession.HeatWithoutStints.HeatWithoutStints_
                    .SelectMany(x => x.HeatIndicators, (Heat, HeatIndicator) => new { Heat, HeatIndicator }))
            {
                _eventUserHeatIndicators.Add((new Guid(item.HeatIndicator.EventUserId), new Guid(item.Heat.Id)), item.HeatIndicator.IndicatorId); // For quick lookup of the current indicator for each event user in a heat
            }

            Initialize();

            var tasks = _raceSession.HeatWithoutStints.HeatWithoutStints_
                .Select(x => GrainFactory.GetGrain<HeatWithoutStint.IHeatWithoutStintGrain>(new Guid(x.Id)).ReadAsync());
            var results = await Task.WhenAll(tasks);

            foreach (var result in results)
            {
                var heatWithoutStint = _raceSession.HeatWithoutStints.HeatWithoutStints_.SingleOrDefault(x => x.Id == result.Id);
                if (heatWithoutStint is not null)
                {
                    heatWithoutStint = result;

                    if (heatWithoutStint.HeatWithoutStintStateType.Id != DetailStateTypeId.Pending && heatWithoutStint.HeatWithoutStintStateType.Id != DetailStateTypeId.Closed)
                    {
                        _currentHeatWithoutStintId = new Guid(heatWithoutStint.Id);
                        _ = _raceSessionWithoutStintStateStream!.OnNextAsync(RaceState(raceSessionGroupHeat.RaceSessionGroup.SessionType.Id));
                    }
                }
            }

            _ = _raceSessionStream!.OnNextAsync(_raceSession);

            _ = GrainFactory.GetGrain<Event.IEventGrain>(new Guid(_raceSession.EventId)).RefreshAsync(true);
        }


        private void Initialize()
        {
            _currentHeatWithoutStintId = null;

            _raceSessionLeaderboardEventUsers.Clear();
            foreach (var sessionTypeId in Enum.GetValues<SessionTypeId>())
            {
                var raceEventUsers = new Dictionary<Guid, RaceSessionLeaderboardEventUser>();
                foreach (var raceEventUserKv in _raceSession.RaceEventUsers.Select((id, index) => new { id, index }))
                {
                    raceEventUsers.Add(new Guid(raceEventUserKv.id), new RaceSessionLeaderboardEventUser { Position = Convert.ToUInt32(raceEventUserKv.index + 1) });
                }

                _raceSessionLeaderboardEventUsers.Add(sessionTypeId, raceEventUsers);
            }
        }


        public Task<Razmanager.Protobuf.Public.V1.Race> ReadAsync()
        {
            return Task.FromResult(_raceSession!);
        }


        public Task<Guid?> CurrentHeatAsync()
        {
            return Task.FromResult(_currentHeatWithoutStintId);
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
                    if (!(_raceSession!.RaceStateType.Id == RaceStateTypeId.Pending || _raceSession!.RaceStateType.Id == RaceStateTypeId.Paused))
                    {
                        return;
                    }

                    await RaceStateSetAsync(RaceStateTypeId.Started);
                    break;

                case RaceCommandTypeId.Pause:
                    if (!(_raceSession!.RaceStateType.Id == RaceStateTypeId.Started))
                    {
                        return;
                    }

                    await RaceStateSetAsync(RaceStateTypeId.Paused);
                    break;

                case RaceCommandTypeId.End:
                    if (!(_raceSession!.RaceStateType.Id == RaceStateTypeId.Started || _raceSession.RaceStateType.Id == RaceStateTypeId.Paused))
                    {
                        return;
                    }

                    await RaceStateSetAsync(RaceStateTypeId.Ended);
                    break;

                case RaceCommandTypeId.Reset:
                    if (!(_raceSession.RaceStateType.Id == RaceStateTypeId.Started || _raceSession.RaceStateType.Id == RaceStateTypeId.Paused || _raceSession.RaceStateType.Id == RaceStateTypeId.Ended))
                    {
                        return;
                    }

                    Initialize();

                    foreach (var raceSessionGroupHeat in _raceSession!.RaceSessionGroups
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
            _raceSession!.RaceStateType = new Razmanager.Protobuf.Public.V1.RaceStateType
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
                var heatId = _raceSession.RaceSessionGroups
                    .SelectMany(x => x.Heats, (RaceSessionGroup, Heat) => new { RaceSessionGroup, Heat })
                    .OrderBy(x => x.RaceSessionGroup.SessionType.Id)
                    .ThenBy(x => x.Heat.Number)
                    .First().Heat.Id;
                _ = GrainFactory.GetGrain<Heat.IHeatWithoutStintGrain>(new Guid(heatId)).CommandAsync(HeatCommandTypeId.Open);
                return;
            }

            _ = _raceSessionStream!.OnNextAsync(_raceSession);
        }


        public Task HeatStateTypeUpdatedAsync(Guid id, Razmanager.Protobuf.Public.V1.HeatStateType heatStateType)
        {
            var raceSessionGroupHeat = _raceSession.RaceSessionGroups
                    .SelectMany(x => x.Heats, (RaceSessionGroup, Heat) => new { RaceSessionGroup, Heat })
                    .SingleOrDefault(x => x.Heat.Id == id.ToString());
            if (raceSessionGroupHeat is not null)
            {
                raceSessionGroupHeat.Heat.HeatStateType = heatStateType;

                switch (heatStateType.Id)
                {
                    case HeatStateTypeId.Pending:
                    case HeatStateTypeId.Opened:
                        var raceLeaderboardEventUsers = _raceSessionLeaderboardEventUsers[raceSessionGroupHeat.RaceSessionGroup.SessionType.Id];
                        foreach (var raceLeaderboardEventUser in raceLeaderboardEventUsers)
                        {
                            raceLeaderboardEventUser.Value.EventUserHeats.Remove(id);
                            CalculateLaps(raceLeaderboardEventUser.Value, null);
                        }

                        CalculatePositions(raceLeaderboardEventUsers, null);

                        _ = _raceSessionLeaderboardStream!.OnNextAsync(RaceLeaderboard(raceSessionGroupHeat.RaceSessionGroup.SessionType.Id));

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
                        foreach (var rsgh in _raceSession.RaceSessionGroups
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

            _ = _raceSessionStream!.OnNextAsync(_raceSession);

            return Task.CompletedTask;
        }


        public Task HeatStateUpdatedAsync(Guid id, Razmanager.Protobuf.Public.V1.HeatState heatState)
        {
            var raceSessionGroupHeat = _raceSession?.RaceSessionGroups
                    .SelectMany(x => x.Heats, (RaceSessionGroup, Heat) => new { RaceSessionGroup, Heat })
                    .SingleOrDefault(x => x.Heat.Id == id.ToString());
            if (raceSessionGroupHeat?.Heat is not null)
            {
                _heatState = heatState;
                _ = _raceSessionWithoutStintStateStream!.OnNextAsync(RaceState(raceSessionGroupHeat.RaceSessionGroup.SessionType.Id));
            }

            return Task.CompletedTask;
        }


        public async Task EventUserUpdateAsync(EventUserUpdate update)
        {
            var heatWithStint = _raceSession.HeatWithStints.  _raceSession?.RaceSessionGroups
                    .SelectMany(x => x.Heats, (RaceSessionGroup, Heat) => new { RaceSessionGroup, Heat })
                    .SingleOrDefault(x => x.Heat.Id == update.HeatId);
            if (heatWithStint?.Heat is null)
            {
                return;
            }

            var raceLeaderboardEventUsers = _raceSessionLeaderboardEventUsers[heatWithStint.RaceSessionGroup.SessionType.Id];
            if (!raceLeaderboardEventUsers.TryGetValue(new Guid(update.EventUserId), out var raceLeaderboardEventUser))
            {
                return;
            }

            if (!raceLeaderboardEventUser.EventUserHeats.TryGetValue(new Guid(update.HeatId), out var raceLeaderboardEventUserHeat))
            {
                raceLeaderboardEventUserHeat = new RaceSessionLeaderboardEventUserHeat();
                raceLeaderboardEventUser.EventUserHeats[new Guid(update.HeatId)] = raceLeaderboardEventUserHeat;
            }

            switch (update.ValueCase)
            {
                case RaceLeaderboardHeatEventUserUpdate.ValueOneofCase.Laps:
                    raceLeaderboardEventUserHeat.EventUserUpdatesLap = update;
                    raceLeaderboardEventUser.PreviousGapLapsPredictedInterval = raceLeaderboardEventUser.GapLapsPredictedInterval;
                    CalculateLaps(raceLeaderboardEventUser, update);
                    CalculatePositions(raceLeaderboardEventUsers, update);
                    _ = _raceSessionLeaderboardStream!.OnNextAsync(RaceSessionLeaderboard(heatWithStint.RaceSessionGroup.SessionType.Id));

                    break;

                case RaceLeaderboardHeatEventUserUpdate.ValueOneofCase.Finished:
                    raceLeaderboardEventUserHeat.Finished = true;
                    _ = _raceSessionLeaderboardStream!.OnNextAsync(RaceSessionLeaderboard(heatWithStint.RaceSessionGroup.SessionType.Id));
                    break;

                //case RaceLeaderboardHeatEventUserUpdate.ValueOneofCase.Flags:
                //    break;

                default:
                    break;
            }

        }


        private void CalculateLaps(RaceSessionLeaderboardEventUser raceSessionLeaderboardEventUser, EventUserUpdate? update)
        {
            var heatWithoutStint = _raceSession?.HeatWithoutStints.HeatWithoutStints_.SingleOrDefault(x => x.Id == update?.Id);
            if (heatWithoutStint is null)
            {
                return;
            }

            raceSessionLeaderboardEventUser.LapsCompleted = raceSessionLeaderboardEventUser.EventUserHeats.Values.Sum(x => x.EventUserUpdatesLap?.Laps);

            if (_raceSession?.HeatStintEndTypeId == HeatStintEndTypeId.Duration)
            {
                raceSessionLeaderboardEventUser.PreviousTimerElapsed = raceSessionLeaderboardEventUser.TimerElapsed;
                var first = true;
                raceSessionLeaderboardEventUser.TimerElapsed = TimeSpan.FromTicks(_raceSession.HeatWithoutStints.HeatWithoutStints_
                        .Where(x => raceSessionLeaderboardEventUser.EventUserHeats.ContainsKey(new Guid(x.Id)))
                    .OrderByDescending(x => x.Number).Sum(x =>
                    {
                        if (first)
                        {
                            first = false;
                            return update?.TimerElapsed.ToTimeSpan().Ticks ?? 0;
                        }
                        else
                        {
                            return _raceSession.HeatStintEndDurationDuration.ToTimeSpan().Ticks;
                        }
                    }));

                if (raceSessionLeaderboardEventUser.TimerElapsed.Ticks == 0 || raceSessionLeaderboardEventUser.LapsCompleted == 0)
                {
                    raceSessionLeaderboardEventUser.LapsPredicted = null;
                }
                else
                {
                    raceSessionLeaderboardEventUser.LapsPredicted = raceSessionLeaderboardEventUser.LapsCompleted * _raceSession.RaceIndicators.Count() * _raceSession.RaceHeatEndDurationDuration.ToTimeSpan().Ticks / raceSessionLeaderboardEventUser.TimerElapsed.Ticks;
                }
            }
        }


        private void CalculatePositions(EventUserUpdate? update)
        {
            if (_raceSession!.HeatStintEndTypeId == HeatStintEndTypeId.Duration)
            {
                KeyValuePair<Guid, RaceSessionLeaderboardEventUser>? leaderRaceSessionLeaderboardEventUserKv = null;
                KeyValuePair<Guid, RaceSessionLeaderboardEventUser>? intervalRaceSessionLeaderboardEventUserKv = null;

                foreach (var item in _raceSessionLeaderboardEventUsers
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
                        if (leaderRaceSessionLeaderboardEventUserKv is not null &&
                            leaderRaceSessionLeaderboardEventUserKv.Value.Value.LapsPredicted.HasValue)
                        {
                            item.raceEventUserKv.Value.GapLapsPredictedLeader = leaderRaceSessionLeaderboardEventUserKv.Value.Value.LapsPredicted.Value - item.raceEventUserKv.Value.LapsPredicted.Value;
                        }
                        if (intervalRaceSessionLeaderboardEventUserKv is not null &&
                            intervalRaceSessionLeaderboardEventUserKv.Value.Value.LapsPredicted.HasValue)
                        {
                            item.raceEventUserKv.Value.GapLapsPredictedInterval = intervalRaceSessionLeaderboardEventUserKv.Value.Value.LapsPredicted.Value - item.raceEventUserKv.Value.LapsPredicted.Value;

                            if (item.raceEventUserKv.Value.PreviousIntervalRaceEventUserId == intervalRaceSessionLeaderboardEventUserKv.Value.Key)
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

                            item.raceEventUserKv.Value.PreviousIntervalRaceEventUserId = intervalRaceSessionLeaderboardEventUserKv.Value.Key;
                        }
                    }

                    if (item.index == 0)
                    {
                        leaderRaceSessionLeaderboardEventUserKv = item.raceEventUserKv;
                    }
                    intervalRaceSessionLeaderboardEventUserKv = item.raceEventUserKv;
                }
            }
        }


        private RaceSessionWithoutStintState RaceSessionWithoutStintState()
        {
            var raceSessionWithoutStintState = new RaceSessionWithoutStintState
            {
                RaceSessionStateType = _raceSession!.RaceSessionStateType,
            };

            var currentHeatWithoutStint = _raceSession.HeatWithoutStints.HeatWithoutStints_.SingleOrDefault(x => x.Id == _currentHeatWithoutStintId.ToString());
            if (currentHeatWithoutStint is not null)
            {
                raceSessionWithoutStintState.CurrentHeatWithoutStint = currentHeatWithoutStint;
            }

            return raceSessionWithoutStintState;
        }


        private RaceSessionLeaderboard RaceSessionLeaderboard()
        {
            var raceSessionLeaderboard = new RaceSessionLeaderboard();

            foreach (var raceSessionLeaderboardEventUserKv in _raceSessionLeaderboardEventUsers)
            {
                var raceSessionLeaderboardEventUser = new Razmanager.Protobuf.Public.V1.RaceSessionLeaderboardEventUser
                {
                    EventUserId = raceSessionLeaderboardEventUserKv.Key.ToString(),
                    Position = raceSessionLeaderboardEventUserKv.Value.Position,
                    GapLapsPredictedIntervalFraction = raceSessionLeaderboardEventUserKv.Value.GapLapsPredictedIntervalFraction
                };
                if (raceSessionLeaderboardEventUserKv.Value.LapsCompleted.HasValue)
                {
                    raceSessionLeaderboardEventUser.LapsCompleted = raceSessionLeaderboardEventUserKv.Value.LapsCompleted.Value.ToString("F0", CultureInfo.InvariantCulture);
                }
                if (raceSessionLeaderboardEventUserKv.Value.LapsPredicted.HasValue)
                {
                    raceSessionLeaderboardEventUser.LapsPredicted = raceSessionLeaderboardEventUserKv.Value.LapsPredicted.Value.ToString(_trackLaptimeDecimalsFormat, CultureInfo.InvariantCulture);
                }
                //Points = raceEventUserKv.Value.Points,
                //PointsEstimate = raceEventUserKv.Value.PointsEstimate,
                if (raceSessionLeaderboardEventUserKv.Value.GapLapsPredictedLeader.HasValue)
                {
                    raceSessionLeaderboardEventUser.GapLapsPredictedLeader = raceSessionLeaderboardEventUserKv.Value.GapLapsPredictedLeader.Value.ToString(_trackLaptimeDecimalsFormat, CultureInfo.InvariantCulture);
                }
                if (raceSessionLeaderboardEventUserKv.Value.GapLapsPredictedInterval.HasValue)
                {
                    raceSessionLeaderboardEventUser.GapLapsPredictedInterval = raceSessionLeaderboardEventUserKv.Value.GapLapsPredictedInterval.Value.ToString(_trackLaptimeDecimalsFormat, CultureInfo.InvariantCulture);
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

                if (_currentHeatWithoutStintId.HasValue)
                {
                    if (raceSessionLeaderboardEventUserKv.Value.EventUserHeats.TryGetValue(_currentHeatWithoutStintId.Value, out var raceLeaderboardEventUserHeat))
                    {
                        if (raceLeaderboardEventUserHeat.Finished)
                        {
                            raceSessionLeaderboardEventUser.Flags.Add(IndicatorFlag.Finished);
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
                            raceSessionLeaderboardEventUser.Flags.Add(IndicatorFlag.Pitlane);
                        }
                        if (raceLeaderboardEventUserHeat.Deslot)
                        {
                            raceSessionLeaderboardEventUser.Flags.Add(IndicatorFlag.Deslot);
                        }
                    }
                }

                raceSessionLeaderboard.EventUsers.Add(raceSessionLeaderboardEventUser);
            }

            return raceSessionLeaderboard;
        }


        public class RaceSessionLeaderboardEventUser
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
            public Dictionary<Guid, RaceSessionLeaderboardEventUserHeat> EventUserHeats { get; set; } = [];

            //public ushort? Points { get; set; }
            //public ushort? PointsEstimate { get; set; }
        }


        public class RaceSessionLeaderboardEventUserHeat
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


Task<Razmanager.Protobuf.Public.V1.Race> ReadAsync();
Task<Razmanager.Protobuf.Public.V1.RaceWithoutStintState> ReadRaceWithoutStintStateAsync(Razmanager.Protobuf.Public.V1.SessionTypeId sessionTypeId);
Task<Razmanager.Protobuf.Public.V1.RaceLeaderboard> ReadRaceLeaderboardAsync(Razmanager.Protobuf.Public.V1.SessionTypeId sessionTypeId);
Task CommandAsync(Razmanager.Protobuf.Public.V1.SummaryCommandTypeId raceCommandTypeId);
Task HeatWithoutStintStateTypeUpdatedAsync(Razmanager.Protobuf.Public.V1.HeatWithoutStint heatWithoutStint);
Task HeatWithoutStintStateUpdatedAsync(Guid id, Razmanager.Protobuf.Public.V1.HeatWithoutStint heatWithoutStint);
Task EventUserUpdateAsync(Razmanager.Protobuf.Internal.Silo.SystemServices.EventUser.EventUserUpdate update);
