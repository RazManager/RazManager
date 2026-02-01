using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;


namespace RazManager.Repository.Stores.Entities.UserImage
{
    public class UserImageConfiguration : IEntityTypeConfiguration<UserImageEntity>
    {
        public void Configure(EntityTypeBuilder<UserImageEntity> builder)
        {
            builder.HasIndex(x => new { x.UserId, x.ImageSize }).IsUnique();
            builder.Property(x => x.ImageSize).HasConversion<string>();
        }
    }
}
