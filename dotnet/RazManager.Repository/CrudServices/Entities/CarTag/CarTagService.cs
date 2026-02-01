using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Razmanager.Protobuf.Internal.Repository.CrudServices.CarTag;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Common;
using System;
using System.Threading.Tasks;


namespace RazManager.Repository.CrudServices.Entities.CarTag
{

    [Authorize]
    public class CarTagService : Razmanager.Protobuf.Internal.Repository.CrudServices.CarTag.CarTagService.CarTagServiceBase
    {
        private readonly ICarTagStore _entityCrudStore;


        public CarTagService(ICarTagStore entityCrudStore)
        {
            _entityCrudStore = entityCrudStore;
        }


        public override Task<CarTagRead> Initialize(Empty request, ServerCallContext context)
        {
            return _entityCrudStore.InitializeAsync();
        }


        public override async Task<CarTagReadResponse> Read(IdRequest request, ServerCallContext context)
        {
            var response = await _entityCrudStore.ReadAsync(new Guid(request.Id));
            return new CarTagReadResponse
            {
                Entity = response.Proto,
                Etag = response.ETag
            };
        }


        public override Task<CreateResponse> Create(CarTagCreateUpdate request, ServerCallContext context)
        {
            return _entityCrudStore.CreateAsync(request);
        }


        public override Task<UpdateResponse> Update(CarTagUpdateRequest request, ServerCallContext context)
        {
            return _entityCrudStore.UpdateAsync(new Guid(request.Id), request.Entity, request.Etag);
        }


        public override Task<Empty> Delete(DeleteRequest request, ServerCallContext context)
        {
            return _entityCrudStore.DeleteAsync(new Guid(request.Id), request.Etag);
        }


        public override async Task<CarTagListResponse> List(ListRequest request, ServerCallContext context)
        {
            var response = _entityCrudStore.ListAsync(request.Limit, request.Offset);
            var result = new CarTagListResponse();
            await foreach (var item in response)
            {
                result.Result.Add(item);
            }
            return result;
        }


        public override async Task<CarTagSelectResponse> Select(Empty request, ServerCallContext context)
        {
            var response = _entityCrudStore.SelectAsync();
            var result = new CarTagSelectResponse();
            await foreach (var item in response)
            {
                result.Result.Add(item);
            }
            return result;
        }
    }
}
