using RazManager.Repository.Stores.Utilities;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.Track
{

    public class TrackEntity : TenantChildEntityBase
    {
        [Required]
        [StringLength(100)]
        public string Name { get; set; } = null!;

        [StringLength(1000)]
        public string? Description { get; set; }

        [Required]
        public List<TrackImage.TrackImageEntity> TrackImages { get; set; } = new();

        [Required]
        public List<Entities.TrackConfiguration.TrackConfigurationEntity> TrackConfigurations { get; set; } = new();
    }
}
