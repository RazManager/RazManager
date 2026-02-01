using AutoMapper;
using Razmanager.Protobuf.Internal.Repository.CrudServices.RaceFormatType;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Track;
using Razmanager.Protobuf.Internal.Repository.CrudServices.TrackConfiguration;
using Razmanager.Protobuf.Public.V1;
using RazManager.Repository.Stores.Entities.TrackConfiguration;
using System.Collections.Generic;
using System.Linq;


namespace RazManager.Repository.CrudServices.Entities.TrackConfiguration
{
    public class TrackConfigurationMap : Profile
    {
        public TrackConfigurationMap()
        {
            CreateMap<TrackConfigurationEntity, TrackConfigurationReadCreateUpdate>()
                .ForMember(dest => dest.DeviceConfigurationIds, opt => opt.MapFrom(src => src.TrackConfigurationDeviceConfigurations.Select(x => x.DeviceConfigurationId)))
                .ForMember(dest => dest.RaceFormatTypeIds, opt => opt.MapFrom(src => src.TrackConfigurationRaceFormats.Select(x => x.RaceFormatTypeId)));
            CreateMap<TrackConfigurationReadCreateUpdate, TrackConfigurationEntity>()
                .ForMember(dest => dest.Id, opt => opt.Ignore());
            CreateMap<TrackConfigurationEntity, TrackConfigurationList>();
            CreateMap<TrackConfigurationEntity, TrackConfigurationSelect>()
                .ForMember(dest => dest.TrackConfigurationIndicators, opt => opt.MapFrom(src => src
                    .TrackConfigurationDeviceConfigurations
                    .SelectMany(x => x.DeviceConfiguration.DeviceConfigurationInputs.Where(x => x.DeviceConfigurationInputTypeId == DeviceConfigurationInputTypeId.StartFinishIndicator && x.DeviceConfigurationInputId != null))
                    .OrderBy(x => x.DeviceConfigurationInputId)
                    .Select(x => new TrackConfigurationIndicatorSelect
                    {
                        IndicatorId = x.DeviceConfigurationInputId!.Value,
                        Color = TrackConfigurationIndicatorColor(x.DeviceConfigurationInputId!.Value, src.TrackConfigurationIndicators)
                    })))
                .ForMember(dest => dest.TrackConfigurationRaceFormats, opt => opt.MapFrom(src => src
                    .TrackConfigurationRaceFormats
                    .OrderBy(x => x.RaceFormatTypeId)
                    .Select(x => Resources.Constants.RaceFormatTypes.SingleOrDefault(c => c.Id == x.RaceFormatTypeId))));
        }


        private uint? TrackConfigurationIndicatorColor(int indicatorId, IEnumerable<Stores.Entities.TrackConfigurationIndicator.TrackConfigurationIndicatorEntity> trackConfigurationIndicators)
        {
            return trackConfigurationIndicators.SingleOrDefault(tci => tci.IndicatorId == indicatorId)?.Color;
        }
    }
}
