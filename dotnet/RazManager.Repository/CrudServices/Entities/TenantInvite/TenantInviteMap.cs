using AutoMapper;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Tenant;
using RazManager.Repository.Stores.Entities.TenantInvite;
using RazManager.Utilities.Protobuf;
using System;


namespace RazManager.Repository.CrudServices.Entities.TenantInvite
{
    public class TenantInviteMap : Profile
    {
        public TenantInviteMap()
        {
            CreateMap<TenantInviteEntity, TenantInviteReadCreateUpdate>()
                .ForMember(dest => dest.TimeToLiveAt, opt => opt.MapFrom<DateTimeToProtoResolver, DateTime>(src => src.TimeToLiveAt));
            CreateMap<TenantInviteReadCreateUpdate, TenantInviteEntity>()
                .ForMember(dest => dest.Id, opt => opt.Ignore())
                .ForMember(dest => dest.TimeToLiveAt, opt => opt.MapFrom<DateTimeFromProtoResolver, Google.Protobuf.WellKnownTypes.Timestamp>(src => src.TimeToLiveAt));
        }
    }
}
