using RazManager.Repository.Stores.Utilities;
using System.ComponentModel.DataAnnotations;
using System;


namespace RazManager.Repository.Stores.Entities.HeatStintJournal
{
    public class HeatStintJournalEntityBase : IEntityId
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        public DateTime Timestamp { get; set; }

        [Required]
        public uint SequenceNumber { get; set; }

        [Required]
        public byte[] Payload { get; set; } = null!;
    }
}
