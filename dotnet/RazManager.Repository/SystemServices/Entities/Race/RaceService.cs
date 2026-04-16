using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Internal.Repository.SystemServices.Race;
using RazManager.Utilities.Exceptions;
using System;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Repository.SystemServices.Entities.Race
{
    public class RaceService : Razmanager.Protobuf.Internal.Repository.SystemServices.Race.RaceService.RaceServiceBase
    {
        private readonly Stores.Context.RepositoryDbContext _repositoryDbContext;
        private readonly AutoMapper.IMapper _mapper;


        public RaceService(Stores.Context.RepositoryDbContext dbContext,
                           AutoMapper.IMapper mapper)
        {
            _repositoryDbContext = dbContext;
            _mapper = mapper;
        }


        public override async Task<Razmanager.Protobuf.Public.V1.Race> Read(StringValue request, ServerCallContext context)
        {
            var entity = await _repositoryDbContext.Races
                .Include(x => x.RaceIndicators.OrderBy(x => x.IndicatorId))
                .Include(x => x.RaceEventUsers)
                .Include(x => x.TrackConfiguration).ThenInclude(x => x.TrackConfigurationIndicators)
                .Include(x => x.TrackConfiguration).ThenInclude(x => x.TrackConfigurationDeviceConfigurations).ThenInclude(x => x.DeviceConfiguration).ThenInclude(x => x.DeviceConfigurationFeatures)
                .Include(x => x.Heats.OrderBy(x => x.Number)).ThenInclude(x => x.HeatIndicators.OrderBy(x => x.IndicatorId))
                .AsSplitQuery()
                .SingleOrDefaultAsync(x => x.Id == new System.Guid(request.Value));
            if (entity is null)
            {
                throw new NotFoundException();
            }

            var result = _mapper.Map<Razmanager.Protobuf.Public.V1.Race>(entity);

            foreach (var deviceConfigurationFeature in entity.TrackConfiguration.TrackConfigurationDeviceConfigurations.SelectMany(x => x.DeviceConfiguration.DeviceConfigurationFeatures).Distinct())
            {
                switch (deviceConfigurationFeature.DeviceConfigurationFeatureTypeId)
                {
                    //case Razmanager.Protobuf.Public.V1.DeviceConfigurationFeatureTypeId.Undefined:
                    //    break;
                    //case Razmanager.Protobuf.Public.V1.DeviceConfigurationFeatureTypeId.Sector1:
                    //    break;
                    //case Razmanager.Protobuf.Public.V1.DeviceConfigurationFeatureTypeId.Sector2:
                    //    break;
                    //case Razmanager.Protobuf.Public.V1.DeviceConfigurationFeatureTypeId.Sector3:
                    //    break;
                    //case Razmanager.Protobuf.Public.V1.DeviceConfigurationFeatureTypeId.SpeedTrap:
                    //    break;
                    //case Razmanager.Protobuf.Public.V1.DeviceConfigurationFeatureTypeId.Pitlane:
                    //    break;
                    //case Razmanager.Protobuf.Public.V1.DeviceConfigurationFeatureTypeId.Pitstop:
                    //    break;
                    //case Razmanager.Protobuf.Public.V1.DeviceConfigurationFeatureTypeId.Motor:
                    //    break;
                    //case Razmanager.Protobuf.Public.V1.DeviceConfigurationFeatureTypeId.CarOnTrack:
                    //    break;
                    case Razmanager.Protobuf.Public.V1.DeviceConfigurationFeatureTypeId.LaneBasedId:
                        result.RaceFeatures.Add(Razmanager.Protobuf.Public.V1.RaceFeatureTypeId.LaneBasedId);
                        break;

                    case Razmanager.Protobuf.Public.V1.DeviceConfigurationFeatureTypeId.ControllerBasedId:
                        result.RaceFeatures.Add(Razmanager.Protobuf.Public.V1.RaceFeatureTypeId.ControllerBasedId);
                        break;

                    //case Razmanager.Protobuf.Public.V1.DeviceConfigurationFeatureTypeId.ThrottleProfiles:
                    //    break;
                    default:
                        break;
                }
            }

            //result.RaceFeatures.Add(Razmanager.Protobuf.Public.V1.RaceFeatureTypeId.LaneBasedId);


            if (entity.EnergySimulation)
            {
                result.RaceFeatures.Add(Razmanager.Protobuf.Public.V1.RaceFeatureTypeId.Energy);
            }

            return result;
        }


        public override async Task<Empty> UpdateState(RaceStateUpdateRequest request, ServerCallContext context)
        {
            var entity = await _repositoryDbContext.Races.AsTracking()
                .SingleOrDefaultAsync(x => x.Id == new Guid(request.Id)).ConfigureAwait(false);
            if (entity is null)
            {
                throw new NotFoundException();
            }

            entity.RaceStateTypeId = request.RaceStateTypeId;

            await _repositoryDbContext.SaveChangesAsync().ConfigureAwait(false);

            return new Empty();
        }
    }
}