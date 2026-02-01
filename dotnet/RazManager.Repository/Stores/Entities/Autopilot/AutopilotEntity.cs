using RazManager.Repository.Stores.Utilities;
using System.ComponentModel.DataAnnotations;
using System;
using System.Collections.Generic;


namespace RazManager.Repository.Stores.Entities.Autopilot
{
    public class AutopilotEntity : EntityBase
    {
        [Required]
        public Guid TrackConfigurationId { get; set; }

        public required TrackConfiguration.TrackConfigurationEntity TrackConfiguration { get; set; }

        [Required]
        [StringLength(100)]
        public required string Name { get; set; }

        [StringLength(3)]
        [MinLength(3)]
        public string? ShortName { get; set; }

        [StringLength(1000)]
        public string? Description { get; set; }

        [Required]
        public List<AutopilotImage.AutopilotImageEntity> AutopilotImages { get; set; } = new();
    }
}
