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
        private Guid? _heatId = null;
        private Dictionary<SessionTypeId, Dictionary<Guid, RaceEventUser>> _raceEventUsers = [];
        private string _trackLaptimeDecimalsFormat = "F2";


        public RaceGrain(Razmanager.Protobuf.Internal.Repository.SystemServices.Race.RaceService.RaceServiceClient serviceClient)
        {
            _serviceClient = serviceClient;
        }


        public override async Task OnActivateAsync(CancellationToken cancellationToken)
        {
            var streamProvider = this.GetStreamProvider(Constants.StreamProvider);
            _raceStream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.Race> (Constants.StreamName.Race.ToString(), this.GetPrimaryKey());
            await RefreshAsync(false);
        }


        public async Task RefreshAsync(bool publish)
        {
            _race = await _serviceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });

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
                    }
                }
            }

            if (publish)
            {
                _ = _raceStream!.OnNextAsync(_race);
            }

            _ = GrainFactory.GetGrain<Event.IEventGrain>(new Guid(_race.EventId)).RefreshAsync(publish);
        }


        public Task<Razmanager.Protobuf.Public.V1.Race> ReadAsync()
        {
            return Task.FromResult(_race!);
        }


        public Task<Guid?> ReadRaceStateAsync()
        {
            return Task.FromResult(_heatId);
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

            _ = RefreshAsync(true);
        }


        public Task HeatClosedAsync()
        {
            foreach (var heat in _race!.Heats.OrderBy(x => x.Number))
            {
                if (heat.HeatStateType.Id == HeatStateTypeId.Pending)
                {
                    _ = GrainFactory.GetGrain<Heat.IHeatGrain>(new Guid(heat.Id)).CommandAsync(HeatCommandTypeId.Open);
                    return Task.CompletedTask;
                }
            }

            _ = RefreshAsync(true);

            return Task.CompletedTask;
        }


        public Task RaceLeaderboardEventUserUpdateAsync(RaceLeaderboardEventUserUpdate update)
        {
            var raceEventUsers = _raceEventUsers[update.SessionTypeId];
            if (!raceEventUsers.TryGetValue(new Guid(update.EventUserId), out var raceEventUser))
            {
                raceEventUser = new RaceEventUser();
                raceEventUsers.Add(new Guid(update.EventUserId), raceEventUser);

            }

            switch (update.ValueCase)
            {
                case RaceLeaderboardEventUserUpdate.ValueOneofCase.Laps:
                    raceEventUser.TimerElapsed = update.TimerElapsed.ToTimeSpan();
                    raceEventUser.Laps = update.Laps;
                    break;

                case RaceLeaderboardEventUserUpdate.ValueOneofCase.Flags:
                    break;

                default:
                    break;
            }




            throw new NotImplementedException();
        }


        private RaceLeaderboard RaceLeaderboard(SessionTypeId sessionTypeId)
        {
            var raceLeaderboard = new RaceLeaderboard();

            foreach (var raceEventUserKv in _raceEventUsers[sessionTypeId])
            {
                var raceLeaderboardEventUser = new RaceLeaderboardEventUser
                {
                    EventUserId = raceEventUserKv.Key.ToString(),
                    Position = raceEventUserKv.Value.Position,
                    Laps = raceEventUserKv.Value.Laps,
                    LapsEstimate = raceEventUserKv.Value.LapsEstimate,
                    Points = raceEventUserKv.Value.Points,
                    PointsEstimate = raceEventUserKv.Value.PointsEstimate,
                    GapIntervalFraction = raceEventUserKv.Value.GapIntervalFraction
                };

                if (raceEventUserKv.Value.GapLeaderLaps.HasValue)
                {
                    raceLeaderboardEventUser.GapLeader = $"{raceEventUserKv.Value.GapLeaderLaps.Value}L";
                }
                else if (raceEventUserKv.Value.GapLeaderTime.HasValue)
                {
                    raceLeaderboardEventUser.GapLeader = raceEventUserKv.Value.GapLeaderTime.Value.ToString(_trackLaptimeDecimalsFormat, CultureInfo.InvariantCulture);
                }

                if (raceEventUserKv.Value.GapIntervalLaps.HasValue)
                {
                    raceLeaderboardEventUser.GapInterval = $"{raceEventUserKv.Value.GapIntervalLaps.Value}L";
                }
                else if (raceEventUserKv.Value.GapIntervalTime.HasValue)
                {
                    raceLeaderboardEventUser.GapInterval = raceEventUserKv.Value.GapIntervalTime.Value.ToString(_trackLaptimeDecimalsFormat, CultureInfo.InvariantCulture);
                }

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


        private class RaceEventUser
        {
            //public required string EventUserId { get; set; }
            public TimeSpan TimerElapsed { get; set; }
            public uint? Position { get; set; }
            //public uint PositionEstimate { get; set; }
            public double? Laps { get; set; }
            public double? LapsEstimate { get; set; }
            public ushort? Points { get; set; }
            public ushort? PointsEstimate { get; set; }
            public double? GapLeaderTime { get; set; }
            public short? GapLeaderLaps { get; set; }
            public double? GapIntervalTime { get; set; }
            public short? GapIntervalLaps { get; set; }
            public double? GapIntervalFraction { get; set; }
            public bool Finished { get; set; }
            //public bool LapWarning { get; set; }
            public bool Pitlane { get; set; }
            //public ushort LapPitlanes { get; set; }
            public bool Deslot { get; set; }
            //public ushort LapCarOffTracks { get; set; }
        }
    }
}
