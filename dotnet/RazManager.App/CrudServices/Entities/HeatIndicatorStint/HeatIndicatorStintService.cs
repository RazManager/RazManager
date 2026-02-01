using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Orleans;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Common;
using Razmanager.Protobuf.Internal.Repository.CrudServices.HeatIndicatorStint;
using System;
using System.Threading.Tasks;


namespace RazManager.App.CrudServices.Entities.HeatIndicatorStint
{
    [Authorize]
    public class HeatIndicatorStintService : Razmanager.Protobuf.Internal.Repository.CrudServices.HeatIndicatorStint.HeatIndicatorStintService.HeatIndicatorStintServiceBase
    {
        private readonly Razmanager.Protobuf.Internal.Repository.CrudServices.HeatIndicatorStint.HeatIndicatorStintService.HeatIndicatorStintServiceClient _serviceClient;
        private readonly Razmanager.Protobuf.Internal.Repository.SystemServices.HeatIndicatorStint.HeatIndicatorStintService.HeatIndicatorStintServiceClient _systemServiceClient;
        private readonly IClusterClient _clusterClient;


        public HeatIndicatorStintService(Razmanager.Protobuf.Internal.Repository.CrudServices.HeatIndicatorStint.HeatIndicatorStintService.HeatIndicatorStintServiceClient serviceClient,
                                         Razmanager.Protobuf.Internal.Repository.SystemServices.HeatIndicatorStint.HeatIndicatorStintService.HeatIndicatorStintServiceClient systemServiceClient,
                                         IClusterClient clusterClient)
        {
            _serviceClient = serviceClient;
            _systemServiceClient = systemServiceClient;
            _clusterClient = clusterClient;
        }


        public override async Task<HeatIndicatorStintRead> Initialize(Empty request, ServerCallContext context)
        {
            return await _serviceClient.InitializeAsync(request);
        }


        public override async Task<HeatIndicatorStintReadResponse> Read(IdRequest request, ServerCallContext context)
        {
            return await _serviceClient.ReadAsync(request);
        }


        public override async Task<CreateResponse> Create(HeatIndicatorStintCreate request, ServerCallContext context)
        {
            var response = await _serviceClient.CreateAsync(request);
            var parentIds = await _systemServiceClient.ReadAsync(new StringValue { Value = response.Id});
            await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.Heat.IHeatGrain>(new Guid(parentIds.HeatId)).RefreshHeatIndicatorStintsAsync(new Guid(parentIds.HeatIndicatorId));
            return response;
        }


        public override async Task<UpdateResponse> Update(HeatIndicatorStintUpdateRequest request, ServerCallContext context)
        {
            var response = await _serviceClient.UpdateAsync(request);
            var parentIds = await _systemServiceClient.ReadAsync(new StringValue { Value = request.Id });
            await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.Heat.IHeatGrain>(new Guid(parentIds.HeatId)).RefreshHeatIndicatorStintsAsync(new Guid(parentIds.HeatIndicatorId));
            return response;
        }


        public override async Task<Empty> Delete(DeleteRequest request, ServerCallContext context)
        {
            var parentIds = await _systemServiceClient.ReadAsync(new StringValue { Value = request.Id });
            var response = await _serviceClient.DeleteAsync(request);
            await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.Heat.IHeatGrain>(new Guid(parentIds.HeatId)).RefreshHeatIndicatorStintsAsync(new Guid(parentIds.HeatIndicatorId));
            return response;
        }
    }
}