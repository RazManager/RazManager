using Orleans;
using Razmanager.Protobuf.Public.V1;
using System;
using System.Threading.Tasks;


namespace RazManager.Silo.Grains.Entities.Heat
{
    public interface IHeatGrain : IGrainWithGuidKey
    {
        Task RefreshHeatIndicatorStintsAsync(Guid heatIndicatorId);
        Task<Razmanager.Protobuf.Public.V1.Heat> ReadAsync();
        Task<Razmanager.Protobuf.Public.V1.HeatState> ReadHeatStateAsync();
        Task<Razmanager.Protobuf.Public.V1.HeatLeaderboard> ReadHeatLeaderboardAsync();
        Task<Razmanager.Protobuf.Public.V1.HeatAnalyses> ReadHeatAnalysesAsync();
        Task<Razmanager.Protobuf.Public.V1.HeatStintAnalysisIndicatorStints> ReadHeatStintAnalysisIndicatorStintsAsync(byte indicatorId);
        Task<Razmanager.Protobuf.Public.V1.HeatStintEventUsers> ReadHeatStintEventUsersAsync();
        Task CommandAsync(Razmanager.Protobuf.Public.V1.HeatCommandTypeId heatCommandTypeId);
        Task StartLightAsync();
    }
}
