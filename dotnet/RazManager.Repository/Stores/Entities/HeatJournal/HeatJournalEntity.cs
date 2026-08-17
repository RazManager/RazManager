using RazManager.Repository.Stores.Entities.HeatStintJournal;
using System;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.HeatJournal
{
    public class HeatJournalEntity : HeatStintJournalEntityBase
    {
        [Required]
        public Guid HeatWithoutStintId { get; set; }

        public HeatWithoutStint.HeatWithoutStintsEntity HeatWithoutStint { get; set; } = null!;
    }
}
