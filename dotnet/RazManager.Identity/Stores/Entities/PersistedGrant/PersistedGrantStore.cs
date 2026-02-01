using Duende.IdentityServer.Stores;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;


namespace RazManager.Identity.Stores.Entities.PersistedGrant
{
    public class PersistedGrantStore : IPersistedGrantStore
    {
        private readonly IServiceScopeFactory _serviceScopeFactory;
        private readonly IClientStore _clientStore;
        private readonly AutoMapper.IMapper _mapper;
        private readonly ILogger<PersistedGrantStore> _logger;

        public PersistedGrantStore(IServiceScopeFactory serviceScopeFactory,
                                   IClientStore clientStore,
                                   AutoMapper.IMapper mapper,
                                   ILogger<PersistedGrantStore> logger)
        {
            _serviceScopeFactory = serviceScopeFactory;
            _clientStore = clientStore;
            _mapper = mapper;
            _logger = logger;
        }


        public Task<IEnumerable<Duende.IdentityServer.Models.PersistedGrant>> GetAllAsync(PersistedGrantFilter filter)
        {
            throw new NotImplementedException();
        }


        public async Task<Duende.IdentityServer.Models.PersistedGrant> GetAsync(string key)
        {
            using (var scope = _serviceScopeFactory.CreateScope())
            {
                var dbContext = scope.ServiceProvider.GetRequiredService<Context.IdentityDbContext>();
                var entity = await dbContext.PersistedGrants.SingleOrDefaultAsync(x => x.Key == key).ConfigureAwait(false);
                if (entity is null)
                {
                    _logger.LogError($"Cannot find a PersistedGrant with key={key}");
                    return new Duende.IdentityServer.Models.PersistedGrant { Key = key };
                }

                return entity;
            }
        }


        public Task RemoveAllAsync(PersistedGrantFilter filter)
        {
            throw new NotImplementedException();
        }


        public async Task RemoveAsync(string key)
        {
            using (var scope = _serviceScopeFactory.CreateScope())
            {
                var dbContext = scope.ServiceProvider.GetRequiredService<Context.IdentityDbContext>();
                var entity = await dbContext.PersistedGrants.AsTracking().SingleOrDefaultAsync(x => x.Key == key).ConfigureAwait(false);
                if (entity is not null)
                {
                    dbContext.Remove(entity);
                    await dbContext.SaveChangesAsync();
                }
            }
        }


        public async Task StoreAsync(Duende.IdentityServer.Models.PersistedGrant grant)
        {
            var client = await _clientStore.FindClientByIdAsync(grant.ClientId);

            using (var scope = _serviceScopeFactory.CreateScope())
            {
                var dbContext = scope.ServiceProvider.GetRequiredService<Context.IdentityDbContext>();

                var entity = await dbContext.PersistedGrants.AsTracking().SingleOrDefaultAsync(x => x.Key == grant.Key);
                if (entity is null)
                {
                    entity = new PersistedGrantEntity();
                    dbContext.Add(entity);
                }

                _mapper.Map(grant, entity);
                switch (grant.Type)
                {
                    case "authorization_code":
                        entity.TimeToLiveAt = DateTime.UtcNow.AddSeconds(client.AuthorizationCodeLifetime);
                        break;

                    case "refresh_token":
                        entity.TimeToLiveAt = DateTime.UtcNow.AddSeconds(client.AbsoluteRefreshTokenLifetime);
                        break;

                    default:
                        throw new NotImplementedException($"No time to live specified for {grant.Type}.");
                }

                await dbContext.SaveChangesAsync();
            }
        }
    }
}