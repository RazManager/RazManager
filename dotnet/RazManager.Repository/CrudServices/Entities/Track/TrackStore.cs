using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Track;
using RazManager.Repository.CrudServices.Utilities;
using RazManager.Repository.Stores.Entities.Track;
using RazManager.Repository.Stores.Utilities;
using RazManager.Repository.Utilities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Repository.CrudServices.Entities.Track
{
    public class TrackStore : EntityCrudStoreBase<TrackEntity,
                                                  TrackRead, TrackCreateUpdate, TrackCreateUpdate>, ITrackStore
    {
        public TrackStore(Stores.Context.RepositoryDbContext dbContext,
                          IHttpContextOptions httpContextOptions,
                          AutoMapper.IMapper mapper) :
            base(dbContext, httpContextOptions, mapper)
        { }


        protected override IQueryable<TrackEntity> GetQueryable()
        {
            return RepositoryDbContext.Tracks
                .Include(x => x.TrackImages)
                .Include(x => x.TrackConfigurations.OrderBy(x => x.Name))
                .Include(x => x.TrackConfigurations).ThenInclude(x => x.TrackConfigurationDeviceConfigurations)
                .Include(x => x.TrackConfigurations).ThenInclude(x => x.TrackConfigurationRaceFormats)
                .Include(x => x.TrackConfigurations).ThenInclude(x => x.TrackConfigurationIndicators.OrderBy(x => x.IndicatorId));
        }


        public override async Task<TrackRead> InitializeAsync()
        {
            var result = await base.InitializeAsync();
            result.TrackConfigurations.Add(new TrackConfigurationReadCreateUpdate());
            return result;
        }


        protected override TrackEntity CreateMap(TrackCreateUpdate proto)
        {
            var entity = base.CreateMap(proto);
            CreateUpdateMap(proto, entity);
            return entity;
        }


        protected override void UpdateMap(TrackCreateUpdate proto, TrackEntity entity)
        {
            base.UpdateMap(proto, entity);
            CreateUpdateMap(proto, entity);
        }


        private void CreateUpdateMap(TrackCreateUpdate proto, TrackEntity entity)
        {
            if (proto.HasImageDeleted && proto.ImageDeleted)
            {
                entity.TrackImages.Clear();
            }
            else if (proto.HasImage)
            {
                entity.TrackImages.Clear();
                entity.TrackImages.Add(new()
                {
                    ImageSize = ImageSize.Original,
                    Image = proto.Image.ToByteArray()
                });
                entity.TrackImages.Add(new()
                {
                    ImageSize = ImageSize.Avatar,
                    Image = Avatar(proto.Image.ToByteArray())
                });
            }

            entity.TrackConfigurations.RemoveAll(x => !proto.TrackConfigurations.Select(x => x.Id).Contains(x.Id.ToString()));
            foreach (var trackConfigurationProto in proto.TrackConfigurations)
            {
                Stores.Entities.TrackConfiguration.TrackConfigurationEntity? trackConfigurationEntity = null;
                if (!string.IsNullOrEmpty(trackConfigurationProto.Id))
                {
                    trackConfigurationEntity = entity.TrackConfigurations.SingleOrDefault(x => x.Id == new Guid(trackConfigurationProto.Id));
                }
                if (trackConfigurationEntity is null)
                {
                    trackConfigurationEntity = new Stores.Entities.TrackConfiguration.TrackConfigurationEntity();
                    entity.TrackConfigurations.Add(trackConfigurationEntity);
                }
                Mapper.Map(trackConfigurationProto, trackConfigurationEntity);

                trackConfigurationEntity.TrackConfigurationRaceFormats.Clear();
                foreach (var raceFormatTypeId in trackConfigurationProto.RaceFormatTypeIds)
                {
                    trackConfigurationEntity.TrackConfigurationRaceFormats.Add(new Stores.Entities.TrackConfigurationRaceFormat.TrackConfigurationRaceFormatEntity
                    {
                        RaceFormatTypeId = raceFormatTypeId
                    });
                }

                trackConfigurationEntity.TrackConfigurationIndicators.Clear();
                foreach (var trackConfigurationIndicator in trackConfigurationProto.TrackConfigurationIndicators)
                {
                    trackConfigurationEntity.TrackConfigurationIndicators.Add(Mapper.Map<Stores.Entities.TrackConfigurationIndicator.TrackConfigurationIndicatorEntity>(trackConfigurationIndicator));
                }

                trackConfigurationEntity.TrackConfigurationDeviceConfigurations.Clear();
                foreach (var deviceConfigurationId in trackConfigurationProto.DeviceConfigurationIds)
                {
                    trackConfigurationEntity.TrackConfigurationDeviceConfigurations.Add(new Stores.Entities.TrackConfigurationDeviceConfiguration.TrackConfigurationDeviceConfigurationEntity
                    {
                        DeviceConfigurationId = new Guid(deviceConfigurationId)
                    });
                }
            }
        }


        protected override Task CreateValidateAsync(TrackEntity entity)
        {
            return CreateUpdateValidateAsync(entity);
        }


        protected override Task UpdateValidateAsync(TrackEntity entity)
        {
            return CreateUpdateValidateAsync(entity);
        }


        private async Task CreateUpdateValidateAsync(TrackEntity entity)
        {
            if (await RepositoryDbContext.Tracks.AnyAsync(x => x.TenantId == HttpContextOptions.TenantId && x.Id != entity.Id && x.Name == entity.Name))
            {
                throw new ValidationException(ExceptionMessages.TrackNameDuplicate);
            }

            if (entity.TrackConfigurations
                    .GroupBy(x => x.Name)
                    .Any(x => x.Count() > 1))
            {
                throw new ValidationException(ExceptionMessages.TrackConfigurationNameDuplicate);
            }
        }


        public async IAsyncEnumerable<TrackList> ListAsync(int limit, int offset)
        {
            var query = RepositoryDbContext.Tracks
                .Include(x => x.TrackImages.Where(x => x.ImageSize == ImageSize.Avatar))
                .Where(x => x.TenantId == HttpContextOptions.TenantId)
                .OrderBy(x => x.Name);

            var response = ListAsync(limit, offset, query);

            await foreach (var entity in response)
            {
                yield return Mapper.Map<TrackList>(entity);
            }
        }
    }
}
