using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Razmanager.Protobuf.Internal.Repository.UserServices.TenantInvite;
using System.Threading.Tasks;


namespace RazManager.App.UserServices.Entities.TenantInvite
{
    [Authorize]
    public class TenantInviteService : Razmanager.Protobuf.Internal.Repository.UserServices.TenantInvite.TenantInviteService.TenantInviteServiceBase
    {
        private readonly Razmanager.Protobuf.Internal.Repository.UserServices.TenantInvite.TenantInviteService.TenantInviteServiceClient _serviceClient;


        public TenantInviteService(Razmanager.Protobuf.Internal.Repository.UserServices.TenantInvite.TenantInviteService.TenantInviteServiceClient serviceClient)
        {
            _serviceClient = serviceClient;
        }


        public async override Task<Empty> Create(TenantInviteCreate request, ServerCallContext context)
        {
            return await _serviceClient.CreateAsync(request);
        }
    }
}
