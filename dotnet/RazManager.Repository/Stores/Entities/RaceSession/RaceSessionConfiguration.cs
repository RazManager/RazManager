using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.RaceSession
{
    public class RaceSessionConfiguration : IEntityTypeConfiguration<RaceSessionEntity>
    {
        public void Configure(EntityTypeBuilder<RaceSessionEntity> builder)
        {
            builder.HasIndex(x => new { x.RaceId, x.SessionTypeId }).IsUnique();
            builder.Property(x => x.SessionTypeId).HasConversion<string>();
            builder.Property(x => x.HeatStintEndTypeId).HasConversion<string>();
            builder.Property(x => x.RaceSessionStateTypeId).HasConversion<string>();
        }
    }
}
