using RazManager.Repository.Stores.Utilities;
using System.ComponentModel.DataAnnotations;
using System;


namespace RazManager.Repository.Stores.Entities.TrackConfigurationDeviceConfiguration
{
    public class TrackConfigurationDeviceConfigurationEntity : IEntityId
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        public Guid TrackConfigurationId { get; set; }

        public TrackConfiguration.TrackConfigurationEntity TrackConfiguration { get; set; } = null!;

        [Required]
        public Guid DeviceConfigurationId { get; set; }

        public DeviceConfiguration.DeviceConfigurationEntity DeviceConfiguration { get; set; } = null!;
    }
}
