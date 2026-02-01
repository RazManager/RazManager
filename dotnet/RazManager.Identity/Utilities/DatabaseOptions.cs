using System.ComponentModel.DataAnnotations;


namespace RazManager.Identity.Utilities
{
    public class DatabaseOptions
    {
        [Required]
        public string DbContextConnectionStringIdentity { get; set; } = null!;
    }
}
