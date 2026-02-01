using Orleans.Runtime;
using System;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Silo.Repository.Stores.Entities.Reminder
{
    public class ReminderEntity : IGrainReminder
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        [StringLength(100)]
        public required string ClusterId { get; set; } = null!;

        [Required]
        public required string GrainId { get; set; } = null!;

        [Required]
        public required string ReminderName { get; set; } = null!;

        [Required]
        public DateTime StartAt { get; set; }

        [Required]
        public TimeSpan Period { get; set; }

        [Required]
        [ConcurrencyCheck]
        public Guid ETag { get; set; }
    }
}
