using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.CarTag
{
    public class CarTagConfiguration : IEntityTypeConfiguration<CarTagEntity>
    {
        public void Configure(EntityTypeBuilder<CarTagEntity> builder)
        {
            builder.HasIndex(x => new { x.TenantId, x.Name }).IsUnique();
            builder.HasIndex(x => new { x.TenantId, x.Position, x.Name }).IsUnique();
        }
    }
}