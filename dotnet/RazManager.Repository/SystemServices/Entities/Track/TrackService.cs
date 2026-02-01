using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Internal.Repository.SystemServices.Track;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Repository.SystemServices.Entities.Track
{
    public class TrackService : Razmanager.Protobuf.Internal.Repository.SystemServices.Track.TrackService.TrackServiceBase
    {
        private readonly Stores.Context.RepositoryDbContext _repositoryDbContext;
        private readonly AutoMapper.IMapper _mapper;


        public TrackService(Stores.Context.RepositoryDbContext dbContext,
                            AutoMapper.IMapper mapper)
        {
            _repositoryDbContext = dbContext;
            _mapper = mapper;
        }


        public override async Task<TrackRead> Read(StringValue request, ServerCallContext context)
        {
            var trackConfigurations = await _repositoryDbContext.TrackConfigurations
                .Where(x => x.TrackId == new System.Guid(request.Value))
                .ToListAsync()
                .ConfigureAwait(false);

            var result = new TrackRead();
            result.TrackConfigurationIds.AddRange(trackConfigurations.Select(x => x.Id.ToString()));
            return result;
        }
    }
}
