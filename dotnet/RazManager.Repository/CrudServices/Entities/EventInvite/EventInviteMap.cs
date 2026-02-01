using AutoMapper;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Event;
using RazManager.Repository.Stores.Entities.EventInvite;
using RazManager.Utilities.Protobuf;
using System;


namespace RazManager.Repository.CrudServices.Entities.EventInvite
{
    public class EventInviteMap : Profile
    {
        public EventInviteMap()
        {
            CreateMap<EventInviteEntity, EventInviteReadCreateUpdate>()
                .ForMember(dest => dest.TimeToLiveAt, opt => opt.MapFrom<DateTimeToProtoResolver, DateTime>(src => src.TimeToLiveAt));
            CreateMap<EventInviteReadCreateUpdate, EventInviteEntity>()
                .ForMember(dest => dest.Id, opt => opt.Ignore())
                .ForMember(dest => dest.TimeToLiveAt, opt => opt.MapFrom<DateTimeFromProtoResolver, Google.Protobuf.WellKnownTypes.Timestamp>(src => src.TimeToLiveAt));
        }
    }
}
