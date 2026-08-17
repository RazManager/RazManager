using Orleans.Streams;
using Razmanager.Protobuf.Internal.Silo.SystemServices.EventUser;
using Razmanager.Protobuf.Public.V1;
using System.Globalization;
using System.Resources;


namespace RazManager.Silo.Grains.Entities.RaceSessionWithoutStints
{
    public class RaceSessionWithoutStintGrain : Grain, IRaceSessionWithoutStintsGrain
    {
        private readonly Razmanager.Protobuf.Internal.Repository.SystemServices.Race.RaceService.RaceServiceClient _raceServiceClient;
        private readonly Razmanager.Protobuf.Internal.Repository.SystemServices.RaceSessionWithoutStints.RaceSessionWithoutStintsService.RaceSessionWithoutStintsServiceClient _serviceClient;
        private Razmanager.Protobuf.Public.V1.Race? _race;
        private Razmanager.Protobuf.Public.V1.RaceSessionWithoutStints? _raceSessionWithoutStints;
        private IAsyncStream<Razmanager.Protobuf.Public.V1.RaceSessionWithoutStints>? _raceSessionWithoutStintsStream;
        private IAsyncStream<Razmanager.Protobuf.Public.V1.RaceSessionWithoutStintsState>? _raceSessionWithoutStintsStateStream;
        private IAsyncStream<Razmanager.Protobuf.Public.V1.RaceSessionLeaderboard>? _raceSessionLeaderboardStream;
        private Guid? _currentHeatWithoutStintsId = null;
        private Dictionary<(Guid EventUserId, Guid HeatId), uint> _eventUserHeatIndicators = [];
        private Dictionary<Guid, RaceSessionLeaderboardEventUser> _raceSessionLeaderboardEventUsers = [];
        private string _trackLaptimeDecimalsFormat = "F2";


        public RaceSessionWithoutStintGrain(Razmanager.Protobuf.Internal.Repository.SystemServices.Race.RaceService.RaceServiceClient raceServiceClient, 
                                            Razmanager.Protobuf.Internal.Repository.SystemServices.RaceSessionWithoutStints.RaceSessionWithoutStintsService.RaceSessionWithoutStintsServiceClient serviceClient)
        {
            _raceServiceClient = raceServiceClient;
            _serviceClient = serviceClient;
        }


        public override async Task OnActivateAsync(CancellationToken cancellationToken)
        {
            var streamProvider = this.GetStreamProvider(Constants.StreamProvider);
            _raceSessionWithoutStintsStream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.RaceSessionWithoutStints> (Constants.StreamName.RaceSessionWithoutStints.ToString(), this.GetPrimaryKey());
            _raceSessionWithoutStintsStateStream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.RaceSessionWithoutStintsState>(Constants.StreamName.RaceSessionWithoutStintsState.ToString(), this.GetPrimaryKey());
            _raceSessionLeaderboardStream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.RaceSessionLeaderboard>(Constants.StreamName.RaceSessionLeaderboard.ToString(), this.GetPrimaryKey());
            await RefreshAsync();
        }


        public async Task RefreshAsync()
        {
            _raceSessionWithoutStints = await _serviceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });
            _race = await _raceServiceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = _raceSessionWithoutStints.RaceId });

            _eventUserHeatIndicators.Clear();
            foreach (var item in _raceSessionWithoutStints.HeatWithoutStints
                    .SelectMany(x => x.HeatIndicators, (Heat, HeatIndicator) => new { Heat, HeatIndicator }))
            {
                _eventUserHeatIndicators.Add((new Guid(item.HeatIndicator.EventUserId), new Guid(item.Heat.Id)), item.HeatIndicator.IndicatorId); // For quick lookup of the current indicator for each event user in a heat
            }

            Initialize();

            var tasks = _raceSessionWithoutStints.HeatWithoutStints
                .Select(x => GrainFactory.GetGrain<HeatWithoutStints.IHeatWithoutStintsGrain>(new Guid(x.Id)).ReadAsync());
            var results = await Task.WhenAll(tasks);

            foreach (var result in results)
            {
                var heatWithoutStints = _raceSessionWithoutStints.HeatWithoutStints.SingleOrDefault(x => x.Id == result.Id);
                if (heatWithoutStints is not null)
                {
                    heatWithoutStints = result;

                    if (heatWithoutStints.StateType.Id != DetailStateTypeId.Pending && heatWithoutStints.StateType.Id != DetailStateTypeId.Closed)
                    {
                        _currentHeatWithoutStintsId = new Guid(heatWithoutStints.Id);
                        _ = _raceSessionWithoutStintsStateStream!.OnNextAsync(RaceSessionWithoutStintsState());
                    }
                }
            }

            _ = _raceSessionWithoutStintsStream!.OnNextAsync(_raceSessionWithoutStints);

            _ = GrainFactory.GetGrain<Race.IRaceGrain>(new Guid(_raceSessionWithoutStints.RaceId)).RefreshAsync();
        }


        private void Initialize()
        {
            _currentHeatWithoutStintsId = null;

            _raceSessionLeaderboardEventUsers.Clear();
            foreach (var item in _raceSessionWithoutStints!.HeatWithoutStints
                    .SelectMany(x => x.HeatIndicators, (Heat, HeatIndicator) => new { Heat, HeatIndicator })
                    .GroupBy(x => x.HeatIndicator.EventUserId)
                    .Select((x, index) => new { x.Key, index }))
            {
                _raceSessionLeaderboardEventUsers.Add(new Guid(item.Key), new RaceSessionLeaderboardEventUser { Position = Convert.ToUInt32(item.index + 1) });
            }
        }


        public Task<Razmanager.Protobuf.Public.V1.RaceSessionWithoutStints> ReadAsync()
        {
            return Task.FromResult(_raceSessionWithoutStints!);
        }


        public Task<Razmanager.Protobuf.Public.V1.RaceSessionWithoutStintsState> ReadStateAsync()
        {
            return Task.FromResult(RaceSessionWithoutStintsState());
        }


        public Task<Razmanager.Protobuf.Public.V1.RaceSessionLeaderboard> ReadLeaderboardAsync()
        {
            return Task.FromResult(RaceSessionLeaderboard());
        }


        public async Task CommandAsync(Razmanager.Protobuf.Public.V1.SummaryCommandTypeId commandTypeId)
        {
            switch (commandTypeId)
            {
                case Razmanager.Protobuf.Public.V1.SummaryCommandTypeId.Start:
                    if (_raceSessionWithoutStints!.StateType.Id != SummaryStateTypeId.Pending)
                    {
                        return;
                    }

                    await RaceSessionStateSetAsync(SummaryStateTypeId.Started);
                    break;

                case Razmanager.Protobuf.Public.V1.SummaryCommandTypeId.End:
                    if (_raceSessionWithoutStints!.StateType.Id != SummaryStateTypeId.Started)
                    {
                        return;
                    }

                    await RaceSessionStateSetAsync(SummaryStateTypeId.Ended);
                    break;

                case Razmanager.Protobuf.Public.V1.SummaryCommandTypeId.Reset:
                    if (!(_raceSessionWithoutStints!.StateType.Id == SummaryStateTypeId.Started || _raceSessionWithoutStints!.StateType.Id == SummaryStateTypeId.Ended))
                    {
                        return;
                    }

                    Initialize();

                    foreach (var heatWithoutStint in _raceSessionWithoutStints!.HeatWithoutStints)
                    {
                        _ = GrainFactory.GetGrain<HeatWithoutStints.IHeatWithoutStintsGrain>(new Guid(heatWithoutStint.Id)).CommandAsync(DetailCommandTypeId.Reset);
                    }

                    await RaceSessionStateSetAsync(SummaryStateTypeId.Pending);
                    break;

                default:
                    break;
            }
       }


        private async Task RaceSessionStateSetAsync(SummaryStateTypeId stateTypeId)
        {
            _raceSessionWithoutStints!.StateType = new Razmanager.Protobuf.Public.V1.SummaryStateType
            {
                Id = stateTypeId,
                Name = new ResourceManager(typeof(RazManager.Resources.SummaryStateType)).GetString(stateTypeId.ToString())
            };

            await _serviceClient.UpdateStateAsync(new Razmanager.Protobuf.Internal.Repository.SystemServices.RaceSessionWithoutStints.RaceSessionWithoutStintsStateUpdateRequest
            {
                Id = this.GetPrimaryKey().ToString(),
                StateTypeId = stateTypeId
            });

            if (stateTypeId == SummaryStateTypeId.Started)
            {
                var heatWithoutStintId = _raceSessionWithoutStints.HeatWithoutStints
                    .OrderBy(x => x.Number)
                    .First().Id;
                _ = GrainFactory.GetGrain<HeatWithoutStints.IHeatWithoutStintsGrain>(new Guid(heatWithoutStintId)).CommandAsync(DetailCommandTypeId.Open);
                return;
            }

            _ = _raceSessionWithoutStintsStream!.OnNextAsync(_raceSessionWithoutStints);
        }


        public Task HeatWithoutStintsStateTypeUpdatedAsync(Razmanager.Protobuf.Public.V1.HeatWithoutStints heatWithoutStints)
        {
            var oldHeatWithoutStints = _raceSessionWithoutStints!.HeatWithoutStints
                    .SingleOrDefault(x => x.Id == heatWithoutStints.Id.ToString());
            if (oldHeatWithoutStints is not null)
            {
                oldHeatWithoutStints = heatWithoutStints;

                switch (heatWithoutStints.StateType.Id)
                {
                    case DetailStateTypeId.Pending:
                    case DetailStateTypeId.Opened:
                        foreach (var raceSessionLeaderboardEventUser in _raceSessionLeaderboardEventUsers)
                        {
                            raceSessionLeaderboardEventUser.Value.EventUserHeats.Remove(new Guid(heatWithoutStints.Id));
                            CalculateLaps(raceSessionLeaderboardEventUser.Value, null);
                        }

                        CalculatePositions(null);

                        _ = _raceSessionLeaderboardStream!.OnNextAsync(RaceSessionLeaderboard());

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
                        foreach (var h in _raceSessionWithoutStints!.HeatWithoutStints
                            .OrderBy(x => x.Number))
                        {
                            if (h.StateType.Id == DetailStateTypeId.Pending)
                            {
                                _ = GrainFactory.GetGrain<HeatWithoutStints.IHeatWithoutStintsGrain>(new Guid(h.Id)).CommandAsync(DetailCommandTypeId.Open);
                                break;
                            }
                        }
                        break;

                    default:
                        throw new ArgumentException($"Unhandled StateType: {heatWithoutStints.StateType.Id}", nameof(heatWithoutStints.StateType.Id));
                }
            }

            _ = _raceSessionWithoutStintsStream!.OnNextAsync(_raceSessionWithoutStints);

            return Task.CompletedTask;
        }


        public Task HeatWithoutStintsStateUpdatedAsync(Guid id, Razmanager.Protobuf.Public.V1.HeatWithoutStints heatWithoutStints)
        {
            var oldHeatWithoutStints = _raceSessionWithoutStints!.HeatWithoutStints
                    .SingleOrDefault(x => x.Id == heatWithoutStints.Id.ToString());
            if (oldHeatWithoutStints is not null)
            {
                oldHeatWithoutStints = heatWithoutStints;
                _ = _raceSessionWithoutStintsStateStream!.OnNextAsync(RaceSessionWithoutStintsState());
            }

            return Task.CompletedTask;
        }


        public async Task EventUserUpdateAsync(Razmanager.Protobuf.Internal.Silo.SystemServices.EventUser.EventUserUpdate update)
        {
            var heatWithoutStints = _raceSessionWithoutStints!.HeatWithoutStints
                    .SingleOrDefault(x => x.Id == update.Id.ToString());
            if (heatWithoutStints is null)
            {
                return;
            }

            if (!_raceSessionLeaderboardEventUsers.TryGetValue(new Guid(update.EventUserId), out var raceSessionLeaderboardEventUser))
            {
                return;
            }

            if (!raceSessionLeaderboardEventUser.EventUserHeats.TryGetValue(new Guid(update.Id), out var raceLeaderboardEventUserHeat))
            {
                raceLeaderboardEventUserHeat = new RaceSessionLeaderboardEventUserHeat();
                raceSessionLeaderboardEventUser.EventUserHeats[new Guid(update.Id)] = raceLeaderboardEventUserHeat;
            }

            switch (update.ValueCase)
            {
                case EventUserUpdate.ValueOneofCase.Laps:
                    raceLeaderboardEventUserHeat.EventUserUpdatesLap = update;
                    raceSessionLeaderboardEventUser.PreviousGapLapsPredictedInterval = raceSessionLeaderboardEventUser.GapLapsPredictedInterval;
                    CalculateLaps(raceSessionLeaderboardEventUser, update);
                    CalculatePositions(update);
                    _ = _raceSessionLeaderboardStream!.OnNextAsync(RaceSessionLeaderboard());

                    break;

                case EventUserUpdate.ValueOneofCase.Finished:
                    raceLeaderboardEventUserHeat.Finished = true;
                    _ = _raceSessionLeaderboardStream!.OnNextAsync(RaceSessionLeaderboard());
                    break;

                //case RaceLeaderboardHeatEventUserUpdate.ValueOneofCase.Flags:
                //    break;

                default:
                    break;
            }

        }


        private void CalculateLaps(RaceSessionLeaderboardEventUser raceSessionLeaderboardEventUser, EventUserUpdate? update)
        {
            var heatWithoutStints = _raceSessionWithoutStints?.HeatWithoutStints.SingleOrDefault(x => x.Id == update?.Id);
            if (heatWithoutStints is null)
            {
                return;
            }

            raceSessionLeaderboardEventUser.LapsCompleted = raceSessionLeaderboardEventUser.EventUserHeats.Values.Sum(x => x.EventUserUpdatesLap?.Laps);

            if (_raceSessionWithoutStints?.HeatStintEndTypeId == HeatStintEndTypeId.Duration)
            {
                raceSessionLeaderboardEventUser.PreviousTimerElapsed = raceSessionLeaderboardEventUser.TimerElapsed;
                var first = true;
                raceSessionLeaderboardEventUser.TimerElapsed = TimeSpan.FromTicks(_raceSessionWithoutStints.HeatWithoutStints
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
                            return _raceSessionWithoutStints.HeatStintEndDurationDuration.ToTimeSpan().Ticks;
                        }
                    }));

                if (raceSessionLeaderboardEventUser.TimerElapsed.Ticks == 0 || raceSessionLeaderboardEventUser.LapsCompleted == 0)
                {
                    raceSessionLeaderboardEventUser.LapsPredicted = null;
                }
                else
                {   
                    raceSessionLeaderboardEventUser.LapsPredicted =
                        raceSessionLeaderboardEventUser.LapsCompleted * _race!.RaceIndicators.Count() * _raceSessionWithoutStints!.HeatStintEndDurationDuration.ToTimeSpan().Ticks / raceSessionLeaderboardEventUser.TimerElapsed.Ticks;

                }
            }
        }


        private void CalculatePositions(EventUserUpdate? update)
        {
            if (_raceSessionWithoutStints!.HeatStintEndTypeId == HeatStintEndTypeId.Duration)
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


        private RaceSessionWithoutStintsState RaceSessionWithoutStintsState()
        {
            var raceSessionWithoutStintState = new RaceSessionWithoutStintsState
            {
                StateType = _raceSessionWithoutStints!.StateType,
            };

            var currentHeatWithoutStints = _raceSessionWithoutStints.HeatWithoutStints.SingleOrDefault(x => x.Id == _currentHeatWithoutStintsId.ToString());
            if (currentHeatWithoutStints is not null)
            {
                raceSessionWithoutStintState.CurrentHeatWithoutStints = currentHeatWithoutStints;
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

                if (_currentHeatWithoutStintsId.HasValue)
                {
                    if (raceSessionLeaderboardEventUserKv.Value.EventUserHeats.TryGetValue(_currentHeatWithoutStintsId.Value, out var raceLeaderboardEventUserHeat))
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