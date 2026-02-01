using AutoMapper;
using Razmanager.Protobuf.Internal.Repository.CrudServices.HeatIndicatorStint;
using RazManager.Repository.Stores.Entities.HeatIndicatorStint;
using RazManager.Utilities.Protobuf;
using System;


namespace RazManager.Repository.CrudServices.Entities.HeatIndicatorStint
{
    public class HeatIndicatorStintMap : Profile
    {
        public HeatIndicatorStintMap()
        {
            CreateMap<HeatIndicatorStintEntity, HeatIndicatorStintRead>()
                .ForMember(dest => dest.Id, opt => opt.MapFrom<EmptyGuidToProtoResolver, Guid>(src => src.Id));
            CreateMap<HeatIndicatorStintCreate, HeatIndicatorStintEntity>();
            CreateMap<HeatIndicatorStintUpdate, HeatIndicatorStintEntity>();
        }
    }
}
