using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Public.V1;
using RazManager.Repository.Utilities;
using System;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Repository.PublicServices.Entities.Heat
{
    public class HeatService : Razmanager.Protobuf.Public.V1.HeatWithoutStintsService.HeatWithoutStintsServiceBase
    {
        private readonly Stores.Context.RepositoryDbContext _repositoryDbContext;
        private readonly IHttpContextOptions _httpContextOptions;


        public HeatService(Stores.Context.RepositoryDbContext dbContext,
                            IHttpContextOptions httpContextOptions)
        {
            _repositoryDbContext = dbContext;
            _httpContextOptions = httpContextOptions;
        }


        public override async Task<DetailCommandPermissions> CommandPermissions(StringValue request, ServerCallContext context)
        {
            var result = new DetailCommandPermissions();

            var entity = await _repositoryDbContext.HeatWithoutStints
                .SingleOrDefaultAsync(x => (x.Id == new Guid(request.Value) &&
                                       (x.Race.Event.Tenant.TenantUsers.Any(x => x.UserId == _httpContextOptions.UserId && x.Administrator))))
                .ConfigureAwait(false);
            if (entity != null)
            {
                result.Items.AddRange(System.Enum.GetValues<DetailCommandTypeId>());
            }

            return result;
        }
    }
}
