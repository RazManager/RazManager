using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Razmanager.Protobuf.Internal.Repository.CrudServices.TenantUser;
using System.Threading.Tasks;


namespace RazManager.App.CrudServices.Entities.TenantUser
{
    [Authorize(Policy = "TenantAdministrator")]
    public class TenantUserService : Razmanager.Protobuf.Internal.Repository.CrudServices.TenantUser.TenantUserService.TenantUserServiceBase
    {
        private readonly Razmanager.Protobuf.Internal.Repository.CrudServices.TenantUser.TenantUserService.TenantUserServiceClient _serviceClient;


        public TenantUserService(Razmanager.Protobuf.Internal.Repository.CrudServices.TenantUser.TenantUserService.TenantUserServiceClient serviceClient)
        {
            _serviceClient = serviceClient;
        }


        public override async Task<TenantUserSelectResponse> Select(TenantUserSelectRequest request, ServerCallContext context)
        {
            return await _serviceClient.SelectAsync(request);
        }
    }
}
