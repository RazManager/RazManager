using Orleans;
using System;
using System.Threading.Tasks;


namespace RazManager.Silo.Grains.Entities.RaceSessionWithoutStint
{
    public interface IRaceSessionWithoutStintGrain : IGrainWithGuidKey
    {
        Task RefreshAsync();
        Task<Razmanager.Protobuf.Public.V1.Race> ReadAsync();
        Task<Razmanager.Protobuf.Public.V1.RaceSessionWithoutStintState> ReadRaceSessionWithoutStintStateAsync();
        Task<Razmanager.Protobuf.Public.V1.RaceSessionLeaderboard> ReadRaceSessionLeaderboardAsync();
        Task CommandAsync(Razmanager.Protobuf.Public.V1.SummaryCommandTypeId raceSessionCommandTypeId);
        Task HeatWithoutStintStateTypeUpdatedAsync(Razmanager.Protobuf.Public.V1.HeatWithoutStint heatWithoutStint);
        Task HeatWithoutStintStateUpdatedAsync(Guid id, Razmanager.Protobuf.Public.V1.HeatWithoutStint heatWithoutStint);
        Task EventUserUpdateAsync(Razmanager.Protobuf.Internal.Silo.SystemServices.EventUser.EventUserUpdate update);
    }
}
