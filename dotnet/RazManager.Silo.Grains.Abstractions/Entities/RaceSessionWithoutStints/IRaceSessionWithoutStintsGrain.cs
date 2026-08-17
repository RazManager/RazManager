using Orleans;
using System;
using System.Threading.Tasks;


namespace RazManager.Silo.Grains.Entities.RaceSessionWithoutStints
{
    public interface IRaceSessionWithoutStintsGrain : IGrainWithGuidKey
    {
        Task RefreshAsync();
        Task<Razmanager.Protobuf.Public.V1.RaceSessionWithoutStints> ReadAsync();
        Task<Razmanager.Protobuf.Public.V1.RaceSessionWithoutStintsState> ReadStateAsync();
        Task<Razmanager.Protobuf.Public.V1.RaceSessionLeaderboard> ReadLeaderboardAsync();
        Task CommandAsync(Razmanager.Protobuf.Public.V1.SummaryCommandTypeId commandTypeId);
        Task HeatWithoutStintsStateTypeUpdatedAsync(Razmanager.Protobuf.Public.V1.HeatWithoutStints heatWithoutStints);
        Task HeatWithoutStintsStateUpdatedAsync(Guid id, Razmanager.Protobuf.Public.V1.HeatWithoutStints heatWithoutStints);
        Task EventUserUpdateAsync(Razmanager.Protobuf.Internal.Silo.SystemServices.EventUser.EventUserUpdate update);
    }
}
