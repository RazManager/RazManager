using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.HeatWithoutStint
{
    public class HeatWithoutStintEntity : HeatBase.HeatEntityBase
    {
        [Required]
        public List<HeatIndicator.HeatIndicatorEntity> HeatIndicators { get; set; } = [];

        [Required]
        public List<HeatJournal.HeatJournalEntity> HeatJournals { get; set; } = [];

        public string? PreconfiguredIndicatorsJson { get; set; }
    }
}