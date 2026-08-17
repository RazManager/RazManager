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
            DeviceRequest,
            DeviceResponse,
            Event,
            EventState,
            EventSpeechTexts,
            Race,
            RaceState,
            RaceSessionWithoutStints,
            RaceSessionWithoutStintsState,
            RaceSessionWithStints,
            RaceSessionWithStintsState,
            RaceSessionLeaderboard,
            HeatWithoutStints,
            HeatWithoutStintsState,
            HeatWithoutStintsLeaderboard,
            HeatWithStints,
            HeatWithStintsState,
            HeatWithStintsLeaderboard,
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
