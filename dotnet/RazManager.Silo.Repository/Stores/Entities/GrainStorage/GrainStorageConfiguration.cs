using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;


namespace RazManager.Silo.Repository.Stores.Entities.GrainStorage
{
    public class GrainStorageConfiguration : IEntityTypeConfiguration<GrainStorageEntity>
    {
        public void Configure(EntityTypeBuilder<GrainStorageEntity> builder)
        {
            builder.HasIndex(x => new { x.ClusterId, x.StateName, x.GrainId }).IsUnique();
        }
    }
}
