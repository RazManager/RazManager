using Orleans;
using Razmanager.Protobuf.Public.V1;
using System.Threading.Tasks;


namespace RazManager.Silo.Grains.Entities.Device
{
    public interface IDeviceGrain : IGrainWithGuidKey
    {
        //Task DeviceInformationAsync(DeviceInformation deviceInformation);
        Task RefreshAsync();
        //Task ConnectedAsync();
        //Task DisconnectedAsync();
    }
}
