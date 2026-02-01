using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;


namespace RazManager.Repository.Stores.Entities.TenantImage
{
    public class TenantImageConfiguration : IEntityTypeConfiguration<TenantImageEntity>
    {
        public void Configure(EntityTypeBuilder<TenantImageEntity> builder)
        {
            builder.HasIndex(x => new { x.TenantId, x.ImageSize }).IsUnique();
            builder.Property(x => x.ImageSize).HasConversion<string>();
        }
    }
}
