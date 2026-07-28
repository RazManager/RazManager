using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Internal.Repository.SystemServices.RaceSession;
using RazManager.Utilities.Exceptions;
using System;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Repository.SystemServices.Entities.RaceSession
{
    public class RaceSessionService : Razmanager.Protobuf.Internal.Repository.SystemServices.RaceSession.RaceSessionService.RaceSessionServiceBase
    {
        private readonly Stores.Context.RepositoryDbContext _repositoryDbContext;
        private readonly AutoMapper.IMapper _mapper;


        public RaceSessionService(Stores.Context.RepositoryDbContext dbContext,
                           AutoMapper.IMapper mapper)
        {
            _repositoryDbContext = dbContext;
            _mapper = mapper;
        }


        public override async Task<Razmanager.Protobuf.Public.V1.RaceSession> Read(StringValue request, ServerCallContext context)
        {
            var entity = await _repositoryDbContext.RaceSessions
                .Include(x => x.HeatWithoutStints.OrderBy(x => x.Number)).ThenInclude(x => x.HeatIndicators.OrderBy(x => x.IndicatorId))
                .Include(x => x.HeatWithStints.OrderBy(x => x.Number))
                .AsSplitQuery()
                .SingleOrDefaultAsync(x => x.Id == new System.Guid(request.Value));
            if (entity is null)
            {
                throw new NotFoundException();
            }

            return _mapper.Map<Razmanager.Protobuf.Public.V1.RaceSession>(entity);
        }


        public override async Task<Empty> UpdateState(RaceSessionStateUpdateRequest request, ServerCallContext context)
        {
            var entity = await _repositoryDbContext.RaceSessions.AsTracking()
                .SingleOrDefaultAsync(x => x.Id == new Guid(request.Id)).ConfigureAwait(false);
            if (entity is null)
            {
                throw new NotFoundException();
            }

            entity.RaceSessionStateTypeId = request.RaceSessionStateTypeId;

            await _repositoryDbContext.SaveChangesAsync().ConfigureAwait(false);

            return new Empty();
        }
    }
}