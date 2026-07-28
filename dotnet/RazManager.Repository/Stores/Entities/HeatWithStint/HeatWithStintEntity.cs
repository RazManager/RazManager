using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;


namespace RazManager.Repository.Stores.Entities.HeatWithStint
{
    public class HeatWithStintEntity : HeatBase.HeatEntityBase
    {
        [Required]
        public List<Stint.StintEntity> Stints { get; set; } = [];

        [Required]
        public Razmanager.Protobuf.Public.V1.SummaryStateTypeId HeatWithStintStateTypeId { get; set; }
    }
}