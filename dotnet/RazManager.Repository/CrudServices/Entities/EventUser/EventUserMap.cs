using AutoMapper;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Event;
using RazManager.Repository.Stores.Entities.EventUser;
using RazManager.Repository.Stores.Utilities;
using RazManager.Repository.Utilities;
using RazManager.Utilities.Protobuf;
using System;
using System.Linq;


namespace RazManager.Repository.CrudServices.Entities.EventUser
{
    public class EventUserMap : Profile
    {
        public EventUserMap()
        {
            CreateMap<EventUserEntity, EventUserRead>()
                .ForMember(dest => dest.Name, opt => opt.MapFrom(src =>
                    src.User != null ?
                        src.User.Name :
                        src.Name))
                .ForMember(dest => dest.ShortName, opt => opt.MapFrom(src =>
                    src.User != null ?
                        src.User.ShortName :
                        src.ShortName))
                .ForMember(dest => dest.Image, opt => opt.MapFrom<ImageToProtoResolver, ImageEntityBase?>(src => src.EventUserImages.SingleOrDefault()));
            CreateMap<EventUserCreateUpdate, EventUserEntity>()
                .ForMember(dest => dest.Id, opt => opt.Ignore())
                .ForMember(dest => dest.UserId, opt => opt.MapFrom<NullableGuidFromProtoResolver, string>(src => src.UserId))
                .ForMember(dest => dest.Name, opt => opt.Condition((src, dest) => !dest.UserId.HasValue))
                .ForMember(dest => dest.ShortName, opt => opt.Condition((src, dest) => !dest.UserId.HasValue))
                .ForMember(dest => dest.ShortName, opt => opt.MapFrom(s => s.ShortName.ToUpper()))
                .ForMember(dest => dest.EventUserId, opt => opt.MapFrom<NullableGuidFromProtoResolver, string>(src => src.EventUserId));
            CreateMap<EventUserEntity, EventUserSelect>()
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
