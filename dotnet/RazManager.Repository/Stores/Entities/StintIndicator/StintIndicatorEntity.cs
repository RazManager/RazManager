using RazManager.Repository.Stores.Utilities;
using System;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.StintIndicator
{
    public class StintIndicatorEntity : IEntityId
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        public Guid StintId { get; set; }

        public Stint.StintEntity Stint { get; set; } = null!;

        [Required]
        public uint IndicatorId { get; set; }

        public Guid? EventUserId { get; set; }

        public EventUser.EventUserEntity? EventUser { get; set; } = null!;

        public Guid? CarId { get; set; }

        public Car.CarEntity? Car { get; set; }
    }
}
