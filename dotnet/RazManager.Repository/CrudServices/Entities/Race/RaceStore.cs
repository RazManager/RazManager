using Azure.Core;
using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Common;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Race;
using Razmanager.Protobuf.Internal.Repository.CrudServices.RaceFormatType;
using Razmanager.Protobuf.Public.V1;
using RazManager.Repository.CrudServices.Utilities;
using RazManager.Repository.Stores.Context;
using RazManager.Repository.Stores.Entities.Heat;
using RazManager.Repository.Stores.Entities.HeatIndicator;
using RazManager.Repository.Stores.Entities.HeatIndicatorStint;
using RazManager.Repository.Stores.Entities.Race;
using RazManager.Repository.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Repository.CrudServices.Entities.Race
{
    public class RaceStore : EntityCrudStoreBase<RaceEntity,
                                                 RaceRead, RaceCreate, RaceUpdate>, IRaceStore
    {
        public RaceStore(Stores.Context.RepositoryDbContext dbContext,
                         IHttpContextOptions httpContextOptions,
                         AutoMapper.IMapper mapper) :
            base(dbContext, httpContextOptions, mapper)
        { }


        protected override IQueryable<RaceEntity> GetQueryable()
        {
            return RepositoryDbContext.Races
                .Include(x => x.Event).ThenInclude(x => x.EventUsers)
                    .ThenInclude(x => x.User).ThenInclude(x => x.UserImages.Where(x => x.ImageSize == Stores.Utilities.ImageSize.Avatar))
                .Include(x => x.Event).ThenInclude(x => x.EventUsers)
                    .ThenInclude(x => x.Autopilot).ThenInclude(x => x.AutopilotImages.Where(x => x.ImageSize == Stores.Utilities.ImageSize.Avatar))
                .Include(x => x.TrackConfiguration).ThenInclude(x => x.Track)
                .Include(x => x.TrackConfiguration).ThenInclude(x => x.TrackConfigurationRaceFormats)
                .Include(x => x.TrackConfiguration).ThenInclude(x => x.TrackConfigurationIndicators)
                .Include(x => x.TrackConfiguration).ThenInclude(x => x.TrackConfigurationDeviceConfigurations).ThenInclude(x => x.DeviceConfiguration).ThenInclude(x => x.DeviceConfigurationInputs)
                .Include(x => x.RaceCarTags)
                .Include(x => x.RaceIndicators)
                .Include(x => x.RaceEventUsers)
                .Include(x => x.RaceIndicatorEventUsers)
                .Include(x => x.Heats);
        }


        public override async Task<RaceRead> InitializeAsync()
        {
            var result = await base.InitializeAsync();

            var events = await RepositoryDbContext
                .Events
                .Where(x => x.TenantId == HttpContextOptions.TenantId)
                .ToListAsync()
                .ConfigureAwait(false);
            if (events.Count() == 1)
            {
                result.EventId = events.First().Id.ToString();
            }

            var trackConfigurations = await RepositoryDbContext
                .TrackConfigurations
                .Where(x => x.Track.TenantId == HttpContextOptions.TenantId)
                .ToListAsync()
                .ConfigureAwait(false);
            if (trackConfigurations.Count() == 1)
            {
                result.TrackConfigurationId = trackConfigurations.First().Id.ToString();
            }

            return result;
        }


        protected override RaceRead ReadMap(RaceEntity entity)
        {
            var proto = base.ReadMap(entity);

            proto.Event.EventUsers.AddRange(entity.Event.EventUsers
                .Where(x => x.EventUserTypeId == Razmanager.Protobuf.Public.V1.EventUserTypeId.Team || (x.EventUserTypeId == Razmanager.Protobuf.Public.V1.EventUserTypeId.Driver && x.EventUserId is null))
                .OrderBy(x => x.AutopilotId.HasValue).ThenBy(x => !x.UserId.HasValue).ThenBy(x => x.User?.Name).ThenBy(x => x.Name)
                .Select(x => Mapper.Map<Razmanager.Protobuf.Internal.Repository.CrudServices.Event.EventUserSelect>(x)));

            return proto;
        }

        protected override RaceEntity CreateMap(RaceCreate proto)
        {
            var entity = base.CreateMap(proto);

            entity.RaceStateTypeId = Razmanager.Protobuf.Public.V1.RaceStateTypeId.Pending;

            CreateUpdateMapCarTags(proto.CarTagIds, entity);
            CreateUpdateMapRaceIndicators(proto.RaceIndicators, entity);
            CreateUpdateMapRaceEventUsers(proto.RaceEventUsers, entity);
            CreateUpdateMapRaceIndicatorEventUsers(proto.RaceIndicatorEventUsers, entity);
            CreateUpdateMapHeats(proto.RaceFormatTypeId, entity);
            return entity;
        }


        protected override void UpdateMap(RaceUpdate proto, RaceEntity entity)
        {
            base.UpdateMap(proto, entity);
            CreateUpdateMapCarTags(proto.CarTagIds, entity);
            CreateUpdateMapRaceIndicators(proto.RaceIndicators, entity);
            CreateUpdateMapRaceEventUsers(proto.RaceEventUsers, entity);
            CreateUpdateMapRaceIndicatorEventUsers(proto.RaceIndicatorEventUsers, entity);
            CreateUpdateMapHeats(proto.RaceFormatTypeId, entity);
        }


        private void CreateUpdateMapCarTags(IEnumerable<string> carTagIds, RaceEntity entity)
        {
            entity.RaceCarTags.RemoveAll(x => !carTagIds.Contains(x.CarTagId.ToString()));
            foreach (var carTagId in carTagIds)
            {
                var raceCarTagEntity = entity.RaceCarTags.SingleOrDefault(x => x.CarTagId == new Guid(carTagId));
                if (raceCarTagEntity is null)
                {
                    entity.RaceCarTags.Add(new Stores.Entities.RaceCarTag.RaceCarTagEntity
                    {
                        CarTagId = new Guid(carTagId)
                    });
                }
            }
        }


        private void CreateUpdateMapRaceIndicators(IEnumerable<RaceIndicatorReadCreateUpdate> raceIndicatorProtos, RaceEntity entity)
        {
            entity.RaceIndicators.RemoveAll(x => !raceIndicatorProtos.Any(p => x.IndicatorId == p.IndicatorId));
            foreach (var raceIndicatorProto in raceIndicatorProtos)
            {
                var raceIndicatorEntity = entity.RaceIndicators.SingleOrDefault(x => x.IndicatorId == raceIndicatorProto.IndicatorId);
                if (raceIndicatorEntity is null)
                {
                    entity.RaceIndicators.Add(Mapper.Map<Stores.Entities.RaceIndicator.RaceIndicatorEntity>(raceIndicatorProto));
                }
                else
                {
                    Mapper.Map(raceIndicatorProto, raceIndicatorEntity);
                }
            }
        }


        private void CreateUpdateMapRaceEventUsers(IEnumerable<RaceEventUserReadCreateUpdate> raceEventUserProtos, RaceEntity entity)
        {
            entity.RaceEventUsers.RemoveAll(x => !raceEventUserProtos.Any(p => x.EventUserId == new Guid(p.EventUserId)));
            foreach (var raceEventUserProto in raceEventUserProtos)
            {
                var raceEventUserEntity = entity.RaceEventUsers.SingleOrDefault(x => x.EventUserId == new Guid(raceEventUserProto.EventUserId));
                if (raceEventUserEntity is null)
                {
                    entity.RaceEventUsers.Add(Mapper.Map<Stores.Entities.RaceEventUser.RaceEventUserEntity>(raceEventUserProto));
                }
                else
                {
                    Mapper.Map(raceEventUserProto, raceEventUserEntity);
                }
            }
        }


        private void CreateUpdateMapRaceIndicatorEventUsers(IEnumerable<RaceIndicatorEventUserReadCreateUpdate> raceIndicatorEventUserProtos, RaceEntity entity)
        {
            entity.RaceIndicatorEventUsers.Clear();
            foreach (var raceIndicatorEventUserProto in raceIndicatorEventUserProtos)
            {
                entity.RaceIndicatorEventUsers.Add(Mapper.Map<Stores.Entities.RaceIndicatorEventUser.RaceIndicatorEventUserEntity>(raceIndicatorEventUserProto));
            }
        }


        private void CreateUpdateMapHeats(Razmanager.Protobuf.Internal.Repository.CrudServices.RaceFormatType.RaceFormatTypeId raceFormatTypeId, RaceEntity entity)
        {
            entity.Heats.Clear();

            HeatEntity? heat;

            if (entity.RaceSession)
            {
                switch (raceFormatTypeId)
                {
                    case RaceFormatTypeId.AllDriversAllLanesNext:
                        for (int heatNumber = 1; heatNumber <= Math.Max(entity.RaceEventUsers.Count, entity.RaceIndicators.Count); heatNumber++)
                        {
                            heat = new HeatEntity
                            {
                                Number = heatNumber,
                                SessionTypeId = Razmanager.Protobuf.Public.V1.SessionTypeId.Race,
                            };

                            entity.Heats.Add(heat);
                        }

                        foreach (var raceEventUser in entity.RaceEventUsers.Select((x, index) => new { Item = x, Index = index }))
                        {
                            foreach (var raceIndicator in entity.RaceIndicators.Select((x, index) => new { Item = x, Index = index }))
                            {
                                var heatNumber = (raceEventUser.Index / entity.RaceIndicators.Count) + (raceIndicator.Index - raceEventUser.Index + entity.RaceIndicators.Count) % entity.RaceIndicators.Count + 1;

                                Console.WriteLine($"raceEventUser.Index={raceEventUser.Index}  raceIndicator.Index={raceIndicator.Index}  heatNumber={heatNumber}");

                                heat = entity.Heats.SingleOrDefault(x => x.Number == heatNumber);
                                heat!.HeatIndicators.Add(new HeatIndicatorEntity
                                {
                                    IndicatorId = raceIndicator.Item.IndicatorId,
                                    EventUserId = raceEventUser.Item.EventUserId,
                                    CarId = entity.HeatCarTypeId == Razmanager.Protobuf.Internal.Repository.CrudServices.HeatCarType.HeatCarTypeId.Indicator ?
                                                raceIndicator.Item.CarId :
                                                entity.HeatCarTypeId == Razmanager.Protobuf.Internal.Repository.CrudServices.HeatCarType.HeatCarTypeId.Driver ?
                                                    raceEventUser.Item.CarId :
                                                    null
                                });
                            }
                        }

                        break;

                    case RaceFormatTypeId.AllDriversAllLanesSpread:
                        break;

                    case RaceFormatTypeId.AllDriversAllLanesAllDrivers:
                        break;

                    case RaceFormatTypeId.AllDriversUniqueController:
                        heat = new HeatEntity
                        {
                            Number = 1,
                            SessionTypeId = Razmanager.Protobuf.Public.V1.SessionTypeId.Race
                        };

                        foreach (var raceIndicatorEventUser in entity.RaceIndicatorEventUsers)
                        {
                            var heatIndicatorStint = new HeatIndicatorStintEntity { Lap = 1 };

                            //var heatIndicatorEventUserEventUsers = RepositoryDbContext.EventUsers
                            //    .Include(x => x.EventUsers)
                            //    .SingleOrDefault(x => x.Id == raceIndicatorEventUser.EventUserId);

                            //if (heatIndicatorEventUserEventUsers is not null && heatIndicatorEventUserEventUsers.EventUsers.Count >= 2)
                            //{
                            //    var teamEventUser = heatIndicatorEventUserEventUsers.EventUsers[new Random().Next(heatIndicatorEventUserEventUsers.EventUsers.Count)];
                            //    if (teamEventUser is not null)
                            //    {
                            //        heatIndicatorStint.EventUserId = teamEventUser.Id;
                            //    }
                            //}

                            heat.HeatIndicators.Add(new HeatIndicatorEntity
                            {
                                IndicatorId = raceIndicatorEventUser.IndicatorId,
                                EventUserId = raceIndicatorEventUser.EventUserId,
                                CarClassColor = raceIndicatorEventUser.CarClassColor,
                                CarId = raceIndicatorEventUser.CarId,
                                HeatIndicatorStints = { heatIndicatorStint }
                            });
                        }

                        entity.Heats.Add(heat);

                        break;

                    case RaceFormatTypeId.StepUp:
                        break;

                    default:
                        break;
                }
            }
        }


        protected override async Task CreateBeforeAsync(RaceEntity entity)
        {
            var race = await RepositoryDbContext.Races
                .Where(x => x.EventId == entity.EventId && x.Event.TenantId == HttpContextOptions.TenantId)
                .OrderByDescending(x => x.Number)
                .FirstOrDefaultAsync();
            entity.Number = race?.Number + 1 ?? 1;
        }


        public async IAsyncEnumerable<RaceList> ListAsync(int limit, int offset)
        {
            var query = RepositoryDbContext.Races
                .Include(x => x.Event)
                .Include(x => x.TrackConfiguration).ThenInclude(x => x.Track)
                .Where(x => x.Event.TenantId == HttpContextOptions.TenantId)
                .OrderBy(x => x.Event.TimeToLiveAt)
                .ThenBy(x => x.Number);

            var response = ListAsync(limit, offset, query);

            await foreach (var entity in response)
            {
                yield return Mapper.Map<RaceList>(entity);
            }
        }


        public async IAsyncEnumerable<RaceSelect> SelectAsync(Guid eventId)
        {
            var response = RepositoryDbContext.Races
                .Where(x => x.Event.TenantId == HttpContextOptions.TenantId && x.EventId == eventId)
                .OrderBy(x => x.Number)
                .AsAsyncEnumerable()
                .ConfigureAwait(false);

            await foreach (var entity in response)
            {
                yield return Mapper.Map<RaceSelect>(entity);
            }
        }


        public async Task<CreateResponse> CopyAsync(Guid id)
        {
            (RaceRead readProto, string ETag) = await ReadAsync(id);

            var createProto = Mapper.Map<RaceCreate>(readProto);

            return await this.CreateAsync(createProto);
        }
    }
}
