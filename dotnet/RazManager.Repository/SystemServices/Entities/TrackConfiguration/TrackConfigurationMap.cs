using AutoMapper;
using Razmanager.Protobuf.Internal.Repository.SystemServices.TrackConfiguration;
using RazManager.Repository.Stores.Entities.Race;
using RazManager.Repository.Stores.Entities.TrackConfiguration;
using System.Linq;


namespace RazManager.Repository.SystemServices.Entities.TrackConfiguration
{
    public class TrackConfigurationMap : Profile
    {
        public TrackConfigurationMap()
        {
            CreateMap<TrackConfigurationEntity, TrackConfigurationRead>()
                .ForMember(dest => dest.DeviceConfigurationIds, opt => opt.MapFrom(src => src.TrackConfigurationDeviceConfigurations.Select(x => x.DeviceConfigurationId)));
            CreateMap<TrackConfigurationEntity, Razmanager.Protobuf.Public.V1.TrackConfiguration>();
        }
    }
}
