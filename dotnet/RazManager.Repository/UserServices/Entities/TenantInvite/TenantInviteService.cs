using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Internal.Repository.UserServices.TenantInvite;
using RazManager.Repository.Stores.Utilities;
using RazManager.Repository.Utilities;
using System;
using System.ComponentModel.DataAnnotations;
using System.Threading.Tasks;


namespace RazManager.Repository.UserServices.Entities.TenantInvite
{
    [Authorize]
    public class TenantInviteService : Razmanager.Protobuf.Internal.Repository.UserServices.TenantInvite.TenantInviteService.TenantInviteServiceBase
    {
        private readonly Stores.Context.RepositoryDbContext _repositoryDbContext;
        private readonly IHttpContextOptions _httpContextOptions;


        public TenantInviteService(Stores.Context.RepositoryDbContext dbContext,
                                   IHttpContextOptions httpContextOptions)
        {
            _repositoryDbContext = dbContext;
            _httpContextOptions = httpContextOptions;
        }


        public override async Task<Empty> Create(TenantInviteCreate request, ServerCallContext context)
        {
            var now = DateTime.UtcNow;
            var tenantInvitate = await _repositoryDbContext.TenantInvites.AsTracking().SingleOrDefaultAsync(x => x.Code == request.Code && x.TimeToLiveAt > now);

            if (tenantInvitate is null)
            {
                throw new ValidationException(ExceptionMessages.InvitationCodeNotValid);
            }

            if (await _repositoryDbContext.TenantUsers.AnyAsync(x => x.TenantId == tenantInvitate.TenantId && x.UserId == _httpContextOptions.UserId))
            {
                throw new ValidationException(ExceptionMessages.TenantInviteExistingUser);
            }

            _repositoryDbContext.TenantUsers.Add(new Stores.Entities.TenantUser.TenantUserEntity
            {
                TenantId = tenantInvitate.TenantId,
                UserId = _httpContextOptions.UserId
            });

            if (!tenantInvitate.Multiple)
            {
                _repositoryDbContext.TenantInvites.Remove(tenantInvitate);
            }

            await _repositoryDbContext.SaveChangesAsync();

            return new Empty();
        }
    }
}
