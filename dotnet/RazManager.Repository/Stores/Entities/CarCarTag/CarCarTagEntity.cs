using RazManager.Repository.Stores.Utilities;
using System;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.CarCarTag
{
    public class CarCarTagEntity : IEntityId
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        public Guid CarId { get; set; }

        public Car.CarEntity Car { get; set; } = null!;

        [Required]
        public Guid CarTagId { get; set; }

        public CarTag.CarTagEntity CarTag { get; set; } = null!;
    }
}
