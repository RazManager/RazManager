using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.DeviceConfiguration
{
    public class DeviceConfigurationConfiguration : IEntityTypeConfiguration<DeviceConfigurationEntity>
    {
        public void Configure(EntityTypeBuilder<DeviceConfigurationEntity> builder)
        {
            builder.HasIndex(x => new { x.DeviceId, x.Name }).IsUnique();
        }
    }
}
