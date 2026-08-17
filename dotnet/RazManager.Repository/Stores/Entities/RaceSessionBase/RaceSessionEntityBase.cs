using RazManager.Repository.Stores.Utilities;
using System;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.RaceSessionBase
{
    public class RaceSessionEntityBase : EntityBase
    {
        [Required]
        public Guid RaceId { get; set; }

        public Race.RaceEntity Race { get; set; } = null!;

        [Required]
        public Razmanager.Protobuf.Public.V1.SessionTypeId SessionTypeId { get; set; }

        [Required]
        public uint Number { get; set; }

        [StringLength(100)]
        public string? Name { get; set; }

        [Required]
        public Razmanager.Protobuf.Public.V1.HeatStintEndTypeId HeatStintEndTypeId { get; set; }

        public int? HeatStintEndLapLaps { get; set; }

        public TimeSpan? HeatStintEndDurationDuration { get; set; }

        [Required]
        public Razmanager.Protobuf.Public.V1.SummaryStateTypeId StateTypeId { get; set; }
    }
}
