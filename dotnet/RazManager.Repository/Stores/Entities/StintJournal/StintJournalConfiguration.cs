using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.StintJournal
{
    public class StintJournalConfiguration : IEntityTypeConfiguration<StintJournalEntity>
    {
        public void Configure(EntityTypeBuilder<StintJournalEntity> builder)
        {
            builder.HasIndex(x => new { x.StintId, x.Timestamp, x.SequenceNumber }).IsUnique();
        }
    }
}
