using RazManager.Repository.Stores.Utilities;
using System.ComponentModel.DataAnnotations;
using System;


namespace RazManager.Repository.Stores.Entities.TenantUser
{
    public class TenantUserEntity : IEntityId, ITenantEntity
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        public Guid TenantId { get; set; }

        public Tenant.TenantEntity Tenant { get; set; } = null!;

        public Guid? UserId { get; set; }

        public User.UserEntity? User { get; set; }

        [StringLength(100)]
        public string? Name { get; set; }

        [StringLength(3)]
        [MinLength(3)]
        public string? ShortName { get; set; }

        [Required]
        public bool Administrator { get; set; }
    }
}
