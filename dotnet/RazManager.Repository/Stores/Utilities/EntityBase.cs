using System.ComponentModel.DataAnnotations;
using System;


namespace RazManager.Repository.Stores.Utilities
{
    public abstract class EntityBase : IEntity
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        [ConcurrencyCheck]
        public Guid ETag { get; set; }
    }
}
