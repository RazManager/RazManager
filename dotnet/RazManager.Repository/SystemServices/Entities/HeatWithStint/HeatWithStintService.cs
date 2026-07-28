using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Internal.Repository.SystemServices.HeatWithStint;
using RazManager.Utilities.Exceptions;
using System;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Repository.SystemServices.Entities.HeatWithStint
{
    public class HeatWithStintService : Razmanager.Protobuf.Internal.Repository.SystemServices.HeatWithStint.HeatWithStintService.HeatWithStintServiceBase
    {
        private readonly Stores.Context.RepositoryDbContext _repositoryDbContext;
        private readonly AutoMapper.IMapper _mapper;


        public HeatWithStintService(Stores.Context.RepositoryDbContext dbContext,
                                    AutoMapper.IMapper mapper)
        {
            _repositoryDbContext = dbContext;
            _mapper = mapper;
        }


        public override async Task<Razmanager.Protobuf.Public.V1.HeatWithStint> Read(StringValue request, ServerCallContext context)
        {
            var entity = await _repositoryDbContext.HeatWithStints
                .Include(x => x.Stints.OrderBy(x => x.Number))
                .AsSplitQuery()
                .SingleOrDefaultAsync(x => x.Id == new System.Guid(request.Value));
            if (entity is null)
            {
                throw new NotFoundException();
            }

            return _mapper.Map<Razmanager.Protobuf.Public.V1.HeatWithStint>(entity);
        }


        public override async Task<Empty> UpdateState(HeatWithStintStateUpdateRequest request, ServerCallContext context)
        {
            var entity = await _repositoryDbContext.HeatWithStints.AsTracking()
                .SingleOrDefaultAsync(x => x.Id == new Guid(request.Id)).ConfigureAwait(false);
            if (entity is null)
            {
                throw new NotFoundException();
            }

            entity.HeatWithStintStateTypeId = request.HeatWithStintStateTypeId;

            await _repositoryDbContext.SaveChangesAsync().ConfigureAwait(false);

            return new Empty();
        }
    }
}