using AutoMapper;
using Razmanager.Protobuf.Public.V1;
using RazManager.Repository.Stores.Entities.HeatWithStints;
using System.Resources;


namespace RazManager.Repository.SystemServices.Entities.HeatWithStints
{
    public class HeatWithStintsMap : Profile
    {
        public HeatWithStintsMap()
        {
            CreateMap<HeatWithStintsEntity, Razmanager.Protobuf.Public.V1.HeatWithStints>()
                .ForMember(dest => dest.StateType, opt => opt.MapFrom(src => new SummaryStateType
                {
                    Id = src.StateTypeId,
                    Name = new ResourceManager(typeof(RazManager.Resources.SummaryStateType)).GetString(src.StateTypeId.ToString())
                }));
        }
    }
}
