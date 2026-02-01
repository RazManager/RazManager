using RazManager.Repository.Stores.Utilities;
using System.ComponentModel.DataAnnotations;
using System;


namespace RazManager.Repository.Stores.Entities.EventUserImage
{
    public class EventUserImageEntity : ImageEntityBase
    {
        [Required]
        public Guid EventUserId { get; set; }

        public EventUser.EventUserEntity EventUser { get; set; } = null!;
    }
}
