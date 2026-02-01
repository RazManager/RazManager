using RazManager.Repository.Stores.Utilities;
using System.ComponentModel.DataAnnotations;
using System;


namespace RazManager.Repository.Stores.Entities.UserImage
{
    public class UserImageEntity : ImageEntityBase
    {
        [Required]
        public Guid UserId { get; set; }

        public User.UserEntity User { get; set; } = null!;
    }
}
