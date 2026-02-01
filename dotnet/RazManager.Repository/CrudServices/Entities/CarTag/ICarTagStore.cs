using Razmanager.Protobuf.Internal.Repository.CrudServices.CarTag;
using RazManager.Repository.CrudServices.Utilities;
using RazManager.Repository.Stores.Entities.CarTag;
using System.Collections.Generic;


namespace RazManager.Repository.CrudServices.Entities.CarTag
{
    public interface ICarTagStore : IEntityCrudStore<CarTagEntity, CarTagRead, CarTagCreateUpdate, CarTagCreateUpdate>
    {
        IAsyncEnumerable<CarTagList> ListAsync(int limit, int offset);
        IAsyncEnumerable<CarTagSelect> SelectAsync();
    }
}