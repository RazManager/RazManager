using Orleans;
using Razmanager.Protobuf.Internal.Silo.UserServices.Event;
using System;
using System.Threading.Tasks;


namespace RazManager.Silo.Grains.Entities.Event
{
    public interface IEventGrain : IGrainWithGuidKey
    {
        Task RefreshAsync(bool publish);
        Task<Razmanager.Protobuf.Public.V1.Event> ReadAsync();
        Task<Razmanager.Protobuf.Public.V1.EventState> ReadEventStateAsync();
        Task EventUserSpeechData(Guid eventUserId, EventSpeechTypeId eventSpeechTypeId, string text);
    }
}
