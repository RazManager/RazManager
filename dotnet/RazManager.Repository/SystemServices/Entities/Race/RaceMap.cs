using AutoMapper;
using Razmanager.Protobuf.Public.V1;
using RazManager.Repository.Stores.Entities.Race;
using RazManager.Utilities.Protobuf;
using System;
using System.Resources;


namespace RazManager.Repository.SystemServices.Entities.Race
{
    public class RaceMap : Profile
    {
        public RaceMap()
        {
            CreateMap<RaceEntity, Razmanager.Protobuf.Public.V1.Race>()
                .ForMember(dest => dest.RaceStateType, opt => opt.MapFrom(src => new RaceStateType
                {
                    Id = src.RaceStateTypeId,
                    Name = new ResourceManager(typeof(RazManager.Resources.RaceStateType)).GetString(src.RaceStateTypeId.ToString())
                }))
                .ForMember(dest => dest.RaceHeatEndDurationDuration, opt => opt.MapFrom<NullableTimeSpanToProtoResolver, TimeSpan?>(src => src.RaceHeatEndDurationDuration));
        }
    }
}
