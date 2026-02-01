using Razmanager.Protobuf.Internal.Repository.CrudServices.Tenant;
using RazManager.Repository.CrudServices.Utilities;
using RazManager.Repository.Stores.Entities.Tenant;


namespace RazManager.Repository.CrudServices.Entities.Tenant
{
    public interface ITenantStore : IEntityCrudStore<TenantEntity, TenantRead, TenantCreateUpdate, TenantCreateUpdate>
    {
    }
}