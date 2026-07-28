using AutoMapper;
using Razmanager.Protobuf.Public.V1;
using RazManager.Repository.Stores.Entities.RaceSession;
using RazManager.Utilities.Protobuf;
using System;
using System.Resources;


namespace RazManager.Repository.SystemServices.Entities.RaceSession
{
    public class RaceSessionMap : Profile
    {
        public RaceSessionMap()
        {
            CreateMap<RaceSessionEntity, Razmanager.Protobuf.Public.V1.RaceSession>()
                .ForMember(dest => dest.SessionType, opt => opt.MapFrom(src => new SessionType
                {
                    Id = src.SessionTypeId,
                    Name = new ResourceManager(typeof(RazManager.Resources.SessionType)).GetString(src.SessionTypeId.ToString())
                }))
                .ForMember(dest => dest.RaceSessionStateType, opt => opt.MapFrom(src => new SummaryStateType
                {
                    Id = src.RaceSessionStateTypeId,
                    Name = new ResourceManager(typeof(RazManager.Resources.SummaryStateType)).GetString(src.RaceSessionStateTypeId.ToString())
                }))
                .ForMember(dest => dest.HeatStintEndDurationDuration, opt => opt.MapFrom<NullableTimeSpanToProtoResolver, TimeSpan?>(src => src.HeatStintEndDurationDuration));
        }
    }
}
