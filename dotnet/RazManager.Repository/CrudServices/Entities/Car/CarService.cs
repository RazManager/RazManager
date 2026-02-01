using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Car;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Common;
using System;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Repository.CrudServices.Entities.Car
{

    [Authorize]
    public class CarService : Razmanager.Protobuf.Internal.Repository.CrudServices.Car.CarService.CarServiceBase
    {
        private readonly ICarStore _entityCrudStore;


        public CarService(ICarStore entityCrudStore)
        {
            _entityCrudStore = entityCrudStore;
        }


        public override Task<CarRead> Initialize(Empty request, ServerCallContext context)
        {
            return _entityCrudStore.InitializeAsync();
        }


        public override async Task<CarReadResponse> Read(IdRequest request, ServerCallContext context)
        {
            var response = await _entityCrudStore.ReadAsync(new Guid(request.Id));
            return new CarReadResponse
            {
                Entity = response.Proto,
                Etag = response.ETag
            };
        }


        public override Task<CreateResponse> Create(CarCreateUpdate request, ServerCallContext context)
        {
            return _entityCrudStore.CreateAsync(request);
        }


        public override Task<UpdateResponse> Update(CarUpdateRequest request, ServerCallContext context)
        {
            return _entityCrudStore.UpdateAsync(new Guid(request.Id), request.Entity, request.Etag);
        }


        public override Task<Empty> Delete(DeleteRequest request, ServerCallContext context)
        {
            return _entityCrudStore.DeleteAsync(new Guid(request.Id), request.Etag);
        }


        public override async Task<CarListResponse> List(CarListRequest request, ServerCallContext context)
        {
            var response = _entityCrudStore.ListAsync(request.Limit, request.Offset, request.CarTagIds.Select(x => new Guid(x)));
            var result = new CarListResponse();
            await foreach (var item in response)
            {
                result.Result.Add(item);
            }
            return result;
        }


        public override async Task<CarSelectResponse> Select(Empty request, ServerCallContext context)
        {
            var response = _entityCrudStore.SelectAsync();
            var result = new CarSelectResponse();
            await foreach (var item in response)
            {
                result.Result.Add(item);
            }
            return result;
        }
    }
}
