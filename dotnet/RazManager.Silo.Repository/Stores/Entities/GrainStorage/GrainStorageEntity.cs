using System;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Silo.Repository.Stores.Entities.GrainStorage
{
    public class GrainStorageEntity
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        [StringLength(100)]
        public required string ClusterId { get; set; } = null!;

        [Required]
        [StringLength(100)]
        public required string StateName { get; set; } = null!;

        [Required]
        public required string GrainId { get; set; } = null!;

        [Required]
        public byte[] State { get; set; } = null!;

        [Required]
        public DateTime TimeToLiveAt { get; set; }

        [Required]
        [ConcurrencyCheck]
        public Guid ETag { get; set; }
    }
}
