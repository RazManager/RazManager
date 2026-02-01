using System.ComponentModel.DataAnnotations;


namespace RazManager.App.Utilities
{
    public class DatabaseOptions
    {
        [Required]
        public string DbContextConnectionStringSilo { get; set; } = null!;
    }
}
