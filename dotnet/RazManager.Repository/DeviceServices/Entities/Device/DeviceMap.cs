using AutoMapper;
using RazManager.Repository.Stores.Entities.Device;


namespace RazManager.Repository.DeviceServices.Entities.Device
{
    public class DeviceMap : Profile
    {
        public DeviceMap()
        {
            CreateMap<Razmanager.Protobuf.Public.V1.DeviceInformation, DeviceEntity>()
                .ForMember(dest => dest.Id, opt => opt.Ignore())
                .ForMember(dest => dest.DeviceConfigurations, opt => opt.Ignore());
        }
    }
}
