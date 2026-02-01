using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Internal.Repository.SystemServices.Device;
using RazManager.Utilities.Exceptions;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Repository.SystemServices.Entities.Device
{
    public class DeviceService : Razmanager.Protobuf.Internal.Repository.SystemServices.Device.DeviceService.DeviceServiceBase
    {
        private readonly Stores.Context.RepositoryDbContext _repositoryDbContext;
        private readonly AutoMapper.IMapper _mapper;


        public DeviceService(Stores.Context.RepositoryDbContext dbContext,
                             AutoMapper.IMapper mapper)
        {
            _repositoryDbContext = dbContext;
            _mapper = mapper;
        }


        public override async Task<DeviceRead> Read(StringValue request, ServerCallContext context)
        {
            var entity = await _repositoryDbContext.Devices
                .Include(x => x.DeviceConfigurations)
                .SingleOrDefaultAsync(x => x.Id == new System.Guid(request.Value));
            if (entity is null)
            {
                throw new NotFoundException();
            }

            var result = new DeviceRead
            {
                Simulated = entity.Simulated
            };
            result.DeviceConfigurationIds.AddRange(entity.DeviceConfigurations.Select(x => x.Id.ToString()));
            return result;
        }
    }
}
