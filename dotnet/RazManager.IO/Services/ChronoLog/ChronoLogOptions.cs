using System;
using System.ComponentModel.DataAnnotations;


namespace RazManager.IO.Services.ChronoLog
{
    public class ChronoLogOptions
    {
        [Required]
        public Uri AppClientAddress { get; set; } = null!;

        [Required]
        public Uri DeviceClientAddress { get; set; } = null!;

        [Required]
        public string RaceId { get; set; } = null!;

        [Required]
        public string HeatId { get; set; } = null!;

        [Required]
        public string CronoLogFilename { get; set; } = null!;

        [Required]
        public bool UseDongleData { get; set; } = false;

        [Required]
        public byte PitLaneThreshold { get; set; } = 20;

        [Required]
        public byte DeslotThreshold { get; set; } = 15;
    }
}
