using Orleans;
using Razmanager.Protobuf.Public.V1;
using System.Threading.Tasks;


namespace RazManager.Silo.Grains.Entities.DeviceConfiguration
{
    public interface IDeviceConfigurationGrain : IGrainWithGuidKey
    {
        Task RefreshAsync();
        Task DeviceConfigurationInputsAsync(DeviceConfigurationInputs deviceConfigurationInputs, bool simulated);
        Task DeviceConfigurationOutputsAsync(DeviceConfigurationOutputs deviceConfigurationOutputs);
        //Task HeatOutputAsync(Heat.HeatOutputMessage heatOutput);
    }
}
