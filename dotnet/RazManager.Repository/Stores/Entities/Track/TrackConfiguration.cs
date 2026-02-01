using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;


namespace RazManager.Repository.Stores.Entities.Track
{
    public class TrackConfiguration : IEntityTypeConfiguration<TrackEntity>
    {
        public void Configure(EntityTypeBuilder<TrackEntity> builder)
        {
            builder.HasIndex(x => new { x.TenantId, x.Name }).IsUnique();
        }
    }
}
