using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Public.V1;
using RazManager.Repository.Utilities;
using System;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Repository.PublicServices.Entities.Race
{
    public class RaceService : Razmanager.Protobuf.Public.V1.RaceService.RaceServiceBase
    {
        private readonly Stores.Context.RepositoryDbContext _repositoryDbContext;
        private readonly IHttpContextOptions _httpContextOptions;


        public RaceService(Stores.Context.RepositoryDbContext dbContext,
                            IHttpContextOptions httpContextOptions)
        {
            _repositoryDbContext = dbContext;
            _httpContextOptions = httpContextOptions;
        }


        public override async Task<SummaryCommandPermissions> CommandPermissions(StringValue request, ServerCallContext context)
        {
            var result = new SummaryCommandPermissions();

            var entity = await _repositoryDbContext.Races
                .SingleOrDefaultAsync(x => (x.Id == new Guid(request.Value) &&
                                       (x.Event.Tenant.TenantUsers.Any(x => x.UserId == _httpContextOptions.UserId && x.Administrator))))
                .ConfigureAwait(false);
            if (entity != null)
            {
                result.Items.AddRange(System.Enum.GetValues<SummaryCommandTypeId>());
            }

            return result;
        }
    }
}
