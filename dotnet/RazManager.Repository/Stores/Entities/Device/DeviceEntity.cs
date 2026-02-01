using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System;
using RazManager.Repository.Stores.Utilities;


namespace RazManager.Repository.Stores.Entities.Device
{
    public class DeviceEntity : TenantChildEntityBase
    {
        [Required]
        [StringLength(100)]
        public string Name { get; set; } = null!;

        [StringLength(1000)]
        public string? Description { get; set; }

        //[Required]
        //public bool Connected { get; set; }

        public DateTime? LastConnectedAt { get; set; }

        [Required]
        public bool Simulated { get; set; } = false;

        //[Required]
        //public List<DeviceProperty.DevicePropertyEntity> DeviceProperties { get; set; } = new();

        [Required]
        public List<Entities.DeviceConfiguration.DeviceConfigurationEntity> DeviceConfigurations { get; set; } = new();
    }
}
