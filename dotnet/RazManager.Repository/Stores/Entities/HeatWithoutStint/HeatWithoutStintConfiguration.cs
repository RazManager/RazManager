using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.HeatWithoutStint
{
    public class HeatWithoutStintConfiguration : IEntityTypeConfiguration<HeatWithoutStintEntity>
    {
        public void Configure(EntityTypeBuilder<HeatWithoutStintEntity> builder)
        {
            builder.HasIndex(x => new { x.RaceSessionId, x.Number }).IsUnique();
        }
    }
}
