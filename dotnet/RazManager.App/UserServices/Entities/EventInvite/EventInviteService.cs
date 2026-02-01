using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Razmanager.Protobuf.Internal.Repository.UserServices.EventInvite;
using System.Threading.Tasks;


namespace RazManager.App.UserServices.Entities.EventInvite
{
    [Authorize]
    public class EventInviteService : Razmanager.Protobuf.Internal.Repository.UserServices.EventInvite.EventInviteService.EventInviteServiceBase
    {
        private readonly Razmanager.Protobuf.Internal.Repository.UserServices.EventInvite.EventInviteService.EventInviteServiceClient _serviceClient;


        public EventInviteService(Razmanager.Protobuf.Internal.Repository.UserServices.EventInvite.EventInviteService.EventInviteServiceClient serviceClient)
        {
            _serviceClient = serviceClient;
        }


        public async override Task<Empty> Create(EventInviteCreate request, ServerCallContext context)
        {
            return await _serviceClient.CreateAsync(request);
        }
    }
}
