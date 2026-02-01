using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.VersionNote
{
    public class VersionNoteConfiguration : IEntityTypeConfiguration<VersionNoteEntity>
    {
        public void Configure(EntityTypeBuilder<VersionNoteEntity> builder)
        {
            builder.HasIndex(x => new { x.VersionId, x.Position }).IsUnique();
        }
    }
}