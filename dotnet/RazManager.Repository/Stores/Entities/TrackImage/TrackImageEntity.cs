using RazManager.Repository.Stores.Utilities;
using System.ComponentModel.DataAnnotations;
using System;


namespace RazManager.Repository.Stores.Entities.TrackImage
{
    public class TrackImageEntity : ImageEntityBase
    {
        [Required]
        public Guid TrackId { get; set; }

        public Track.TrackEntity Track { get; set; } = null!;
    }
}
