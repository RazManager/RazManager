using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Common;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Event;
using System;
using System.Threading.Tasks;


namespace RazManager.Repository.CrudServices.Entities.Event
{

    [Authorize]
    public class EventService : Razmanager.Protobuf.Internal.Repository.CrudServices.Event.EventService.EventServiceBase
    {
        private readonly IEventStore _entityCrudStore;


        public EventService(IEventStore entityCrudStore)
        {
            _entityCrudStore = entityCrudStore;
        }


        public override Task<EventRead> Initialize(Empty request, ServerCallContext context)
        {
            return _entityCrudStore.InitializeAsync();
        }


        public override async Task<EventReadResponse> Read(IdRequest request, ServerCallContext context)
        {
            var response = await _entityCrudStore.ReadAsync(new Guid(request.Id));
            return new EventReadResponse
            {
                Entity = response.Proto,
                Etag = response.ETag
            };
        }


        public override Task<CreateResponse> Create(EventCreateUpdate request, ServerCallContext context)
        {
            return _entityCrudStore.CreateAsync(request);
        }


        public override Task<UpdateResponse> Update(EventUpdateRequest request, ServerCallContext context)
        {
            return _entityCrudStore.UpdateAsync(new Guid(request.Id), request.Entity, request.Etag);
        }


        public override Task<Empty> Delete(DeleteRequest request, ServerCallContext context)
        {
            return _entityCrudStore.DeleteAsync(new Guid(request.Id), request.Etag);
        }


        public override async Task<EventListResponse> List(ListRequest request, ServerCallContext context)
        {
            var response = _entityCrudStore.ListAsync(request.Limit, request.Offset);
            var result = new EventListResponse();
            await foreach (var item in response)
            {
                result.Result.Add(item);
            }
            return result;
        }


        public override async Task<EventSelectResponse> Select(Empty request, ServerCallContext context)
        {
            var response = _entityCrudStore.SelectAsync();
            var result = new EventSelectResponse();
            await foreach (var item in response)
            {
                result.Result.Add(item);
            }
            return result;
        }
    }
}
