using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Device;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Common;
using System;
using System.Threading.Tasks;


namespace RazManager.Repository.CrudServices.Entities.Device
{

    [Authorize]
    public class DeviceService : Razmanager.Protobuf.Internal.Repository.CrudServices.Device.DeviceService.DeviceServiceBase
    {
        private readonly IDeviceStore _entityCrudStore;


        public DeviceService(IDeviceStore entityCrudStore)
        {
            _entityCrudStore = entityCrudStore;
        }


        public override Task<DeviceRead> Initialize(Empty request, ServerCallContext context)
        {
            return _entityCrudStore.InitializeAsync();
        }


        public override async Task<DeviceReadResponse> Read(IdRequest request, ServerCallContext context)
        {
            var response = await _entityCrudStore.ReadAsync(new Guid(request.Id));
            return new DeviceReadResponse
            {
                Entity = response.Proto,
                Etag = response.ETag
            };
        }


        public override Task<CreateResponse> Create(DeviceCreateUpdate request, ServerCallContext context)
        {
            return _entityCrudStore.CreateAsync(request);
        }


        public override Task<UpdateResponse> Update(DeviceUpdateRequest request, ServerCallContext context)
        {
            return _entityCrudStore.UpdateAsync(new Guid(request.Id), request.Entity, request.Etag);
        }


        public override Task<Empty> Delete(DeleteRequest request, ServerCallContext context)
        {
            return _entityCrudStore.DeleteAsync(new Guid(request.Id), request.Etag);
        }


        public override async Task<DeviceListResponse> List(ListRequest request, ServerCallContext context)
        {
            var response = _entityCrudStore.ListAsync(request.Limit, request.Offset);
            var result = new DeviceListResponse();
            await foreach (var item in response)
            {
                result.Result.Add(item);
            }
            return result;
        }


        public override Task<DeviceCommissioningCertificateResponse> CertificateRequest(DeviceCommissioningCertificateRequest request, ServerCallContext context)
        {
            return _entityCrudStore.CertificateRequest(request);
        }
    }
}
