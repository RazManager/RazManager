using AutoMapper;
using Razmanager.Protobuf.Internal.Repository.UserServices.Tenant;
using RazManager.Repository.Stores.Entities.Tenant;
using RazManager.Repository.Stores.Utilities;
using RazManager.Repository.Utilities;
using System;
using System.Linq;
using static Grpc.Core.Metadata;


namespace RazManager.Repository.UserServices.Entities.Tenant
{
    public class TenantMap : Profile
    {
        public TenantMap()
        {
            CreateMap<TenantEntity, TenantRead>();
            CreateMap<TenantEntity, TenantSelect>()
                .ForMember(dest => dest.Image, opt => opt.MapFrom<ImageToProtoResolver, ImageEntityBase?>(src => src.TenantImages.FirstOrDefault()))
                .ForMember(dest => dest.Administrator, opt => opt.MapFrom<TenantSelectAdministratorResolver>());
        }
    }


    public class TenantSelectAdministratorResolver : IValueResolver<TenantEntity, TenantSelect, bool>
    {
        private readonly IHttpContextOptions _httpContextOptions;


        public TenantSelectAdministratorResolver(IHttpContextOptions httpContextOptions)
        {
            _httpContextOptions = httpContextOptions;
        }


        public bool Resolve(TenantEntity source, TenantSelect destination, bool destMember, ResolutionContext context)
        {
            return source.TenantUsers.Any(x => x.UserId == _httpContextOptions.UserId && x.Administrator);
        }
    }
}