using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.HeatJournal
{
    public class HeatJournalConfiguration : IEntityTypeConfiguration<HeatJournalEntity>
    {
        public void Configure(EntityTypeBuilder<HeatJournalEntity> builder)
        {
            builder.HasIndex(x => new { x.HeatWithoutStintId, x.Timestamp, x.SequenceNumber }).IsUnique();
        }
    }
}
