using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Internal.Repository.CrudServices.User;
using RazManager.Repository.CrudServices.Utilities;
using RazManager.Repository.Stores.Entities.User;
using RazManager.Repository.Stores.Utilities;
using RazManager.Repository.Utilities;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Security.Cryptography;
using System.Threading.Tasks;


namespace RazManager.Repository.CrudServices.Entities.User
{
    public class UserStore : EntityCrudStoreBase<UserEntity,
                                                 UserRead, UserCreate, UserUpdate>, IUserStore
    {
        public UserStore(Stores.Context.RepositoryDbContext dbContext,
                         IHttpContextOptions httpContextOptions,
                         AutoMapper.IMapper mapper) :
            base(dbContext, httpContextOptions, mapper)
        {
        }


        public Task<(UserRead Proto, string ETag)> ReadAsync()
        {
            throw new System.NotImplementedException();
        }


        protected override IQueryable<UserEntity> GetQueryable()
        {
            return RepositoryDbContext.Users
                .Include(x => x.UserImages)
                .Include(x => x.EventUsers).ThenInclude(x => x.Event).ThenInclude(x => x.EventImages.Where(x => x.ImageSize == ImageSize.Avatar))
                .Include(x => x.EventUsers).ThenInclude(x => x.Event).ThenInclude(x => x.Tenant).ThenInclude(x => x.TenantImages.Where(x => x.ImageSize == ImageSize.Avatar))
                .Include(x => x.EventUsers).ThenInclude(x => x.Event).ThenInclude(x => x.Tenant).ThenInclude(x => x.TenantUsers)
                .Include(x => x.TenantUsers).ThenInclude(x => x.Tenant).ThenInclude(x => x.TenantImages.Where(x => x.ImageSize == ImageSize.Avatar));
        }


        protected override Task CreateValidateAsync(UserEntity entity)
        {
            return CreateUpdateValidateAsync(entity);
        }


        protected override Task UpdateValidateAsync(UserEntity entity)
        {
            return CreateUpdateValidateAsync(entity);
        }


        private async Task CreateUpdateValidateAsync(UserEntity entity)
        {
            if (await RepositoryDbContext.Users.AnyAsync(x => x.Id != entity.Id && x.UserName.ToLower() == entity.UserName.ToLower()))
            {
                throw new ValidationException(ExceptionMessages.UserAlreadySignedUp);
            }
        }


        protected override UserEntity CreateMap(UserCreate proto)
        {
            var entity = base.CreateMap(proto);

            using (var sha512 = SHA512.Create())
            {
                entity.PasswordHash = sha512.ComputeHash(System.Text.Encoding.UTF8.GetBytes(proto.Password));
            };

            if (proto.HasImage)
            {
                entity.UserImages.Clear();
                entity.UserImages.Add(new()
                {
                    ImageSize = ImageSize.Original,
                    Image = proto.Image.ToByteArray()
                });
                entity.UserImages.Add(new()
                {
                    ImageSize = ImageSize.Avatar,
                    Image = Avatar(proto.Image.ToByteArray())
                });
            }
            return entity;
        }


        protected override void UpdateMap(UserUpdate proto, UserEntity entity)
        {
            base.UpdateMap(proto, entity);
            if (proto.HasImageDeleted && proto.ImageDeleted)
            {
                entity.UserImages.Clear();
            }
            else if (proto.HasImage)
            {
                entity.UserImages.Clear();
                entity.UserImages.Add(new()
                {
                    ImageSize = ImageSize.Original,
                    Image = proto.Image.ToByteArray()
                });
                entity.UserImages.Add(new()
                {
                    ImageSize = ImageSize.Avatar,
                    Image = Avatar(proto.Image.ToByteArray())
                });
            }
        }
    }
}
