using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.CarCarTag
{
    public class CarCarTagConfiguration : IEntityTypeConfiguration<CarCarTagEntity>
    {
        public void Configure(EntityTypeBuilder<CarCarTagEntity> builder)
        {
            builder.HasIndex(x => new { x.CarId, x.CarTagId }).IsUnique();
            builder.HasIndex(x => new { x.CarTagId, x.CarId }).IsUnique();

            //builder.HasOne(x => x.Car)
            //       .WithMany(x => x.CarCarTags)
            //       .OnDelete(DeleteBehavior.ClientCascade);

            //builder.HasOne(x => x.CarTag)
            //       .WithMany(x => x.CarCarTags)
            //       .OnDelete(DeleteBehavior.ClientCascade);
        }
    }
}
