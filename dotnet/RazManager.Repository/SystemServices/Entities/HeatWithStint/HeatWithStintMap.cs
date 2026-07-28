using AutoMapper;
using Razmanager.Protobuf.Public.V1;
using RazManager.Repository.Stores.Entities.HeatWithStint;
using System.Resources;


namespace RazManager.Repository.SystemServices.Entities.HeatWithStint
{
    public class HeatWithStintMap : Profile
    {
        public HeatWithStintMap()
        {
            CreateMap<HeatWithStintEntity, Razmanager.Protobuf.Public.V1.HeatWithStint>()
                .ForMember(dest => dest.HeatWithStintStateType, opt => opt.MapFrom(src => new SummaryStateType
                {
                    Id = src.HeatWithStintStateTypeId,
                    Name = new ResourceManager(typeof(RazManager.Resources.SummaryStateType)).GetString(src.HeatWithStintStateTypeId.ToString())
                }));
        }
    }
}
