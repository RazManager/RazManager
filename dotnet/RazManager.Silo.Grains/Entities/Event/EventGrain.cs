using Orleans.Streams;
using Razmanager.Protobuf.Internal.Silo.UserServices.Event;
using Razmanager.Protobuf.Public.V1;
using System.Diagnostics;


namespace RazManager.Silo.Grains.Entities.Event
{
    public class EventGrain : Grain, IEventGrain
    {
        private readonly Razmanager.Protobuf.Internal.Repository.SystemServices.Event.EventService.EventServiceClient _serviceClient;
        private Razmanager.Protobuf.Public.V1.Event? _event;
        private Guid? _currentRaceId = null;
        private IAsyncStream<Razmanager.Protobuf.Public.V1.Event>? _eventStream;
        private IAsyncStream<Razmanager.Protobuf.Public.V1.EventState>? _eventStateStream;
        private Dictionary<Guid, IAsyncStream<EventSpeechTexts>?> _eventSpeechTextsStreams = [];


        public EventGrain(Razmanager.Protobuf.Internal.Repository.SystemServices.Event.EventService.EventServiceClient serviceClient)
        {
            _serviceClient = serviceClient;
        }


        public override async Task OnActivateAsync(CancellationToken cancellationToken)
        {
            var streamProvider = this.GetStreamProvider(Constants.StreamProvider);
            _eventStream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.Event>(Constants.StreamName.Event.ToString(), this.GetPrimaryKey());
            _eventStateStream = streamProvider.GetStream<EventState>(Constants.StreamName.EventState.ToString(), this.GetPrimaryKey());
            await RefreshAsync();
        }


        public async Task RefreshAsync()
        {
            _event = await _serviceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });

            _currentRaceId = null;

            var tasks = _event.Races
                .Select(x => GrainFactory.GetGrain<Race.IRaceGrain>(new Guid(x.Id)).ReadAsync());
            var results = await Task.WhenAll(tasks);

            foreach (var result in results)
            {
                var race = _event.Races.SingleOrDefault(x => x.Id == result.Id);
                if (race is not null)
                {
                    race = result;

                    if (race.StateType.Id == SummaryStateTypeId.Started)
                    {
                        _currentRaceId = new Guid(race.Id);
                        _ = _eventStateStream!.OnNextAsync(EventState());
                    }
                }
            }

            _ = _eventStream!.OnNextAsync(_event);
        }


        public Task<Razmanager.Protobuf.Public.V1.Event> ReadAsync()
        {
            return Task.FromResult(_event!);
        }


        public Task<EventState> ReadStateAsync()
        {
            return Task.FromResult(EventState());
        }


        public async Task EventSpeechTexts(Guid eventUserId, EventSpeechTexts texts)
        {
            if (!_eventSpeechTextsStreams.TryGetValue(eventUserId, out var stream))
            {
                var streamProvider = this.GetStreamProvider(Constants.StreamProvider);
                stream = streamProvider.GetStream<EventSpeechTexts>(Constants.StreamName.EventSpeechTexts.ToString(), $"{this.GetPrimaryKey()}:{eventUserId}");
                _eventSpeechTextsStreams.Add(eventUserId, stream);
            }

            await stream!.OnNextAsync(texts);
        }


        private EventState EventState()
        {
            var eventState = new EventState();

            var currentRace = _event.Races.SingleOrDefault(x => x.Id == _currentRaceId.ToString());
            if (currentRace is not null)
            {
                eventState.CurrentRace = currentRace;
            }

            return eventState;
        }
    }
}
