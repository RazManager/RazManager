using RazManager.Repository.Stores.Utilities;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System;


namespace RazManager.Repository.Stores.Entities.TrackConfiguration
{
    public class TrackConfigurationEntity : IEntityId
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        public Guid TrackId { get; set; }

        public Track.TrackEntity Track { get; set; } = null!;

        [Required]
        [StringLength(100)]
        public string Name { get; set; } = null!;

        [Required]
        [Range(1, 60)]
        public byte LaptimeMinSeconds { get; set; } = 1;

        [Required]
        [Range(10, 600)]
        public short LaptimeMaxSeconds { get; set; } = 30;

        [Required]
        public List<TrackConfigurationDeviceConfiguration.TrackConfigurationDeviceConfigurationEntity> TrackConfigurationDeviceConfigurations { get; set; } = new();

        [Required]
        public List<TrackConfigurationRaceFormat.TrackConfigurationRaceFormatEntity> TrackConfigurationRaceFormats { get; set; } = new();

        [Required]
        public List<TrackConfigurationIndicator.TrackConfigurationIndicatorEntity> TrackConfigurationIndicators { get; set; } = new();

        //[Required]
        //public List<CarTrackConfiguration.CarTrackConfigurationEntity> CarTrackConfigurations { get; set; } = new();

        [Required]
        public List<Race.RaceEntity> Races { get; set; } = new();
    }
}
