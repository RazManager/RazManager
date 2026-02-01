using System.ComponentModel.DataAnnotations;
using System;


namespace RazManager.Repository.Stores.Utilities
{
    public class TenantChildEntityBase : EntityBase, ITenantEntity
    {
        [Required]
        public Guid TenantId { get; set; }

        public Entities.Tenant.TenantEntity Tenant { get; set; } = null!;
    }
}
