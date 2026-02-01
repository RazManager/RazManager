using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Razmanager.Protobuf.Internal.Repository.CrudServices.DeviceConfiguration;
using System.Threading.Tasks;


namespace RazManager.App.CrudServices.Entities.DeviceConfiguration
{
    [Authorize(Policy = "TenantAdministrator")]
    public class DeviceConfigurationService : Razmanager.Protobuf.Internal.Repository.CrudServices.DeviceConfiguration.DeviceConfigurationService.DeviceConfigurationServiceBase
    {
        private readonly Razmanager.Protobuf.Internal.Repository.CrudServices.DeviceConfiguration.DeviceConfigurationService.DeviceConfigurationServiceClient _serviceClient;


        public DeviceConfigurationService(Razmanager.Protobuf.Internal.Repository.CrudServices.DeviceConfiguration.DeviceConfigurationService.DeviceConfigurationServiceClient serviceClient)
        {
            _serviceClient = serviceClient;
        }


        public override async Task<DeviceConfigurationSelectResponse> Select(Empty request, ServerCallContext context)
        {
            return await _serviceClient.SelectAsync(request);
        }
    }
}
