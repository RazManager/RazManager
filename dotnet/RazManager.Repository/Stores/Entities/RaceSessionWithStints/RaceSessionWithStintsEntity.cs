using RazManager.Repository.Stores.Entities.RaceSessionBase;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.RaceSessionWithStints
{
    public class RaceSessionWithStintsEntity : RaceSessionEntityBase
    {
        [Required]
        public List<HeatWithStint.HeatWithStintsEntity> HeatWithStints { get; set; } = [];
    }
}
