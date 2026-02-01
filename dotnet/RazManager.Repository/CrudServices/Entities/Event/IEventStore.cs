using Razmanager.Protobuf.Internal.Repository.CrudServices.Event;
using RazManager.Repository.CrudServices.Utilities;
using RazManager.Repository.Stores.Entities.Event;
using System.Collections.Generic;


namespace RazManager.Repository.CrudServices.Entities.Event
{
    public interface IEventStore : IEntityCrudStore<EventEntity, EventRead, EventCreateUpdate, EventCreateUpdate>
    {
        IAsyncEnumerable<EventList> ListAsync(int limit, int offset);
        IAsyncEnumerable<EventSelect> SelectAsync();
    }
}