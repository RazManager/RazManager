using Orleans;
using System;
using System.Threading.Tasks;


namespace RazManager.Silo.Grains.Entities.RaceSessionWithStint
{
    public interface IRaceSessionWithStintGrain : IGrainWithGuidKey
    {
        Task RefreshAsync();
        Task<Razmanager.Protobuf.Public.V1.RaceSession> ReadAsync();
        //Task<Guid?> CurrentHeatAsync();
        Task<Razmanager.Protobuf.Public.V1.RaceSessionWithStintState> ReadRaceWithStintStateAsync();
        Task<Razmanager.Protobuf.Public.V1.RaceSessionLeaderboard> ReadSessionRaceLeaderboardAsync();
        Task CommandAsync(Razmanager.Protobuf.Public.V1.SummaryCommandTypeId raceSessionCommandTypeId);
        Task HeatWithStintStateTypeUpdatedAsync(Guid id, Razmanager.Protobuf.Public.V1.SummaryStateType heatWithStintStateType);
        Task HeatWithStintStateUpdatedAsync(Guid id, Razmanager.Protobuf.Public.V1.HeatWithStintState heatWithStintState);
        Task RaceLeaderboardHeatEventUserUpdateAsync(Razmanager.Protobuf.Internal.Silo.SystemServices.EventUser.EventUserUpdate update);
    }
}
