using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Event;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Common;
using System.Threading.Tasks;
using Orleans;
using System;


namespace RazManager.App.CrudServices.Entities.Event
{
    [Authorize(Policy = "TenantAdministrator")]
    public class EventService : Razmanager.Protobuf.Internal.Repository.CrudServices.Event.EventService.EventServiceBase
    {
        private readonly Razmanager.Protobuf.Internal.Repository.CrudServices.Event.EventService.EventServiceClient _serviceClient;
        private readonly IClusterClient _clusterClient;


        public EventService(Razmanager.Protobuf.Internal.Repository.CrudServices.Event.EventService.EventServiceClient serviceClient,
                            IClusterClient clusterClient)
        {
            _serviceClient = serviceClient;
            _clusterClient = clusterClient;
        }


        public override async Task<EventRead> Initialize(Empty request, ServerCallContext context)
        {
            return await _serviceClient.InitializeAsync(request);
        }


        public override async Task<EventReadResponse> Read(IdRequest request, ServerCallContext context)
        {
            return await _serviceClient.ReadAsync(request);
        }


        public override async Task<CreateResponse> Create(EventCreateUpdate request, ServerCallContext context)
        {
            return await _serviceClient.CreateAsync(request);
        }


        public override async Task<UpdateResponse> Update(EventUpdateRequest request, ServerCallContext context)
        {
            var response = await _serviceClient.UpdateAsync(request);
            await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.Event.IEventGrain>(new Guid(request.Id)).RefreshAsync();
            return response;
        }


        public override async Task<Empty> Delete(DeleteRequest request, ServerCallContext context)
        {
            return await _serviceClient.DeleteAsync(request);
        }


        public override async Task<EventListResponse> List(ListRequest request, ServerCallContext context)
        {
            return await _serviceClient.ListAsync(request);
        }


        public override async Task<EventSelectResponse> Select(Empty request, ServerCallContext context)
        {
            return await _serviceClient.SelectAsync(request);
        }
    }
}