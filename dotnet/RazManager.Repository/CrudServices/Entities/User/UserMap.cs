using AutoMapper;
using Razmanager.Protobuf.Internal.Repository.CrudServices.User;
using RazManager.Repository.Stores.Entities.User;
using RazManager.Repository.Stores.Utilities;
using RazManager.Repository.Utilities;
using System.Linq;


namespace RazManager.Repository.CrudServices.Entities.User
{
    public class UserMap : Profile
    {
        public UserMap()
        {
            CreateMap<UserEntity, UserRead>()
                .ForMember(dest => dest.Image, opt => opt.MapFrom<ImageToProtoResolver, ImageEntityBase?>(src => src.UserImages.SingleOrDefault(x => x.ImageSize == ImageSize.Original)))
                .ForMember(dest => dest.Events, opt => opt.MapFrom(src => src.EventUsers.Select(x => x.Event)))
                .ForMember(dest => dest.Tenants, opt => opt.MapFrom(src => src.TenantUsers.Select(x => x.Tenant)));
            CreateMap<UserCreate, UserEntity>()
                .ForMember(dest => dest.ShortName, opt => opt.MapFrom(s => s.ShortName.ToUpper()));
            CreateMap<UserUpdate, UserEntity>()
                .ForMember(dest => dest.ShortName, opt => opt.MapFrom(s => s.ShortName.ToUpper()));
        }
    }
}
