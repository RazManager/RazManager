using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.VersionPlatform
{
    public class VersionPlatformConfiguration : IEntityTypeConfiguration<VersionPlatformEntity>
    {
        public void Configure(EntityTypeBuilder<VersionPlatformEntity> builder)
        {
            builder.HasIndex(x => new { x.VersionId, x.VersionPlatformId }).IsUnique();
            builder.Property(x => x.VersionPlatformId).HasConversion<string>();
        }
    }
}