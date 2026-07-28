using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.StintIndicator
{
    public class StintIndicatorConfiguration : IEntityTypeConfiguration<StintIndicatorEntity>
    {
        public void Configure(EntityTypeBuilder<StintIndicatorEntity> builder)
        {
            builder.HasIndex(x => new { x.HeatWithStintId, x.EventUserId }).IsUnique();
            builder.HasIndex(x => new { x.HeatWithStintId, x.IndicatorId }).IsUnique();
        }
    }
}
