using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Internal.Repository.SystemServices.Tenant;
using System;
using System.Threading.Tasks;


namespace RazManager.Repository.SystemServices.Entities.Tenant
{
    public class TenantService : Razmanager.Protobuf.Internal.Repository.SystemServices.Tenant.TenantService.TenantServiceBase
    {
        private readonly Stores.Context.RepositoryDbContext _repositoryDbContext;


        public TenantService(Stores.Context.RepositoryDbContext dbContext)
        {
            _repositoryDbContext = dbContext;
        }


        public override async Task<BoolValue> IsAdministrator(TenantIdUserIdRequest request, ServerCallContext context)
        {
            return new BoolValue
            {
                Value = await _repositoryDbContext.TenantUsers
                .AnyAsync(x => x.TenantId == new Guid(request.TenantId) && x.UserId == new Guid(request.UserId) && x.Administrator).ConfigureAwait(false)
            };
        }
    }
}
