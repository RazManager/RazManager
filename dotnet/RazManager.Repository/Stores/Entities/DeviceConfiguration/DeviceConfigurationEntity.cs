using RazManager.Repository.Stores.Utilities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;


namespace RazManager.Repository.Stores.Entities.DeviceConfiguration
{
    public class DeviceConfigurationEntity : IEntityId
    {
        [Required]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public Guid Id { get; set; }

        [Required]
        public Guid DeviceId { get; set; }

        public Device.DeviceEntity Device { get; set; } = null!;

        [Required]
        [StringLength(100)]
        public string Name { get; set; } = null!;

        [Required]
        public List<DeviceConfigurationInput.DeviceConfigurationInputEntity> DeviceConfigurationInputs { get; set; } = new();

        [Required]
        public List<DeviceConfigurationOutput.DeviceConfigurationOutputEntity> DeviceConfigurationOutputs { get; set; } = new();

        [Required]
        public List<DeviceConfigurationFeature.DeviceConfigurationFeatureEntity> DeviceConfigurationFeatures { get; set; } = new();

        [Required]
        public List<TrackConfigurationDeviceConfiguration.TrackConfigurationDeviceConfigurationEntity> TrackConfigurationDeviceConfigurations { get; set; } = new();
    }
}
