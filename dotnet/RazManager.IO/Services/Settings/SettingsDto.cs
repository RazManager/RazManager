using Microsoft.VisualBasic;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Resources;
using System;
using System.Device.Gpio;
using System.Linq;
using RazManager.IO.Utilities;
using Constants = RazManager.IO.Utilities.Constants;
using Razmanager.Protobuf.Public.V1;


namespace RazManager.IO.Services.Settings
{
    public class SettingsDto
    {
        public string? CertificatePem { get; set; }
        public string KeyPem { get; set; } = null!;
        public List<DeviceConfiguration> DeviceConfigurations { get; set; } = [];
    }


    public class DeviceConfiguration
    {
        public Guid Id { get; set; }
        public IEnumerable<GpioPinConfiguration> GpioPinConfigurations { get; set; } = [];
    }


    public class GpioPinConfiguration : IValidatableObject
    {
        public int Id { get; set; }
        public PinMode? PinModeId { get; set; }
        public List<GpioPinConfigurationEvent> Events { get; set; } = [];

        public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
        {
            var validationResults = new List<ValidationResult>();

            if (PinModeId.HasValue)
            {
                if (Events.Count == 0)
                {
                    yield return new ValidationResult($"Pin {Id}: If a pin mode is defined, the pin needs to have at least one event.");
                }

                switch (PinModeId.Value)
                {
                    case System.Device.Gpio.PinMode.Input:
                    case System.Device.Gpio.PinMode.InputPullDown:
                    case System.Device.Gpio.PinMode.InputPullUp:
                        foreach (var item in Events)
                        {
                            if (!item.GpioInputTypeId.HasValue)
                            {
                                yield return new ValidationResult($"Pin {Id}: GPIO event needs to have a value.");
                            }
                            if (!item.PinEventTypeId.HasValue)
                            {
                                yield return new ValidationResult($"Pin {Id}: Pin event needs to have a value.");
                            }

                            if (!item.DeviceConfigurationInputOutputId.HasValue && Constants.GpioInputTypes.First(t => t.GpioInputTypeId == item.GpioInputTypeId!.Value).DeviceConfigurationInputOutputIdTypeId.Equals(DeviceConfigurationInputOutputIdTypeId.Required))
                            {
                                yield return new ValidationResult(
                                    string.Format(ExceptionMessages.GpioInputIdRequired,
                                                  new ResourceManager(typeof(GpioInputType)).GetString(item.GpioInputTypeId!.Value.ToString())));
                            }

                            if (item.DeviceConfigurationInputOutputId.HasValue && Constants.GpioInputTypes.First(t => t.GpioInputTypeId == item.GpioInputTypeId!.Value).DeviceConfigurationInputOutputIdTypeId.Equals(DeviceConfigurationInputOutputIdTypeId.None))
                            {
                                yield return new ValidationResult(
                                    string.Format(ExceptionMessages.GpioInputIdNone,
                                                  new ResourceManager(typeof(GpioInputType)).GetString(item.GpioInputTypeId!.Value.ToString())));
                            }
                        }
                        if (Events.GroupBy(x => new { x.GpioInputTypeId, x.DeviceConfigurationInputOutputId })
                                  .Any(x => x.Count() > 1))
                        {
                            yield return new ValidationResult($"Pin {Id}: {ExceptionMessages.GpioInputDuplicate}");
                        }
                        break;

                    case System.Device.Gpio.PinMode.Output:
                        foreach (var item in Events)
                        {
                            if (!item.GpioOutputTypeId.HasValue)
                            {
                                yield return new ValidationResult($"Pin {Id}: A GPIO event needs to have a value.");
                            }
                            if (string.IsNullOrEmpty(item.PinValueId))
                            {
                                yield return new ValidationResult($"Pin {Id}: A pin value needs to have a value.");
                            }
                            if (!item.DeviceConfigurationInputOutputId.HasValue && Constants.GpioOutputTypes.First(t => t.GpioOutputTypeId == item.GpioOutputTypeId!.Value).DeviceConfigurationInputOutputIdTypeId.Equals(DeviceConfigurationInputOutputIdTypeId.Required))
                            {
                                yield return new ValidationResult(
                                    string.Format(ExceptionMessages.GpioOutputIdRequired,
                                                  new ResourceManager(typeof(GpioOutputType)).GetString(item.GpioOutputTypeId!.Value.ToString())));
                            }

                            if (item.DeviceConfigurationInputOutputId.HasValue && Constants.GpioOutputTypes.First(t => t.GpioOutputTypeId == item.GpioOutputTypeId!.Value).DeviceConfigurationInputOutputIdTypeId.Equals(DeviceConfigurationInputOutputIdTypeId.None))
                            {
                                yield return new ValidationResult(
                                    string.Format(ExceptionMessages.GpioOutputIdNone,
                                                  new ResourceManager(typeof(GpioOutputType)).GetString(item.GpioOutputTypeId!.Value.ToString())));
                            }
                        }
                        if (Events.GroupBy(x => new { x.GpioOutputTypeId, x.DeviceConfigurationInputOutputId })
                                  .Any(x => x.Count() > 1))
                        {
                            yield return new ValidationResult($"Pin {Id}: {ExceptionMessages.GpioOutputDuplicate}");
                        }
                        break;
                }
            }
        }
    }


    public class GpioPinConfigurationEvent
    {
        public GpioInputTypeId? GpioInputTypeId { get; set; }
        public PinEventTypes? PinEventTypeId { get; set; }
        public GpioOutputTypeId? GpioOutputTypeId { get; set; }
        public string? PinValueId { get; set; }
        public int? DeviceConfigurationInputOutputId { get; set; }
    }
}
