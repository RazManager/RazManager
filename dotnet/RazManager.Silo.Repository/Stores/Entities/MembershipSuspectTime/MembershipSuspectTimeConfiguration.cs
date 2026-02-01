using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;


namespace RazManager.Silo.Repository.Stores.Entities.MembershipSuspectTime
{
    public class MembershipSuspectTimeConfiguration : IEntityTypeConfiguration<MembershipSuspectTimeEntity>
    {
        public void Configure(EntityTypeBuilder<MembershipSuspectTimeEntity> builder)
        {
            builder.HasIndex(x => new { x.MembershipId, x.SiloAddress }).IsUnique();
        }
    }
}
