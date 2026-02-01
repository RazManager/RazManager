using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.RaceCarTag
{
    public class RaceCarTagConfiguration : IEntityTypeConfiguration<RaceCarTagEntity>
    {
        public void Configure(EntityTypeBuilder<RaceCarTagEntity> builder)
        {
            builder.HasIndex(x => new { x.RaceId, x.CarTagId }).IsUnique();

            //builder.HasOne(x => x.Car)
            //       .WithMany(x => x.CarCarTags)
            //       .OnDelete(DeleteBehavior.ClientCascade);

            //builder.HasOne(x => x.CarTag)
            //       .WithMany(x => x.CarCarTags)
            //       .OnDelete(DeleteBehavior.ClientCascade);
        }
    }
}
