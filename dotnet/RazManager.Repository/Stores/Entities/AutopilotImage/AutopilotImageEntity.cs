using RazManager.Repository.Stores.Utilities;
using System.ComponentModel.DataAnnotations;
using System;


namespace RazManager.Repository.Stores.Entities.AutopilotImage
{
    public class AutopilotImageEntity : ImageEntityBase
    {
        [Required]
        public Guid AutopilotId { get; set; }

        public Autopilot.AutopilotEntity Autopilot { get; set; } = null!;
    }
}
