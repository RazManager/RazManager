using Razmanager.Protobuf.Public.V1;
using System.Collections.Generic;


namespace RazManager.Repository.Resources
{
    public class DeviceConfigurationInputTypeOption
    {
        public DeviceConfigurationInputTypeId DeviceConfigurationInputTypeId { get; set; }
        public DeviceConfigurationInputOutputIdTypeId DeviceConfigurationInputOutputIdTypeId { get; set; }
    }


    public static partial class Constants
    {
        public static IEnumerable<DeviceConfigurationInputTypeOption> DeviceConfigurationInputTypes
        {
            get
            {
                return new List<DeviceConfigurationInputTypeOption>()
                {
                    new DeviceConfigurationInputTypeOption
                    {
                        DeviceConfigurationInputTypeId = DeviceConfigurationInputTypeId.StartFinishIndicator,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required
                    },
                    new DeviceConfigurationInputTypeOption
                    {
                        DeviceConfigurationInputTypeId = DeviceConfigurationInputTypeId.Sector1FinishIndicator,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required
                    },
                    new DeviceConfigurationInputTypeOption
                    {
                        DeviceConfigurationInputTypeId = DeviceConfigurationInputTypeId.Sector2FinishIndicator,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required
                    },
                    new DeviceConfigurationInputTypeOption
                    {
                        DeviceConfigurationInputTypeId = DeviceConfigurationInputTypeId.SpeedTrapStartIndicator,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required
                    },
                    new DeviceConfigurationInputTypeOption
                    {
                        DeviceConfigurationInputTypeId = DeviceConfigurationInputTypeId.SpeedTrapFinishIndicator,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required
                    },
                    new DeviceConfigurationInputTypeOption
                    {
                        DeviceConfigurationInputTypeId = DeviceConfigurationInputTypeId.ExtraIndicator,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required
                    },
                    new DeviceConfigurationInputTypeOption
                    {
                        DeviceConfigurationInputTypeId = DeviceConfigurationInputTypeId.PitlaneEntry,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required
                    },
                    new DeviceConfigurationInputTypeOption
                    {
                        DeviceConfigurationInputTypeId = DeviceConfigurationInputTypeId.PitlaneExit,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required
                    },
                    new DeviceConfigurationInputTypeOption
                    {
                        DeviceConfigurationInputTypeId = DeviceConfigurationInputTypeId.PitstopEntry,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required
                    },
                    new DeviceConfigurationInputTypeOption
                    {
                        DeviceConfigurationInputTypeId = DeviceConfigurationInputTypeId.PitstopExit,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required
                    },
                    new DeviceConfigurationInputTypeOption
                    {
                        DeviceConfigurationInputTypeId = DeviceConfigurationInputTypeId.ControllerOn,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required
                    },
                    new DeviceConfigurationInputTypeOption
                    {
                        DeviceConfigurationInputTypeId = DeviceConfigurationInputTypeId.ControllerBatteryOk,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required
                    },
                    new DeviceConfigurationInputTypeOption
                    {
                        DeviceConfigurationInputTypeId = DeviceConfigurationInputTypeId.Energy,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required
                    },
                    new DeviceConfigurationInputTypeOption
                    {
                        DeviceConfigurationInputTypeId = DeviceConfigurationInputTypeId.Brake,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required
                    },
                    new DeviceConfigurationInputTypeOption
                    {
                        DeviceConfigurationInputTypeId = DeviceConfigurationInputTypeId.LaneChange,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required
                    },
                    new DeviceConfigurationInputTypeOption
                    {
                        DeviceConfigurationInputTypeId = DeviceConfigurationInputTypeId.LaneChangeUp,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required
                    },
                    new DeviceConfigurationInputTypeOption
                    {
                        DeviceConfigurationInputTypeId = DeviceConfigurationInputTypeId.LaneChangeDown,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required
                    },
                    new DeviceConfigurationInputTypeOption
                    {
                        DeviceConfigurationInputTypeId = DeviceConfigurationInputTypeId.LaneChangeDoubleTapped,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required
                    },
                    new DeviceConfigurationInputTypeOption
                    {
                        DeviceConfigurationInputTypeId = DeviceConfigurationInputTypeId.CarOnTrack,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Required
                    },
                    new DeviceConfigurationInputTypeOption
                    {
                        DeviceConfigurationInputTypeId = DeviceConfigurationInputTypeId.Yellow,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Optional
                    },
                    new DeviceConfigurationInputTypeOption
                    {
                        DeviceConfigurationInputTypeId = DeviceConfigurationInputTypeId.Red,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Optional
                    },
                    new DeviceConfigurationInputTypeOption
                    {
                        DeviceConfigurationInputTypeId = DeviceConfigurationInputTypeId.PowerOverload,
                        DeviceConfigurationInputOutputIdTypeId = DeviceConfigurationInputOutputIdTypeId.Optional
                    },
                };
            }
        }
    }
}