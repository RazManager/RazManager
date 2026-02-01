using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Internal.Repository.CrudServices.Event;
using Razmanager.Protobuf.Internal.Repository.UserServices.HeatIndicator;
using RazManager.Repository.Stores.Context;
using RazManager.Repository.Stores.Utilities;
using RazManager.Repository.Utilities;
using RazManager.Utilities.Exceptions;
using System;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Repository.UserServices.Entities.HeatIndicator
{
    [Authorize]
    public class HeatIndicatorService : Razmanager.Protobuf.Internal.Repository.UserServices.HeatIndicator.HeatIndicatorService.HeatIndicatorServiceBase
    {
        private readonly Stores.Context.RepositoryDbContext _repositoryDbContext;
        private readonly AutoMapper.IMapper _mapper;
        private readonly IHttpContextOptions _httpContextOptions;


        public HeatIndicatorService(Stores.Context.RepositoryDbContext dbContext,
                                    AutoMapper.IMapper mapper,
                                    IHttpContextOptions httpContextOptions)
        {
            _repositoryDbContext = dbContext;
            _mapper = mapper;
            _httpContextOptions = httpContextOptions;
        }


        public override async Task<HeatIndicatorRead> Read(StringValue request, ServerCallContext context)
        {
            var entity = await _repositoryDbContext.HeatIndicators
                .Include(x => x.EventUser)
                .SingleOrDefaultAsync(x => x.Id == new Guid(request.Value));

            if (entity is null)
            {
                throw new NotFoundException();
            }

            var result = _mapper.Map<HeatIndicatorRead>(entity);

            var drivers = _repositoryDbContext.EventUsers
                .Where(x => x.EventUserId == entity.EventUserId)
                .Include(x => x.User).ThenInclude(x => x.UserImages.Where(x => x.ImageSize == Stores.Utilities.ImageSize.Avatar))
                .Include(x => x.Autopilot).ThenInclude(x => x.AutopilotImages.Where(x => x.ImageSize == Stores.Utilities.ImageSize.Avatar))
                .AsAsyncEnumerable();

            await foreach (var driver in drivers)
            {
                var proto = _mapper.Map<EventUserSelect>(driver);
                result.EventUsers.Add(proto);
            }

            return result;
        }
    }
}
