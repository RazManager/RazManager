using RazManager.Repository.Stores.Utilities;
using RazManager.Utilities.Store;
using System.ComponentModel.DataAnnotations;
using System;


namespace RazManager.Repository.Stores.Entities.EventInvite
{
    public class EventInviteEntity : IEntityId, ITimeToLiveAtRequired
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        public Guid EventId { get; set; }

        public Event.EventEntity Event { get; set; } = null!;

        [Required]
        [Range(100000, 999999)]
        public int Code { get; set; }

        [Required]
        public bool Multiple { get; set; }

        [Required]
        public DateTime TimeToLiveAt { get; set; }
    }
}
