using AutoMapper;
using RazManager.Repository.Stores.Entities.Event;
using RazManager.Repository.Stores.Entities.EventUser;
using RazManager.Repository.Stores.Utilities;
using RazManager.Repository.Utilities;
using RazManager.Utilities.Protobuf;
using System;
using System.Linq;


namespace RazManager.Repository.SystemServices.Entities.Event
{
    public class EventMap : Profile
    {
        public EventMap()
        {
            CreateMap<EventEntity, Razmanager.Protobuf.Public.V1.Event>()
                .ForMember(dest => dest.StartsAt, opt => opt.MapFrom<NullableDateTimeToProtoResolver, DateTime?>(src => src.StartsAt))
                .ForMember(dest => dest.Image, opt => opt.MapFrom<ImageToProtoResolver, ImageEntityBase?>(src => src.EventImages.SingleOrDefault(x => x.ImageSize == ImageSize.Avatar)))
                .ForMember(dest => dest.EventUsers, opt => opt.Ignore());
            CreateMap<EventUserEntity, Razmanager.Protobuf.Public.V1.EventUser>()
                .ForMember(dest => dest.Name, opt => opt.MapFrom(src =>
                    src.User != null ?
                        src.User.Name :
                        src.Autopilot != null ?
                            src.Autopilot.Name :
                            src.Name))
                .ForMember(dest => dest.ShortName, opt => opt.MapFrom(src =>
                    src.User != null ?
                        src.User.ShortName :
                        src.Autopilot != null ?
                            src.Autopilot.ShortName :
                            src.ShortName))
                .ForMember(dest => dest.Image, opt => opt.MapFrom<ImageToProtoResolver, ImageEntityBase?>
                    (src => src.EventUserImages.FirstOrDefault() != null ?
                        src.EventUserImages.FirstOrDefault() :
                            src.User != null ?
                            src.User.UserImages.FirstOrDefault() :
                            src.Autopilot != null ?
                                src.Autopilot.AutopilotImages.FirstOrDefault() :
                                null));
            CreateMap<EventUserEntity, Razmanager.Protobuf.Public.V1.TeamUser>()
                .ForMember(dest => dest.Name, opt => opt.MapFrom(src =>
                    src.User != null ?
                        src.User.Name :
                        src.Autopilot != null ?
                            src.Autopilot.Name :
                            src.Name))
                .ForMember(dest => dest.ShortName, opt => opt.MapFrom(src =>
                    src.User != null ?
                        src.User.ShortName :
                        src.Autopilot != null ?
                            src.Autopilot.ShortName :
                            src.ShortName))
                .ForMember(dest => dest.Image, opt => opt.MapFrom<ImageToProtoResolver, ImageEntityBase?>
                    (src => src.EventUserImages.FirstOrDefault() != null ?
                        src.EventUserImages.FirstOrDefault() :
                            src.User != null ?
                            src.User.UserImages.FirstOrDefault() :
                            src.Autopilot != null ?
                                src.Autopilot.AutopilotImages.FirstOrDefault() :
                                null)); 
        }
    }
}
