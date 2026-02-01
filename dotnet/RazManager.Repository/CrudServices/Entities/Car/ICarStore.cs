using Razmanager.Protobuf.Internal.Repository.CrudServices.Car;
using RazManager.Repository.CrudServices.Utilities;
using RazManager.Repository.Stores.Entities.Car;
using System;
using System.Collections.Generic;


namespace RazManager.Repository.CrudServices.Entities.Car
{
    public interface ICarStore : IEntityCrudStore<CarEntity, CarRead, CarCreateUpdate, CarCreateUpdate>
    {
        IAsyncEnumerable<CarList> ListAsync(int limit, int offset, IEnumerable<Guid> carTagIds);
        IAsyncEnumerable<CarSelect> SelectAsync();
    }
}