using AutoMapper;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Race;
using RazManager.Repository.Stores.Entities.RaceIndicator;


namespace RazManager.Repository.CrudServices.Entities.RaceIndicator
{
    public class RaceIndicatorMap : Profile
    {
        public RaceIndicatorMap()
        {
            CreateMap<RaceIndicatorEntity, RaceIndicatorReadCreateUpdate>();
            CreateMap<RaceIndicatorReadCreateUpdate, RaceIndicatorEntity>()
                .ForMember(dest => dest.Id, opt => opt.Ignore());
        }
    }
}
