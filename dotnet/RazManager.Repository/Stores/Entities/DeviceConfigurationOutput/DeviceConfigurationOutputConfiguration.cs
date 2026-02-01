using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;


namespace RazManager.Repository.Stores.Entities.DeviceConfigurationOutput
{
    public class DeviceConfigurationOutputConfiguration : IEntityTypeConfiguration<DeviceConfigurationOutputEntity>
    {
        public void Configure(EntityTypeBuilder<DeviceConfigurationOutputEntity> builder)
        {
            builder.Property(x => x.DeviceConfigurationOutputTypeId).HasConversion<string>();
        }
    }
}
