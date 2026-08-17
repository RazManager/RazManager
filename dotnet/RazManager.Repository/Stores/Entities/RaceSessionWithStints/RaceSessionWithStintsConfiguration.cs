using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.RaceSessionWithStints
{
    public class RaceSessionWithStintsConfiguration : IEntityTypeConfiguration<RaceSessionWithStintsEntity>
    {
        public void Configure(EntityTypeBuilder<RaceSessionWithStintsEntity> builder)
        {
            builder.HasIndex(x => new { x.RaceId, x.SessionTypeId, x.Number }).IsUnique();
            builder.Property(x => x.SessionTypeId).HasConversion<string>();
            builder.Property(x => x.HeatStintEndTypeId).HasConversion<string>();
            builder.Property(x => x.StateTypeId).HasConversion<string>();
        }
    }
}
