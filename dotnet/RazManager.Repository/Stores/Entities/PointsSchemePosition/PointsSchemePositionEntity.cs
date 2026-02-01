using RazManager.Repository.Stores.Utilities;
using System.ComponentModel.DataAnnotations;
using System;


namespace RazManager.Repository.Stores.Entities.PointsSchemePosition
{
    public class PointsSchemePositionEntity : IEntityId
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        public Guid PointsSchemeId { get; set; }

        public PointsScheme.PointsSchemeEntity PointsScheme { get; set; } = null!;

        [Required]
        [Range(1, 100)]
        public byte Position { get; set; }

        [Required]
        [Range(1, 100)]
        public byte Points { get; set; }
    }
}
