using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;


namespace RazManager.Repository.Stores.Entities.AutopilotImage
{
    public class AutopilotImageConfiguration : IEntityTypeConfiguration<AutopilotImageEntity>
    {
        public void Configure(EntityTypeBuilder<AutopilotImageEntity> builder)
        {
            builder.HasIndex(x => new { x.AutopilotId, x.ImageSize }).IsUnique();
            builder.Property(x => x.ImageSize).HasConversion<string>();
        }
    }
}
