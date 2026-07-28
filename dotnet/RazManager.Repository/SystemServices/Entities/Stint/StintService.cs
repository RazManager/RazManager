using Google.Protobuf;
using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Internal.Repository.SystemServices.HeatStintJournal;
using RazManager.Repository.Stores.Entities.StintJournal;
using RazManager.Repository.Stores.Utilities;
using RazManager.Utilities.Exceptions;
using System;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Repository.SystemServices.Entities.Stint
{
    public class StintService : Razmanager.Protobuf.Internal.Repository.SystemServices.Stint.StintService.StintServiceBase
    {
        private readonly Stores.Context.RepositoryDbContext _repositoryDbContext;
        private readonly AutoMapper.IMapper _mapper;

        public StintService(Stores.Context.RepositoryDbContext dbContext,
                            AutoMapper.IMapper mapper)
        {
            _repositoryDbContext = dbContext;
            _mapper = mapper;
        }


        public override async Task<Razmanager.Protobuf.Public.V1.Stint> Read(StringValue request, ServerCallContext context)
        {
            var entity = await _repositoryDbContext.Stints
                .Include(x => x.HeatWithStint).ThenInclude(x => x.RaceSession).ThenInclude(x => x.Race).ThenInclude(x => x.TrackConfiguration).ThenInclude(x => x.TrackConfigurationIndicators)
                .Include(x => x.StintIndicators.OrderBy(x => x.IndicatorId)).ThenInclude(x => x.Car).ThenInclude(x => x.CarImages.Where(x => x.ImageSize == ImageSize.Avatar))
                .Include(x => x.StintIndicators.OrderBy(x => x.IndicatorId)).ThenInclude(x => x.EventUser.EventUsers)
                .AsSplitQuery()
                .SingleOrDefaultAsync(x => x.Id == new Guid(request.Value));
            if (entity is null)
            {
                throw new NotFoundException();
            }

            return _mapper.Map<Razmanager.Protobuf.Public.V1.Stint>(entity);
        }


        public override async Task<HeatStintJournalListResponse> ListStintJournals(StringValue request, ServerCallContext context)
        {
            var entities = _repositoryDbContext.StintJournals
                .Where(x => x.StintId == new Guid(request.Value))
                .OrderBy(x => x.Timestamp).ThenBy(x => x.SequenceNumber)
                .AsAsyncEnumerable()
                .ConfigureAwait(false);

            var result = new HeatStintJournalListResponse();

            var parser = Razmanager.Protobuf.Internal.Repository.SystemServices.HeatStintJournal.HeatStintJournal.Descriptor.Parser;

            await foreach (var entity in entities)
            {
                result.HeatStintJournals.Add(parser.ParseFrom(entity.Payload) as Razmanager.Protobuf.Internal.Repository.SystemServices.HeatStintJournal.HeatStintJournal);
            }

            return result;
        }


        public override async Task<Empty> CreateStintJournal(HeatStintJournalCreateRequest request, ServerCallContext context)
        {
            _repositoryDbContext.Add(new StintJournalEntity
            {
                StintId = new Guid(request.HeatStintId),
                Timestamp = request.HeatStintJournal.HeatStintJournalState.Timestamp.ToDateTime(),
                SequenceNumber = request.SequenceNumber,
                Payload = request.HeatStintJournal.ToByteArray(),
            });

            await _repositoryDbContext.SaveChangesAsync().ConfigureAwait(false);

            return new Empty();
        }


        public override async Task<Empty> DeleteStintJournals(StringValue request, ServerCallContext context)
        {
            await _repositoryDbContext.StintJournals
                .Where(x => x.StintId == new Guid(request.Value))
                .ExecuteDeleteAsync();

            return new Empty();
        }
    }
}