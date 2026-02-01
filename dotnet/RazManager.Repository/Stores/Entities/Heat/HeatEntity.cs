using RazManager.Repository.Stores.Utilities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.Heat
{
    public class HeatEntity : IEntityId
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        public Guid RaceId { get; set; }

        public Race.RaceEntity Race { get; set; } = null!;

        [Required]
        public int Number { get; set; }

        [Required]
        public Razmanager.Protobuf.Public.V1.SessionTypeId SessionTypeId { get; set; }

        [Required]
        public List<HeatIndicator.HeatIndicatorEntity> HeatIndicators { get; set; } = new();

        [Required]
        public List<HeatJournal.HeatJournalEntity> HeatJournals { get; set; } = new();
    }
}