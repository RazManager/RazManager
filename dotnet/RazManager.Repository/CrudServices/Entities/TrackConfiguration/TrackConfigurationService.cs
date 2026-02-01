using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Track;
using Razmanager.Protobuf.Internal.Repository.CrudServices.TrackConfiguration;
using RazManager.Repository.CrudServices.Utilities;
using RazManager.Repository.Stores.Entities.TrackConfiguration;
using RazManager.Repository.Utilities;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Repository.CrudServices.Entities.TrackConfiguration
{

    [Authorize]
    public class TrackConfigurationService : Razmanager.Protobuf.Internal.Repository.CrudServices.TrackConfiguration.TrackConfigurationService.TrackConfigurationServiceBase
    {
        private readonly Stores.Context.RepositoryDbContext _repositoryDbContext;
        private readonly IHttpContextOptions _httpContextOptions;
        private readonly AutoMapper.IMapper _mapper;


        public TrackConfigurationService(Stores.Context.RepositoryDbContext dbContext,
                                         IHttpContextOptions httpContextOptions,
                                         AutoMapper.IMapper mapper)
        {
            _repositoryDbContext = dbContext;
            _httpContextOptions = httpContextOptions;
            _mapper = mapper;
        }


        public override Task<TrackConfigurationReadCreateUpdate> Initialize(Empty request, ServerCallContext context)
        {
            return Task.FromResult(_mapper.Map<TrackConfigurationReadCreateUpdate>(new TrackConfigurationEntity()));
        }


        public override async Task<TrackConfigurationSelectResponse> Select(Empty request, ServerCallContext context)
        {
            var response = _repositoryDbContext.TrackConfigurations
                .Include(x => x.Track)
                .Include(x => x.TrackConfigurationRaceFormats)
                .Include(x => x.TrackConfigurationIndicators)
                .Include(x => x.TrackConfigurationDeviceConfigurations).ThenInclude(x => x.DeviceConfiguration).ThenInclude(x => x.DeviceConfigurationInputs)
                .Where(x => x.Track.TenantId == _httpContextOptions.TenantId)
                .OrderBy(x => x.Track.Name).ThenBy(x => x.Name)
                .AsAsyncEnumerable()
                .ConfigureAwait(false);

            var result = new TrackConfigurationSelectResponse();
            await foreach (var entity in response)
            {
                var proto = _mapper.Map<TrackConfigurationSelect>(entity);
                result.Result.Add(proto);
            }
            return result;
        }
    }
}
