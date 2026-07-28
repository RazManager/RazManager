using RazManager.Repository.Stores.Entities.HeatStintJournal;
using System;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.StintJournal
{
    public class StintJournalEntity : HeatStintJournalEntityBase
    {
        [Required]
        public Guid StintId { get; set; }

        public Stint.StintEntity Stint { get; set; } = null!;
    }
}
