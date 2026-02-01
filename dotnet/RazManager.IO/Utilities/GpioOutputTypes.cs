using Razmanager.Protobuf.Public.V1;
using System.Collections.Generic;

namespace RazManager.IO.Utilities
{
    public enum GpioOutputTypeId
    {
        StartFinishIndicator,
        PowerOn,
        PowerYellow,
        PowerOff,
        CountdownOn,
        CountdownOff,
        HeatGreen,
        HeatYellow,
        HeatRed,
        HeatOff,
        Pitstop,
        EnergyLevel,
        //ExtraIndicator,
        RgbLedMatrixA,
        RgbLedMatrixB,
        RgbLedMatrixC,
        RgbLedMatrixD,
        RgbLedMatrixE,
        RgbLedMatrixR1,
        RgbLedMatrixG1,
        RgbLedMatrixB1,
        RgbLedMatrixR2,
        RgbLedMatrixG2,
        RgbLedMatrixB2,
        RgbLedMatrixOe,
        RgbLedMatrixClk,
        RgbLedMatrixLat
    }


    public static partial class Converters
    {
        public static GpioOutputTypeId? ToGpioOutputTypeId(DeviceConfigurationOutputTypeId deviceConfigurationOutputTypeId)
        {
            switch (deviceConfigurationOutputTypeId)
            {
                case DeviceConfigurationOutputTypeId.StartFinishIndicator:
                    return GpioOutputTypeId.StartFinishIndicator;

                case DeviceConfigurationOutputTypeId.PowerOn:
                    return GpioOutputTypeId.PowerOn;

                case DeviceConfigurationOutputTypeId.PowerYellow:
                    return GpioOutputTypeId.PowerYellow;

                case DeviceConfigurationOutputTypeId.PowerOff:
                    return GpioOutputTypeId.PowerOff;

                case DeviceConfigurationOutputTypeId.CountdownOn:
                    return GpioOutputTypeId.CountdownOn;

                case DeviceConfigurationOutputTypeId.CountdownOff:
                    return GpioOutputTypeId.CountdownOff;

                case DeviceConfigurationOutputTypeId.HeatGreen:
                    return GpioOutputTypeId.HeatGreen;

                case DeviceConfigurationOutputTypeId.HeatYellow:
                    return GpioOutputTypeId.HeatYellow;

                case DeviceConfigurationOutputTypeId.HeatRed:
                    return GpioOutputTypeId.HeatRed;

                case DeviceConfigurationOutputTypeId.HeatOff:
                    return GpioOutputTypeId.HeatOff;

                case DeviceConfigurationOutputTypeId.Pitstop:
                    return GpioOutputTypeId.Pitstop;

                case DeviceConfigurationOutputTypeId.EnergyLevel:
                    return GpioOutputTypeId.EnergyLevel;

                default:
                    return null;
            }
        }


        public static DeviceConfigurationOutputTypeId? FromGpioOutputTypeId(GpioOutputTypeId gpioOutputTypeId)
        {
            switch (gpioOutputTypeId)
            {
                case GpioOutputTypeId.StartFinishIndicator:
                    return DeviceConfigurationOutputTypeId.StartFinishIndicator;

                case GpioOutputTypeId.PowerOn:
                    return DeviceConfigurationOutputTypeId.PowerOn;

                case GpioOutputTypeId.PowerYellow:
                    return DeviceConfigurationOutputTypeId.PowerYellow;

                case GpioOutputTypeId.PowerOff:
                    return DeviceConfigurationOutputTypeId.PowerOff;

                case GpioOutputTypeId.CountdownOn:
                    return DeviceConfigurationOutputTypeId.CountdownOn;

                case GpioOutputTypeId.CountdownOff:
                    return DeviceConfigurationOutputTypeId.CountdownOff;

                case GpioOutputTypeId.HeatGreen:
                    return DeviceConfigurationOutputTypeId.HeatGreen;

                case GpioOutputTypeId.HeatYellow:
                    return DeviceConfigurationOutputTypeId.HeatYellow;

                case GpioOutputTypeId.HeatRed:
                    return DeviceConfigurationOutputTypeId.HeatRed;

                case GpioOutputTypeId.HeatOff:
                    return DeviceConfigurationOutputTypeId.HeatOff;

                case GpioOutputTypeId.Pitstop:
                    return DeviceConfigurationOutputTypeId.Pitstop;

                case GpioOutputTypeId.EnergyLevel:
                    return DeviceConfigurationOutputTypeId.EnergyLevel;

                default:
                    return null;
            }
        }
    }


    public class DeviceOutputTypeOption
    {
        public GpioOutputTypeId GpioOutputTypeId { get; set; }
        public DeviceConfigurationInputOutputIdTypeId DeviceConfigurationInputOutputIdTypeId { get; set; }
    }


    public static partial class Constants
    {
        public static IEnumerable<DeviceOutputTypeOption> GpioOutputTypes
        {
            get
            {
                return new List<DeviceOutputTypeOption>()
                {
                    new DeviceOutputTypeOption
                    {
                        GpioOutputTypeId = GpioOutputTypeId.StartFinishIndicator,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Optional
                    },
                    new DeviceOutputTypeOption
                    {
                        GpioOutputTypeId = GpioOutputTypeId.PowerOn,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Optional
                    },
                    new DeviceOutputTypeOption
                    {
                        GpioOutputTypeId = GpioOutputTypeId.PowerYellow,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Optional
                    },
                    new DeviceOutputTypeOption
                    {
                        GpioOutputTypeId = GpioOutputTypeId.PowerOff,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Optional
                    },
                    new DeviceOutputTypeOption
                    {
                        GpioOutputTypeId = GpioOutputTypeId.CountdownOn,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required
                    },
                    new DeviceOutputTypeOption
                    {
                        GpioOutputTypeId = GpioOutputTypeId.CountdownOff,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.None
                    },
                    new DeviceOutputTypeOption
                    {
                        GpioOutputTypeId = GpioOutputTypeId.HeatGreen,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.None
                    },
                    new DeviceOutputTypeOption
                    {
                        GpioOutputTypeId = GpioOutputTypeId.HeatYellow,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.None
                    },
                    new DeviceOutputTypeOption
                    {
                        GpioOutputTypeId = GpioOutputTypeId.HeatRed,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.None
                    },
                    new DeviceOutputTypeOption
                    {
                        GpioOutputTypeId = GpioOutputTypeId.HeatOff,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.None
                    },
                    new DeviceOutputTypeOption
                    {
                        GpioOutputTypeId = GpioOutputTypeId.Pitstop,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Optional
                    },
                    new DeviceOutputTypeOption
                    {
                        GpioOutputTypeId = GpioOutputTypeId.EnergyLevel,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required
                    },
                    //new DeviceOutputTypeOption
                    //{
                    //    GpioOutputTypeId = GpioOutputTypeId.ExtraIndicator,
                    //    InputOutputIdTypeId = InputOutputIdTypeId.Required
                    //},
                    new DeviceOutputTypeOption
                    {
                        GpioOutputTypeId = GpioOutputTypeId.RgbLedMatrixA,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.None
                    },
                    new DeviceOutputTypeOption
                    {
                        GpioOutputTypeId = GpioOutputTypeId.RgbLedMatrixB,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.None
                    },
                    new DeviceOutputTypeOption
                    {
                        GpioOutputTypeId = GpioOutputTypeId.RgbLedMatrixC,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.None
                    },
                    new DeviceOutputTypeOption
                    {
                        GpioOutputTypeId = GpioOutputTypeId.RgbLedMatrixD,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.None
                    },
                    new DeviceOutputTypeOption
                    {
                        GpioOutputTypeId = GpioOutputTypeId.RgbLedMatrixE,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.None
                    },
                    new DeviceOutputTypeOption
                    {
                        GpioOutputTypeId = GpioOutputTypeId.RgbLedMatrixR1,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.None
                    },
                    new DeviceOutputTypeOption
                    {
                        GpioOutputTypeId = GpioOutputTypeId.RgbLedMatrixG1,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.None
                    },
                    new DeviceOutputTypeOption
                    {
                        GpioOutputTypeId = GpioOutputTypeId.RgbLedMatrixB1,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.None
                    },
                    new DeviceOutputTypeOption
                    {
                        GpioOutputTypeId = GpioOutputTypeId.RgbLedMatrixR2,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.None
                    },
                    new DeviceOutputTypeOption
                    {
                        GpioOutputTypeId = GpioOutputTypeId.RgbLedMatrixG2,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.None
                    },
                    new DeviceOutputTypeOption
                    {
                        GpioOutputTypeId = GpioOutputTypeId.RgbLedMatrixB2,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.None
                    },
                    new DeviceOutputTypeOption
                    {
                        GpioOutputTypeId = GpioOutputTypeId.RgbLedMatrixOe,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.None
                    },
                    new DeviceOutputTypeOption
                    {
                        GpioOutputTypeId = GpioOutputTypeId.RgbLedMatrixClk,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.None
                    },
                    new DeviceOutputTypeOption
                    {
                        GpioOutputTypeId = GpioOutputTypeId.RgbLedMatrixLat,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.None
                    }
                };
            }
        }
    }
}
