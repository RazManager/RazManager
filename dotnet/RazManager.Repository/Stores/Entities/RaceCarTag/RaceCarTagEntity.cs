using RazManager.Repository.Stores.Utilities;
using System;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.RaceCarTag
{
    public class RaceCarTagEntity : IEntityId
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        public Guid RaceId { get; set; }

        public Race.RaceEntity Race { get; set; } = null!;

        [Required]
        public Guid CarTagId { get; set; }

        public CarTag.CarTagEntity CarTag { get; set; } = null!;
    }
}
