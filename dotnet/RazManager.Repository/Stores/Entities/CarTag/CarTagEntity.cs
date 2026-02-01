using RazManager.Repository.Stores.Utilities;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.CarTag
{
    public class CarTagEntity : TenantChildEntityBase
    {
        [Required]
        [StringLength(100)]
        public string Name { get; set; } = null!;

        [StringLength(1000)]
        public string? Description { get; set; }

        [Required]
        [Range(1, 99)]
        public byte Position { get; set; } = 1;

        [Required]
        public List<CarCarTag.CarCarTagEntity> CarCarTags { get; set; } = new();
    }
}
