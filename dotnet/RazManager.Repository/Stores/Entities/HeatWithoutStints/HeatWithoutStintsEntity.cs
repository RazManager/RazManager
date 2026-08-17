using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.HeatWithoutStints
{
    public class HeatWithoutStintsEntity : HeatBase.HeatEntityBase
    {
        [Required]
        public Guid RaceSessionWithoutStintsId { get; set; }

        public RaceSessionWithoutStints.RaceSessionWithoutStintsEntity RaceSessionWithoutStints { get; set; } = null!;

        [Required]
        public List<HeatIndicator.HeatIndicatorEntity> HeatIndicators { get; set; } = [];

        [Required]
        public List<HeatJournal.HeatJournalEntity> HeatJournals { get; set; } = [];

        public string? PreconfiguredIndicatorsJson { get; set; }
    }
}