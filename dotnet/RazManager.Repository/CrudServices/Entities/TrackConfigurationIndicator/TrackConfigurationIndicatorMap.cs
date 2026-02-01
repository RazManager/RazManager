using AutoMapper;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Track;
using Razmanager.Protobuf.Internal.Repository.CrudServices.TrackConfiguration;
using RazManager.Repository.Stores.Entities.TrackConfigurationIndicator;


namespace RazManager.Repository.CrudServices.Entities.TrackConfigurationIndicator
{
    public class TrackConfigurationIndicatorMap : Profile
    {
        public TrackConfigurationIndicatorMap()
        {
            CreateMap<TrackConfigurationIndicatorEntity, TrackConfigurationIndicatorReadCreateUpdate>();
            CreateMap<TrackConfigurationIndicatorReadCreateUpdate, TrackConfigurationIndicatorEntity>();
            CreateMap<TrackConfigurationIndicatorEntity, TrackConfigurationIndicatorSelect>();
        }
    }
}
