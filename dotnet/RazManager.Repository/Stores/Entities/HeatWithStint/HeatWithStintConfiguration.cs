using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.HeatWithStint
{
    public class HeatWithStintConfiguration : IEntityTypeConfiguration<HeatWithStintEntity>
    {
        public void Configure(EntityTypeBuilder<HeatWithStintEntity> builder)
        {
            builder.HasIndex(x => new { x.RaceSessionId, x.Number }).IsUnique();
        }
    }
}
