using Orleans;
using System;
using System.Threading.Tasks;


namespace RazManager.Silo.Grains.Entities.HeatWithoutStints
{
    public interface IHeatWithoutStintsGrain : IGrainWithGuidKey
    {
        Task RefreshHeatIndicatorStintsAsync(Guid heatIndicatorId);
        Task<Razmanager.Protobuf.Public.V1.HeatWithoutStints> ReadAsync();
        Task<Razmanager.Protobuf.Public.V1.DetailState> ReadStateAsync();
        Task<Razmanager.Protobuf.Public.V1.HeatWithoutStintsLeaderboard> ReadLeaderboardAsync();
        Task<Razmanager.Protobuf.Public.V1.HeatAnalyses> ReadHeatAnalysesAsync();
        Task<Razmanager.Protobuf.Public.V1.HeatStintAnalysisIndicatorStints> ReadHeatStintAnalysisIndicatorStintsAsync(byte indicatorId);
        Task<Razmanager.Protobuf.Public.V1.HeatStintEventUsers> ReadHeatStintEventUsersAsync();
        Task CommandAsync(Razmanager.Protobuf.Public.V1.DetailCommandTypeId commandTypeId);
        Task StartLightAsync();
    }
}
