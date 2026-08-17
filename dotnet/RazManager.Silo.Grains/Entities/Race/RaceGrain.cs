using Orleans.Streams;
using Razmanager.Protobuf.Public.V1;
using System.Globalization;
using System.Resources;
using static RazManager.Silo.Grains.Entities.RaceSessionWithoutStints.RaceSessionWithoutStintGrain;


namespace RazManager.Silo.Grains.Entities.Race
{
    public class RaceGrain : Grain, IRaceGrain
    {
        private readonly Razmanager.Protobuf.Internal.Repository.SystemServices.Race.RaceService.RaceServiceClient _serviceClient;
        private Razmanager.Protobuf.Public.V1.Race? _race;
        private Guid? _currentRaceSessionWithoutStintsId = null;
        private Guid? _currentRaceSessionWithStintsId = null;
        private IAsyncStream<Razmanager.Protobuf.Public.V1.Race>? _raceStream;
        private IAsyncStream<Razmanager.Protobuf.Public.V1.RaceState>? _raceStateStream;
        //private Guid? _heatId = null;


        public RaceGrain(Razmanager.Protobuf.Internal.Repository.SystemServices.Race.RaceService.RaceServiceClient serviceClient)
        {
            _serviceClient = serviceClient;
        }


        public override async Task OnActivateAsync(CancellationToken cancellationToken)
        {
            var streamProvider = this.GetStreamProvider(Constants.StreamProvider);
            _raceStream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.Race> (Constants.StreamName.Race.ToString(), this.GetPrimaryKey());
            _raceStateStream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.RaceState>(Constants.StreamName.RaceState.ToString(), this.GetPrimaryKey());
            await RefreshAsync();
        }


        public async Task RefreshAsync()
        {
            _race = await _serviceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });

            Initialize();

            var raceSessionsWithoutStintsTasks = _race.RaceSessionsWithoutStints
                .Select(x => GrainFactory.GetGrain<RaceSessionWithoutStints.IRaceSessionWithoutStintsGrain>(new Guid(x.Id)).ReadAsync());
            var raceSessionsWithoutStintsResults = await Task.WhenAll(raceSessionsWithoutStintsTasks);

            foreach (var result in raceSessionsWithoutStintsResults)
            {
                var raceSession = _race.RaceSessionsWithoutStints.SingleOrDefault(x => x.Id == result.Id);
                if (raceSession is not null)
                {
                    raceSession = result;

                    if (raceSession.StateType.Id == SummaryStateTypeId.Started)
                    {
                        _currentRaceSessionWithoutStintsId = new Guid(raceSession.Id);
                        _ = _raceStateStream!.OnNextAsync(RaceState());
                    }
                }
            }

            var raceSessionsWithStintsTasks = _race.RaceSessionsWithStints
                .Select(x => GrainFactory.GetGrain<RaceSessionWithStints.IRaceSessionWithStintsGrain>(new Guid(x.Id)).ReadAsync());
            var raceSessionsWithStintsResults = await Task.WhenAll(raceSessionsWithStintsTasks);

            foreach (var result in raceSessionsWithStintsResults)
            {
                var raceSession = _race.RaceSessionsWithStints.SingleOrDefault(x => x.Id == result.Id);
                if (raceSession is not null)
                {
                    raceSession = result;

                    if (raceSession.StateType.Id == SummaryStateTypeId.Started)
                    {
                        _currentRaceSessionWithStintsId = new Guid(raceSession.Id);
                        _ = _raceStateStream!.OnNextAsync(RaceState());
                    }
                }
            }

            _ = _raceStream!.OnNextAsync(_race);

            _ = GrainFactory.GetGrain<Event.IEventGrain>(new Guid(_race.EventId)).RefreshAsync();
        }


        private void Initialize()
        {
            _currentRaceSessionWithoutStintsId = null;
            _currentRaceSessionWithStintsId = null;
        }


        public Task<Razmanager.Protobuf.Public.V1.Race> ReadAsync()
        {
            return Task.FromResult(_race!);
        }


        public Task<RaceState> ReadStateAsync()
        {
            return Task.FromResult(RaceState());
        }


        public async Task CommandAsync(Razmanager.Protobuf.Public.V1.SummaryCommandTypeId commandTypeId)
        {
            switch (commandTypeId)
            {
                case SummaryCommandTypeId.Start:
                    if (!(_race!.StateType.Id == SummaryStateTypeId.Pending))
                    {
                        return;
                    }

                    await RaceStateSetAsync(SummaryStateTypeId.Started);
                    break;

                case SummaryCommandTypeId.End:
                    if (!(_race!.StateType.Id == SummaryStateTypeId.Started))
                    {
                        return;
                    }

                    await RaceStateSetAsync(SummaryStateTypeId.Ended);
                    break;

                case SummaryCommandTypeId.Reset:
                    if (!(_race.StateType.Id == SummaryStateTypeId.Started || _race.StateType.Id == SummaryStateTypeId.Ended))
                    {
                        return;
                    }

                    Initialize();

                    foreach (var raceSession in _race!.RaceSessionsWithoutStints)
                    {
                        _ = GrainFactory.GetGrain<RaceSessionWithoutStints.IRaceSessionWithoutStintsGrain>(new Guid(raceSession.Id)).CommandAsync(SummaryCommandTypeId.Reset);
                    }
                    foreach (var raceSession in _race!.RaceSessionsWithStints)
                    {
                        _ = GrainFactory.GetGrain<RaceSessionWithStints.IRaceSessionWithStintsGrain>(new Guid(raceSession.Id)).CommandAsync(SummaryCommandTypeId.Reset);
                    }

                    await RaceStateSetAsync(SummaryStateTypeId.Pending);
                    break;

                default:
                    break;
            }
       }


        private async Task RaceStateSetAsync(SummaryStateTypeId stateTypeId)
        {
            _race!.StateType = new Razmanager.Protobuf.Public.V1.SummaryStateType
            {
                Id = stateTypeId,
                Name = new ResourceManager(typeof(RazManager.Resources.SummaryStateType)).GetString(stateTypeId.ToString())
            };

            await _serviceClient.UpdateStateAsync(new Razmanager.Protobuf.Internal.Repository.SystemServices.Race.RaceStateUpdateRequest
            {
                Id = this.GetPrimaryKey().ToString(),
                RaceStateTypeId = stateTypeId
            });

            if (stateTypeId == SummaryStateTypeId.Started)
            {
                foreach (var sessionTypeId in Enum.GetValues<SessionTypeId>())
                {
                    var raceSessionWithoutStintsId = _race.RaceSessionsWithoutStints
                        .OrderBy(x => x.Number)
                        .FirstOrDefault()?.Id;
                    if (raceSessionWithoutStintsId is not null)                    
                    {
                        _ = GrainFactory.GetGrain<RaceSessionWithoutStints.IRaceSessionWithoutStintsGrain>(new Guid(raceSessionWithoutStintsId)).CommandAsync(SummaryCommandTypeId.Start);
                        break;
                    }

                    var raceSessionWithStintsId = _race.RaceSessionsWithStints
                        .OrderBy(x => x.Number)
                        .FirstOrDefault()?.Id;
                    if (raceSessionWithStintsId is not null)
                    {
                        _ = GrainFactory.GetGrain<RaceSessionWithStints.IRaceSessionWithStintsGrain>(new Guid(raceSessionWithStintsId)).CommandAsync(SummaryCommandTypeId.Start);
                        break;
                    }
                }
            }

            _ = _raceStream!.OnNextAsync(_race);
        }



        private RaceState RaceState()
        {
            var raceState = new RaceState
            {
                StateType = _race.StateType,
            };

            var currentRaceSessionWithoutStints = _race.RaceSessionsWithoutStints.SingleOrDefault(x => x.Id == _currentRaceSessionWithoutStintsId.ToString());
            if (currentRaceSessionWithoutStints is not null)
            {
                raceState.RaceSessionWithoutStints = currentRaceSessionWithoutStints;
            }

            var currentRaceSessionWithStints = _race.RaceSessionsWithStints.SingleOrDefault(x => x.Id == _currentRaceSessionWithStintsId.ToString());
            if (currentRaceSessionWithStints is not null)
            {
                raceState.RaceSessionWithStints = currentRaceSessionWithStints;
            }

            return raceState;
        }
    }
}