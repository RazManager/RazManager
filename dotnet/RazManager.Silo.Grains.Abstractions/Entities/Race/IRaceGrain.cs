using Orleans;
using Razmanager.Protobuf.Public.V1;
using System;
using System.Threading.Tasks;


namespace RazManager.Silo.Grains.Entities.Race
{
    public interface IRaceGrain : IGrainWithGuidKey
    {
        Task RefreshAsync();
        Task<Razmanager.Protobuf.Public.V1.Race> ReadAsync();
        Task<Guid?> CurrentHeatAsync();
        Task<Razmanager.Protobuf.Public.V1.RaceState> ReadRaceStateAsync(SessionTypeId sessionTypeId);
        Task<Razmanager.Protobuf.Public.V1.RaceLeaderboard> ReadRaceLeaderboardAsync(SessionTypeId sessionTypeId);
        Task CommandAsync(Razmanager.Protobuf.Public.V1.RaceCommandTypeId raceCommandTypeId);
        Task HeatStateTypeUpdatedAsync(Guid id, Razmanager.Protobuf.Public.V1.HeatStateType heatStateType);
        Task HeatStateUpdatedAsync(Guid id, Razmanager.Protobuf.Public.V1.HeatState heatState);
        Task RaceLeaderboardHeatEventUserUpdateAsync(Razmanager.Protobuf.Public.V1.RaceLeaderboardHeatEventUserUpdate update);
    }
}
