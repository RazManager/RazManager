using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Orleans;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Common;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Race;
using System;
using System.Threading.Tasks;


namespace RazManager.App.CrudServices.Entities.Race
{
    [Authorize(Policy = "TenantAdministrator")]
    public class RaceService : Razmanager.Protobuf.Internal.Repository.CrudServices.Race.RaceService.RaceServiceBase
    {
        private readonly Razmanager.Protobuf.Internal.Repository.CrudServices.Race.RaceService.RaceServiceClient _serviceClient;
        private readonly IClusterClient _clusterClient;


        public RaceService(Razmanager.Protobuf.Internal.Repository.CrudServices.Race.RaceService.RaceServiceClient serviceClient,
                           IClusterClient clusterClient)
        {
            _serviceClient = serviceClient;
            _clusterClient = clusterClient;
        }


        public override async Task<RaceRead> Initialize(Empty request, ServerCallContext context)
        {
            return await _serviceClient.InitializeAsync(request);
        }


        public override async Task<RaceReadResponse> Read(IdRequest request, ServerCallContext context)
        {
            return await _serviceClient.ReadAsync(request);
        }


        public override async Task<CreateResponse> Create(RaceCreate request, ServerCallContext context)
        {
            return await _serviceClient.CreateAsync(request);
        }


        public override async Task<UpdateResponse> Update(RaceUpdateRequest request, ServerCallContext context)
        {
            var response = await _serviceClient.UpdateAsync(request);
            await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.Race.IRaceGrain>(new Guid(request.Id)).RefreshAsync();
            return response;
        }


        public override async Task<Empty> Delete(DeleteRequest request, ServerCallContext context)
        {
            return await _serviceClient.DeleteAsync(request);
        }


        public override async Task<RaceListResponse> List(ListRequest request, ServerCallContext context)
        {
            return await _serviceClient.ListAsync(request);
        }


        public override async Task<RaceSelectResponse> Select(RaceSelectRequest request, ServerCallContext context)
        {
            return await _serviceClient.SelectAsync(request);
        }


        public override async Task<CreateResponse> Copy(IdRequest request, ServerCallContext context)
        {
            return await _serviceClient.CopyAsync(request);
        }
    }
}