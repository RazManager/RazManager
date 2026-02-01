using System.ComponentModel.DataAnnotations;
using System;
using RazManager.Utilities.Store;


namespace RazManager.Identity.Stores.Entities.PersistedGrant
{
    public class PersistedGrantEntity : Duende.IdentityServer.Models.PersistedGrant, ITimeToLiveAtRequired
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        public DateTime TimeToLiveAt { get; set; }
    }
}
