using RazManager.Repository.Stores.Utilities;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.PointsScheme
{
    public class PointsSchemeEntity : TenantChildEntityBase
    {
        [Required]
        [StringLength(100)]
        public string Name { get; set; } = null!;

        [StringLength(1000)]
        public string? Description { get; set; }

        [Required]
        [Range(1, 100)]
        public byte Position { get; set; } = 1;

        [Range(1, 100)]
        public byte? PointsRaceSessionHeatFastestLap { get; set; }

        [Range(1, 100)]
        public byte? PointsRaceSessionHeatMostLedLaps { get; set; }

        [Range(1, 100)]
        public byte? PointsRaceSessionHeatLedAtLeastOneLap { get; set; }

        [Range(1, 100)]
        public byte? PointsRaceSessionOverallFastestLap { get; set; }

        [Range(1, 100)]
        public byte? PointsRaceSessionOverallMostLedLaps { get; set; }

        [Required]
        [Range(1, 100)]
        public byte MinDrivers { get; set; } = 1;

        [Required]
        [Range(1, 100)]
        public byte MaxDrivers { get; set; } = 99;

        [Required]
        public List<PointsSchemePosition.PointsSchemePositionEntity> PointsSchemePositions { get; set; } = new();
    }
}
