using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;


namespace RazManager.Repository.Stores.Entities.CarImage
{
    public class CarImageConfiguration : IEntityTypeConfiguration<CarImageEntity>
    {
        public void Configure(EntityTypeBuilder<CarImageEntity> builder)
        {
            builder.HasIndex(x => new { x.CarId, x.ImageSize }).IsUnique();
            builder.Property(x => x.ImageSize).HasConversion<string>();
        }
    }
}
