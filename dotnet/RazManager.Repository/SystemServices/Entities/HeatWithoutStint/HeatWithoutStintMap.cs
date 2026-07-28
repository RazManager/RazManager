using AutoMapper;
using RazManager.Repository.Stores.Entities.HeatIndicator;
using RazManager.Repository.Stores.Entities.HeatIndicatorStint;
using RazManager.Repository.Stores.Entities.HeatWithoutStint;
using RazManager.Repository.Stores.Utilities;
using RazManager.Repository.Utilities;
using System.Linq;


namespace RazManager.Repository.SystemServices.Entities.HeatWithoutStint
{
    public class HeatWithoutStintMap : Profile
    {
        public HeatWithoutStintMap()
        {
            CreateMap<HeatWithoutStintEntity, Razmanager.Protobuf.Public.V1.HeatWithoutStint>();
            CreateMap<HeatIndicatorEntity, Razmanager.Protobuf.Public.V1.HeatIndicator>()
                .ForMember(dest => dest.Color, opt => opt.MapFrom(src => IndicatorColor(src)))
                .ForMember(dest => dest.CarImage, opt => opt.MapFrom<ImageToProtoResolver, ImageEntityBase?>(src => CarImage(src)));
            CreateMap<HeatIndicatorStintEntity, Razmanager.Protobuf.Public.V1.HeatIndicatorStint>();
        }


        private uint? IndicatorColor(HeatIndicatorEntity heatIndicator)
        {
            return heatIndicator.HeatWithoutStint.RaceSession.Race.TrackConfiguration.TrackConfigurationIndicators.SingleOrDefault(x => x.IndicatorId == heatIndicator.IndicatorId)?.Color;
        }


        private Stores.Entities.CarImage.CarImageEntity? CarImage(HeatIndicatorEntity heatIndicator)
        {
            return heatIndicator?.Car?.CarImages.FirstOrDefault();
        }
    }
}
