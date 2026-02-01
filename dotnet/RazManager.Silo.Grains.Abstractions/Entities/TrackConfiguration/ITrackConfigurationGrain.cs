using Orleans;
using Razmanager.Protobuf.Public.V1;
using System;
using System.Threading.Tasks;


namespace RazManager.Silo.Grains.Entities.TrackConfiguration
{
    public interface ITrackConfigurationGrain : IGrainWithGuidKey
    {
        Task RefreshAsync();
        Task DeviceConfigurationInputsAsync(Guid deviceConfigurationId, DeviceConfigurationInputs deviceConfigurationInputs, bool simulated);
        Task DeviceConfigurationOutputsAsync(DeviceConfigurationOutputs deviceConfigurationOutputs);
        //Task HeatOutputAsync(Heat.HeatOutputMessage heatOutput);
    }
}
