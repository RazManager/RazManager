using AutoMapper;
using Razmanager.Protobuf.Public.V1;
using RazManager.Repository.Stores.Entities.Race;
using RazManager.Repository.Stores.Entities.RaceIndicator;
using System.Linq;
using System.Resources;


namespace RazManager.Repository.SystemServices.Entities.Race
{
    public class RaceMap : Profile
    {
        public RaceMap()
        {
            CreateMap<RaceEntity, Razmanager.Protobuf.Public.V1.Race>()
                .ForMember(dest => dest.RaceStateType, opt => opt.MapFrom(src => new SummaryStateType
                {
                    Id = src.RaceStateTypeId,
                    Name = new ResourceManager(typeof(RazManager.Resources.SummaryStateType)).GetString(src.RaceStateTypeId.ToString())
                }))
                .ForMember(dest => dest.RaceEventUsers, opt => opt.MapFrom(src => src.RaceEventUsers.Select(x => x.EventUserId.ToString())));
            CreateMap<RaceIndicatorEntity, Razmanager.Protobuf.Public.V1.RaceIndicator>()
                .ForMember(dest => dest.Color, opt => opt.MapFrom(src => IndicatorColor(src)));
        }


        private uint? IndicatorColor(RaceIndicatorEntity raceIndicator)
        {
            return raceIndicator.Race.TrackConfiguration.TrackConfigurationIndicators.SingleOrDefault(x => x.IndicatorId == raceIndicator.IndicatorId)?.Color;
        }
    }
}
