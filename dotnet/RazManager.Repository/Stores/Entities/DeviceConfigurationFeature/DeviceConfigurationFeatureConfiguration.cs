using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.DeviceConfigurationFeature
{
    public class DeviceConfigurationFeatureConfiguration : IEntityTypeConfiguration<DeviceConfigurationFeatureEntity>
    {
        public void Configure(EntityTypeBuilder<DeviceConfigurationFeatureEntity> builder)
        {
            builder.HasIndex(x => new { x.DeviceConfigurationId, x.DeviceConfigurationFeatureTypeId }).IsUnique();
            builder.Property(x => x.DeviceConfigurationFeatureTypeId).HasConversion<string>();
        }
    }
}
