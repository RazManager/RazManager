using RazManager.Repository.Stores.Utilities;
using System.ComponentModel.DataAnnotations;
using System;


namespace RazManager.Repository.Stores.Entities.DeviceConfigurationOutput
{
    public class DeviceConfigurationOutputEntity : IEntityId
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        public Guid DeviceConfigurationId { get; set; }

        public DeviceConfiguration.DeviceConfigurationEntity DeviceConfiguration { get; set; } = null!;

        [Required]
        public Razmanager.Protobuf.Public.V1.DeviceConfigurationOutputTypeId DeviceConfigurationOutputTypeId { get; set; }

        public byte? DeviceConfigurationOutputId { get; set; }
    }
}
