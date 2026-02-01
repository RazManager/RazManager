using RazManager.Repository.Stores.Utilities;
using System;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.DeviceConfigurationInput
{
    public class DeviceConfigurationInputEntity : IEntityId
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        public Guid DeviceConfigurationId { get; set; }

        public DeviceConfiguration.DeviceConfigurationEntity DeviceConfiguration { get; set; } = null!;

        [Required]
        public Razmanager.Protobuf.Public.V1.DeviceConfigurationInputTypeId DeviceConfigurationInputTypeId { get; set; }

        public byte? DeviceConfigurationInputId { get; set; }

        public byte? DeviceConfigurationInputSubId { get; set; }
    }
}
