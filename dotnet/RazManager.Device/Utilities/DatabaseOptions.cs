using System.ComponentModel.DataAnnotations;


namespace RazManager.Device.Utilities
{
    public class DatabaseOptions
    {
        [Required]
        public string DbContextConnectionStringSilo { get; set; } = null!;
    }
}
