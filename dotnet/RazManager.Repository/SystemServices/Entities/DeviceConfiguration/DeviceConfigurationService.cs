using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Internal.Repository.SystemServices.DeviceConfiguration;
using RazManager.Utilities.Exceptions;
using System.Threading.Tasks;


namespace RazManager.Repository.SystemServices.Entities.DeviceConfiguration
{
    public class DeviceConfigurationService : Razmanager.Protobuf.Internal.Repository.SystemServices.DeviceConfiguration.DeviceConfigurationService.DeviceConfigurationServiceBase
    {
        private readonly Stores.Context.RepositoryDbContext _repositoryDbContext;
        private readonly AutoMapper.IMapper _mapper;


        public DeviceConfigurationService(Stores.Context.RepositoryDbContext dbContext,
                                          AutoMapper.IMapper mapper)
        {
            _repositoryDbContext = dbContext;
            _mapper = mapper;
        }


        public override async Task<DeviceConfigurationRead> Read(StringValue request, ServerCallContext context)
        {
            var entity = await _repositoryDbContext.DeviceConfigurations
                .Include(x => x.DeviceConfigurationInputs)
                .Include(x => x.DeviceConfigurationOutputs)
                .Include(x => x.TrackConfigurationDeviceConfigurations)
                .SingleOrDefaultAsync(x => x.Id == new System.Guid(request.Value));
            if (entity is null)
            {
                throw new NotFoundException();
            }

            return _mapper.Map<DeviceConfigurationRead>(entity);
        }
    }
}
