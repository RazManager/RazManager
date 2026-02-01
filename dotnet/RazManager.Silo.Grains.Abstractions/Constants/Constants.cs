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
            EventSpeechData,
            Race,
            Heat,
            HeatState,
            HeatLeaderboard,
            HeatAnalyses,
            HeatStintAnalysis
            //AllDeviceConfigurationDeviceConfigurationInput,
            //AllDeviceConfigurationDeviceConfigurationOutput,
            //AllHeatOutput,
            //AllEvent
        }
    }
}
