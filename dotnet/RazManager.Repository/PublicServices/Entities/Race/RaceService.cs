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
        private readonly AutoMapper.IMapper _mapper;
        private readonly IHttpContextOptions _httpContextOptions;


        public RaceService(Stores.Context.RepositoryDbContext dbContext,
                            AutoMapper.IMapper mapper,
                            IHttpContextOptions httpContextOptions)
        {
            _repositoryDbContext = dbContext;
            _mapper = mapper;
            _httpContextOptions = httpContextOptions;
        }


        public override async Task<RaceCommandPermissions> CommandPermissions(StringValue request, ServerCallContext context)
        {
            var result = new RaceCommandPermissions();

            var entity = await _repositoryDbContext.Races
                .SingleOrDefaultAsync(x => (x.Id == new Guid(request.Value) &&
                                       (x.Event.Tenant.TenantUsers.Any(x => x.UserId == _httpContextOptions.UserId && x.Administrator))))
                .ConfigureAwait(false);
            if (entity != null)
            {
                result.Items.AddRange(System.Enum.GetValues<RaceCommandTypeId>());
            }

            return result;
        }
    }
}
