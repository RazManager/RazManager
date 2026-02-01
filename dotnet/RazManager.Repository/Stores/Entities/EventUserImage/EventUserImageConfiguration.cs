using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;


namespace RazManager.Repository.Stores.Entities.EventUserImage
{
    public class EventUserImageConfiguration : IEntityTypeConfiguration<EventUserImageEntity>
    {
        public void Configure(EntityTypeBuilder<EventUserImageEntity> builder)
        {
            builder.HasIndex(x => new { x.EventUserId, x.ImageSize }).IsUnique();
            builder.Property(x => x.ImageSize).HasConversion<string>();
        }
    }
}
