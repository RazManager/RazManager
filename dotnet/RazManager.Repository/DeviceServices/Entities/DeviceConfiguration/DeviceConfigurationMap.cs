using AutoMapper;
using RazManager.Repository.Stores.Entities.DeviceConfiguration;
using RazManager.Repository.Stores.Entities.DeviceConfigurationInput;
using RazManager.Repository.Stores.Entities.DeviceConfigurationOutput;
using RazManager.Repository.Stores.Entities.DeviceConfigurationFeature;
using System;


namespace RazManager.Repository.DeviceServices.Entities.DeviceConfiguration
{
    public class DeviceConfigurationMap : Profile
    {
        public DeviceConfigurationMap()
        {
            CreateMap<Razmanager.Protobuf.Public.V1.DeviceConfiguration, DeviceConfigurationEntity>()
                .ForMember(dest => dest.Id, opt => opt.MapFrom(src => new Guid(src.Id)));
            CreateMap<Razmanager.Protobuf.Public.V1.DeviceDeviceConfigurationInput, DeviceConfigurationInputEntity>();
            CreateMap<Razmanager.Protobuf.Public.V1.DeviceDeviceConfigurationOutput, DeviceConfigurationOutputEntity>();
            CreateMap<Razmanager.Protobuf.Public.V1.DeviceConfigurationFeatureTypeId, DeviceConfigurationFeatureEntity>()
                .ForMember(dest => dest.DeviceConfigurationFeatureTypeId, opt => opt.MapFrom(src => src));
        }
    }
}
