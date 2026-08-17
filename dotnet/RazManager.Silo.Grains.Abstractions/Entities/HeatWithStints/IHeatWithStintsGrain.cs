using Orleans;
using System.Threading.Tasks;


namespace RazManager.Silo.Grains.Entities.HeatWithStints
{
    public interface IHeatWithStintsGrain : IGrainWithGuidKey
    {
        Task<Razmanager.Protobuf.Public.V1.HeatWithStints> ReadAsync();
        Task<Razmanager.Protobuf.Public.V1.HeatWithStintsState> ReadStateAsync();
        Task<Razmanager.Protobuf.Public.V1.HeatWithStintsLeaderboard> ReadLeaderboardAsync();
        Task CommandAsync(Razmanager.Protobuf.Public.V1.SummaryCommandTypeId commandTypeId);
        Task StintStateTypeUpdatedAsync(Razmanager.Protobuf.Public.V1.Stint stint);
        Task StintStateUpdatedAsync(Razmanager.Protobuf.Public.V1.Stint stint);
        Task EventUserUpdateAsync(Razmanager.Protobuf.Internal.Silo.SystemServices.EventUser.EventUserUpdate update);
    }
}
