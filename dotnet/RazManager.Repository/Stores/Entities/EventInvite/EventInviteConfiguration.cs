using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.EventInvite
{
    public class EventInviteConfiguration : IEntityTypeConfiguration<EventInviteEntity>
    {
        public void Configure(EntityTypeBuilder<EventInviteEntity> builder)
        {
            builder.HasIndex(x => new { x.Code }).IsUnique();
            builder.HasIndex(x => x.TimeToLiveAt);
        }
    }
}
