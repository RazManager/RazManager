using RazManager.Repository.Stores.Utilities;
using System.ComponentModel.DataAnnotations;
using System;


namespace RazManager.Repository.Stores.Entities.CarImage
{
    public class CarImageEntity : ImageEntityBase
    {
        [Required]
        public Guid CarId { get; set; }

        public Car.CarEntity Car { get; set; } = null!;
    }
}
