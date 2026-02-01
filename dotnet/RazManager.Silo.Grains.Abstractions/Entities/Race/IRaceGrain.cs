using Orleans;
using System;
using System.Threading.Tasks;


namespace RazManager.Silo.Grains.Entities.Race
{
    public interface IRaceGrain : IGrainWithGuidKey
    {
        Task RefreshAsync(bool publish);
        Task<Razmanager.Protobuf.Public.V1.Race> ReadAsync();
        Task<Guid?> ReadRaceStateAsync();
        Task<Razmanager.Protobuf.Public.V1.RaceLeaderboard> ReadRaceLeaderboardAsync();
        Task CommandAsync(Razmanager.Protobuf.Public.V1.RaceCommandTypeId raceCommandTypeId);
        Task HeatClosedAsync();
    }
}
