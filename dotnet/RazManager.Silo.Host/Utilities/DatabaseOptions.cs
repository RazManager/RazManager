using System.ComponentModel.DataAnnotations;


namespace RazManager.Silo.Host.Utilities
{
    internal class DatabaseOptions
    {
        [Required]
        public string DbContextConnectionStringSilo { get; set; } = null!;
    }
}
