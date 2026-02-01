using AutoMapper;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Tenant;
using RazManager.Repository.Stores.Entities.Tenant;
using RazManager.Repository.Stores.Utilities;
using RazManager.Repository.Utilities;
using RazManager.Utilities.Protobuf;
using System;
using System.Linq;


namespace RazManager.Repository.CrudServices.Entities.Tenant
{
    public class TenantMap : Profile
    {
        public TenantMap()
        {
            CreateMap<TenantEntity, TenantRead>()
                .ForMember(dest => dest.Id, opt => opt.MapFrom<EmptyGuidToProtoResolver, Guid>(src => src.Id))
                .ForMember(dest => dest.Image, opt => opt.MapFrom<ImageToProtoResolver, ImageEntityBase?>(src => src.TenantImages.SingleOrDefault(x => x.ImageSize == ImageSize.Original)));
            CreateMap<TenantCreateUpdate, TenantEntity>()
                .ForMember(dest => dest.TenantInvites, opt => opt.Ignore())
                .ForMember(dest => dest.TenantUsers, opt => opt.Ignore());
        }
    }
}
