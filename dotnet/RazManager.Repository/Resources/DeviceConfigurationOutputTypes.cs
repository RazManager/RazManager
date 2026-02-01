using Razmanager.Protobuf.Public.V1;
using System.Collections.Generic;


namespace RazManager.Repository.Resources
{
    public class DeviceConfigurationOutputTypeOption
    {
        public DeviceConfigurationOutputTypeId DeviceConfigurationOutputTypeId { get; set; }
        public DeviceConfigurationInputOutputIdTypeId DeviceConfigurationInputOutputIdTypeId { get; set; }
    }


    public static partial class Constants
    {
        public static IEnumerable<DeviceConfigurationOutputTypeOption> DeviceConfigurationOutputTypes
        {
            get
            {
                return new List<DeviceConfigurationOutputTypeOption>()
                {
                    new DeviceConfigurationOutputTypeOption
                    {
                        DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.StartFinishIndicator,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required,
                    },
                    new DeviceConfigurationOutputTypeOption
                    {
                        DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.PowerOn,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Optional,
                    },
                    new DeviceConfigurationOutputTypeOption
                    {
                        DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.PowerYellow,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Optional,
                    },
                    new DeviceConfigurationOutputTypeOption
                    {
                        DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.PowerOff,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Optional,
                    },
                    new DeviceConfigurationOutputTypeOption
                    {
                        DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.CountdownOn,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required,
                    },
                    new DeviceConfigurationOutputTypeOption
                    {
                        DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.CountdownOff,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.None,
                    },
                    new DeviceConfigurationOutputTypeOption
                    {
                        DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.HeatGreen,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.None,
                    },
                    new DeviceConfigurationOutputTypeOption
                    {
                        DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.HeatYellow,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.None,
                    },
                    new DeviceConfigurationOutputTypeOption
                    {
                        DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.HeatRed,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.None,
                    },
                    new DeviceConfigurationOutputTypeOption
                    {
                        DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.HeatOff,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.None,
                    },
                    new DeviceConfigurationOutputTypeOption
                    {
                        DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.EnergyLevel,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required,
                    }
                };
            }
        }
    }
}