using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;


namespace RazManager.Repository.Stores.Entities.DeviceConfigurationInput
{
    public class DeviceConfigurationInputConfiguration : IEntityTypeConfiguration<DeviceConfigurationInputEntity>
    {
        public void Configure(EntityTypeBuilder<DeviceConfigurationInputEntity> builder)
        {
            builder.Property(x => x.DeviceConfigurationInputTypeId).HasConversion<string>();
        }
    }

}
