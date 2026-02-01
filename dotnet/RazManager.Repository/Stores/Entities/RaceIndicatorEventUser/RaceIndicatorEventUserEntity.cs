using RazManager.Repository.Stores.Utilities;
using System.ComponentModel.DataAnnotations;
using System;


namespace RazManager.Repository.Stores.Entities.RaceIndicatorEventUser
{
    public class RaceIndicatorEventUserEntity : IEntityId
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        public Guid RaceId { get; set; }

        public required Race.RaceEntity Race { get; set; }

        [Required]
        public uint IndicatorId { get; set; }

        public Guid? EventUserId { get; set; }

        public EventUser.EventUserEntity? EventUser { get; set; }

        public uint? CarClassColor { get; set; }

        public Guid? CarId { get; set; }

        public Car.CarEntity? Car { get; set; }
    }
}
