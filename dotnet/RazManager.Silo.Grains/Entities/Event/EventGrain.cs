using Orleans.Streams;
using Razmanager.Protobuf.Internal.Silo.UserServices.Event;
using Razmanager.Protobuf.Public.V1;


namespace RazManager.Silo.Grains.Entities.Event
{
    public class EventGrain : Grain, IEventGrain
    {
        private readonly Razmanager.Protobuf.Internal.Repository.SystemServices.Event.EventService.EventServiceClient _serviceClient;
        private Razmanager.Protobuf.Public.V1.Event? _event;
        private Razmanager.Protobuf.Public.V1.EventState? _eventState;
        private IAsyncStream<Razmanager.Protobuf.Public.V1.Event>? _eventStream;
        private IAsyncStream<Razmanager.Protobuf.Public.V1.EventState>? _eventStateStream;
        private Dictionary<Guid, IAsyncStream<EventSpeechData>?> _eventUserSpeechDataStreams = [];


        public EventGrain(Razmanager.Protobuf.Internal.Repository.SystemServices.Event.EventService.EventServiceClient serviceClient)
        {
            _serviceClient = serviceClient;
        }


        public override async Task OnActivateAsync(CancellationToken cancellationToken)
        {
            _eventState = new EventState
            {
                Id = this.GetPrimaryKey().ToString()
            };

            var streamProvider = this.GetStreamProvider(Constants.StreamProvider);
            _eventStream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.Event>(Constants.StreamName.Event.ToString(), this.GetPrimaryKey());
            _eventStateStream = streamProvider.GetStream<EventState>(Constants.StreamName.EventState.ToString(), this.GetPrimaryKey());

            await RefreshAsync(false);
        }


        public async Task RefreshAsync(bool publish)
        {
            _event = await _serviceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });
            _eventState!.RaceId = null;
            _eventState.HeatId = null;

            foreach (var race in _event.Races)
            {
                var raceProto = await GrainFactory.GetGrain<Race.IRaceGrain>(new Guid(race.Id)).ReadAsync();

                if (race.RaceStateType.Id != RaceStateTypeId.Pending && race.RaceStateType.Id != RaceStateTypeId.Ended)
                {
                    _eventState!.RaceId = race.Id;
                    var heatId = await GrainFactory.GetGrain<Race.IRaceGrain>(new Guid(race.Id)).ReadRaceStateAsync();
                    if (heatId.HasValue)
                    {
                        _eventState!.HeatId = heatId.Value.ToString();
                    }
                }
            }

            if (publish)
            {
                await _eventStream!.OnNextAsync(_event);
                await _eventStateStream!.OnNextAsync(_eventState!);
            }
        }


        public Task<Razmanager.Protobuf.Public.V1.Event> ReadAsync()
        {
            return Task.FromResult(_event!);
        }


        public Task<EventState> ReadEventStateAsync()
        {
            return Task.FromResult(_eventState!);
        }


        public async Task EventUserSpeechData(Guid eventUserId, EventSpeechTypeId eventSpeechTypeId, string text)
        {
            if (!_eventUserSpeechDataStreams.TryGetValue(eventUserId, out var stream))
            {
                var streamProvider = this.GetStreamProvider(Constants.StreamProvider);
                stream = streamProvider.GetStream<EventSpeechData>(Constants.StreamName.EventSpeechData.ToString(), $"{this.GetPrimaryKey()}:{eventUserId}");
                _eventUserSpeechDataStreams.Add(eventUserId, stream);
            }

            await stream!.OnNextAsync(new EventSpeechData { EventSpeechTypeId = eventSpeechTypeId, Text = text });
        }
    }
}
