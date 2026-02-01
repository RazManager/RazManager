using Orleans;
using Orleans.Runtime;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Silo.Repository.Stores.Entities.Membership
{
    public class MembershipEntity
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        public Guid MembershipVersionId { get; set; }

        public MembershipVersion.MembershipVersionEntity MembershipVersion { get; set; } = null!;

        [Required]
        [StringLength(100)]
        public string SiloAddress { get; set; } = null!;

        [Required]
        public SiloStatus Status { get; set; }

        [Required]
        public List<MembershipSuspectTime.MembershipSuspectTimeEntity> MembershipSuspectTimes { get; set; } = new();

        [Required]
        public int ProxyPort { get; set; }

        [Required]
        [StringLength(100)]
        public string HostName { get; set; } = null!;

        [Required]
        [StringLength(100)]
        public string SiloName { get; set; } = null!;

        //[Required]
        //public string RoleName { get; set; } = null!;

        //public int UpdateZone { get; set; }

        //public int FaultZone { get; set; }

        [Required]
        public DateTime StartTime { get; set; }

        [Required]
        public DateTime IAmAliveTime { get; set; }

        [Required]
        [ConcurrencyCheck]
        public Guid ETag { get; set; }
    }
}
