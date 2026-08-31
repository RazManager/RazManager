using AutoMapper;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Race;
using Razmanager.Protobuf.Public.V1;
using RazManager.Repository.Stores.Entities.Race;
using RazManager.Repository.Stores.Entities.RaceSessionWithoutStints;
using RazManager.Repository.Stores.Entities.RaceSessionWithStints;
using RazManager.Utilities.Protobuf;
using System;
using System.Linq;
using System.Resources;


namespace RazManager.Repository.CrudServices.Entities.Race
{
    public class RaceMap : Profile
    {
        public RaceMap()
        {
            CreateMap<RaceEntity, RaceRead>()
                .ForMember(dest => dest.Id, opt => opt.MapFrom<EmptyGuidToProtoResolver, Guid>(src => src.Id))
                .ForMember(dest => dest.TrackConfigurationId, opt => opt.MapFrom<EmptyGuidToProtoResolver, Guid>(src => src.TrackConfigurationId))
                .ForMember(dest => dest.CarTagIds, opt => opt.MapFrom(src => src.RaceCarTags.Select(x => x.CarTagId)));
            CreateMap<RaceCreate, RaceEntity>()
                .ForMember(dest => dest.RaceCarTags, opt => opt.Ignore())
                .ForMember(dest => dest.RaceIndicators, opt => opt.Ignore())
                .ForMember(dest => dest.RaceEventUsers, opt => opt.Ignore())
                .ForMember(dest => dest.RaceIndicatorEventUsers, opt => opt.Ignore());
            CreateMap<RaceUpdate, RaceEntity>()
                .ForMember(dest => dest.RaceCarTags, opt => opt.Ignore())
                .ForMember(dest => dest.RaceIndicators, opt => opt.Ignore())
                .ForMember(dest => dest.RaceEventUsers, opt => opt.Ignore())
                .ForMember(dest => dest.RaceIndicatorEventUsers, opt => opt.Ignore());
            CreateMap<RaceEntity, RaceList>()
                .ForMember(dest => dest.RaceStateType, opt => opt.MapFrom(src => new SummaryStateType
                {
                    Id = src.StateTypeId,
                    Name = new ResourceManager(typeof(RazManager.Resources.SummaryStateType)).GetString(src.StateTypeId.ToString())
                }));
            CreateMap<RaceSessionWithoutStintsEntity, RaceSessionReadCreateUpdate>()
                .ForMember(dest => dest.Id, opt => opt.MapFrom<EmptyGuidToProtoResolver, Guid>(src => src.Id))
                .ForMember(dest => dest.HeatStintEndDurationDuration, opt => opt.MapFrom<NullableTimeSpanToProtoResolver, TimeSpan?>(src => src.HeatStintEndDurationDuration));
            CreateMap<RaceSessionReadCreateUpdate, RaceSessionWithoutStintsEntity>()
                .ForMember(dest => dest.HeatStintEndDurationDuration, opt => opt.MapFrom<NullableTimeSpanFromProtoResolver, Google.Protobuf.WellKnownTypes.Duration>(src => src.HeatStintEndDurationDuration));
        }
    }
}
