using RazManager.Repository.Stores.Utilities;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.Car
{
    public class CarEntity : TenantChildEntityBase
    {
        [Required]
        [StringLength(100)]
        public string Name { get; set; } = null!;

        [Range(1, 200)]
        public int? Number { get; set; }

        [StringLength(1000)]
        public string? Description { get; set; }

        //[Required]
        //public bool FuelTankSizeTrack { get; set; }

        //[Range(1, 100)]
        //public byte? FuelTankSize { get; set; }

        [Required]
        public List<CarImage.CarImageEntity> CarImages { get; set; } = [];

        [Required]
        public List<CarCarTag.CarCarTagEntity> CarCarTags { get; set; } = [];

        //[Required]
        //public List<CarTrackConfiguration.CarTrackConfigurationEntity> CarTrackConfigurations { get; set; } = new();

        //[Required]
        //public List<RaceIndicator.RaceIndicatorEntity> RaceIndicators { get; set; } = new();

        //[Required]
        //public List<RaceEventUser.RaceEventUserEntity> RaceEventUsers { get; set; } = new();

        //[Required]
        //public List<RaceIndicatorEventUser.RaceIndicatorEventUserEntity> RaceIndicatorEventUsers { get; set; } = new();

        //[Required]
        //public List<HeatIndicatorEventUser.HeatIndicatorEventUserEntity> HeatIndicatorEventUsers { get; set; } = new();
    }
}
