using AutoMapper;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Event;
using RazManager.Repository.Stores.Entities.Event;
using RazManager.Repository.Stores.Utilities;
using RazManager.Repository.Utilities;
using RazManager.Utilities.Protobuf;
using System;
using System.Linq;


namespace RazManager.Repository.CrudServices.Entities.Event
{
    public class EventMap : Profile
    {
        public EventMap()
        {
            CreateMap<EventEntity, EventRead>()
                .ForMember(dest => dest.Id, opt => opt.MapFrom<EmptyGuidToProtoResolver, Guid>(src => src.Id))
                .ForMember(dest => dest.StartsAt, opt => opt.MapFrom<NullableDateTimeToProtoResolver, DateTime?>(src => src.StartsAt))
                .ForMember(dest => dest.PublishFrom, opt => opt.MapFrom<NullableDateTimeToProtoResolver, DateTime?>(src => src.PublishFrom))
                .ForMember(dest => dest.PublishUntil, opt => opt.MapFrom<DateTimeToProtoResolver, DateTime>(src => src.TimeToLiveAt))
                .ForMember(dest => dest.Image, opt => opt.MapFrom<ImageToProtoResolver, ImageEntityBase?>(src => src.EventImages.SingleOrDefault(x => x.ImageSize == ImageSize.Original)));
            CreateMap<EventCreateUpdate, EventEntity>()
                .ForMember(dest => dest.StartsAt, opt => opt.MapFrom<NullableDateTimeFromProtoResolver, Google.Protobuf.WellKnownTypes.Timestamp>(src => src.StartsAt))
                .ForMember(dest => dest.PublishFrom, opt => opt.MapFrom<NullableDateTimeFromProtoResolver, Google.Protobuf.WellKnownTypes.Timestamp>(src => src.PublishFrom))
                .ForMember(dest => dest.TimeToLiveAt, opt => opt.MapFrom<DateTimeFromProtoResolver, Google.Protobuf.WellKnownTypes.Timestamp>(src => src.PublishUntil))
                .ForMember(dest => dest.EventInvites, opt => opt.Ignore())
                .ForMember(dest => dest.EventUsers, opt => opt.Ignore());
            CreateMap<EventEntity, EventList>()
                .ForMember(dest => dest.PublishFrom, opt => opt.MapFrom<NullableDateTimeToProtoResolver, DateTime?>(src => src.PublishFrom))
                .ForMember(dest => dest.PublishUntil, opt => opt.MapFrom<NullableDateTimeToProtoResolver, DateTime?>(src => src.TimeToLiveAt))
                .ForMember(dest => dest.Image, opt => opt.MapFrom<ImageToProtoResolver, ImageEntityBase?>(src => src.EventImages.SingleOrDefault(x => x.ImageSize == ImageSize.Avatar)));
            CreateMap<EventEntity, EventSelect>()
                .ForMember(dest => dest.EventUsers, opt => opt.Ignore());
        }
    }
}
