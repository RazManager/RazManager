using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Tenant;
using RazManager.Repository.CrudServices.Utilities;
using RazManager.Repository.Stores.Entities.Tenant;
using RazManager.Repository.Stores.Entities.TenantInvite;
using RazManager.Repository.Stores.Entities.TenantUser;
using RazManager.Repository.Stores.Utilities;
using RazManager.Repository.Utilities;
using System;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Repository.CrudServices.Entities.Tenant
{
    public class TenantStore : EntityCrudStoreBase<TenantEntity,
                                                   TenantRead, TenantCreateUpdate, TenantCreateUpdate>, ITenantStore
    {
        public TenantStore(Stores.Context.RepositoryDbContext dbContext,
                               IHttpContextOptions httpContextOptions,
                               AutoMapper.IMapper mapper) :
            base(dbContext, httpContextOptions, mapper)
        { }


        protected override IQueryable<TenantEntity> GetQueryable()
        {
            return RepositoryDbContext.Tenants
                .Where(x => x.Id == HttpContextOptions.TenantId)
                .Include(x => x.TenantImages)
                .Include(x => x.TenantInvites.OrderBy(x => x.TimeToLiveAt))
                .Include(x => x.TenantUsers.OrderByDescending(x => x.Administrator).ThenBy(x => x.User.Name).ThenBy(x => x.Name)).ThenInclude(x => x.User);
        }


        protected override Task UpdateValidateAsync(TenantEntity entity)
        {
            if (!entity.TenantUsers.Any(x => x.Administrator))
            {
                throw new ValidationException(ExceptionMessages.TenantUserAdministratorRequired);
            }
            return Task.CompletedTask;
        }



        protected override TenantEntity CreateMap(TenantCreateUpdate proto)
        {
            var entity = base.CreateMap(proto);
            CreateUpdateMap(proto, entity);
            entity.TenantUsers.Add(new TenantUserEntity
            {
                UserId = HttpContextOptions.UserId,
                Administrator = true
            });
            return entity;
        }


        protected override void UpdateMap(TenantCreateUpdate proto, TenantEntity entity)
        {
            base.UpdateMap(proto, entity);
            CreateUpdateMap(proto, entity);
        }


        private void CreateUpdateMap(TenantCreateUpdate proto, TenantEntity entity)
        {
            if (proto.HasImageDeleted && proto.ImageDeleted)
            {
                entity.TenantImages.Clear();
            }
            else if (proto.HasImage)
            {
                entity.TenantImages.Clear();
                entity.TenantImages.Add(new()
                {
                    ImageSize = ImageSize.Original,
                    Image = proto.Image.ToByteArray()
                });
                entity.TenantImages.Add(new()
                {
                    ImageSize = ImageSize.Avatar,
                    Image = Avatar( proto.Image.ToByteArray())
                });
            }

            entity.TenantInvites.RemoveAll(x => proto.TenantInvitesDeleted.Any(p => new Guid(p).Equals(x.Id)));
            foreach (var item in proto.TenantInvites)
            {
                var tenantInviteEntity = entity.TenantInvites.SingleOrDefault(x => x.Id.ToString() == item.Id);
                if (tenantInviteEntity is null)
                {
                    entity.TenantInvites.Add(Mapper.Map<TenantInviteEntity>(item));
                }
                else
                {
                    Mapper.Map(item, tenantInviteEntity);
                }
            }

            entity.TenantUsers.RemoveAll(x => proto.TenantUsersDeleted.Any(p => new Guid(p).Equals(x.Id)));
            foreach (var item in proto.TenantUsers)
            {
                var tenantUserEntity = entity.TenantUsers.SingleOrDefault(x => x.Id.ToString() == item.Id);
                if (tenantUserEntity is null)
                {
                    entity.TenantUsers.Add(Mapper.Map<TenantUserEntity>(item));
                }
                else
                {
                    Mapper.Map(item, tenantUserEntity);
                }
            }
        }
    }
}
