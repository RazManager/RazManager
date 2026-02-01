using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Options;
using Orleans.Configuration;
using Orleans.Messaging;
using Orleans.Runtime;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace RazManager.Silo.Repository.Services
{
    public class GatewayListProviderRepository : IGatewayListProvider
    {
        private readonly IServiceScopeFactory _serviceScopeFactory;
        private readonly IOptions<ClusterOptions> _clusterOptions;
        private readonly IOptions<GatewayOptions> _gatewayOptions;


        public GatewayListProviderRepository(IServiceScopeFactory serviceScopeFactory,
                                             IOptions<ClusterOptions> clusterOptions,
                                             IOptions<GatewayOptions> gatewayOptions)
        {
            _serviceScopeFactory = serviceScopeFactory;
            _clusterOptions = clusterOptions;
            _gatewayOptions = gatewayOptions;
        }


        public Task InitializeGatewayListProvider()
        {
            return Task.CompletedTask;
        }


        public TimeSpan MaxStaleness => _gatewayOptions.Value.GatewayListRefreshPeriod;


        public bool IsUpdatable => true;


        public async Task<IList<Uri>> GetGateways()
        {
            using (var scope = _serviceScopeFactory.CreateScope())
            {
                var dbContext = scope.ServiceProvider.GetRequiredService<Stores.Context.SiloDbContext>();
                var entities = await dbContext.Memberships
                    .Where(x => x.MembershipVersion.ClusterId == _clusterOptions.Value.ClusterId && x.Status == SiloStatus.Active)
                    .ToListAsync().ConfigureAwait(false);
                return entities.Select(x =>
                {
                    //return SiloAddress.FromParsableString(x.SiloAddress).ToGatewayUri();
                    var siloAddress = SiloAddress.FromParsableString(x.SiloAddress);
                    return SiloAddress.New(new System.Net.IPEndPoint(siloAddress.Endpoint.Address, x.ProxyPort), siloAddress.Generation).ToGatewayUri();
                }).ToList();
            }
        }
    }
}
