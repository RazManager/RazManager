using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Internal.Repository.CrudServices.DeviceConfiguration;
using RazManager.Repository.Utilities;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Repository.CrudServices.Entities.DeviceConfiguration
{
    [Authorize]
    public class DeviceConfigurationService : Razmanager.Protobuf.Internal.Repository.CrudServices.DeviceConfiguration.DeviceConfigurationService.DeviceConfigurationServiceBase
    {
        private readonly Stores.Context.RepositoryDbContext _repositoryDbContext;
        private readonly IHttpContextOptions _httpContextOptions;
        private readonly AutoMapper.IMapper _mapper;


        public DeviceConfigurationService(Stores.Context.RepositoryDbContext dbContext,
                                          IHttpContextOptions httpContextOptions,
                                          AutoMapper.IMapper mapper)
        {
            _repositoryDbContext = dbContext;
            _httpContextOptions = httpContextOptions;
            _mapper = mapper;
        }


        public override async Task<DeviceConfigurationSelectResponse> Select(Empty request, ServerCallContext context)
        {
            var result = new DeviceConfigurationSelectResponse();

            var response = _repositoryDbContext.DeviceConfigurations
                .Include(x => x.Device)
                .Where(x => x.Device.TenantId == _httpContextOptions.TenantId)
                .OrderBy(x => x.Device.Name).ThenBy(x => x.Name)
                .AsAsyncEnumerable()
                .ConfigureAwait(false);

            await foreach (var entity in response)
            {
                var proto = _mapper.Map<DeviceConfigurationSelect>(entity);
                result.Result.Add(proto);
            }

            return result;
        }
    }

}
