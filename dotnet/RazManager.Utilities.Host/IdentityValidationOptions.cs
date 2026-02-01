using System;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Utilities.Host
{
    public class IdentityValidationOptions
    {
        [Required]
        public Uri IdentityAuthority { get; set; } = null!;
    }
}
