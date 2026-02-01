using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.Device
{
    public class DeviceConfiguration : IEntityTypeConfiguration<DeviceEntity>
    {
        public void Configure(EntityTypeBuilder<DeviceEntity> builder)
        {
            builder.HasIndex(x => new { x.TenantId, x.Name }).IsUnique();
        }
    }
}