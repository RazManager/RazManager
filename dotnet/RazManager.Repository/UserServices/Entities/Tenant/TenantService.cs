using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Internal.Repository.UserServices.Tenant;
using RazManager.Repository.Stores.Utilities;
using RazManager.Repository.Utilities;
using RazManager.Utilities.Exceptions;
using System;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Repository.UserServices.Entities.Tenant
{
    [Authorize]
    public class TenantService : Razmanager.Protobuf.Internal.Repository.UserServices.Tenant.TenantService.TenantServiceBase
    {
        private readonly Stores.Context.RepositoryDbContext _repositoryDbContext;
        private readonly IHttpContextOptions _httpContextOptions;
        private readonly AutoMapper.IMapper _mapper;


        public TenantService(Stores.Context.RepositoryDbContext dbContext,
                             IHttpContextOptions httpContextOptions,
                             AutoMapper.IMapper mapper)
        {
            _repositoryDbContext = dbContext;
            _httpContextOptions = httpContextOptions;
            _mapper = mapper;
        }


        public override async Task<TenantRead> Read(Empty request, ServerCallContext context)
        {
            var now = DateTimeOffset.UtcNow;
            var entity = await _repositoryDbContext.Tenants
                .SingleOrDefaultAsync(x => x.Id == _httpContextOptions.TenantId);

            if (entity is null)
            {
                throw new NotFoundException();
            }

            return _mapper.Map<TenantRead>(entity);
        }


        public override async Task<TenantSelectResponse> Select(Empty request, ServerCallContext context)
        {
            var result = new TenantSelectResponse();

            var response = _repositoryDbContext.Tenants
                .Include(x => x.TenantImages.Where(x => x.ImageSize == ImageSize.Avatar))
                .Where(x => x.TenantUsers.Any(x => x.UserId == _httpContextOptions.UserId && x.Administrator))
                .OrderBy(x => x.Name)
                .AsAsyncEnumerable()
                .ConfigureAwait(false);

            await foreach (var entity in response)
            {
                result.Result.Add(_mapper.Map<TenantSelect>(entity));
            }

            return result;
        }
    }
}
