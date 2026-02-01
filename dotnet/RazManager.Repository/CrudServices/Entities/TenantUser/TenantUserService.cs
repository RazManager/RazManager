using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Internal.Repository.CrudServices.TenantUser;
using RazManager.Repository.Stores.Utilities;
using RazManager.Repository.Utilities;
using System;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Repository.CrudServices.Entities.TenantUser
{
    [Authorize]
    public class TenantUserService : Razmanager.Protobuf.Internal.Repository.CrudServices.TenantUser.TenantUserService.TenantUserServiceBase
    {
        private readonly Stores.Context.RepositoryDbContext _repositoryDbContext;
        private readonly IHttpContextOptions _httpContextOptions;
        private readonly AutoMapper.IMapper _mapper;


        public TenantUserService(Stores.Context.RepositoryDbContext dbContext,
                                 IHttpContextOptions httpContextOptions,
                                 AutoMapper.IMapper mapper)
        {
            _repositoryDbContext = dbContext;
            _httpContextOptions = httpContextOptions;
            _mapper = mapper;
        }


        public override async Task<TenantUserSelectResponse> Select(TenantUserSelectRequest request, ServerCallContext context)
        {
            var result = new TenantUserSelectResponse();

            var now = DateTimeOffset.UtcNow;
            var response = _repositoryDbContext.TenantUsers
                .Include(x => x.User).ThenInclude(x => x.UserImages.Where(x => x.ImageSize == ImageSize.Avatar))
                .Where(x => x.TenantId == _httpContextOptions.TenantId &&  (x.UserId.HasValue && !request.UserIdsExclude.Contains(x.UserId.ToString()) || !x.UserId.HasValue && !request.ShortNamesExclude.Contains(x.ShortName)))
                .OrderByDescending(x => x.Administrator).ThenBy(x => x.User.Name).ThenBy(x => x.Name)
                .AsAsyncEnumerable()
                .ConfigureAwait(false);

            await foreach (var entity in response)
            {
                var proto = _mapper.Map<TenantUserSelect>(entity);
                result.Result.Add(proto);
            }

            return result;
        }
    }
}
