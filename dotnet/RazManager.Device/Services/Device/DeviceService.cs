using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Microsoft.Extensions.Logging;
using Orleans;
using Razmanager.Protobuf.Public.V1;
using RazManager.Device.Utilities;
using System;
using System.Threading.Tasks;


namespace RazManager.Device.Services.Device
{
    [Authorize]
    public class DeviceService : Razmanager.Protobuf.Public.V1.DeviceService.DeviceServiceBase
    {
        private readonly Razmanager.Protobuf.Internal.Repository.DeviceServices.Device.DeviceService.DeviceServiceClient _serviceClient;
        private readonly IClusterClient _clusterClient;
        private readonly IHttpContextOptions _httpContextOptions;
        private readonly ILogger<DeviceService> _logger;


        public DeviceService(Razmanager.Protobuf.Internal.Repository.DeviceServices.Device.DeviceService.DeviceServiceClient serviceClient,
                             IClusterClient clusterClient,
                             IHttpContextOptions httpContextOptions,
                             ILogger<DeviceService> logger)
        {
            _serviceClient = serviceClient;
            _clusterClient = clusterClient;
            _httpContextOptions = httpContextOptions;
            _logger = logger;
        }


        public override async Task<Empty> DeviceInformation(DeviceInformation request, ServerCallContext context)
        {
            try
            {
                await _serviceClient.DeviceInformationAsync(
                    new Razmanager.Protobuf.Internal.Repository.DeviceServices.Device.DeviceInformationRequest
                    { 
                        Id = _httpContextOptions.DeviceId.ToString(),
                        DeviceInformation = request
                    },
                    null, null, context.CancellationToken);

                foreach (var deviceConfiguration in request.DeviceConfigurations)
                {
                    await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.DeviceConfiguration.IDeviceConfigurationGrain>(new Guid(deviceConfiguration.Id)).RefreshAsync();
                }
                return new Empty();
            }
            catch (Exception exception)
            {
                _logger.LogError(exception, exception.Message);
                throw new RpcException(new Status(StatusCode.Internal, exception.Message));
            }
        }
    }
}