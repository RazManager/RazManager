using RazManager.Repository.Stores.Utilities;
using RazManager.Utilities.Store;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.User
{
    public sealed class UserEntity : EntityBase, ITimeToLiveAtRequired
    {
        [Required]
        [StringLength(100)]
        public string UserName { get; set; } = null!;

        [StringLength(100)]
        [EmailAddress]
        public string? Email { get; set; }

        [StringLength(100)]
        public string Name { get; set; } = null!;

        [StringLength(3)]
        [MinLength(3)]
        public string ShortName { get; set; } = null!;

        [Required]
        public byte[] PasswordHash { get; set; } = null!;

        [Required]
        public bool Administrator { get; set; }

        [Required]
        public List<UserImage.UserImageEntity> UserImages { get; set; } = new();

        [Required]
        public List<EventUser.EventUserEntity> EventUsers { get; set; } = new();

        [Required]
        public List<TenantUser.TenantUserEntity> TenantUsers { get; set; } = new();

        [Required]
        public DateTime TimeToLiveAt { get; set; } = DateTime.UtcNow.AddYears(1);
    }
}