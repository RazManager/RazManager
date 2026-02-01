using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Tenant;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Common;
using System;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Repository.CrudServices.Entities.Tenant
{

    [Authorize]
    public class TenantService : Razmanager.Protobuf.Internal.Repository.CrudServices.Tenant.TenantService.TenantServiceBase
    {
        private readonly ITenantStore _entityCrudStore;


        public TenantService(ITenantStore entityCrudStore)
        {
            _entityCrudStore = entityCrudStore;
        }


        public override Task<TenantRead> Initialize(Empty request, ServerCallContext context)
        {
            return _entityCrudStore.InitializeAsync();
        }


        public override async Task<TenantReadResponse> Read(IdRequest request, ServerCallContext context)
        {
            var response = await _entityCrudStore.ReadAsync(new Guid(request.Id));
            return new TenantReadResponse
            {
                Entity = response.Proto,
                Etag = response.ETag
            };
        }


        public override Task<CreateResponse> Create(TenantCreateUpdate request, ServerCallContext context)
        {
            return _entityCrudStore.CreateAsync(request);
        }


        public override Task<UpdateResponse> Update(TenantUpdateRequest request, ServerCallContext context)
        {
            return _entityCrudStore.UpdateAsync(new Guid(request.Id), request.Entity, request.Etag);
        }


        public override Task<Empty> Delete(DeleteRequest request, ServerCallContext context)
        {
            return _entityCrudStore.DeleteAsync(new Guid(request.Id), request.Etag);
        }
    }
}
