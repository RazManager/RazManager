using System;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Utilities.Speech
{
    public class SpeechConfigOptions
    {
        [Required]
        public Uri SpeechConfigEndpoint { get; set; } = null!;

        [Required]
        public string SpeechConfigKey { get; set; } = null!;
    }
}
