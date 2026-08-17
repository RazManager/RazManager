using RazManager.Repository.Stores.Utilities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.Stint
{

    public class StintEntity : IEntityId
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        public Guid HeatWithStintsId { get; set; }

        public HeatWithStints.HeatWithStintsEntity HeatWithStints { get; set; } = null!;

        [Required]
        public uint Number { get; set; }

        [StringLength(100)]
        public string? Name { get; set; }

        [Required]
        public List<StintIndicator.StintIndicatorEntity> StintIndicators { get; set; } = [];

        [Required]
        public List<StintJournal.StintJournalEntity> StintJournals { get; set; } = [];
    }
}