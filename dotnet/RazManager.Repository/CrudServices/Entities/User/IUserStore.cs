using Razmanager.Protobuf.Internal.Repository.CrudServices.User;
using RazManager.Repository.CrudServices.Utilities;
using RazManager.Repository.Stores.Entities.User;


namespace RazManager.Repository.CrudServices.Entities.User
{
    public interface IUserStore : IEntityCrudStore<UserEntity, UserRead, UserCreate, UserUpdate>
    {
    }
}
