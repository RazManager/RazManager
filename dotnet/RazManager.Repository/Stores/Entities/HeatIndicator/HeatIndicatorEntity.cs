using RazManager.Repository.Stores.Utilities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.HeatIndicator
{
    public class HeatIndicatorEntity : IEntityId
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        public Guid HeatWithoutStintId { get; set; }

        public HeatWithoutStint.HeatWithoutStintEntity HeatWithoutStint { get; set; } = null!;

        [Required]
        public uint IndicatorId { get; set; }

        public Guid? EventUserId { get; set; }

        public EventUser.EventUserEntity? EventUser { get; set; } = null!;

        public uint? CarClassColor { get; set; }

        public Guid? CarId { get; set; }

        public Car.CarEntity? Car { get; set; }

        [Required]
        public List<HeatIndicatorStint.HeatIndicatorStintEntity> HeatIndicatorStints { get; set; } = new();
    }
}
