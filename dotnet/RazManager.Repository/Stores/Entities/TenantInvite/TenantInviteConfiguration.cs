using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.TenantInvite
{
    public class TenantInviteConfiguration : IEntityTypeConfiguration<TenantInviteEntity>
    {
        public void Configure(EntityTypeBuilder<TenantInviteEntity> builder)
        {
            builder.HasIndex(x => new { x.Code }).IsUnique();
            builder.HasIndex(x => x.TimeToLiveAt);
        }
    }
}
