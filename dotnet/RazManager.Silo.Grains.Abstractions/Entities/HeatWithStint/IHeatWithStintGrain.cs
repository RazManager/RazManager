using Orleans;
using System.Threading.Tasks;


namespace RazManager.Silo.Grains.Entities.HeatWithStint
{
    public interface IHeatWithStintGrain : IGrainWithGuidKey
    {
        Task<Razmanager.Protobuf.Public.V1.HeatWithStint> ReadAsync();
        Task<Razmanager.Protobuf.Public.V1.HeatWithStintState> ReadHeatWithStateAsync();
        Task<Razmanager.Protobuf.Public.V1.HeatWithStintLeaderboard> ReadHeatWithStintLeaderboardAsync();
        Task CommandAsync(Razmanager.Protobuf.Public.V1.SummaryCommandTypeId heatWithStintCommandTypeId);
        Task StintStateTypeUpdatedAsync(Razmanager.Protobuf.Public.V1.Stint stint);
        Task StintStateUpdatedAsync(Razmanager.Protobuf.Public.V1.Stint stint);
        Task EventUserUpdateAsync(Razmanager.Protobuf.Internal.Silo.SystemServices.EventUser.EventUserUpdate update);
    }
}
