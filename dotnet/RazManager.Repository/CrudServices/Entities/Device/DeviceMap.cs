using AutoMapper;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Device;
using Razmanager.Protobuf.Public.V1;
using RazManager.Repository.Stores.Entities.Device;
using RazManager.Repository.Stores.Entities.DeviceConfiguration;
using RazManager.Repository.Stores.Entities.DeviceConfigurationInput;
using RazManager.Repository.Stores.Entities.DeviceConfigurationOutput;
using RazManager.Utilities.Protobuf;
using System;
using System.Linq;


namespace RazManager.Repository.CrudServices.Entities.Device
{
    public class DeviceMap : Profile
    {
        public DeviceMap()
        {
            CreateMap<DeviceEntity, DeviceRead>()
                .ForMember(dest => dest.Id, opt => opt.MapFrom<EmptyGuidToProtoResolver, Guid>(src => src.Id));
            CreateMap<DeviceConfigurationEntity, DeviceConfigurationRead>()
                .ForMember(dest => dest.Id, opt => opt.MapFrom<EmptyGuidToProtoResolver, Guid>(src => src.Id))
                .ForMember(dest => dest.DeviceConfigurationInputs, opt => opt.MapFrom(src => src.DeviceConfigurationInputs
                                                                                                .OrderBy(x => x.DeviceConfigurationInputTypeId)
                                                                                                .ThenBy(x => x.DeviceConfigurationInputId)
                                                                                                .ThenBy(x => x.DeviceConfigurationInputSubId)))
                .ForMember(dest => dest.DeviceConfigurationOutputs, opt => opt.MapFrom(src => src.DeviceConfigurationOutputs
                                                                                                .OrderBy(x => x.DeviceConfigurationOutputTypeId)
                                                                                                .ThenBy(x => x.DeviceConfigurationOutputId)));
            CreateMap<DeviceConfigurationInputEntity, DeviceDeviceConfigurationInput>();
            CreateMap<DeviceConfigurationOutputEntity, DeviceDeviceConfigurationOutput>();
            CreateMap<DeviceCreateUpdate, DeviceEntity>()
                .ForMember(dest => dest.DeviceConfigurations, opt => opt.Ignore());
            CreateMap<DeviceEntity, DeviceList>()
                .ForMember(dest => dest.LastConnectedAt, opt => opt.MapFrom<NullableDateTimeToProtoResolver, DateTime?>(src => src.LastConnectedAt));
            CreateMap<DeviceEntity, DeviceSelect>();
        }
    }
}
