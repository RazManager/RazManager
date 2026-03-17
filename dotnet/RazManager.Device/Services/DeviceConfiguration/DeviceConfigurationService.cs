using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Microsoft.Extensions.Logging;
using Orleans;
using Razmanager.Protobuf.Public.V1;
using RazManager.Silo.Grains.Entities.DeviceConfiguration;
using System;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Device.Services.DeviceConfiguration
{
    [Authorize]
    public class DeviceConfigurationService : Razmanager.Protobuf.Public.V1.DeviceConfigurationService.DeviceConfigurationServiceBase
    {
        private readonly IClusterClient _clusterClient;
        private readonly ILogger<DeviceConfigurationService> _logger;


        public DeviceConfigurationService(Razmanager.Protobuf.Internal.Repository.DeviceServices.Device.DeviceService.DeviceServiceClient serviceClient,
                             IClusterClient clusterClient,
                             ILogger<DeviceConfigurationService> logger)
        {
            _clusterClient = clusterClient;
            _logger = logger;
        }


        public override async Task<Empty> DeviceConfigurationInputsPublish(DeviceConfigurationInputs request, ServerCallContext context)
        {
            var i = request.Items.FirstOrDefault();

            await _clusterClient.GetGrain<IDeviceConfigurationGrain>(new Guid(i!.DeviceConfigurationId))
                .DeviceConfigurationInputsAsync(request, false);
            return new Empty();
        }
    }
}
