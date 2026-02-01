using AutoMapper;
using Razmanager.Protobuf.Internal.Repository.CrudServices.DeviceConfiguration;
using RazManager.Repository.Stores.Entities.DeviceConfiguration;


namespace RazManager.Repository.CrudServices.Entities.DeviceConfiguration
{
    public class DeviceConfigurationMap : Profile
    {
        public DeviceConfigurationMap()
        {
            CreateMap<DeviceConfigurationEntity, DeviceConfigurationSelect>();
        }
    }
}
