using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;


namespace RazManager.Silo.Repository.Stores.Entities.Membership
{
    public class MembershipConfiguration : IEntityTypeConfiguration<MembershipEntity>
    {
        public void Configure(EntityTypeBuilder<MembershipEntity> builder)
        {
            builder.HasIndex(x => new { x.MembershipVersionId, x.SiloAddress }).IsUnique();
            builder.Property(x => x.Status).HasConversion<string>();
        }
    }
}
