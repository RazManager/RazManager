using AutoMapper;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Race;
using RazManager.Repository.Stores.Entities.RaceIndicatorEventUser;


namespace RazManager.Repository.CrudServices.Entities.RaceIndicatorEventUser
{
    public class RaceIndicatorEventUserMap : Profile
    {
        public RaceIndicatorEventUserMap()
        {
            CreateMap<RaceIndicatorEventUserEntity, RaceIndicatorEventUserReadCreateUpdate>();
            CreateMap<RaceIndicatorEventUserReadCreateUpdate, RaceIndicatorEventUserEntity>()
                .ForMember(dest => dest.Id, opt => opt.Ignore());
        }
    }
}
