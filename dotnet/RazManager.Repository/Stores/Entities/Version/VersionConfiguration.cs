using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.Version
{
    public class VersionConfiguration : IEntityTypeConfiguration<VersionEntity>
    {
        public void Configure(EntityTypeBuilder<VersionEntity> builder)
        {
            builder.HasIndex(x => new { x.Major, x.Minor, x.Patch }).IsUnique();
        }
    }
}