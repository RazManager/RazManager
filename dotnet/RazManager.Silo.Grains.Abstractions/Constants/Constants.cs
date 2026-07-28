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
            RaceSession,
            RaceSessionWithoutStintState,
            RaceSessionWithStintState,
            RaceSessionLeaderboard,
            HeatWithoutStint,
            HeatWithoutStintState,
            HeatWithoutStintLeaderboard,
            HeatWithStint,
            HeatWithStintState,
            HeatWithStintLeaderboard,
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
