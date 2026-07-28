using RazManager.Repository.Stores.Utilities;
using System;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.HeatBase
{
    public abstract class HeatEntityBase : IEntityId
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        public Guid RaceSessionId { get; set; }

        public RaceSession.RaceSessionEntity RaceSession { get; set; } = null!;

        [Required]
        public uint Number { get; set; }

        [StringLength(100)]
        public string? Name { get; set; }

        public uint? EventUserCount { get; set; }
    }
}