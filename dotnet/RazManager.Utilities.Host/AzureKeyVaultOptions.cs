using System;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Utilities.Host
{
    public class AzureKeyVaultOptions
    {
        [Required]
        public Uri AzureKeyVaultUri { get; set; } = null!;

        [Required]
        public string AzureKeyVaultManagedIdentityObjectId { get; set; } = null!;
    }
}
