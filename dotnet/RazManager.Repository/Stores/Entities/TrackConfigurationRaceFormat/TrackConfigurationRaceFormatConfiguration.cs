using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.TrackConfigurationRaceFormat
{
    public class TrackConfigurationRaceFormatConfiguration : IEntityTypeConfiguration<TrackConfigurationRaceFormatEntity>
    {
        public void Configure(EntityTypeBuilder<TrackConfigurationRaceFormatEntity> builder)
        {
            builder.HasIndex(x => new { x.TrackConfigurationId, x.RaceFormatTypeId }).IsUnique();
            builder.Property(x => x.RaceFormatTypeId).HasConversion<string>();
        }
    }
}
