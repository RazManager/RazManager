using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Internal.Repository.SystemServices.RaceSessionWithStints;
using RazManager.Utilities.Exceptions;
using System;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Repository.SystemServices.Entities.RaceSessionWithStints
{
    public class RaceSessionWithStintsService : Razmanager.Protobuf.Internal.Repository.SystemServices.RaceSessionWithStints.RaceSessionWithStintsService.RaceSessionWithStintsServiceBase
    {
        private readonly Stores.Context.RepositoryDbContext _repositoryDbContext;
        private readonly AutoMapper.IMapper _mapper;


        public RaceSessionWithStintsService(Stores.Context.RepositoryDbContext dbContext,
                                            AutoMapper.IMapper mapper)
        {
            _repositoryDbContext = dbContext;
            _mapper = mapper;
        }


        public override async Task<Razmanager.Protobuf.Public.V1.RaceSessionWithStints> Read(StringValue request, ServerCallContext context)
        {
            var entity = await _repositoryDbContext.RaceSessionsWithStints
                .Include(x => x.HeatWithStints.OrderBy(x => x.Number))
                .AsSplitQuery()
                .SingleOrDefaultAsync(x => x.Id == new System.Guid(request.Value));
            if (entity is null)
            {
                throw new NotFoundException();
            }

            return _mapper.Map<Razmanager.Protobuf.Public.V1.RaceSessionWithStints>(entity);
        }


        public override async Task<Empty> UpdateState(RaceSessionWithStintsStateUpdateRequest request, ServerCallContext context)
        {
            var entity = await _repositoryDbContext.RaceSessionsWithStints.AsTracking()
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