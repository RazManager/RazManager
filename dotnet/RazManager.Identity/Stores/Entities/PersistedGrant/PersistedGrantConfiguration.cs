using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Identity.Stores.Entities.PersistedGrant
{
    public class PersistedGrantConfiguration : IEntityTypeConfiguration<PersistedGrantEntity>
    {
        public void Configure(EntityTypeBuilder<PersistedGrantEntity> builder)
        {
            builder.HasIndex(x => x.Key).IsUnique();
            builder.HasIndex(x => x.TimeToLiveAt);
        }
    }
}
