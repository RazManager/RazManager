using System.ComponentModel.DataAnnotations;

namespace RazManager.Repository.Utilities
{
    public class DatabaseOptions
    {
        [Required]
        public string DbContextConnectionStringRepository { get; set; } = null!;
    }
}