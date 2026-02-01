using AutoMapper;
using Razmanager.Protobuf.Internal.Repository.SystemServices.DeviceConfiguration;
using RazManager.Repository.Stores.Entities.DeviceConfiguration;
using RazManager.Repository.Stores.Entities.DeviceConfigurationInput;
using RazManager.Repository.Stores.Entities.DeviceConfigurationOutput;
using System.Linq;


namespace RazManager.Repository.SystemServices.Entities.DeviceConfiguration
{
    public class DeviceConfigurationMap : Profile
    {
        public DeviceConfigurationMap()
        {
            CreateMap<DeviceConfigurationEntity, DeviceConfigurationRead>()
                .ForMember(x => x.DeviceConfiguration, opt => opt.MapFrom(src => src))
                .ForMember(dest => dest.TrackConfigurationIds, opt => opt.MapFrom(src => src.TrackConfigurationDeviceConfigurations.Select(x => x.TrackConfigurationId)));
            CreateMap<DeviceConfigurationEntity, Razmanager.Protobuf.Public.V1.DeviceConfiguration>();
                //.ForMember(dest => dest.DeviceConfigurationInputs, opt => opt.MapFrom(src => src.DeviceConfigurationInputs))
                //.ForMember(dest => dest.DeviceConfigurationOutputs, opt => opt.MapFrom(src => src.DeviceConfigurationOutputs));
            CreateMap<DeviceConfigurationInputEntity, Razmanager.Protobuf.Public.V1.DeviceDeviceConfigurationInput>();
            CreateMap<DeviceConfigurationOutputEntity, Razmanager.Protobuf.Public.V1.DeviceDeviceConfigurationOutput>();
        }
    }
}