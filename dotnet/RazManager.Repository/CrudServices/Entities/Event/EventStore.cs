using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Event;
using RazManager.Repository.CrudServices.Utilities;
using RazManager.Repository.Stores.Entities.Event;
using RazManager.Repository.Stores.Entities.EventInvite;
using RazManager.Repository.Stores.Entities.EventUser;
using RazManager.Repository.Stores.Utilities;
using RazManager.Repository.Utilities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Repository.CrudServices.Entities.Event
{
    public class EventStore : EntityCrudStoreBase<EventEntity,
                                                  EventRead, EventCreateUpdate, EventCreateUpdate>, IEventStore
    {
        public EventStore(Stores.Context.RepositoryDbContext dbContext,
                          IHttpContextOptions httpContextOptions,
                          AutoMapper.IMapper mapper) :
            base(dbContext, httpContextOptions, mapper)
        { }


        protected override IQueryable<EventEntity> GetQueryable()
        {
            return RepositoryDbContext.Events
                .Where(x => x.TenantId == HttpContextOptions.TenantId)
                .Include(x => x.EventImages)
                .Include(x => x.EventInvites.OrderBy(x => x.TimeToLiveAt))
                .Include(x => x.EventUsers).ThenInclude(x => x.EventUserImages.Where(x => x.ImageSize == Stores.Utilities.ImageSize.Avatar))
                .Include(x => x.EventUsers.OrderBy(x => x.EventUserTypeId).ThenBy(x => !x.UserId.HasValue).ThenBy(x => x.User.Name).ThenBy(x => x.Name)).ThenInclude(x => x.User);
        }


        protected override Task CreateValidateAsync(EventEntity entity)
        {
            return CreateUpdateValidateAsync(entity);
        }


        protected override Task UpdateValidateAsync(EventEntity entity)
        {
            return CreateUpdateValidateAsync(entity);
        }


        private async Task CreateUpdateValidateAsync(EventEntity entity)
        {
            if (await RepositoryDbContext.Events.AnyAsync(x => x.TenantId == HttpContextOptions.TenantId && x.Id != entity.Id && x.Name == entity.Name))
            {
                throw new ValidationException(ExceptionMessages.EventNameDuplicate);
            }
        }


        protected override EventEntity CreateMap(EventCreateUpdate proto)
        {
            var entity = base.CreateMap(proto);
            CreateUpdateMap(proto, entity);
            return entity;
        }


        protected override void UpdateMap(EventCreateUpdate proto, EventEntity entity)
        {
            base.UpdateMap(proto, entity);
            CreateUpdateMap(proto, entity);
        }


        private void CreateUpdateMap(EventCreateUpdate proto, EventEntity entity)
        {
            if (proto.HasImageDeleted && proto.ImageDeleted)
            {
                entity.EventImages.Clear();
            }
            else if (proto.HasImage)
            {
                entity.EventImages.Clear();
                entity.EventImages.Add(new()
                {
                    ImageSize = ImageSize.Original,
                    Image = proto.Image.ToByteArray()
                });
                entity.EventImages.Add(new()
                {
                    ImageSize = ImageSize.Avatar,
                    Image = Avatar( proto.Image.ToByteArray())
                });
            }

            entity.EventInvites.RemoveAll(x => proto.EventInvitesDeleted.Any(p => new Guid(p).Equals(x.Id)));
            foreach (var item in proto.EventInvites)
            {
                var eventInviteEntity = entity.EventInvites.SingleOrDefault(x => x.Id.ToString() == item.Id);
                if (eventInviteEntity is null)
                {
                    entity.EventInvites.Add(Mapper.Map<EventInviteEntity>(item));
                }
                else
                {
                    Mapper.Map(item, eventInviteEntity);
                }
            }

            entity.EventUsers.RemoveAll(x => proto.EventUsersDeleted.Any(p => new Guid(p).Equals(x.Id)));
            foreach (var eventUserProto in proto.EventUsers)
            {
                var eventUserEntity = entity.EventUsers.SingleOrDefault(x => x.Id.ToString() == eventUserProto.Id);
                if (eventUserEntity is null)
                {
                    eventUserEntity = Mapper.Map<EventUserEntity>(eventUserProto);
                    entity.EventUsers.Add(eventUserEntity);
                }
                else
                {
                    Mapper.Map(eventUserProto, eventUserEntity);
                }


                if (eventUserProto.HasImageDeleted && eventUserProto.ImageDeleted)
                {
                    eventUserEntity.EventUserImages.Clear();
                }
                else if (eventUserProto.HasImage)
                {
                    eventUserEntity.EventUserImages.Clear();
                    //eventUserEntity.EventUserImages.Add(new()
                    //{
                    //    ImageSize = ImageSize.Original,
                    //    Image = eventUserProto.Image.ToByteArray()
                    //});
                    eventUserEntity.EventUserImages.Add(new()
                    {
                        ImageSize = ImageSize.Avatar,
                        Image = Avatar(eventUserProto.Image.ToByteArray())
                    });
                }




            }
        }


        public async IAsyncEnumerable<EventList> ListAsync(int limit, int offset)
        {
            var query = RepositoryDbContext.Events
                .Include(x => x.EventImages.Where(x => x.ImageSize == ImageSize.Avatar))
                .Where(x => x.TenantId == HttpContextOptions.TenantId)
                .OrderByDescending(x => x.TimeToLiveAt)
                .ThenBy(x => x.Name);

            var response = ListAsync(limit, offset, query);

            await foreach (var entity in response)
            {
                yield return Mapper.Map<EventList>(entity);
            }
        }


        public async IAsyncEnumerable<EventSelect> SelectAsync()
        {
            var response = RepositoryDbContext.Events
                .Include(x => x.EventImages.Where(x => x.ImageSize == ImageSize.Avatar))
                .Where(x => x.TenantId == HttpContextOptions.TenantId)
                .OrderBy(x => x.Name)
                .AsAsyncEnumerable()
                .ConfigureAwait(false);

            await foreach (var entity in response)
            {
                yield return Mapper.Map<EventSelect>(entity);
            }
        }
    }
}
