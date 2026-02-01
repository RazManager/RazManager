using RazManager.Repository.Stores.Utilities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.EventUser
{
    public class EventUserEntity : IEntityId
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        public Guid EventId { get; set; }

        public Event.EventEntity Event { get; set; } = null!;

        public Guid? EventUserId { get; set; }

        public EventUserEntity? EventUser { get; set; }

        public Guid? UserId { get; set; }

        public User.UserEntity? User { get; set; }

        public Guid? AutopilotId { get; set; }

        public Autopilot.AutopilotEntity? Autopilot { get; set; }

        [StringLength(100)]
        public string? Name { get; set; }

        [StringLength(3)]
        [MinLength(3)]
        public string? ShortName { get; set; }

        [Required]
        public Razmanager.Protobuf.Public.V1.EventUserTypeId EventUserTypeId { get; set; }

        [Required]
        public List<EventUserImage.EventUserImageEntity> EventUserImages { get; set; } = [];

        [Required]
        public List<EventUserEntity> EventUsers { get; set; } = [];

        //[Required]
        //public List<RaceEventUser.RaceEventUserEntity> RaceEventUsers { get; set; } = new();

        //[Required]
        //public List<RaceIndicatorEventUser.RaceIndicatorEventUserEntity> RaceIndicatorEventUsers { get; set; } = new();

        //[Required]
        //public List<HeatIndicatorEventUser.HeatIndicatorEventUserEntity> HeatIndicatorEventUsers { get; set; } = new();
    }
}
