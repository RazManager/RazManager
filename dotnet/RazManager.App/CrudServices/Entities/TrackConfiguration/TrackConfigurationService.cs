using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Track;
using Razmanager.Protobuf.Internal.Repository.CrudServices.TrackConfiguration;
using System.Threading.Tasks;


namespace RazManager.App.CrudServices.Entities.TrackConfiguration
{
    [Authorize(Policy = "TenantAdministrator")]
    public class TrackConfigurationService : Razmanager.Protobuf.Internal.Repository.CrudServices.TrackConfiguration.TrackConfigurationService.TrackConfigurationServiceBase
    {
        private readonly Razmanager.Protobuf.Internal.Repository.CrudServices.TrackConfiguration.TrackConfigurationService.TrackConfigurationServiceClient _serviceClient;


        public TrackConfigurationService(Razmanager.Protobuf.Internal.Repository.CrudServices.TrackConfiguration.TrackConfigurationService.TrackConfigurationServiceClient serviceClient)
        {
            _serviceClient = serviceClient;
        }


        public override async Task<TrackConfigurationReadCreateUpdate> Initialize(Empty request, ServerCallContext context)
        {
            return await _serviceClient.InitializeAsync(request);
        }


        public override async Task<TrackConfigurationSelectResponse> Select(Empty request, ServerCallContext context)
        {
            return await _serviceClient.SelectAsync(request);
        }
    }
}
