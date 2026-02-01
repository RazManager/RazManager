using AutoMapper;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Car;
using RazManager.Repository.Stores.Entities.Car;
using RazManager.Repository.Stores.Utilities;
using RazManager.Repository.Utilities;
using RazManager.Utilities.Protobuf;
using System;
using System.Linq;


namespace RazManager.Repository.CrudServices.Entities.Car
{
    public class CarMap : Profile
    {
        public CarMap()
        {
            CreateMap<CarEntity, CarRead>()
                .ForMember(dest => dest.Id, opt => opt.MapFrom<EmptyGuidToProtoResolver, Guid>(src => src.Id))
                .ForMember(dest => dest.Image, opt => opt.MapFrom<ImageToProtoResolver, ImageEntityBase?>(src => src.CarImages.SingleOrDefault(x => x.ImageSize == ImageSize.Original)))
                .ForMember(dest => dest.CarTagIds, opt => opt.MapFrom(src => src.CarCarTags.Select(x => x.CarTagId)));
            CreateMap<CarCreateUpdate, CarEntity>();
            CreateMap<CarEntity, CarList>()
                .ForMember(dest => dest.Image, opt => opt.MapFrom<ImageToProtoResolver, ImageEntityBase?>(src => src.CarImages.FirstOrDefault()))
                .ForMember(dest => dest.CarTagNames, opt => opt.MapFrom(src => string.Join(", ", src.CarCarTags.Select(x => x.CarTag.Name))));
            CreateMap<CarEntity, CarSelect>()
                .ForMember(dest => dest.Image, opt => opt.MapFrom<ImageToProtoResolver, ImageEntityBase?>(src => src.CarImages.FirstOrDefault()))
                .ForMember(dest => dest.CarTagIds, opt => opt.MapFrom(src => src.CarCarTags.Select(x => x.CarTagId)));
        }
    }
}
