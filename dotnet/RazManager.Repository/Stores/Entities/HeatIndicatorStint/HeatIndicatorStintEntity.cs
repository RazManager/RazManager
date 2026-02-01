using RazManager.Repository.Stores.Utilities;
using System.ComponentModel.DataAnnotations;
using System;


namespace RazManager.Repository.Stores.Entities.HeatIndicatorStint
{
    public class HeatIndicatorStintEntity : EntityBase
    {
        [Required]
        public Guid HeatIndicatorId { get; set; }

        public HeatIndicator.HeatIndicatorEntity HeatIndicator { get; set; } = null!;

        [Required]
        public uint Lap { get; set; }

        public Guid? EventUserId { get; set; }

        public EventUser.EventUserEntity? EventUser { get; set; } = null!;

        [StringLength(1000)]
        public string? Comments { get; set; }
    }
}
