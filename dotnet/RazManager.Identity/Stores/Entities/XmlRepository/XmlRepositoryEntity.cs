using RazManager.Utilities.Store;
using System.ComponentModel.DataAnnotations;
using System;


namespace RazManager.Identity.Stores.Entities.XmlRepository
{
    public class XmlRepositoryEntity : ITimeToLiveAtRequired
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        public required string FriendlyName { get; set; }

        [Required]
        public required string Element { get; set; }

        [Required]
        public DateTime TimeToLiveAt { get; set; }
    }
}
