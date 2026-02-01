using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;

namespace RazManager.Identity.Stores.Entities.XmlRepository
{
    public class XmlRepositoryGrantConfiguration : IEntityTypeConfiguration<XmlRepositoryEntity>
    {
        public void Configure(EntityTypeBuilder<XmlRepositoryEntity> builder)
        {
            builder.HasIndex(x => x.TimeToLiveAt);
        }
    }
}
