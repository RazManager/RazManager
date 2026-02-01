using RazManager.Repository.Stores.Utilities;
using System.ComponentModel.DataAnnotations;
using System;


namespace RazManager.Repository.Stores.Entities.EventImage
{
    public class EventImageEntity : ImageEntityBase
    {
        [Required]
        public Guid EventId { get; set; }

        public Event.EventEntity Event { get; set; } = null!;
    }
}
