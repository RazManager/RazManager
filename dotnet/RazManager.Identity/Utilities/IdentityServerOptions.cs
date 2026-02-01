using System.ComponentModel.DataAnnotations;


namespace RazManager.Identity.Utilities
{
    public class IdentityServerOptions
    {
        [Required]
        public string IdentityServerLicenseKey { get; set; } = null!;
    }
}
