using RazManager.Repository.Stores.Entities.RaceSessionBase;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.RaceSessionWithoutStints
{
    public class RaceSessionWithoutStintsEntity : RaceSessionEntityBase
    {
        [Required]
        public List<HeatWithoutStint.HeatWithoutStintsEntity> HeatWithoutStints { get; set; } = [];
    }
}
