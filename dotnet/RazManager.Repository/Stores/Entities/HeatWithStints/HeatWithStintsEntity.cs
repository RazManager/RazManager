using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.HeatWithStints
{
    public class HeatWithStintsEntity : HeatBase.HeatEntityBase
    {
        [Required]
        public Guid RaceSessionWithStintsId { get; set; }

        public RaceSessionWithStints.RaceSessionWithStintsEntity RaceSessionWithStints { get; set; } = null!;

        [Required]
        public List<Stint.StintEntity> Stints { get; set; } = [];

        [Required]
        public Razmanager.Protobuf.Public.V1.SummaryStateTypeId StateTypeId { get; set; }
    }
}