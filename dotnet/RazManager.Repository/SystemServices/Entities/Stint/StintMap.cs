using AutoMapper;
using RazManager.Repository.Stores.Entities.Stint;
using RazManager.Repository.Stores.Entities.StintIndicator;
using RazManager.Repository.Stores.Utilities;
using RazManager.Repository.Utilities;
using System.Linq;


namespace RazManager.Repository.SystemServices.Entities.Stint
{
    public class StintMap : Profile
    {
        public StintMap()
        {
            CreateMap<StintEntity, Razmanager.Protobuf.Public.V1.Stint>();
            CreateMap<StintIndicatorEntity, Razmanager.Protobuf.Public.V1.HeatIndicator>()
                .ForMember(dest => dest.Color, opt => opt.MapFrom(src => IndicatorColor(src)))
                .ForMember(dest => dest.CarImage, opt => opt.MapFrom<ImageToProtoResolver, ImageEntityBase?>(src => CarImage(src)));
        }


        private uint? IndicatorColor(StintIndicatorEntity stintIndicator)
        {
            return stintIndicator.Stint.HeatWithStint.RaceSession.Race.TrackConfiguration.TrackConfigurationIndicators.SingleOrDefault(x => x.IndicatorId == stintIndicator.IndicatorId)?.Color;
        }


        private Stores.Entities.CarImage.CarImageEntity? CarImage(StintIndicatorEntity stintIndicator)
        {
            return stintIndicator.Car?.CarImages.FirstOrDefault();
        }
    }
}
