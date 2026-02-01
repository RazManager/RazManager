using RazManager.Repository.Stores.Utilities;
using System.ComponentModel.DataAnnotations;
using System;


namespace RazManager.Repository.Stores.Entities.DeviceConfigurationFeature
{
    public class DeviceConfigurationFeatureEntity : IEntityId
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        public Guid DeviceConfigurationId { get; set; }

        public DeviceConfiguration.DeviceConfigurationEntity DeviceConfiguration { get; set; } = null!;

        [Required]
        public required Razmanager.Protobuf.Public.V1.DeviceConfigurationFeatureTypeId DeviceConfigurationFeatureTypeId { get; set; }
    }
}
