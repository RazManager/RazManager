using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.TrackConfigurationIndicator
{
    public class TrackConfigurationIndicatorConfiguration : IEntityTypeConfiguration<TrackConfigurationIndicatorEntity>
    {
        public void Configure(EntityTypeBuilder<TrackConfigurationIndicatorEntity> builder)
        {
            builder.HasIndex(x => new { x.TrackConfigurationId, x.IndicatorId }).IsUnique();
        }
    }
}
