using Razmanager.Protobuf.Internal.Repository.CrudServices.Race;
using RazManager.Repository.CrudServices.Utilities;
using RazManager.Repository.Stores.Entities.Race;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;


namespace RazManager.Repository.CrudServices.Entities.Race
{
    public interface IRaceStore : IEntityCrudStore<RaceEntity, RaceRead, RaceCreate, RaceUpdate>
    {
        IAsyncEnumerable<RaceList> ListAsync(int limit, int offset);
        IAsyncEnumerable<RaceSelect> SelectAsync(Guid eventId);
        Task<Razmanager.Protobuf.Internal.Repository.CrudServices.Common.CreateResponse> CopyAsync(Guid id);
    }
}