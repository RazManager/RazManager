using AutoMapper;
using Razmanager.Protobuf.Public.V1;
using RazManager.Repository.Stores.Entities.RaceSessionWithStints;
using RazManager.Utilities.Protobuf;
using System;
using System.Resources;


namespace RazManager.Repository.SystemServices.Entities.RaceSessionWithStints
{
    public class RaceSessionWithStintsMap : Profile
    {
        public RaceSessionWithStintsMap()
        {
            CreateMap<RaceSessionWithStintsEntity, Razmanager.Protobuf.Public.V1.RaceSessionWithStints>()
                .ForMember(dest => dest.SessionType, opt => opt.MapFrom(src => new SessionType
                {
                    Id = src.SessionTypeId,
                    Name = new ResourceManager(typeof(RazManager.Resources.SessionType)).GetString(src.SessionTypeId.ToString())
                }))
                .ForMember(dest => dest.StateType, opt => opt.MapFrom(src => new SummaryStateType
                {
                    Id = src.StateTypeId,
                    Name = new ResourceManager(typeof(RazManager.Resources.SummaryStateType)).GetString(src.StateTypeId.ToString())
                }))
                .ForMember(dest => dest.HeatStintEndDurationDuration, opt => opt.MapFrom<NullableTimeSpanToProtoResolver, TimeSpan?>(src => src.HeatStintEndDurationDuration));
        }
    }
}
