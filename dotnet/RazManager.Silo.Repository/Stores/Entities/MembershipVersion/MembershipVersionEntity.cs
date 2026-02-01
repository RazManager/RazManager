using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Silo.Repository.Stores.Entities.MembershipVersion
{
    public class MembershipVersionEntity
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        [StringLength(150)]
        public string ClusterId { get; set; } = null!;

        [Required]
        public int Version { get; set; }

        [Required]
        public List<Membership.MembershipEntity> Memberships { get; set; } = new();

        [Required]
        [ConcurrencyCheck]
        public Guid ETag { get; set; }
    }
}
