using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Car;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Common;
using System.Threading.Tasks;


namespace RazManager.App.CrudServices.Entities.Car
{
    [Authorize(Policy = "TenantAdministrator")]
    public class CarService : Razmanager.Protobuf.Internal.Repository.CrudServices.Car.CarService.CarServiceBase
    {
        private readonly Razmanager.Protobuf.Internal.Repository.CrudServices.Car.CarService.CarServiceClient _serviceClient;


        public CarService(Razmanager.Protobuf.Internal.Repository.CrudServices.Car.CarService.CarServiceClient serviceClient)
        {
            _serviceClient = serviceClient;
        }


        public override async Task<CarRead> Initialize(Empty request, ServerCallContext context)
        {
            return await _serviceClient.InitializeAsync(request);
        }


        public override async Task<CarReadResponse> Read(IdRequest request, ServerCallContext context)
        {
            return await _serviceClient.ReadAsync(request);
        }


        public override async Task<CreateResponse> Create(CarCreateUpdate request, ServerCallContext context)
        {
            return await _serviceClient.CreateAsync(request);
        }


        public override async Task<UpdateResponse> Update(CarUpdateRequest request, ServerCallContext context)
        {
            return await _serviceClient.UpdateAsync(request);
        }


        public override async Task<Empty> Delete(DeleteRequest request, ServerCallContext context)
        {
            return await _serviceClient.DeleteAsync(request);
        }


        public override async Task<CarListResponse> List(CarListRequest request, ServerCallContext context)
        {
            return await _serviceClient.ListAsync(request);
        }


        public override async Task<CarSelectResponse> Select(Empty request, ServerCallContext context)
        {
            return await _serviceClient.SelectAsync(request);
        }
    }
}