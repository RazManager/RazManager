using System;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Utilities.Host
{
    public class RepositoryClientOptions
    {
        [Required]
        public Uri RepositoryClientAddress { get; set; } = null!;
    }
}
