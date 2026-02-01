using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;


namespace RazManager.Repository.Stores.Entities.TrackImage
{
    public class TrackImageConfiguration : IEntityTypeConfiguration<TrackImageEntity>
    {
        public void Configure(EntityTypeBuilder<TrackImageEntity> builder)
        {
            builder.HasIndex(x => new { x.TrackId, x.ImageSize }).IsUnique();
            builder.Property(x => x.ImageSize).HasConversion<string>();
        }
    }
}
