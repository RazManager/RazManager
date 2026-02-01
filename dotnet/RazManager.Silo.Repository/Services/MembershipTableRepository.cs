using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Options;
using Orleans;
using Orleans.Configuration;
using Orleans.Runtime;
using RazManager.Silo.Repository.Stores.Entities.Membership;
using RazManager.Silo.Repository.Stores.Entities.MembershipSuspectTime;
using RazManager.Silo.Repository.Stores.Entities.MembershipVersion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Silo.Repository.Services
{
    public class MembershipTableRepository : IMembershipTable
    {
        private readonly IServiceScopeFactory _serviceScopeFactory;
        private readonly IOptions<ClusterOptions> _clusterOptions;


        public MembershipTableRepository(IServiceScopeFactory serviceScopeFactory,
                                         IOptions<ClusterOptions> clusterOptions)
        {
            _serviceScopeFactory = serviceScopeFactory;
            _clusterOptions = clusterOptions;
        }


        public Task InitializeMembershipTable(bool tryInitTableVersion)
        {
            if (tryInitTableVersion)
            {
            }
            return Task.CompletedTask;
        }


        public async Task<MembershipTableData> ReadAll()
        {
            using (var scope = _serviceScopeFactory.CreateScope())
            {
                var dbContext = scope.ServiceProvider.GetRequiredService<Stores.Context.SiloDbContext>();
                var membershipVersionEntity = await dbContext.MembershipVersions
                    .Include(x => x.Memberships)
                    .SingleOrDefaultAsync(x => x.ClusterId == _clusterOptions.Value.ClusterId).ConfigureAwait(false);

                if (membershipVersionEntity is null)
                {
                    return new MembershipTableData(new TableVersion(0, string.Empty));
                }

                var membershipEntries = new List<Tuple<MembershipEntry, string>>();
                foreach (var membershipEntity in membershipVersionEntity.Memberships)
                {
                    var entry = new MembershipEntry
                    {
                        SiloAddress = SiloAddress.FromParsableString(membershipEntity.SiloAddress),
                        Status = membershipEntity.Status,
                        SuspectTimes = membershipEntity.MembershipSuspectTimes.Select(x => new Tuple<SiloAddress, DateTime>(SiloAddress.FromParsableString(x.SiloAddress), x.SuspectTime)).ToList(),
                        ProxyPort = membershipEntity.ProxyPort,
                        HostName = membershipEntity.HostName,
                        SiloName = membershipEntity.SiloName,
                        //RoleName = membershipEntity.RoleName,
                        //UpdateZone = membershipEntity.UpdateZone,
                        //FaultZone = membershipEntity.FaultZone,
                        StartTime = membershipEntity.StartTime,
                        IAmAliveTime = membershipEntity.IAmAliveTime
                    };

                    membershipEntries.Add(new Tuple<MembershipEntry, string>(entry, membershipEntity.ETag.ToString()));
                }

                return new MembershipTableData(membershipEntries, new TableVersion(membershipVersionEntity.Version, membershipVersionEntity.ETag.ToString()));
            }
        }


        public Task<MembershipTableData> ReadRow(SiloAddress key)
        {
            throw new NotImplementedException();
        }


        public async Task<bool> InsertRow(MembershipEntry entry, TableVersion tableVersion)
        {
            using (var scope = _serviceScopeFactory.CreateScope())
            {
                var dbContext = scope.ServiceProvider.GetRequiredService<Stores.Context.SiloDbContext>();

                var membershipVersionEntity = await dbContext.MembershipVersions.AsTracking()
                    .SingleOrDefaultAsync(x => x.ClusterId == _clusterOptions.Value.ClusterId).ConfigureAwait(false);

                if (membershipVersionEntity is null)
                {
                    membershipVersionEntity = new MembershipVersionEntity();
                    membershipVersionEntity.ClusterId = _clusterOptions.Value.ClusterId;
                    membershipVersionEntity.Version = tableVersion.Version;
                    dbContext.MembershipVersions.Add(membershipVersionEntity);
                }
                else
                {
                    membershipVersionEntity.Version = tableVersion.Version;
                }

                membershipVersionEntity.Memberships.Add(new MembershipEntity
                {
                    SiloAddress = entry.SiloAddress.ToParsableString(),
                    Status = entry.Status,
                    MembershipSuspectTimes = entry.SuspectTimes.Select(x => new MembershipSuspectTimeEntity { SiloAddress = x.Item1.ToParsableString(), SuspectTime = x.Item2 }).ToList(),
                    ProxyPort = entry.ProxyPort,
                    HostName = entry.HostName,
                    SiloName = entry.SiloName,
                    //RoleName = entry.RoleName,
                    //UpdateZone = entry.UpdateZone,
                    //FaultZone = entry.FaultZone,
                    StartTime = entry.StartTime,
                    IAmAliveTime = entry.IAmAliveTime
                });

                await dbContext.SaveChangesAsync();

                return true;
            }
        }


        public async Task<bool> UpdateRow(MembershipEntry entry, string etag, TableVersion tableVersion)
        {
            using (var scope = _serviceScopeFactory.CreateScope())
            {
                var dbContext = scope.ServiceProvider.GetRequiredService<Stores.Context.SiloDbContext>();

                var membershipVersionEntity = await dbContext.MembershipVersions.AsTracking()
                    .Include(x => x.Memberships.Where(x => x.SiloAddress == entry.SiloAddress.ToParsableString())).ThenInclude(x => x.MembershipSuspectTimes)
                    .SingleOrDefaultAsync(x => x.ClusterId == _clusterOptions.Value.ClusterId).ConfigureAwait(false);

                if (membershipVersionEntity is null)
                {
                    throw new NotImplementedException();
                    return false;
                }

                if (!string.IsNullOrEmpty(tableVersion.VersionEtag) && tableVersion.VersionEtag != membershipVersionEntity.ETag.ToString())
                {
                    throw new NotImplementedException();
                    return false;
                }

                var membershipEntity = membershipVersionEntity.Memberships.FirstOrDefault();

                if (membershipEntity is null)
                {
                    throw new NotImplementedException();
                    return false;
                }

                if (!string.IsNullOrEmpty(etag) && etag != membershipEntity.ETag.ToString())
                {
                    throw new NotImplementedException();
                    return false;
                }

                membershipVersionEntity.Version = tableVersion.Version;

                //membershipEntity.SiloAddress = entry.SiloAddress.ToParsableString();
                membershipEntity.Status = entry.Status;
                membershipEntity.ProxyPort = entry.ProxyPort;
                membershipEntity.HostName = entry.HostName;
                membershipEntity.SiloName = entry.SiloName;
                //membershipEntity.RoleName = entry.RoleName;
                //membershipEntity.UpdateZone = entry.UpdateZone;
                //membershipEntity.FaultZone = entry.FaultZone;
                membershipEntity.StartTime = entry.StartTime;
                membershipEntity.IAmAliveTime = entry.IAmAliveTime;

                foreach (var suspectTime in entry.SuspectTimes)
                {
                    var membershipSuspectTimeEntity = membershipEntity.MembershipSuspectTimes.SingleOrDefault(x => x.SiloAddress == suspectTime.Item1.ToParsableString());
                    if (membershipSuspectTimeEntity is null)
                    {
                        membershipEntity.MembershipSuspectTimes.Add(new MembershipSuspectTimeEntity
                        {
                            SiloAddress = suspectTime.Item1.ToParsableString(),
                            SuspectTime = suspectTime.Item2
                        });
                    }
                    else
                    {
                        membershipSuspectTimeEntity.SuspectTime = suspectTime.Item2;
                    }
                }

                await dbContext.SaveChangesAsync();

                return true;
            }
        }


        public async Task UpdateIAmAlive(MembershipEntry entry)
        {
            using (var scope = _serviceScopeFactory.CreateScope())
            {
                var dbContext = scope.ServiceProvider.GetRequiredService<Stores.Context.SiloDbContext>();

                var membershipVersionEntity = await dbContext.MembershipVersions.AsTracking()
                    .Include(x => x.Memberships.Where(x => x.SiloAddress == entry.SiloAddress.ToParsableString()))
                    .SingleOrDefaultAsync(x => x.ClusterId == _clusterOptions.Value.ClusterId).ConfigureAwait(false);

                if (membershipVersionEntity is null)
                {
                    throw new NotImplementedException();
                }

                var membershipEntity = membershipVersionEntity.Memberships.FirstOrDefault();

                if (membershipEntity is null)
                {
                    throw new NotImplementedException();
                }

                membershipEntity.IAmAliveTime = entry.IAmAliveTime;

                await dbContext.SaveChangesAsync();
            }
        }


        public async Task CleanupDefunctSiloEntries(DateTimeOffset beforeDate)
        {
            using (var scope = _serviceScopeFactory.CreateScope())
            {
                var dbContext = scope.ServiceProvider.GetRequiredService<Stores.Context.SiloDbContext>();

                var membershipEntities = await dbContext.Memberships.AsTracking()
                    .Where(x => x.MembershipVersion.ClusterId == _clusterOptions.Value.ClusterId && 
                                x.IAmAliveTime < beforeDate.UtcDateTime &&
                                x.Status != SiloStatus.Active)
                    .ToListAsync()
                    .ConfigureAwait(false);

                foreach (var membershipEntity in membershipEntities)
                {
                    dbContext.Memberships.Remove(membershipEntity);
                }
                await dbContext.SaveChangesAsync();
            }
        }


        public Task DeleteMembershipTableEntries(string clusterId)
        {
            throw new NotImplementedException();

            //using (var scope = _serviceScopeFactory.CreateScope())
            //{
            //    var dbContext = scope.ServiceProvider.GetRequiredService<Context.EventClusterDbContext>();

            //    var membershipVersionEntity = await dbContext.MembershipVersions.AsTracking()
            //        .SingleOrDefaultAsync(x => x.DeploymentId == clusterId).ConfigureAwait(false);

            //    if (membershipVersionEntity is not null)
            //    {
            //        dbContext.MembershipVersions.Remove(membershipVersionEntity);
            //        await dbContext.SaveChangesAsync();
            //    }
            //}
        }
    }
}
