using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Car;
using RazManager.Repository.CrudServices.Utilities;
using RazManager.Repository.Stores.Entities.Car;
using RazManager.Repository.Stores.Utilities;
using RazManager.Repository.Utilities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Repository.CrudServices.Entities.Car
{
    public class CarStore : EntityCrudStoreBase<CarEntity,
                                                CarRead, CarCreateUpdate, CarCreateUpdate>, ICarStore
    {
        public CarStore(Stores.Context.RepositoryDbContext dbContext,
                        IHttpContextOptions httpContextOptions,
                        AutoMapper.IMapper mapper) :
            base(dbContext, httpContextOptions, mapper)
        { }


        protected override IQueryable<CarEntity> GetQueryable()
        {
            return RepositoryDbContext.Cars
                .Include(x => x.CarImages)
                .Include(x => x.CarCarTags);
        }


        protected override Task CreateValidateAsync(CarEntity entity)
        {
            return CreateUpdateValidateAsync(entity);
        }


        protected override Task UpdateValidateAsync(CarEntity entity)
        {
            return CreateUpdateValidateAsync(entity);
        }


        private async Task CreateUpdateValidateAsync(CarEntity entity)
        {
            if (await RepositoryDbContext.Cars.AnyAsync(x => x.TenantId == HttpContextOptions.TenantId && x.Id != entity.Id && x.Name == entity.Name))
            {
                throw new ValidationException(ExceptionMessages.CarNameDuplicate);
            }
        }


        protected override CarEntity CreateMap(CarCreateUpdate proto)
        {
            var entity = base.CreateMap(proto);
            CreateUpdateMap(proto, entity);
            return entity;
        }


        protected override void UpdateMap(CarCreateUpdate proto, CarEntity entity)
        {
            base.UpdateMap(proto, entity);
            CreateUpdateMap(proto, entity);
        }


        private void CreateUpdateMap(CarCreateUpdate proto, CarEntity entity)
        {
            if (proto.HasImageDeleted && proto.ImageDeleted)
            {
                entity.CarImages.Clear();
            }
            else if (proto.HasImage)
            {
                entity.CarImages.Clear();
                entity.CarImages.Add(new()
                {
                    ImageSize = ImageSize.Original,
                    Image = proto.Image.ToByteArray()
                });
                entity.CarImages.Add(new()
                {
                    ImageSize = ImageSize.Avatar,
                    Image = Avatar(proto.Image.ToByteArray())
                });
            }

            entity.CarCarTags.RemoveAll(x => !proto.CarTagIds.Contains(x.CarTagId.ToString()));
            foreach (var carTagId in proto.CarTagIds)
            {
                var carCarTagEntity = entity.CarCarTags.SingleOrDefault(x => x.CarTagId == new Guid(carTagId));
                if (carCarTagEntity is null)
                {
                    entity.CarCarTags.Add(new Stores.Entities.CarCarTag.CarCarTagEntity
                    {
                        CarTagId = new Guid(carTagId)
                    });
                }
            }

            //entity.CarTrackConfigurations.RemoveAll(x => !proto.TrackConfigurationIds.Contains(x.TrackConfigurationId.ToString()));
            //foreach (var trackConfigurationId in proto.TrackConfigurationIds)
            //{
            //    var carTrackEntity = entity.CarTrackConfigurations.SingleOrDefault(x => x.TrackConfigurationId == new Guid(trackConfigurationId));
            //    if (carTrackEntity == null)
            //    {
            //        entity.CarTrackConfigurations.Add(new Store.Entities.CarTrackConfiguration.CarTrackConfigurationEntity
            //        {
            //            TrackConfigurationId = new Guid(trackConfigurationId)
            //        });
            //    }
            //}
        }


        public async IAsyncEnumerable<CarList> ListAsync(int limit, int offset, IEnumerable<Guid> carTagIds)
        {
            var query = RepositoryDbContext.Cars
                .Include(x => x.CarImages.Where(x => x.ImageSize == ImageSize.Avatar))
                .Include(x => x.CarCarTags.OrderBy(x => x.CarTag.Position).ThenBy(x => x.CarTag.Name)).ThenInclude(x => x.CarTag)
                .Where(x => x.TenantId == HttpContextOptions.TenantId);

            if (carTagIds.Any())
            {
                query = query.Where(x => carTagIds.All(carTagId => x.CarCarTags.Any(carCarTag => carCarTag.CarTagId == carTagId)));
            }

            query = query.OrderBy(x => x.Name);

            var response = ListAsync(limit, offset, query);

            await foreach (var entity in response)
            {
                yield return Mapper.Map<CarList>(entity);
            }
        }


        public async IAsyncEnumerable<CarSelect> SelectAsync()
        {
            var response = RepositoryDbContext.Cars
                .Include(x => x.CarImages.Where(x => x.ImageSize == ImageSize.Avatar))
                .Include(x => x.CarCarTags)
                .Where(x => x.TenantId == HttpContextOptions.TenantId)
                .OrderBy(x => x.Name)
                .AsAsyncEnumerable()
                .ConfigureAwait(false);

            await foreach (var entity in response)
            {
                yield return Mapper.Map<CarSelect>(entity);
            }
        }
    }
}
