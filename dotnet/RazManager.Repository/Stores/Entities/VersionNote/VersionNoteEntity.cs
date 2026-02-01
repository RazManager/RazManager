using System;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.VersionNote
{
    public class VersionNoteEntity
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        public Guid VersionId { get; set; }

        public Version.VersionEntity Version { get; set; } = null!;

        [Required]
        [Range(1, 99)]
        public byte Position { get; set; }

        [Required]
        [StringLength(1000)]
        public string Description { get; set; } = null!;
    }
}
