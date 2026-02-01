using RazManager.Repository.Stores.Utilities;
using System.ComponentModel.DataAnnotations;
using System;


namespace RazManager.Repository.Stores.Entities.HeatJournal
{
    public class HeatJournalEntity : IEntityId
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        public Guid HeatId { get; set; }

        public Heat.HeatEntity Heat { get; set; } = null!;

        [Required]
        public DateTime Timestamp { get; set; }

        [Required]
        public uint SequenceNumber { get; set; }

        [Required]
        public byte[] Payload { get; set; } = null!;
    }
}
