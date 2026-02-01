using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Razmanager.Protobuf.Internal.Repository.CrudServices.HeatIndicatorStint;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Common;
using System;
using System.Threading.Tasks;


namespace RazManager.Repository.CrudServices.Entities.HeatIndicatorStint
{

    [Authorize]
    public class HeatIndicatorStintService : Razmanager.Protobuf.Internal.Repository.CrudServices.HeatIndicatorStint.HeatIndicatorStintService.HeatIndicatorStintServiceBase
    {
        private readonly IHeatIndicatorStintStore _entityCrudStore;


        public HeatIndicatorStintService(IHeatIndicatorStintStore entityCrudStore)
        {
            _entityCrudStore = entityCrudStore;
        }


        public override Task<HeatIndicatorStintRead> Initialize(Empty request, ServerCallContext context)
        {
            return _entityCrudStore.InitializeAsync();
        }


        public override async Task<HeatIndicatorStintReadResponse> Read(IdRequest request, ServerCallContext context)
        {
            var response = await _entityCrudStore.ReadAsync(new Guid(request.Id));
            return new HeatIndicatorStintReadResponse
            {
                Entity = response.Proto,
                Etag = response.ETag
            };
        }


        public override Task<CreateResponse> Create(HeatIndicatorStintCreate request, ServerCallContext context)
        {
            return _entityCrudStore.CreateAsync(request);
        }


        public override Task<UpdateResponse> Update(HeatIndicatorStintUpdateRequest request, ServerCallContext context)
        {
            return _entityCrudStore.UpdateAsync(new Guid(request.Id), request.Entity, request.Etag);
        }


        public override Task<Empty> Delete(DeleteRequest request, ServerCallContext context)
        {
            return _entityCrudStore.DeleteAsync(new Guid(request.Id), request.Etag);
        }
    }
}
