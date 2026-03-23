using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Internal.Repository.SystemServices.HeatIndicatorStint;
using Razmanager.Protobuf.Public.V1;
using RazManager.Repository.Stores.Entities.HeatIndicatorStint;
using RazManager.Utilities.Exceptions;
using System;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Repository.SystemServices.Entities.HeatIndicatorStint
{
    public class HeatIndicatorStintService : Razmanager.Protobuf.Internal.Repository.SystemServices.HeatIndicatorStint.HeatIndicatorStintService.HeatIndicatorStintServiceBase
    {
        private readonly Stores.Context.RepositoryDbContext _repositoryDbContext;


        public HeatIndicatorStintService(Stores.Context.RepositoryDbContext dbContext)
        {
            _repositoryDbContext = dbContext;
        }


        public override async Task<HeatIndicatorStintReadResponse> Read(StringValue request, ServerCallContext context)
        {
            var entity = await _repositoryDbContext.HeatIndicatorStints
                .Include(x => x.HeatIndicator)
                .SingleOrDefaultAsync(x => x.Id == new Guid(request.Value));
            if (entity is null)
            {
                throw new NotFoundException();
            }

            return new HeatIndicatorStintReadResponse
            {
                HeatId = entity.HeatIndicator.HeatId.ToString(),
                HeatIndicatorId = entity.HeatIndicatorId.ToString()
            };
        }


        public override async Task<Empty> Create(HeatIndicatorStintCreate request, ServerCallContext context)
        {
            var entity = new HeatIndicatorStintEntity
            {
                HeatIndicatorId = new Guid(request.HeatIndicatorId),
                Lap = request.Lap,
            };
            if (!string.IsNullOrEmpty(request.EventUserId))
            {
                entity.EventUserId = new Guid(request.EventUserId);
            }

            //var heatIndicatorEventUserEventUsers = await _repositoryDbContext.HeatIndicators
            //    .Include(x => x.EventUser.EventUsers)
            //    .SingleOrDefaultAsync(x => x.Id == new Guid(request.HeatIndicatorId) && x.EventUser != null);
            //if (heatIndicatorEventUserEventUsers is not null && heatIndicatorEventUserEventUsers.EventUser!.EventUsers.Count >= 2)
            //{
            //    var teamEventUser = heatIndicatorEventUserEventUsers.EventUser.EventUsers[new Random().Next(heatIndicatorEventUserEventUsers.EventUser!.EventUsers.Count)];
            //    if (teamEventUser is not null)
            //    {
            //        entity.EventUserId = teamEventUser.Id;
            //    }
            //}

            _repositoryDbContext.Add(entity);
            try
            {
                await _repositoryDbContext.SaveChangesAsync().ConfigureAwait(false);
            }
            catch (Microsoft.EntityFrameworkCore.DbUpdateException)
            {
            }

            return new Empty();
        }
    }
}