using AutoMapper;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Track;
using RazManager.Repository.Stores.Entities.Track;
using RazManager.Repository.Stores.Utilities;
using RazManager.Repository.Utilities;
using RazManager.Utilities.Protobuf;
using System;
using System.Linq;


namespace RazManager.Repository.CrudServices.Entities.Track
{
    public class TrackMap : Profile
    {
        public TrackMap()
        {
            CreateMap<TrackEntity, TrackRead>()
                .ForMember(dest => dest.Id, opt => opt.MapFrom<EmptyGuidToProtoResolver, Guid>(src => src.Id))
                 .ForMember(dest => dest.Image, opt => opt.MapFrom<ImageToProtoResolver, ImageEntityBase?>(src => src.TrackImages.SingleOrDefault(x => x.ImageSize == ImageSize.Original)));
           CreateMap<TrackCreateUpdate, TrackEntity>()
                .ForMember(dest => dest.TrackConfigurations, opt => opt.Ignore());
            CreateMap<TrackEntity, TrackList>()
                 .ForMember(dest => dest.Image, opt => opt.MapFrom<ImageToProtoResolver, ImageEntityBase?>(src => src.TrackImages.FirstOrDefault()));
           CreateMap<TrackEntity, TrackSelect>();
        }
    }
}
