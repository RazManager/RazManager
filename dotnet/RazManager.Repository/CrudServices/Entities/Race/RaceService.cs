using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Race;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Common;
using System;
using System.Threading.Tasks;


namespace RazManager.Repository.CrudServices.Entities.Race
{

    [Authorize]
    public class RaceService : Razmanager.Protobuf.Internal.Repository.CrudServices.Race.RaceService.RaceServiceBase
    {
        private readonly IRaceStore _entityCrudStore;


        public RaceService(IRaceStore entityCrudStore)
        {
            _entityCrudStore = entityCrudStore;
        }


        public override Task<RaceRead> Initialize(Empty request, ServerCallContext context)
        {
            return _entityCrudStore.InitializeAsync();
        }


        public override async Task<RaceReadResponse> Read(IdRequest request, ServerCallContext context)
        {
            var response = await _entityCrudStore.ReadAsync(new Guid(request.Id));
            return new RaceReadResponse
            {
                Entity = response.Proto,
                Etag = response.ETag
            };
        }


        public override Task<CreateResponse> Create(RaceCreate request, ServerCallContext context)
        {
            return _entityCrudStore.CreateAsync(request);
        }


        public override Task<UpdateResponse> Update(RaceUpdateRequest request, ServerCallContext context)
        {
            return _entityCrudStore.UpdateAsync(new Guid(request.Id), request.Entity, request.Etag);
        }


        public override Task<Empty> Delete(DeleteRequest request, ServerCallContext context)
        {
            return _entityCrudStore.DeleteAsync(new Guid(request.Id), request.Etag);
        }


        public override async Task<RaceListResponse> List(ListRequest request, ServerCallContext context)
        {
            var response = _entityCrudStore.ListAsync(request.Limit, request.Offset);
            var result = new RaceListResponse();
            await foreach (var item in response)
            {
                result.Result.Add(item);
            }
            return result;
        }


        public override Task<CreateResponse> Copy(IdRequest request, ServerCallContext context)
        {
            return _entityCrudStore.CopyAsync(new Guid(request.Id));
        }
    }
}
