using AutoMapper;
using RazManager.Repository.Stores.Entities.Version;
using RazManager.Repository.Stores.Entities.VersionNote;
using RazManager.Repository.Stores.Entities.VersionPlatform;
using RazManager.Utilities.Protobuf;
using System;
using System.Linq;
using System.Resources;


namespace RazManager.Repository.PublicServices.Entities.Version
{
    public class VersionMap : Profile
    {
        public VersionMap()
        {
            CreateMap<VersionEntity, Razmanager.Protobuf.Public.V1.Version>()
               .ForMember(dest => dest.Date, opt => opt.MapFrom<DateOnlyToProtoResolver, DateOnly>(src => src.Date))
               .ForMember(dest => dest.Notes, opt => opt.MapFrom(src => src.VersionNotes))
               .ForMember(dest => dest.Platforms, opt => opt.MapFrom(src => src.VersionPlatforms.OrderBy(x => x.VersionPlatformId)));
            CreateMap<VersionNoteEntity, Razmanager.Protobuf.Public.V1.VersionNote>();
            CreateMap<VersionPlatformEntity, Razmanager.Protobuf.Public.V1.VersionPlatform>()
                .ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.VersionPlatformId))
                .ForMember(dest => dest.Name, opt => opt.MapFrom(src => new ResourceManager(typeof(Resources.Platform)).GetString(src.VersionPlatformId.ToString())));
        }
    }
}
