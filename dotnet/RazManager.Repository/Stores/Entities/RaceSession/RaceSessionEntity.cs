using RazManager.Repository.Stores.Utilities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.RaceSession
{
    public class RaceSessionEntity : EntityBase
    {
        [Required]
        public Guid RaceId { get; set; }

        public Race.RaceEntity Race { get; set; } = null!;

        [Required]
        public Razmanager.Protobuf.Public.V1.SessionTypeId SessionTypeId { get; set; }

        [Required]
        public Razmanager.Protobuf.Public.V1.HeatStintEndTypeId HeatStintEndTypeId { get; set; }

        public int? HeatStintEndLapLaps { get; set; }

        public TimeSpan? HeatStintEndDurationDuration { get; set; }

        [Required]
        public List<HeatWithoutStint.HeatWithoutStintEntity> HeatWithoutStints { get; set; } = [];

        [Required]
        public List<HeatWithStint.HeatWithStintEntity> HeatWithStints { get; set; } = [];

        [Required]
        public Razmanager.Protobuf.Public.V1.SummaryStateTypeId RaceSessionStateTypeId { get; set; }
    }
}
