using System.ComponentModel.DataAnnotations;
using System;


namespace RazManager.Repository.Stores.Utilities
{
    public abstract class ImageEntityBase : IEntityId, IImageEntity
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        public ImageSize ImageSize { get; set; }

        [Required]
        public byte[] Image { get; set; } = null!;
    }
}
