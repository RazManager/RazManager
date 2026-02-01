using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.TrackConfiguration
{
    public class TrackConfigurationConfiguration : IEntityTypeConfiguration<TrackConfigurationEntity>
    {
        public void Configure(EntityTypeBuilder<TrackConfigurationEntity> builder)
        {
            builder.HasIndex(x => new { x.TrackId, x.Name }).IsUnique();
        }
    }
}
