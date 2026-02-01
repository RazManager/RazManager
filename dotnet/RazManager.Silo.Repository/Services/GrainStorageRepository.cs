using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Orleans;
using Orleans.Configuration;
using Orleans.Runtime;
using Orleans.Serialization;
using Orleans.Storage;
using RazManager.Silo.Repository.Stores.Entities.GrainStorage;
using RazManager.Silo.Repository.Stores.Entities.Membership;
using RazManager.Silo.Repository.Stores.Entities.MembershipVersion;
using System;
using System.Text.Json;
using System.Threading.Tasks;

namespace RazManager.Silo.Repository.Services
{
    public class GrainStorageRepository : IGrainStorage
    {
        private readonly IServiceScopeFactory _serviceScopeFactory;
        private readonly Serializer _serializer;
        private readonly IOptions<ClusterOptions> _clusterOptions;


        public GrainStorageRepository(IServiceScopeFactory serviceScopeFactory,
                                      Orleans.Serialization.Serializer serializer,
                                      IOptions<ClusterOptions> clusterOptions)
        {
            _serviceScopeFactory = serviceScopeFactory;
            _serializer = serializer;
            _clusterOptions = clusterOptions;
        }


        public async Task ReadStateAsync<T>(string stateName, GrainId grainId, IGrainState<T> grainState)
        {
            using (var scope = _serviceScopeFactory.CreateScope())
            {
                var dbContext = scope.ServiceProvider.GetRequiredService<Stores.Context.SiloDbContext>();

                var entity = await dbContext.GrainStorage
                    .SingleOrDefaultAsync(x => x.ClusterId == _clusterOptions.Value.ClusterId &&
                                               x.StateName == stateName &&
                                               x.GrainId == grainId.ToString())                  
                    .ConfigureAwait(false);

                if (entity is not null)
                {
                    grainState.State = _serializer.Deserialize<T>(entity.State);
                    grainState.ETag = entity.ETag.ToString();
                    grainState.RecordExists = true;
                }
            }
        }


        public async Task WriteStateAsync<T>(string stateName, GrainId grainId, IGrainState<T> grainState)
        {
            using (var scope = _serviceScopeFactory.CreateScope())
            {
                var dbContext = scope.ServiceProvider.GetRequiredService<Stores.Context.SiloDbContext>();

                var entity = await dbContext.GrainStorage.AsTracking()
                    .SingleOrDefaultAsync(x => x.ClusterId == _clusterOptions.Value.ClusterId &&
                                               x.StateName == stateName &&
                                               x.GrainId == grainId.ToString())
                    .ConfigureAwait(false);
                if (entity is null)
                {
                    entity = new GrainStorageEntity
                    {
                        ClusterId = _clusterOptions.Value.ClusterId,
                        StateName = stateName,
                        GrainId = grainId.ToString(),
                    };
                    dbContext.GrainStorage.Add(entity);
                }
                else if (!string.IsNullOrEmpty(grainState.ETag) && grainState.ETag != entity.ETag.ToString())
                {
                    throw new InconsistentStateException();
                }

                entity.State = _serializer.SerializeToArray<T>(grainState.State);
                entity.TimeToLiveAt = DateTime.UtcNow.AddYears(1);

                await dbContext.SaveChangesAsync();

                grainState.ETag = entity.ETag.ToString();
                grainState.RecordExists = true;
            }
        }


        public async Task ClearStateAsync<T>(string stateName, GrainId grainId, IGrainState<T> grainState)
        {
            using (var scope = _serviceScopeFactory.CreateScope())
            {
                var dbContext = scope.ServiceProvider.GetRequiredService<Stores.Context.SiloDbContext>();

                var entity = await dbContext.GrainStorage.AsTracking()
                    .SingleOrDefaultAsync(x => x.ClusterId == _clusterOptions.Value.ClusterId &&
                                               x.StateName == stateName &&
                                               x.GrainId == grainId.ToString())
                    .ConfigureAwait(false);

                if (entity is null)
                {
                    throw new InconsistentStateException();
                }
                else if (!string.IsNullOrEmpty(grainState.ETag) && grainState.ETag != entity.ETag.ToString())
                {
                    throw new InconsistentStateException();
                }

                dbContext.GrainStorage.Remove(entity);

                await dbContext.SaveChangesAsync();

                grainState.RecordExists = false;
            }
        }
    }
}
