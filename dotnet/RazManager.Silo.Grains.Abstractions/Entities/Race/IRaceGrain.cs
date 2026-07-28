using Orleans;
using System.Threading.Tasks;


namespace RazManager.Silo.Grains.Entities.Race
{
    public interface IRaceGrain : IGrainWithGuidKey
    {
        Task RefreshAsync();
        Task<Razmanager.Protobuf.Public.V1.Race> ReadAsync();
        Task<Razmanager.Protobuf.Public.V1.SummaryStateType> ReadStateAsync();
        Task CommandAsync(Razmanager.Protobuf.Public.V1.SummaryCommandTypeId raceCommandTypeId);
    }
}
