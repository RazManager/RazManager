using System.IO;

namespace RazManager.Silo.Grains
{
    public class Constants
    {
        public const string StreamProvider = "StreamProvider";

        public enum StreamName
        {
            //DeviceDeviceInformation,
            //DeviceConnectionStatus,
            //DeviceDeviceConfigurationOutput,
            //DeviceHeatOutput,
            //DeviceEvent,
            TrackConfigurationDeviceConfigurationInputs,
            DeviceConfigurationInputs,
            DeviceConfigurationOutputs,
            Event,
            EventState,
            EventSpeechTexts,
            Race,
            Heat,
            HeatState,
            HeatLeaderboard,
            HeatAnalyses,
            HeatStintAnalysis,
            HeatStintEventUsers
            //AllDeviceConfigurationDeviceConfigurationInput,
            //AllDeviceConfigurationDeviceConfigurationOutput,
            //AllHeatOutput,
            //AllEvent
        }
    }
}
