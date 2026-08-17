using Orleans;
using Razmanager.Protobuf.Internal.Silo.UserServices.Event;
using System;
using System.Threading.Tasks;


namespace RazManager.Silo.Grains.Entities.Event
{
    public interface IEventGrain : IGrainWithGuidKey
    {
        Task RefreshAsync();
        Task<Razmanager.Protobuf.Public.V1.Event> ReadAsync();
        Task<Razmanager.Protobuf.Public.V1.EventState> ReadStateAsync();
        Task EventSpeechTexts(Guid eventUserId, EventSpeechTexts texts);
    }
}