using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;


namespace RazManager.Silo.Repository.Stores.Entities.MembershipVersion
{
    public class MembershipVersionConfiguration : IEntityTypeConfiguration<MembershipVersionEntity>
    {
        public void Configure(EntityTypeBuilder<MembershipVersionEntity> builder)
        {
            builder.HasIndex(x => x.ClusterId).IsUnique();
        }
    }
}
