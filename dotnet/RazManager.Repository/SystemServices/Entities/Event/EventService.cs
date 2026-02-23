using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.EntityFrameworkCore;
using RazManager.Utilities.Exceptions;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Repository.SystemServices.Entities.Event
{
    public class EventService : Razmanager.Protobuf.Internal.Repository.SystemServices.Event.EventService.EventServiceBase
    {
        private readonly Stores.Context.RepositoryDbContext _repositoryDbContext;
        private readonly AutoMapper.IMapper _mapper;


        public EventService(Stores.Context.RepositoryDbContext dbContext,
                            AutoMapper.IMapper mapper)
        {
            _repositoryDbContext = dbContext;
            _mapper = mapper;
        }


        public override async Task<Razmanager.Protobuf.Public.V1.Event> Read(StringValue request, ServerCallContext context)
        {
            var entity = await _repositoryDbContext.Events
                .Include(x => x.EventImages.Where(x => x.ImageSize == Stores.Utilities.ImageSize.Avatar))
                .Include(x => x.EventUsers)
                    .ThenInclude(x => x.EventUserImages.Where(x => x.ImageSize == Stores.Utilities.ImageSize.Avatar))
                .Include(x => x.EventUsers)
                    .ThenInclude(x => x.User).ThenInclude(x => x.UserImages.Where(x => x.ImageSize == Stores.Utilities.ImageSize.Avatar))
                .Include(x => x.EventUsers)
                    .ThenInclude(x => x.Autopilot).ThenInclude(x => x.AutopilotImages.Where(x => x.ImageSize == Stores.Utilities.ImageSize.Avatar))
                .Include(x => x.Races.OrderBy(x => x.Number))
                .AsSplitQuery()
                .SingleOrDefaultAsync(x => x.Id == new System.Guid(request.Value));
            if (entity is null)
            {
                throw new NotFoundException();
            }

            var result = _mapper.Map<Razmanager.Protobuf.Public.V1.Event>(entity);

            foreach (var eventUserEntity in entity.EventUsers.Where(x => x.EventUserId is null))
            {
                var eventUserProto = _mapper.Map<Razmanager.Protobuf.Public.V1.EventUser>(eventUserEntity);
                foreach (var teamUserEntity in entity.EventUsers.Where(x => x.EventUserId == eventUserEntity.Id))
                {
                    eventUserProto.TeamUsers.Add(_mapper.Map<Razmanager.Protobuf.Public.V1.TeamUser>(teamUserEntity));
                }
                result.EventUsers.Add(eventUserProto);
            }

            return result;
        }
    }
}