using Orleans;
using System.Threading.Tasks;


namespace RazManager.Silo.Grains.Entities.DeviceConfigurationSimulation
{
    public interface IDeviceConfigurationSimulationGrain : IGrainWithGuidKey
    {
        Task RefreshAsync();
        Task<bool> ReadAsync();
        Task StartAsync();
        Task StopAsync();
    }
}
