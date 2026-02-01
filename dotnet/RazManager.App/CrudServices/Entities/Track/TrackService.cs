using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Track;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Common;
using System.Threading.Tasks;
using Orleans;
using System;


namespace RazManager.App.CrudServices.Entities.Track
{
    [Authorize(Policy = "TenantAdministrator")]
    public class TrackService : Razmanager.Protobuf.Internal.Repository.CrudServices.Track.TrackService.TrackServiceBase
    {
        private readonly Razmanager.Protobuf.Internal.Repository.CrudServices.Track.TrackService.TrackServiceClient _serviceClient;
        private readonly IClusterClient _clusterClient;


        public TrackService(Razmanager.Protobuf.Internal.Repository.CrudServices.Track.TrackService.TrackServiceClient serviceClient,
                            IClusterClient clusterClient)
        {
            _serviceClient = serviceClient;
            _clusterClient = clusterClient;
        }


        public override async Task<TrackRead> Initialize(Empty request, ServerCallContext context)
        {
            return await _serviceClient.InitializeAsync(request);
        }


        public override async Task<TrackReadResponse> Read(IdRequest request, ServerCallContext context)
        {
            return await _serviceClient.ReadAsync(request);
        }


        public override async Task<CreateResponse> Create(TrackCreateUpdate request, ServerCallContext context)
        {
            return await _serviceClient.CreateAsync(request);
        }


        public override async Task<UpdateResponse> Update(TrackUpdateRequest request, ServerCallContext context)
        {
            var response = await _serviceClient.UpdateAsync(request);
            await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.Track.ITrackGrain>(new Guid(request.Id)).RefreshAsync();
            return response;
        }


        public override async Task<Empty> Delete(DeleteRequest request, ServerCallContext context)
        {
            return await _serviceClient.DeleteAsync(request);
        }


        public override async Task<TrackListResponse> List(ListRequest request, ServerCallContext context)
        {
            return await _serviceClient.ListAsync(request);
        }
    }
}