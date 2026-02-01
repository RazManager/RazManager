using RazManager.Repository.Stores.Utilities;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.Tenant
{
    public class TenantEntity : EntityBase
    {
        [Required]
        [StringLength(100)]
        public string Name { get; set; } = null!;

        [StringLength(1000)]
        public string? Description { get; set; }

        [Required]
        public bool Enabled { get; set; } = true;

        [Required]
        public List<TenantImage.TenantImageEntity> TenantImages { get; set; } = new();

        [Required]
        public List<TenantInvite.TenantInviteEntity> TenantInvites { get; set; } = new();

        [Required]
        public List<TenantUser.TenantUserEntity> TenantUsers { get; set; } = new();
    }
}
