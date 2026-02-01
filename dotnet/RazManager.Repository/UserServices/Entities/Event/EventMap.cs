using AutoMapper;
using Razmanager.Protobuf.Internal.Repository.UserServices.Event;
using RazManager.Repository.Stores.Entities.Event;
using RazManager.Repository.Stores.Utilities;
using RazManager.Repository.Utilities;
using RazManager.Utilities.Protobuf;
using System;
using System.Linq;


namespace RazManager.Repository.UserServices.Entities.Event
{
    public class EventMap : Profile
    {
        public EventMap()
        {
            CreateMap<EventEntity, EventSelect>()
               .ForMember(dest => dest.StartsAt, opt => opt.MapFrom<NullableDateTimeToProtoResolver, DateTime?>(src => src.StartsAt))
               .ForMember(dest => dest.Image, opt => opt.MapFrom<ImageToProtoResolver, ImageEntityBase?>(src => src.EventImages.FirstOrDefault()));
        }
    }
}