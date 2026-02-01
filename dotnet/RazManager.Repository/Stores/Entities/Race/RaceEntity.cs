using RazManager.Repository.Stores.Utilities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.Race
{
    public class RaceEntity : EntityBase
    {
        [Required]
        public Guid EventId { get; set; }

        public Event.EventEntity Event { get; set; } = null!;

        [Required]
        public int Number { get; set; }

        [StringLength(100)]
        public string? Name { get; set; }

        [Required]
        public Guid TrackConfigurationId { get; set; }

        public TrackConfiguration.TrackConfigurationEntity TrackConfiguration { get; set; } = null!;

        public Guid? PointsSchemeId { get; set; }

        public PointsScheme.PointsSchemeEntity? PointsScheme { get; set; }

        [Required]
        public bool QualifyingSession { get; set; }

        [Required]
        public bool PracticeSession { get; set; }

        [Required]
        public bool RaceSession { get; set; } = true;

        [Required]
        public Razmanager.Protobuf.Internal.Repository.CrudServices.RaceFormatType.RaceFormatTypeId RaceFormatTypeId { get; set; }

        [Required]
        public Razmanager.Protobuf.Public.V1.HeatEndTypeId RaceHeatEndTypeId { get; set; }

        public int? RaceHeatEndLapLaps { get; set; }

        public TimeSpan? RaceHeatEndDurationDuration { get; set; }

        [Required]
        public List<RaceCarTag.RaceCarTagEntity> RaceCarTags { get; set; } = [];

        [Required]
        public Razmanager.Protobuf.Internal.Repository.CrudServices.HeatCarType.HeatCarTypeId HeatCarTypeId { get; set; }

        [Required]
        public List<RaceIndicator.RaceIndicatorEntity> RaceIndicators { get; set; } = [];

        [Required]
        public List<RaceEventUser.RaceEventUserEntity> RaceEventUsers { get; set; } = [];

        [Required]
        public List<RaceIndicatorEventUser.RaceIndicatorEventUserEntity> RaceIndicatorEventUsers { get; set; } = [];

        [Required]
        public List<Heat.HeatEntity> Heats { get; set; } = [];

        [Required]
        public Razmanager.Protobuf.Public.V1.RaceStateTypeId RaceStateTypeId { get; set; }

        [Required]
        public bool EnergySimulation { get; set; }
    }
}
