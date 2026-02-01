using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Track;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Common;
using System;
using System.Threading.Tasks;


namespace RazManager.Repository.CrudServices.Entities.Track
{

    [Authorize]
    public class TrackService : Razmanager.Protobuf.Internal.Repository.CrudServices.Track.TrackService.TrackServiceBase
    {
        private readonly ITrackStore _entityCrudStore;


        public TrackService(ITrackStore entityCrudStore)
        {
            _entityCrudStore = entityCrudStore;
        }


        public override Task<TrackRead> Initialize(Empty request, ServerCallContext context)
        {
            return _entityCrudStore.InitializeAsync();
        }


        public override async Task<TrackReadResponse> Read(IdRequest request, ServerCallContext context)
        {
            var response = await _entityCrudStore.ReadAsync(new Guid(request.Id));
            return new TrackReadResponse
            {
                Entity = response.Proto,
                Etag = response.ETag
            };
        }


        public override Task<CreateResponse> Create(TrackCreateUpdate request, ServerCallContext context)
        {
            return _entityCrudStore.CreateAsync(request);
        }


        public override Task<UpdateResponse> Update(TrackUpdateRequest request, ServerCallContext context)
        {
            return _entityCrudStore.UpdateAsync(new Guid(request.Id), request.Entity, request.Etag);
        }


        public override Task<Empty> Delete(DeleteRequest request, ServerCallContext context)
        {
            return _entityCrudStore.DeleteAsync(new Guid(request.Id), request.Etag);
        }


        public override async Task<TrackListResponse> List(ListRequest request, ServerCallContext context)
        {
            var response = _entityCrudStore.ListAsync(request.Limit, request.Offset);
            var result = new TrackListResponse();
            await foreach (var item in response)
            {
                result.Result.Add(item);
            }
            return result;
        }
    }
}
