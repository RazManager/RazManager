using System;


namespace RazManager.Repository.Stores.Utilities
{
    public interface ITenantEntity
    {
        Guid TenantId { get; set; }
        public Entities.Tenant.TenantEntity Tenant { get; set; }
    }
}
