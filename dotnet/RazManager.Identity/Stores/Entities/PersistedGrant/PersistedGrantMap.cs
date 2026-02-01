using AutoMapper;


namespace RazManager.Identity.Stores.Entities.PersistedGrant
{
    public class PersistedGrantMap : Profile
    {
        public PersistedGrantMap()
        {
            CreateMap<Duende.IdentityServer.Models.PersistedGrant, PersistedGrantEntity>();
        }
    }
}
