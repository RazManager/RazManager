using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.HeatIndicator
{
    public class HeatIndicatorConfiguration : IEntityTypeConfiguration<HeatIndicatorEntity>
    {
        public void Configure(EntityTypeBuilder<HeatIndicatorEntity> builder)
        {
            builder.HasIndex(x => new { x.HeatWithoutStintsId, x.IndicatorId }).IsUnique();
        }
    }
}
