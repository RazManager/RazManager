using System;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Silo.Repository.Stores.Entities.MembershipSuspectTime
{
    public class MembershipSuspectTimeEntity
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        public Guid MembershipId { get; set; }

        public Membership.MembershipEntity Membership { get; set; } = null!;

        [Required]
        [StringLength(100)]
        public string SiloAddress { get; set; } = null!;

        [Required]
        public DateTime SuspectTime { get; set; }
    }
}
