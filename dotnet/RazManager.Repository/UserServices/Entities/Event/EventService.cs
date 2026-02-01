using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Internal.Repository.UserServices.Event;
using RazManager.Repository.Stores.Utilities;
using RazManager.Repository.Utilities;
using System;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Repository.UserServices.Entities.Event
{
    public class EventService : Razmanager.Protobuf.Internal.Repository.UserServices.Event.EventService.EventServiceBase
    {
        private readonly Stores.Context.RepositoryDbContext _repositoryDbContext;
        private readonly AutoMapper.IMapper _mapper;
        private readonly IHttpContextOptions _httpContextOptions;


        public EventService(Stores.Context.RepositoryDbContext dbContext,
                            AutoMapper.IMapper mapper,
                            IHttpContextOptions httpContextOptions)
        {
            _repositoryDbContext = dbContext;
            _mapper = mapper;
            _httpContextOptions = httpContextOptions;
        }


        public override async Task<EventSelectResponse> Select(Empty request, ServerCallContext context)
        {
            var result = new EventSelectResponse();

            var now = DateTimeOffset.UtcNow;
            var entities = _repositoryDbContext.Events
                .Include(x => x.EventImages.Where(x => x.ImageSize == ImageSize.Avatar))
                .Include(x => x.Tenant).ThenInclude(x => x.TenantImages.Where(x => x.ImageSize == ImageSize.Avatar))
                .Where(x => (x.PublishFrom <= now || x.PublishFrom == null) &&
                             x.TimeToLiveAt >= now &&
                             (x.EventVisibilityTypeId == Razmanager.Protobuf.Internal.Repository.CrudServices.Event.EventVisibilityTypeId.Public ||
                              (x.EventVisibilityTypeId == Razmanager.Protobuf.Internal.Repository.CrudServices.Event.EventVisibilityTypeId.MembersAndGuests && (x.EventUsers.Any(x => x.UserId == _httpContextOptions.UserId) || x.Tenant.TenantUsers.Any(x => x.UserId == _httpContextOptions.UserId)))))
                .OrderBy(x => x.StartsAt)
                .AsAsyncEnumerable()
                .ConfigureAwait(false);

            await foreach (var entity in entities)
            {
                var proto = _mapper.Map<EventSelect>(entity);
                result.Result.Add(proto);
            }

            return result;
        }
    }
}
