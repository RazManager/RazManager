using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Razmanager.Protobuf.Internal.Repository.CrudServices.RaceFormatType;
using System.Threading.Tasks;


namespace RazManager.Repository.CrudServices.Entities.RaceFormatType
{
    [Authorize]
    public class RaceFormatTypeService : Razmanager.Protobuf.Internal.Repository.CrudServices.RaceFormatType.RaceFormatTypeService.RaceFormatTypeServiceBase
    {
        public override Task<RaceFormatTypeSelectResponse> Select(Empty request, ServerCallContext context)
        {
            var result = new RaceFormatTypeSelectResponse();
            result.Result.AddRange(Resources.Constants.RaceFormatTypes);
            return Task.FromResult(result);
        }
    }
}
