using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.HeatWithoutStints
{
    public class HeatWithoutStintsConfiguration : IEntityTypeConfiguration<HeatWithoutStintsEntity>
    {
        public void Configure(EntityTypeBuilder<HeatWithoutStintsEntity> builder)
        {
            builder.HasIndex(x => new { x.RaceSessionWithoutStintsId, x.Number }).IsUnique();
        }
    }
}
