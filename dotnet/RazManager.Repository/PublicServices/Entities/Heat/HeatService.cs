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
    public class HeatService : Razmanager.Protobuf.Public.V1.HeatService.HeatServiceBase
    {
        private readonly Stores.Context.RepositoryDbContext _repositoryDbContext;
        private readonly AutoMapper.IMapper _mapper;
        private readonly IHttpContextOptions _httpContextOptions;


        public HeatService(Stores.Context.RepositoryDbContext dbContext,
                            AutoMapper.IMapper mapper,
                            IHttpContextOptions httpContextOptions)
        {
            _repositoryDbContext = dbContext;
            _mapper = mapper;
            _httpContextOptions = httpContextOptions;
        }


        public override async Task<HeatCommandPermissions> CommandPermissions(StringValue request, ServerCallContext context)
        {
            var result = new HeatCommandPermissions();

            var entity = await _repositoryDbContext.Heats
                .SingleOrDefaultAsync(x => (x.Id == new Guid(request.Value) &&
                                       (x.Race.Event.Tenant.TenantUsers.Any(x => x.UserId == _httpContextOptions.UserId && x.Administrator))))
                .ConfigureAwait(false);
            if (entity != null)
            {
                result.Items.AddRange(System.Enum.GetValues<HeatCommandTypeId>());
            }

            return result;
        }
    }
}
