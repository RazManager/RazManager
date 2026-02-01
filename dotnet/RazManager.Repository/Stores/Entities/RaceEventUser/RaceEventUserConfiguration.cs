using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.RaceEventUser
{
    public class RaceEventUserConfiguration : IEntityTypeConfiguration<RaceEventUserEntity>
    {
        public void Configure(EntityTypeBuilder<RaceEventUserEntity> builder)
        {
            builder.HasIndex(x => new { x.RaceId, x.EventUserId }).IsUnique();
        }
    }
}
