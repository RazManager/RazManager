using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.Heat
{
    public class HeatConfiguration : IEntityTypeConfiguration<HeatEntity>
    {
        public void Configure(EntityTypeBuilder<HeatEntity> builder)
        {
            builder.HasIndex(x => new { x.RaceId, x.SessionTypeId, x.Number }).IsUnique();
            builder.Property(x => x.SessionTypeId).HasConversion<string>();
        }
    }
}
