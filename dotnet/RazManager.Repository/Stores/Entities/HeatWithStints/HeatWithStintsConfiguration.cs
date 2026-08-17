using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.HeatWithStints
{
    public class HeatWithStintsConfiguration : IEntityTypeConfiguration<HeatWithStintsEntity>
    {
        public void Configure(EntityTypeBuilder<HeatWithStintsEntity> builder)
        {
            builder.HasIndex(x => new { x.RaceSessionWithStintsId, x.Number }).IsUnique();
        }
    }
}
