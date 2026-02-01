using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Tenant;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Common;
using System.Threading.Tasks;


namespace RazManager.App.CrudServices.Entities.Tenant
{
    public class TenantService : Razmanager.Protobuf.Internal.Repository.CrudServices.Tenant.TenantService.TenantServiceBase
    {
        private readonly Razmanager.Protobuf.Internal.Repository.CrudServices.Tenant.TenantService.TenantServiceClient _serviceClient;


        public TenantService(Razmanager.Protobuf.Internal.Repository.CrudServices.Tenant.TenantService.TenantServiceClient serviceClient)
        {
            _serviceClient = serviceClient;
        }


        [Authorize]
        public override async Task<TenantRead> Initialize(Empty request, ServerCallContext context)
        {
            return await _serviceClient.InitializeAsync(request);
        }


        [Authorize(Policy = "TenantAdministrator")]
        public override async Task<TenantReadResponse> Read(IdRequest request, ServerCallContext context)
        {
            return await _serviceClient.ReadAsync(request);
        }


        [Authorize]
        public override async Task<CreateResponse> Create(TenantCreateUpdate request, ServerCallContext context)
        {
            return await _serviceClient.CreateAsync(request);
        }


        [Authorize(Policy = "TenantAdministrator")]
        public override async Task<UpdateResponse> Update(TenantUpdateRequest request, ServerCallContext context)
        {
            return await _serviceClient.UpdateAsync(request);
        }


        [Authorize(Policy = "TenantAdministrator")]
        public override async Task<Empty> Delete(DeleteRequest request, ServerCallContext context)
        {
            return await _serviceClient.DeleteAsync(request);
        }
    }
}