using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;


namespace RazManager.Silo.Repository.Stores.Entities.Reminder
{
    public class ReminderConfiguration : IEntityTypeConfiguration<ReminderEntity>
    {
        public void Configure(EntityTypeBuilder<ReminderEntity> builder)
        {
            builder.HasIndex(x => new { x.ClusterId, x.GrainId, x.ReminderName }).IsUnique();
        }
    }
}
