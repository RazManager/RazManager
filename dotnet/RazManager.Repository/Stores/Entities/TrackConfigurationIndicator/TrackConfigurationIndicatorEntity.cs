using RazManager.Repository.Stores.Utilities;
using System.ComponentModel.DataAnnotations;
using System;


namespace RazManager.Repository.Stores.Entities.TrackConfigurationIndicator
{
    public class TrackConfigurationIndicatorEntity : IEntityId
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        public Guid TrackConfigurationId { get; set; }

        public TrackConfiguration.TrackConfigurationEntity TrackConfiguration { get; set; } = null!;

        [Required]
        public byte IndicatorId { get; set; }

        [Required]
        public uint Color { get; set; }
    }
}
