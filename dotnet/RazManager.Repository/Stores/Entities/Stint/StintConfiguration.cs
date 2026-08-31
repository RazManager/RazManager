using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.Stint
{
    public class StintConfiguration : IEntityTypeConfiguration<StintEntity>
    {
        public void Configure(EntityTypeBuilder<StintEntity> builder)
        {
            builder.HasIndex(x => new { x.HeatWithStintsId, x.Number }).IsUnique();
        }
    }
}
