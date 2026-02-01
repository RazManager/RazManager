using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.RaceIndicatorEventUser
{
    public class RaceIndicatorEventUserConfiguration : IEntityTypeConfiguration<RaceIndicatorEventUserEntity>
    {
        public void Configure(EntityTypeBuilder<RaceIndicatorEventUserEntity> builder)
        {
            builder.HasIndex(x => new { x.RaceId, x.EventUserId }).IsUnique();
            builder.HasIndex(x => new { x.RaceId, x.IndicatorId }).IsUnique();
        }
    }
}
