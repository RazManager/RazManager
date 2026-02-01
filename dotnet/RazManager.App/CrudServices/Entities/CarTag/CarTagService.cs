using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Razmanager.Protobuf.Internal.Repository.CrudServices.CarTag;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Common;
using System.Threading.Tasks;


namespace RazManager.App.CrudServices.Entities.CarTag
{
    [Authorize(Policy = "TenantAdministrator")]
    public class CarTagService : Razmanager.Protobuf.Internal.Repository.CrudServices.CarTag.CarTagService.CarTagServiceBase
    {
        private readonly Razmanager.Protobuf.Internal.Repository.CrudServices.CarTag.CarTagService.CarTagServiceClient _serviceClient;


        public CarTagService(Razmanager.Protobuf.Internal.Repository.CrudServices.CarTag.CarTagService.CarTagServiceClient serviceClient)
        {
            _serviceClient = serviceClient;
        }


        public override async Task<CarTagRead> Initialize(Empty request, ServerCallContext context)
        {
            return await _serviceClient.InitializeAsync(request);
        }


        public override async Task<CarTagReadResponse> Read(IdRequest request, ServerCallContext context)
        {
            return await _serviceClient.ReadAsync(request);
        }


        public override async Task<CreateResponse> Create(CarTagCreateUpdate request, ServerCallContext context)
        {
            return await _serviceClient.CreateAsync(request);
        }


        public override async Task<UpdateResponse> Update(CarTagUpdateRequest request, ServerCallContext context)
        {
            return await _serviceClient.UpdateAsync(request);
        }


        public override async Task<Empty> Delete(DeleteRequest request, ServerCallContext context)
        {
            return await _serviceClient.DeleteAsync(request);
        }


        public override async Task<CarTagListResponse> List(ListRequest request, ServerCallContext context)
        {
            return await _serviceClient.ListAsync(request);
        }


        public override async Task<CarTagSelectResponse> Select(Empty request, ServerCallContext context)
        {
            return await _serviceClient.SelectAsync(request);
        }
    }
}