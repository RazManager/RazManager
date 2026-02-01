using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.EventUser
{
    public class EventUserConfiguration : IEntityTypeConfiguration<EventUserEntity>
    {
        public void Configure(EntityTypeBuilder<EventUserEntity> builder)
        {
            builder.Property(x => x.EventUserTypeId).HasConversion<string>();
        }
    }
}
