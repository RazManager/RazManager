using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.Autopilot
{
    public class AutopilotConfiguration : IEntityTypeConfiguration<AutopilotEntity>
    {
        public void Configure(EntityTypeBuilder<AutopilotEntity> builder)
        {
            builder.HasIndex(x => new { x.TrackConfigurationId, x.Name }).IsUnique();
        }
    }
}
