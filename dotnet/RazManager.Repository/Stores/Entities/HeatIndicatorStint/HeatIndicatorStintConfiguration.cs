using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.HeatIndicatorStint
{
    public class HeatIndicatorStintConfiguration : IEntityTypeConfiguration<HeatIndicatorStintEntity>
    {
        public void Configure(EntityTypeBuilder<HeatIndicatorStintEntity> builder)
        {
            builder.HasIndex(x => new { x.HeatIndicatorId, x.Lap }).IsUnique();
        }
    }
}
