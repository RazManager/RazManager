using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Razmanager.Protobuf.Internal.Repository.UserServices.Tenant;
using System.Threading.Tasks;


namespace RazManager.App.UserServices.Entities.Tenant
{
    [Authorize]
    public class TenantService : Razmanager.Protobuf.Internal.Repository.UserServices.Tenant.TenantService.TenantServiceBase
    {
        private readonly Razmanager.Protobuf.Internal.Repository.UserServices.Tenant.TenantService.TenantServiceClient _serviceClient;


        public TenantService(Razmanager.Protobuf.Internal.Repository.UserServices.Tenant.TenantService.TenantServiceClient serviceClient)
        {
            _serviceClient = serviceClient;
        }


        public override async Task<TenantRead> Read(Empty request, ServerCallContext context)
        {
            return await _serviceClient.ReadAsync(request);
        }


        public override async Task<TenantSelectResponse> Select(Empty request, ServerCallContext context)
        {
            return await _serviceClient.SelectAsync(request);
        }
    }
}
