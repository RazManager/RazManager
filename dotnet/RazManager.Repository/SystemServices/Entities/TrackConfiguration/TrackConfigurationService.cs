using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Internal.Repository.SystemServices.TrackConfiguration;
using RazManager.Utilities.Exceptions;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Repository.SystemServices.Entities.TrackConfiguration
{
    public class TrackConfigurationService : Razmanager.Protobuf.Internal.Repository.SystemServices.TrackConfiguration.TrackConfigurationService.TrackConfigurationServiceBase
    {
        private readonly Stores.Context.RepositoryDbContext _repositoryDbContext;
        private readonly AutoMapper.IMapper _mapper;


        public TrackConfigurationService(Stores.Context.RepositoryDbContext dbContext,
                                         AutoMapper.IMapper mapper)
        {
            _repositoryDbContext = dbContext;
            _mapper = mapper;
        }


        public override async Task<TrackConfigurationRead> Read(StringValue request, ServerCallContext context)
        {
            var entity = await _repositoryDbContext.TrackConfigurations
                .Include(x => x.TrackConfigurationDeviceConfigurations)
                .SingleOrDefaultAsync(x => x.Id == new System.Guid(request.Value));
            if (entity is null)
            {
                throw new NotFoundException();
            }

            return _mapper.Map<TrackConfigurationRead>(entity);
        }
    }
}
