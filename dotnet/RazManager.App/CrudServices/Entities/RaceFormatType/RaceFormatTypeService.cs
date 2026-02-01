using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Razmanager.Protobuf.Internal.Repository.CrudServices.RaceFormatType;
using System.Threading.Tasks;


namespace RazManager.App.CrudServices.Entities.RaceFormatType
{
    [Authorize(Policy = "TenantAdministrator")]
    public class RaceFormatTypeService : Razmanager.Protobuf.Internal.Repository.CrudServices.RaceFormatType.RaceFormatTypeService.RaceFormatTypeServiceBase
    {
        private readonly Razmanager.Protobuf.Internal.Repository.CrudServices.RaceFormatType.RaceFormatTypeService.RaceFormatTypeServiceClient _serviceClient;


        public RaceFormatTypeService(Razmanager.Protobuf.Internal.Repository.CrudServices.RaceFormatType.RaceFormatTypeService.RaceFormatTypeServiceClient serviceClient)
        {
            _serviceClient = serviceClient;
        }


        public override async Task<RaceFormatTypeSelectResponse> Select(Empty request, ServerCallContext context)
        {
            return await _serviceClient.SelectAsync(request);
        }
    }
}
