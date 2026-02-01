using AutoMapper;
using Razmanager.Protobuf.Internal.Repository.CrudServices.CarTag;
using RazManager.Repository.Stores.Entities.CarTag;
using RazManager.Utilities.Protobuf;
using System;


namespace RazManager.Repository.CrudServices.Entities.CarTag
{
    public class CarTagMap : Profile
    {
        public CarTagMap()
        {
            CreateMap<CarTagEntity, CarTagRead>()
                .ForMember(dest => dest.Id, opt => opt.MapFrom<EmptyGuidToProtoResolver, Guid>(src => src.Id));
            CreateMap<CarTagCreateUpdate, CarTagEntity>();
            CreateMap<CarTagEntity, CarTagList>();
            CreateMap<CarTagEntity, CarTagSelect>();
        }
    }
}
