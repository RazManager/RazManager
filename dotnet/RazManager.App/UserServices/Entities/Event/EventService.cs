using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Razmanager.Protobuf.Internal.Repository.UserServices.Event;
using System.Threading.Tasks;


namespace RazManager.App.UserServices.Entities.Event
{
    public class EventService : Razmanager.Protobuf.Internal.Repository.UserServices.Event.EventService.EventServiceBase
    {
        private readonly Razmanager.Protobuf.Internal.Repository.UserServices.Event.EventService.EventServiceClient _serviceClient;


        public EventService(Razmanager.Protobuf.Internal.Repository.UserServices.Event.EventService.EventServiceClient serviceClient)
        {
            _serviceClient = serviceClient;
        }


        public override async Task<EventSelectResponse> Select(Empty request, ServerCallContext context)
        {
            return await _serviceClient.SelectAsync(request);
        }
    }
}
