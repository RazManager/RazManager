using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.Race
{
    public class RaceConfiguration : IEntityTypeConfiguration<RaceEntity>
    {
        public void Configure(EntityTypeBuilder<RaceEntity> builder)
        {
            builder.HasIndex(x => new { x.EventId, x.Number }).IsUnique();
            builder.Property(x => x.RaceFormatTypeId).HasConversion<string>();
            builder.Property(x => x.RaceHeatEndTypeId).HasConversion<string>();
            builder.Property(x => x.HeatCarTypeId).HasConversion<string>();
            builder.Property(x => x.RaceStateTypeId).HasConversion<string>();

            builder.HasOne(x => x.TrackConfiguration)
                   .WithMany(x => x.Races)
                   .OnDelete(DeleteBehavior.Restrict);
        }
    }
}
