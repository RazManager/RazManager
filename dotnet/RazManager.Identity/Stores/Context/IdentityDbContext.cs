using Microsoft.EntityFrameworkCore;


namespace RazManager.Identity.Stores.Context
{
    public class IdentityDbContext : RazManager.Utilities.EntityFramework.DbContextBase<IdentityDbContext>
    {
        public IdentityDbContext(DbContextOptions<IdentityDbContext> options) : base(options) { }

        //public DbSet<Store.Entities.DistributedCache.DistributedCacheEntity> DistributedCaches { get; set; }
        public DbSet<Entities.PersistedGrant.PersistedGrantEntity> PersistedGrants { get; set; }
        public DbSet<Entities.XmlRepository.XmlRepositoryEntity> XmlRepositories { get; set; }
    }
}
