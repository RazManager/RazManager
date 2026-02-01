using AutoMapper;
using Razmanager.Protobuf.Public.V1;
using RazManager.Repository.Stores.Entities.Heat;
using RazManager.Repository.Stores.Entities.HeatIndicator;
using RazManager.Repository.Stores.Entities.HeatIndicatorStint;
using RazManager.Repository.Stores.Utilities;
using RazManager.Repository.Utilities;
using System.Linq;
using System.Resources;


namespace RazManager.Repository.SystemServices.Entities.Heat
{
    public class HeatMap : Profile
    {
        public HeatMap()
        {
            CreateMap<HeatEntity, Razmanager.Protobuf.Public.V1.Heat>()
                .ForMember(dest => dest.HeatStateType, opt => opt.Ignore())
                .ForMember(dest => dest.SessionType, opt => opt.MapFrom(src => new SessionType
                {
                     Id = src.SessionTypeId,
                     Name = new ResourceManager(typeof(RazManager.Resources.SessionType)).GetString(src.SessionTypeId.ToString())
                 }));
            CreateMap<HeatIndicatorEntity, Razmanager.Protobuf.Public.V1.HeatIndicator>()
                .ForMember(dest => dest.Color, opt => opt.MapFrom(src => IndicatorColor(src)))
                .ForMember(dest => dest.CarImage, opt => opt.MapFrom<ImageToProtoResolver, ImageEntityBase?>(src => CarImage(src)));
            CreateMap<HeatIndicatorStintEntity, Razmanager.Protobuf.Public.V1.HeatIndicatorStint>();
        }


        private uint? IndicatorColor(HeatIndicatorEntity heatIndicator)
        {
            return heatIndicator.Heat.Race.TrackConfiguration.TrackConfigurationIndicators.SingleOrDefault(x => x.IndicatorId == heatIndicator.IndicatorId)?.Color;
        }


        private Stores.Entities.CarImage.CarImageEntity? CarImage(HeatIndicatorEntity heatIndicator)
        {
            return heatIndicator?.Car?.CarImages.FirstOrDefault();
        }
    }
}
