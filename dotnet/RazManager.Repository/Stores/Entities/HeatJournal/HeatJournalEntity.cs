using RazManager.Repository.Stores.Entities.HeatStintJournal;
using System;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.HeatJournal
{
    public class HeatJournalEntity : HeatStintJournalEntityBase
    {
        [Required]
        public Guid HeatWithoutStintsId { get; set; }

        public HeatWithoutStints.HeatWithoutStintsEntity HeatWithoutStints { get; set; } = null!;
    }
}
