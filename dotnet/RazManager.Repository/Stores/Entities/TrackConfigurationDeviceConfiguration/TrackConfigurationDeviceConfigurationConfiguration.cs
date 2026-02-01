using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.TrackConfigurationDeviceConfiguration
{
    public class TrackConfigurationDeviceConfigurationConfiguration : IEntityTypeConfiguration<TrackConfigurationDeviceConfigurationEntity>
    {
        public void Configure(EntityTypeBuilder<TrackConfigurationDeviceConfigurationEntity> builder)
        {
            builder.HasIndex(x => new { x.TrackConfigurationId, x.DeviceConfigurationId }).IsUnique();
            builder.HasIndex(x => new { x.DeviceConfigurationId, x.TrackConfigurationId }).IsUnique();

        //    builder.HasOne(x => x.TrackConfiguration)
        //           .WithMany(x => x.TrackConfigurationDeviceConfigurations)
        //           .OnDelete(DeleteBehavior.ClientCascade);

        //    builder.HasOne(x => x.DeviceConfiguration)
        //           .WithMany(x => x.TrackConfigurationDeviceConfigurations)
        //           .OnDelete(DeleteBehavior.ClientCascade);
        }
    }
}
