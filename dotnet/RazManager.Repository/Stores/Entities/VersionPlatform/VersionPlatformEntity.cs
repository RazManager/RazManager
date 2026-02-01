using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.VersionPlatform
{
    public class VersionPlatformEntity
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        public Guid VersionId { get; set; }

        public Version.VersionEntity Version { get; set; } = null!;

        [Required]
        public Razmanager.Protobuf.Public.V1.VersionPlatformId VersionPlatformId { get; set; }
    }
}
