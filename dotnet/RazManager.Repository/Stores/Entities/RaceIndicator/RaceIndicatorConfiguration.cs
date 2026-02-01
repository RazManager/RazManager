using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.RaceIndicator
{
    public class RaceIndicatorConfiguration : IEntityTypeConfiguration<RaceIndicatorEntity>
    {
        public void Configure(EntityTypeBuilder<RaceIndicatorEntity> builder)
        {
            builder.HasIndex(x => new { x.RaceId, x.IndicatorId }).IsUnique();
        }
    }
}
