using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Internal.Repository.UserServices.EventInvite;
using RazManager.Repository.Stores.Utilities;
using RazManager.Repository.Utilities;
using System;
using System.ComponentModel.DataAnnotations;
using System.Threading.Tasks;


namespace RazManager.Repository.UserServices.Entities.EventInvite
{
    [Authorize]
    public class EventInviteService : Razmanager.Protobuf.Internal.Repository.UserServices.EventInvite.EventInviteService.EventInviteServiceBase
    {
        private readonly Stores.Context.RepositoryDbContext _repositoryDbContext;
        private readonly IHttpContextOptions _httpContextOptions;


        public EventInviteService(Stores.Context.RepositoryDbContext dbContext,
                                   IHttpContextOptions httpContextOptions)
        {
            _repositoryDbContext = dbContext;
            _httpContextOptions = httpContextOptions;
        }


        public override async Task<Empty> Create(EventInviteCreate request, ServerCallContext context)
        {
            var now = DateTime.UtcNow;
            var eventInvitate = await _repositoryDbContext.EventInvites.AsTracking().SingleOrDefaultAsync(x => x.Code == request.Code && x.TimeToLiveAt > now);

            if (eventInvitate is null)
            {
                throw new ValidationException(ExceptionMessages.InvitationCodeNotValid);
            }

            if (await _repositoryDbContext.EventUsers.AnyAsync(x => x.EventId == eventInvitate.EventId && x.UserId == _httpContextOptions.UserId))
            {
                throw new ValidationException(ExceptionMessages.EventInviteExistingUser);
            }

            _repositoryDbContext.EventUsers.Add(new Stores.Entities.EventUser.EventUserEntity
            {
                EventId = eventInvitate.EventId,
                UserId = _httpContextOptions.UserId,
                EventUserTypeId = request.EventUserTypeId
            });

            if (!eventInvitate.Multiple)
            {
                _repositoryDbContext.EventInvites.Remove(eventInvitate);
            }

            await _repositoryDbContext.SaveChangesAsync();

            return new Empty();
        }
    }
}
