using AutoMapper;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Race;
using RazManager.Repository.Stores.Entities.RaceEventUser;


namespace RazManager.Repository.CrudServices.Entities.RaceEventUser
{
    public class RaceEventUserMap : Profile
    {
        public RaceEventUserMap()
        {
            CreateMap<RaceEventUserEntity, RaceEventUserReadCreateUpdate>();
            CreateMap<RaceEventUserReadCreateUpdate, RaceEventUserEntity>()
                .ForMember(dest => dest.Id, opt => opt.Ignore());
        }
    }
}
