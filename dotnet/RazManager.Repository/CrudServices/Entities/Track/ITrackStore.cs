using Razmanager.Protobuf.Internal.Repository.CrudServices.Track;
using RazManager.Repository.CrudServices.Utilities;
using RazManager.Repository.Stores.Entities.Track;
using System.Collections.Generic;


namespace RazManager.Repository.CrudServices.Entities.Track
{
    public interface ITrackStore : IEntityCrudStore<TrackEntity, TrackRead, TrackCreateUpdate, TrackCreateUpdate>
    {
        IAsyncEnumerable<TrackList> ListAsync(int limit, int offset);
    }
}