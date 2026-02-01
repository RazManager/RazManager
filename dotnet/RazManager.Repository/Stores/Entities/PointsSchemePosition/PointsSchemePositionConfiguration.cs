using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;


namespace RazManager.Repository.Stores.Entities.PointsSchemePosition
{
    public class PointsSchemePositionConfiguration : IEntityTypeConfiguration<PointsSchemePositionEntity>
    {
        public void Configure(EntityTypeBuilder<PointsSchemePositionEntity> builder)
        {
            builder.HasIndex(x => new { x.PointsSchemeId, x.Position }).IsUnique();
        }
    }
}
