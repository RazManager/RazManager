using Orleans;
using System.Threading.Tasks;


namespace RazManager.Silo.Grains.Entities.Stint
{
    public interface IStintGrain : IGrainWithGuidKey
    {
        Task<Razmanager.Protobuf.Public.V1.Stint> ReadAsync();
        Task<Razmanager.Protobuf.Public.V1.DetailState> ReadStateAsync();
        Task CommandAsync(Razmanager.Protobuf.Public.V1.DetailCommandTypeId commandTypeId);
        Task StartLightAsync();
    }
}
