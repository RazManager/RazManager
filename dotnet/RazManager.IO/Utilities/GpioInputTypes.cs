using Razmanager.Protobuf.Public.V1;
using System;
using System.Collections.Generic;


namespace RazManager.IO.Utilities
{
    public enum GpioInputTypeId
    {
        StartFinishIndicator,
        Sector1FinishIndicator,
        Sector2FinishIndicator,
        SpeedTrapStartIndicator,
        SpeedTrapFinishIndicator,
        PitstopEntry,
        PitstopExit,
        Yellow,
        Red,
        PowerOverload
    }

    public static partial class Converters
    {
        public static DeviceConfigurationInputTypeId FromGpioInputTypeId(GpioInputTypeId gpioInputTypeId)
        {
            switch (gpioInputTypeId)
            {
                case GpioInputTypeId.StartFinishIndicator:
                    return DeviceConfigurationInputTypeId.StartFinishIndicator;

                case GpioInputTypeId.Sector1FinishIndicator:
                    return DeviceConfigurationInputTypeId.Sector1FinishIndicator;

                case GpioInputTypeId.Sector2FinishIndicator:
                    return DeviceConfigurationInputTypeId.Sector2FinishIndicator;

                case GpioInputTypeId.SpeedTrapStartIndicator:
                    return DeviceConfigurationInputTypeId.SpeedTrapStartIndicator;

                case GpioInputTypeId.SpeedTrapFinishIndicator:
                    return DeviceConfigurationInputTypeId.SpeedTrapFinishIndicator;

                case GpioInputTypeId.PitstopEntry:
                    return DeviceConfigurationInputTypeId.PitstopEntry;

                case GpioInputTypeId.PitstopExit:
                    return DeviceConfigurationInputTypeId.PitstopExit;

                case GpioInputTypeId.Yellow:
                    return DeviceConfigurationInputTypeId.Yellow;

                case GpioInputTypeId.Red:
                    return DeviceConfigurationInputTypeId.Red;

                case GpioInputTypeId.PowerOverload:
                    return DeviceConfigurationInputTypeId.PowerOverload;

                default:
                    throw new ArgumentOutOfRangeException(nameof(gpioInputTypeId));
            }
        }
    }


    public class GpioInputTypeOption
    {
        public GpioInputTypeId GpioInputTypeId { get; set; }
        public DeviceConfigurationInputOutputIdTypeId DeviceConfigurationInputOutputIdTypeId { get; set; }
    }


    public static partial class Constants
    {
        public static IEnumerable<GpioInputTypeOption> GpioInputTypes
        {
            get
            {
                return new List<GpioInputTypeOption>()
                {
                    new GpioInputTypeOption
                    {
                        GpioInputTypeId = GpioInputTypeId.StartFinishIndicator,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required
                    },
                    new GpioInputTypeOption
                    {
                        GpioInputTypeId = GpioInputTypeId.Sector1FinishIndicator,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required
                    },
                    new GpioInputTypeOption
                    {
                        GpioInputTypeId = GpioInputTypeId.Sector2FinishIndicator,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required
                    },
                    new GpioInputTypeOption
                    {
                        GpioInputTypeId = GpioInputTypeId.SpeedTrapStartIndicator,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required
                    },
                    new GpioInputTypeOption
                    {
                        GpioInputTypeId = GpioInputTypeId.SpeedTrapFinishIndicator,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required
                    },
                    new GpioInputTypeOption
                    {
                        GpioInputTypeId = GpioInputTypeId.PitstopEntry,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required
                    },
                    new GpioInputTypeOption
                    {
                        GpioInputTypeId = GpioInputTypeId.PitstopExit,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required
                    },
                    new GpioInputTypeOption
                    {
                        GpioInputTypeId = GpioInputTypeId.Yellow,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Optional
                    },
                    new GpioInputTypeOption
                    {
                        GpioInputTypeId = GpioInputTypeId.Red,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Optional
                    },
                    new GpioInputTypeOption
                    {
                        GpioInputTypeId = GpioInputTypeId.PowerOverload,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Optional
                    }
                };
            }
        }
    }
}
