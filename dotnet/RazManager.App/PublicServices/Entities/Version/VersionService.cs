using Grpc.Core;
using Orleans;
using Razmanager.Protobuf.Public.V1;
using System.Threading.Tasks;


namespace RazManager.App.PublicServices.Entities.Version
{
    public class VersionService : Razmanager.Protobuf.Public.V1.VersionService.VersionServiceBase
    {
        private readonly Razmanager.Protobuf.Public.V1.VersionService.VersionServiceClient _serviceClient;
        private readonly IClusterClient _clusterClient;


        public VersionService(Razmanager.Protobuf.Public.V1.VersionService.VersionServiceClient serviceClient,
                           Orleans.IClusterClient clusterClient)
        {
            _serviceClient = serviceClient;
            _clusterClient = clusterClient;
        }

        public override async Task<VersionAllResponse> All(VersionAllRequest request, ServerCallContext context)
        {
            return await _serviceClient.AllAsync(request);
        }


        public override async Task<VersionNewerResponse> Newer(VersionNewerRequest request, ServerCallContext context)
        {
            return await _serviceClient.NewerAsync(request);
        }
    }
}
