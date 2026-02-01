using Orleans.Streams;
using Razmanager.Protobuf.Public.V1;
using System.Resources;
using System.Xml;


namespace RazManager.Silo.Grains.Entities.Race
{
    public class RaceGrain : Grain, IRaceGrain
    {
        private readonly Razmanager.Protobuf.Internal.Repository.SystemServices.Race.RaceService.RaceServiceClient _serviceClient;
        private Razmanager.Protobuf.Public.V1.Race? _race;
        private IAsyncStream<Razmanager.Protobuf.Public.V1.Race>? _raceStream;
        private Guid? _heatId = null;


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

            foreach (var heat in _race.Heats)
            {
                var heatProto = await GrainFactory.GetGrain<Heat.IHeatGrain>(new Guid(heat.Id)).ReadAsync();
                heat.HeatStateType = heatProto.HeatStateType;

                if (heat.HeatStateType.Id != HeatStateTypeId.Pending && heat.HeatStateType.Id != HeatStateTypeId.Closed)
                {
                    _heatId = new Guid(heat.Id);
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


        public Task<RaceLeaderboard> ReadRaceLeaderboardAsync()
        {
            throw new NotImplementedException();
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
    }
}
