using System.ComponentModel.DataAnnotations;


namespace RazManager.Utilities.Host
{
    public class ApplicationInsightsOptions
    {
        [Required]
        public string ApplicationInsightsConnectionString { get; set; } = null!;
    }
}
