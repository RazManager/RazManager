using Grpc.Core;
using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Public.V1;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Repository.PublicServices.Entities.Version
{
    public class VersionService : Razmanager.Protobuf.Public.V1.VersionService.VersionServiceBase
    {
        private readonly Stores.Context.RepositoryDbContext _repositoryDbContext;
        private readonly AutoMapper.IMapper _mapper;


        public VersionService(Stores.Context.RepositoryDbContext dbContext,
                              AutoMapper.IMapper mapper)
        {
            _repositoryDbContext = dbContext;
            _mapper = mapper;
        }


        public override async Task<VersionAllResponse> All(VersionAllRequest request, ServerCallContext context)
        {
            var result = new VersionAllResponse();
            var response = await _repositoryDbContext.Versions
                .Include(x => x.VersionNotes.OrderBy(x => x.Position))
                .Include(x => x.VersionPlatforms)
                .Where(x => x.VersionPlatforms.Any(x => x.VersionPlatformId == request.VersionPlatformId || x.VersionPlatformId == VersionPlatformId.Server))
                .OrderByDescending(x => x.Major)
                .ThenByDescending(x => x.Minor)
                .ThenByDescending(x => x.Patch)
                .ToListAsync()
                .ConfigureAwait(false);
            result.Result.AddRange(response.Select(x => _mapper.Map<Razmanager.Protobuf.Public.V1.Version>(x)));
            return result;
        }


        public override async Task<VersionNewerResponse> Newer(VersionNewerRequest request, ServerCallContext context)
        {
            var result = new VersionNewerResponse();
            var response = await _repositoryDbContext.Versions
                .Include(x => x.VersionNotes.OrderBy(x => x.Position))
                .Include(x => x.VersionPlatforms)
                .Where(x => (x.Major > request.ConfirmedVersionMajor || (x.Major == request.ConfirmedVersionMajor && x.Minor >= request.ConfirmedVersionMinor)) &&
                            (x.Major != request.ConfirmedVersionMajor || x.Minor != request.ConfirmedVersionMinor || x.Patch != request.ConfirmedVersionPatch) &&
                            x.VersionPlatforms.Any(x => x.VersionPlatformId == request.VersionPlatformId || x.VersionPlatformId == VersionPlatformId.Server))
                .OrderByDescending(x => x.Major)
                .ThenByDescending(x => x.Minor)
                .ThenByDescending(x => x.Patch)
                .ToListAsync()
                .ConfigureAwait(false);
            result.Result.AddRange(response.Select(x => _mapper.Map<Razmanager.Protobuf.Public.V1.Version>(x)));

            var entity = await _repositoryDbContext.Versions
                .SingleOrDefaultAsync(x => x.Major == request.CurrentVersionMajor && x.Minor == request.CurrentVersionMinor && x.Patch == request.CurrentVersionPatch)
                .ConfigureAwait(false);
            if (entity != null)
            {
                result.CurrentVersionValid = entity.Valid;
            }

            return result;
        }
    }
}
