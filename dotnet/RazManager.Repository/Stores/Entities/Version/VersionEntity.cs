using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.Version
{
    public class VersionEntity
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        public DateOnly Date { get; set; }

        [Required]
        public short Major { get; set; }

        [Required]
        public short Minor { get; set; }

        [Required]
        public short Patch { get; set; }

        [Required]
        public bool Valid { get; set; }

        [StringLength(1000)]
        public string? Description { get; set; }

        [Required]
        public List<VersionPlatform.VersionPlatformEntity> VersionPlatforms { get; set; } = [];

        [Required]
        public List<VersionNote.VersionNoteEntity> VersionNotes { get; set; } = [];
    }
}
