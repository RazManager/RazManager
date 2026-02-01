using AutoMapper;
using Razmanager.Protobuf.Internal.Repository.UserServices.HeatIndicator;
using RazManager.Repository.Stores.Entities.HeatIndicator;


namespace RazManager.Repository.UserServices.Entities.HeatIndicator
{
    public class HeatIndicatorMap : Profile
    {
        public HeatIndicatorMap()
        {
            CreateMap<HeatIndicatorEntity, HeatIndicatorRead>()
               .ForMember(dest => dest.EventUserTypeId, opt => opt.MapFrom(src => src.EventUser.EventUserTypeId));
        }
    }
}