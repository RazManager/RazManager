using RazManager.Repository.Stores.Utilities;
using System.ComponentModel.DataAnnotations;
using System;


namespace RazManager.Repository.Stores.Entities.TrackConfigurationRaceFormat
{
    public class TrackConfigurationRaceFormatEntity : IEntityId
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        public Guid TrackConfigurationId { get; set; }

        public TrackConfiguration.TrackConfigurationEntity TrackConfiguration { get; set; } = null!;

        [Required]
        public Razmanager.Protobuf.Internal.Repository.CrudServices.RaceFormatType.RaceFormatTypeId RaceFormatTypeId { get; set; }
    }
}
