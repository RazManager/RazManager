using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.Car
{
    public class CarConfiguration : IEntityTypeConfiguration<CarEntity>
    {
        public void Configure(EntityTypeBuilder<CarEntity> builder)
        {
            builder.HasIndex(x => new { x.TenantId, x.Name }).IsUnique();
        }
    }
}
