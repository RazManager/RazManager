using AutoMapper;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Tenant;
using Razmanager.Protobuf.Internal.Repository.CrudServices.TenantUser;
using RazManager.Repository.Stores.Entities.TenantUser;
using RazManager.Repository.Stores.Utilities;
using RazManager.Repository.Utilities;
using System.Linq;


namespace RazManager.Repository.CrudServices.Entities.TenantUser
{
    public class TenantUserMap : Profile
    {
        public TenantUserMap()
        {
            CreateMap<TenantUserEntity, TenantUserReadCreateUpdate>()
                .ForMember(dest => dest.Name, opt => opt.MapFrom(src =>
                    src.User != null ?
                        src.User.Name :
                        src.Name))
                .ForMember(dest => dest.ShortName, opt => opt.MapFrom(src =>
                    src.User != null ?
                        src.User.ShortName :
                        src.ShortName));
            CreateMap<TenantUserReadCreateUpdate, TenantUserEntity>()
                .ForMember(dest => dest.Id, opt => opt.Ignore())
                .ForMember(dest => dest.UserId, opt => opt.Ignore())
                .ForMember(dest => dest.Name, opt => opt.Condition((src, dest) => !dest.UserId.HasValue))
                .ForMember(dest => dest.ShortName, opt => opt.Condition((src, dest) => !dest.UserId.HasValue))
                .ForMember(dest => dest.ShortName, opt => opt.MapFrom(s => s.ShortName.ToUpper()));
            CreateMap<TenantUserEntity, TenantUserSelect>()
                .ForMember(dest => dest.Name, opt => opt.MapFrom(src =>
                    src.User != null ?
                        src.User.Name :
                        src.Name))
                .ForMember(dest => dest.ShortName, opt => opt.MapFrom(src =>
                    src.User != null ?
                        src.User.ShortName :
                        src.ShortName));
                //.ForMember(dest => dest.Image, opt => opt.MapFrom<ImageToProtoResolver, ImageEntityBase?>(src => src.User.UserImages.SingleOrDefault(x => x.ImageSize == ImageSize.Avatar)));
        }
    }
}
