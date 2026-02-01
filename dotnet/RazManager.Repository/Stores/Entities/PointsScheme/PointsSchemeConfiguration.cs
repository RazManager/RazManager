using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;


namespace RazManager.Repository.Stores.Entities.PointsScheme
{
    public class PointsSchemeConfiguration : IEntityTypeConfiguration<PointsSchemeEntity>
    {
        public void Configure(EntityTypeBuilder<PointsSchemeEntity> builder)
        {
            builder.HasIndex(x => new { x.TenantId, x.Name }).IsUnique();
        }
    }
}
