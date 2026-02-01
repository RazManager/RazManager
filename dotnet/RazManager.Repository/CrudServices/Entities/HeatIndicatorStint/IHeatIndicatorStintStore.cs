using Razmanager.Protobuf.Internal.Repository.CrudServices.HeatIndicatorStint;
using RazManager.Repository.CrudServices.Utilities;
using RazManager.Repository.Stores.Entities.HeatIndicatorStint;


namespace RazManager.Repository.CrudServices.Entities.HeatIndicatorStint
{
    public interface IHeatIndicatorStintStore : IEntityCrudStore<HeatIndicatorStintEntity, HeatIndicatorStintRead, HeatIndicatorStintCreate, HeatIndicatorStintUpdate>
    {
    }
}