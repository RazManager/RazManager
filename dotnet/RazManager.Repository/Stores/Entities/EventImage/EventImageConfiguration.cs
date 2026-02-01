using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;


namespace RazManager.Repository.Stores.Entities.EventImage
{
    public class EventImageConfiguration : IEntityTypeConfiguration<EventImageEntity>
    {
        public void Configure(EntityTypeBuilder<EventImageEntity> builder)
        {
            builder.HasIndex(x => new { x.EventId, x.ImageSize }).IsUnique();
            builder.Property(x => x.ImageSize).HasConversion<string>();
        }
    }
}
