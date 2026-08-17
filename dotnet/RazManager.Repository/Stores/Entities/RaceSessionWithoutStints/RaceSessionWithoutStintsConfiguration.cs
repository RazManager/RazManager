using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.RaceSessionWithoutStints
{
    public class RaceSessionWithoutStintsConfiguration : IEntityTypeConfiguration<RaceSessionWithoutStintsEntity>
    {
        public void Configure(EntityTypeBuilder<RaceSessionWithoutStintsEntity> builder)
        {
            builder.HasIndex(x => new { x.RaceId, x.SessionTypeId, x.Number }).IsUnique();
            builder.Property(x => x.SessionTypeId).HasConversion<string>();
            builder.Property(x => x.HeatStintEndTypeId).HasConversion<string>();
            builder.Property(x => x.StateTypeId).HasConversion<string>();
        }
    }
}
