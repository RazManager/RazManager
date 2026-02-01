using RazManager.Repository.Stores.Utilities;
using System.ComponentModel.DataAnnotations;
using System;


namespace RazManager.Repository.Stores.Entities.TenantImage
{
    public class TenantImageEntity : ImageEntityBase
    {
        [Required]
        public Guid TenantId { get; set; }

        public Tenant.TenantEntity Tenant { get; set; } = null!;
    }
}
