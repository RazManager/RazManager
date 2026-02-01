using RazManager.Repository.Stores.Utilities;
using RazManager.Utilities.Store;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.Event
{
    public class EventEntity : TenantChildEntityBase, ITimeToLiveAtRequired
    {
        [Required]
        [StringLength(100)]
        public string Name { get; set; } = null!;

        [StringLength(1000)]
        public string? Description { get; set; }

        public DateTime? StartsAt { get; set; }

        public DateTime? PublishFrom { get; set; }

        [Required]
        public DateTime TimeToLiveAt { get; set; } = DateTime.UtcNow.AddMonths(1);

        [Required]
        public Razmanager.Protobuf.Internal.Repository.CrudServices.Event.EventVisibilityTypeId EventVisibilityTypeId { get; set; }

        [Required]
        public List<EventImage.EventImageEntity> EventImages { get; set; } = new();

        [Required]
        public List<EventInvite.EventInviteEntity> EventInvites { get; set; } = new();

        [Required]
        public List<EventUser.EventUserEntity> EventUsers { get; set; } = new();

        [Required]
        public List<Race.RaceEntity> Races { get; set; } = new();

        public Guid? CurrentRaceId { get; set; }

        public Guid? CurrentHeatId { get; set; }
    }
}