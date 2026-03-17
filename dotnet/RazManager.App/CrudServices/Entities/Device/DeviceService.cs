using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Orleans;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Common;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Device;
using System;
using System.Threading.Tasks;


namespace RazManager.App.CrudServices.Entities.Device
{
    [Authorize(Policy = "TenantAdministrator")]
    public class DeviceService : Razmanager.Protobuf.Internal.Repository.CrudServices.Device.DeviceService.DeviceServiceBase
    {
        private readonly Razmanager.Protobuf.Internal.Repository.CrudServices.Device.DeviceService.DeviceServiceClient _serviceClient;
        private readonly IClusterClient _clusterClient;


        public DeviceService(Razmanager.Protobuf.Internal.Repository.CrudServices.Device.DeviceService.DeviceServiceClient serviceClient,
                             IClusterClient clusterClient)
        {
            _serviceClient = serviceClient;
            _clusterClient = clusterClient;
        }


        public override async Task<DeviceRead> Initialize(Empty request, ServerCallContext context)
        {
            return await _serviceClient.InitializeAsync(request);
        }


        public override async Task<DeviceReadResponse> Read(IdRequest request, ServerCallContext context)
        {
            return await _serviceClient.ReadAsync(request);
        }


        public override async Task<CreateResponse> Create(DeviceCreateUpdate request, ServerCallContext context)
        {
            return await _serviceClient.CreateAsync(request);
        }


        public override async Task<UpdateResponse> Update(DeviceUpdateRequest request, ServerCallContext context)
        {
            var response = await _serviceClient.UpdateAsync(request);
            await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.Device.IDeviceGrain>(new Guid(request.Id)).RefreshAsync();
            return response;
        }


        public override async Task<Empty> Delete(DeleteRequest request, ServerCallContext context)
        {
            return await _serviceClient.DeleteAsync(request);
        }


        public override async Task<DeviceListResponse> List(ListRequest request, ServerCallContext context)
        {
            var response = await _serviceClient.ListAsync(request);

            foreach (var item in response.Result)
            {
                item.Connected = await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.Device.IDeviceGrain>(new Guid(item.Id)).ConnectedReadAsync();
            }

            return response;
        }


        public override async Task<DeviceCommissioningCertificateResponse> CertificateRequest(DeviceCommissioningCertificateRequest request, ServerCallContext context)
        {
            return await _serviceClient.CertificateRequestAsync(request);
        }
    }
}