using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Options;
using Orleans;
using Orleans.Configuration;
using Orleans.Runtime;
using Orleans.Storage;
using RazManager.Silo.Repository.Stores.Entities.Reminder;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Silo.Repository.Services
{
    public class ReminderTableRepository : IReminderTable
    {
        private readonly IServiceScopeFactory _serviceScopeFactory;
        private readonly IOptions<ClusterOptions> _clusterOptions;


        public ReminderTableRepository(IServiceScopeFactory serviceScopeFactory,
                                       IOptions<ClusterOptions> clusterOptions)
        {
            _serviceScopeFactory = serviceScopeFactory;
            _clusterOptions = clusterOptions;
        }


        public Task Init()
        {
            return Task.CompletedTask;
        }


        public async Task<ReminderEntry> ReadRow(GrainId grainId, string reminderName)
        {
            using (var scope = _serviceScopeFactory.CreateScope())
            {
                var dbContext = scope.ServiceProvider.GetRequiredService<Stores.Context.SiloDbContext>();

                var entity = await dbContext.Reminders
                    .SingleOrDefaultAsync(x => x.ClusterId == _clusterOptions.Value.ClusterId &&
                                               x.GrainId == grainId.ToString() &&
                                               x.ReminderName == reminderName)
                    .ConfigureAwait(false);
                if (entity is null)
                {
                    throw new InconsistentStateException();
                }

                return new ReminderEntry
                {
                    GrainId = grainId,
                    ReminderName = entity.ReminderName,
                    StartAt = entity.StartAt,
                    Period = entity.Period,
                    ETag = entity.ETag.ToString(),
                };
            }
        }


        public Task<ReminderTableData> ReadRows(GrainId grainId)
        {
            throw new System.NotImplementedException();
        }


        public async Task<ReminderTableData> ReadRows(uint begin, uint end)
        {
            using (var scope = _serviceScopeFactory.CreateScope())
            {
                var dbContext = scope.ServiceProvider.GetRequiredService<Stores.Context.SiloDbContext>();

                var entities = await dbContext.Reminders
                    .Where(x => x.ClusterId == _clusterOptions.Value.ClusterId)
                    .ToListAsync()
                    .ConfigureAwait(false);
                return new ReminderTableData(entities.Select(x => new ReminderEntry
                {
                    GrainId = GrainId.Parse(x.GrainId),
                    ReminderName = x.ReminderName,
                    StartAt = x.StartAt,
                    Period = x.Period,
                    ETag = x.ETag.ToString(),
                }));
            }
        }


        public async Task<string> UpsertRow(ReminderEntry entry)
        {
            using (var scope = _serviceScopeFactory.CreateScope())
            {
                var dbContext = scope.ServiceProvider.GetRequiredService<Stores.Context.SiloDbContext>();

                var entity = await dbContext.Reminders.AsTracking()
                    .SingleOrDefaultAsync(x => x.ClusterId == _clusterOptions.Value.ClusterId &&
                                               x.GrainId == entry.GrainId.ToString() &&
                                               x.ReminderName == entry.ReminderName)
                    .ConfigureAwait(false);
                if (entity is null)
                {
                    entity = new ReminderEntity
                    {
                        ClusterId = _clusterOptions.Value.ClusterId,
                        GrainId = entry.GrainId.ToString(),
                        ReminderName = entry.ReminderName
                    };
                    dbContext.Reminders.Add(entity);
                }
                else if (!string.IsNullOrEmpty(entry.ETag) && entry.ETag != entity.ETag.ToString())
                {
                    throw new InconsistentStateException();
                }

                entity.StartAt = entry.StartAt;
                entity.Period = entry.Period;

                await dbContext.SaveChangesAsync();

                return entity.ETag.ToString();
            }
        }


        public async Task<bool> RemoveRow(GrainId grainId, string reminderName, string eTag)
        {
            using (var scope = _serviceScopeFactory.CreateScope())
            {
                var dbContext = scope.ServiceProvider.GetRequiredService<Stores.Context.SiloDbContext>();

                var entity = await dbContext.Reminders
                    .SingleOrDefaultAsync(x => x.ClusterId == _clusterOptions.Value.ClusterId &&
                                               x.GrainId == grainId.ToString() &&
                                               x.ReminderName == reminderName)
                    .ConfigureAwait(false);
                if (entity is null)
                {
                    throw new InconsistentStateException();
                }
                else if (!string.IsNullOrEmpty(eTag) && eTag != entity.ETag.ToString())
                {
                    throw new InconsistentStateException();
                }

                dbContext.Reminders.Remove(entity);

                await dbContext.SaveChangesAsync();
            }

            return true;
        }


        public Task TestOnlyClearTable()
        {
            throw new System.NotImplementedException();
        }
    }
}
