using System;
using System.ComponentModel.DataAnnotations;


namespace RazManager.IO.Utilities
{
    public class ConnectionOptions
    {
        [Required]
        public Uri DeviceClientAddress { get; set; } = null!;

        public Uri AppClientAddress { get; set; } = null!;
    }
}
