using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Razmanager.Protobuf.Internal.Repository.UserServices.HeatIndicator;
using System.Threading.Tasks;


namespace RazManager.App.UserServices.Entities.HeatIndicator
{
    public class HeatIndicatorService : Razmanager.Protobuf.Internal.Repository.UserServices.HeatIndicator.HeatIndicatorService.HeatIndicatorServiceBase
    {
        private readonly Razmanager.Protobuf.Internal.Repository.UserServices.HeatIndicator.HeatIndicatorService.HeatIndicatorServiceClient _serviceClient;


        public HeatIndicatorService(Razmanager.Protobuf.Internal.Repository.UserServices.HeatIndicator.HeatIndicatorService.HeatIndicatorServiceClient serviceClient)
        {
            _serviceClient = serviceClient;
        }


        public override async Task<HeatIndicatorRead> Read(StringValue request, ServerCallContext context)
        {
            return await _serviceClient.ReadAsync(request);
        }
    }
}
