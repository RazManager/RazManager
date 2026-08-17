using Orleans;
using System;
using System.Threading.Tasks;


namespace RazManager.Silo.Grains.Entities.RaceSessionWithStints
{
    public interface IRaceSessionWithStintsGrain : IGrainWithGuidKey
    {
        Task RefreshAsync();
        Task<Razmanager.Protobuf.Public.V1.RaceSessionWithStints> ReadAsync();
        Task<Razmanager.Protobuf.Public.V1.RaceSessionWithStintsState> ReadStateAsync();
        Task<Razmanager.Protobuf.Public.V1.RaceSessionLeaderboard> ReadLeaderboardAsync();
        Task CommandAsync(Razmanager.Protobuf.Public.V1.SummaryCommandTypeId commandTypeId);
        Task HeatWithStintsStateTypeUpdatedAsync(Razmanager.Protobuf.Public.V1.HeatWithStints heatWithStints);
        Task HeatWithStintsStateUpdatedAsync(Razmanager.Protobuf.Public.V1.HeatWithStints heatWithStints);
        Task RaceLeaderboardHeatEventUserUpdateAsync(Razmanager.Protobuf.Internal.Silo.SystemServices.EventUser.EventUserUpdate update);
    }
}
