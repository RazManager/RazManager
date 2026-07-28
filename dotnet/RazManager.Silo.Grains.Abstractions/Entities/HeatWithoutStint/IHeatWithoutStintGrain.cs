using Orleans;
using System;
using System.Threading.Tasks;


namespace RazManager.Silo.Grains.Entities.HeatWithoutStint
{
    public interface IHeatWithoutStintGrain : IGrainWithGuidKey
    {
        Task RefreshHeatIndicatorStintsAsync(Guid heatIndicatorId);
        Task<Razmanager.Protobuf.Public.V1.HeatWithoutStint> ReadAsync();
        Task<Razmanager.Protobuf.Public.V1.DetailState> ReadHeatWithoutStintStateAsync();
        Task<Razmanager.Protobuf.Public.V1.HeatWithoutStintLeaderboard> ReadHeatWithoutStintLeaderboardAsync();
        Task<Razmanager.Protobuf.Public.V1.HeatAnalyses> ReadHeatAnalysesAsync();
        Task<Razmanager.Protobuf.Public.V1.HeatStintAnalysisIndicatorStints> ReadHeatStintAnalysisIndicatorStintsAsync(byte indicatorId);
        Task<Razmanager.Protobuf.Public.V1.HeatStintEventUsers> ReadHeatStintEventUsersAsync();
        Task CommandAsync(Razmanager.Protobuf.Public.V1.DetailCommandTypeId heatWithoutStintCommandTypeId);
        Task StartLightAsync();
    }
}
