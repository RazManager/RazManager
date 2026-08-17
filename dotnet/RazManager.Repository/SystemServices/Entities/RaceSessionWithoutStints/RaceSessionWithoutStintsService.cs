using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Internal.Repository.SystemServices.RaceSessionWithoutStints;
using RazManager.Utilities.Exceptions;
using System;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Repository.SystemServices.Entities.RaceSessionWithoutStints
{
    public class RaceSessionWithoutStintsService : Razmanager.Protobuf.Internal.Repository.SystemServices.RaceSessionWithoutStints.RaceSessionWithoutStintsService.RaceSessionWithoutStintsServiceBase
    {
        private readonly Stores.Context.RepositoryDbContext _repositoryDbContext;
        private readonly AutoMapper.IMapper _mapper;


        public RaceSessionWithoutStintsService(Stores.Context.RepositoryDbContext dbContext,
                                               AutoMapper.IMapper mapper)
        {
            _repositoryDbContext = dbContext;
            _mapper = mapper;
        }


        public override async Task<Razmanager.Protobuf.Public.V1.RaceSessionWithoutStints> Read(StringValue request, ServerCallContext context)
        {
            var entity = await _repositoryDbContext.RaceSessionsWithoutStints
                .Include(x => x.HeatWithoutStints.OrderBy(x => x.Number)).ThenInclude(x => x.HeatIndicators.OrderBy(x => x.IndicatorId))
                .AsSplitQuery()
                .SingleOrDefaultAsync(x => x.Id == new System.Guid(request.Value));
            if (entity is null)
            {
                throw new NotFoundException();
            }

            return _mapper.Map<Razmanager.Protobuf.Public.V1.RaceSessionWithoutStints>(entity);
        }


        public override async Task<Empty> UpdateState(RaceSessionWithoutStintsStateUpdateRequest request, ServerCallContext context)
        {
            var entity = await _repositoryDbContext.RaceSessionsWithoutStints.AsTracking()
                .SingleOrDefaultAsync(x => x.Id == new Guid(request.Id)).ConfigureAwait(false);
            if (entity is null)
            {
                throw new NotFoundException();
            }

            entity.StateTypeId = request.StateTypeId;

            await _repositoryDbContext.SaveChangesAsync().ConfigureAwait(false);

            return new Empty();
        }
    }
}