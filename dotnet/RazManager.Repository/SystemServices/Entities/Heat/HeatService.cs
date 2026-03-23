using Google.Protobuf;
using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Razmanager.Protobuf.Internal.Repository.SystemServices.Heat;
using Razmanager.Protobuf.Public.V1;
using RazManager.Repository.Stores.Entities.HeatIndicatorStint;
using RazManager.Repository.Stores.Entities.HeatJournal;
using RazManager.Repository.Stores.Utilities;
using RazManager.Utilities.Exceptions;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text.Json;
using System.Threading.Tasks;


namespace RazManager.Repository.SystemServices.Entities.Heat
{
    public class HeatService : Razmanager.Protobuf.Internal.Repository.SystemServices.Heat.HeatService.HeatServiceBase
    {
        private readonly Stores.Context.RepositoryDbContext _repositoryDbContext;
        private readonly AutoMapper.IMapper _mapper;
        private readonly ILogger<HeatService> _logger;

        public HeatService(Stores.Context.RepositoryDbContext dbContext,
                           AutoMapper.IMapper mapper,
                           ILogger<HeatService> logger)
        {
            _repositoryDbContext = dbContext;
            _mapper = mapper;
            _logger = logger;
        }


        public override async Task<Razmanager.Protobuf.Public.V1.Heat> Read(StringValue request, ServerCallContext context)
        {
            var entity = await _repositoryDbContext.Heats
                .Include(x => x.Race).ThenInclude(x => x.TrackConfiguration).ThenInclude(x => x.TrackConfigurationIndicators)
                .Include(x => x.HeatIndicators.OrderBy(x => x.IndicatorId)).ThenInclude(x => x.Car).ThenInclude(x => x.CarImages.Where(x => x.ImageSize == ImageSize.Avatar))
                .Include(x => x.HeatIndicators.OrderBy(x => x.IndicatorId)).ThenInclude(x => x.HeatIndicatorStints.OrderBy(x => x.Lap))
                .Include(x => x.HeatIndicators.OrderBy(x => x.IndicatorId)).ThenInclude(x => x.EventUser.EventUsers)
                .AsSplitQuery()
                .SingleOrDefaultAsync(x => x.Id == new Guid(request.Value));
            if (entity is null)
            {
                throw new NotFoundException();
            }

            var result = _mapper.Map<Razmanager.Protobuf.Public.V1.Heat>(entity);

            if (!string.IsNullOrEmpty(entity.PreconfiguredIndicatorsJson))
            {
                var jsonSerializerOptions = new JsonSerializerOptions
                {
                    PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
                };
                var preconfiguredIndicators = JsonSerializer.Deserialize<List<PreconfiguredIndicator>>(entity.PreconfiguredIndicatorsJson, jsonSerializerOptions);
                if (preconfiguredIndicators is null)
                {
                    _logger.LogWarning("preconfiguredIndicators is null.");
                }
                else
                {
                    foreach (var heatIndicator in entity.HeatIndicators)
                    {
                        var heatIndicatorProto = result.HeatIndicators.SingleOrDefault(x => x.Id == heatIndicator!.Id.ToString());
                        if (heatIndicatorProto is not null)
                        {
                            var preconfiguredIndicator = preconfiguredIndicators
                                .SingleOrDefault(x => x.IndicatorId == heatIndicator.IndicatorId);
                            if (preconfiguredIndicator is null)
                            {
                                _logger.LogWarning($"preconfiguredIndicators is missing a definition for IndicatorId={heatIndicator.IndicatorId}.");
                            }
                            else
                            {
                                foreach (var preconfiguredLapTeamEventUser in preconfiguredIndicator.PreconfiguredLapTeamEventUsers)
                                {
                                    var teamEventUser = heatIndicator?.EventUser?.EventUsers
                                        .SingleOrDefault(x => x.ShortName == preconfiguredLapTeamEventUser.TeamEventUserShortName);
                                    if (teamEventUser is null)
                                    {
                                        _logger.LogWarning($"preconfiguredIndicators and IndicatorId={heatIndicator!.IndicatorId} doesn't have an eventUser with the short name {preconfiguredLapTeamEventUser.TeamEventUserShortName}.");
                                    }
                                    else
                                    {
                                        heatIndicatorProto.PreconfiguredLaps.Add(new HeatStintEventUsersIndicatorLap
                                        {
                                            Lap = preconfiguredLapTeamEventUser.Lap,
                                            EventUserId = teamEventUser.Id.ToString()
                                        });
                                    }
                                }
                            }
                        }
                    }
                }
            }

            return result;
        }


        public override async Task<HeatJournalListResponse> ListHeatJournals(StringValue request, ServerCallContext context)
        {
            var entities = _repositoryDbContext.HeatJournals
                .Where(x => x.HeatId == new Guid(request.Value))
                .OrderBy(x => x.Timestamp).ThenBy(x => x.SequenceNumber)
                .AsAsyncEnumerable()
                .ConfigureAwait(false);

            var result = new HeatJournalListResponse();

            var parser = Razmanager.Protobuf.Internal.Repository.SystemServices.Heat.HeatJournal.Descriptor.Parser;

            await foreach (var entity in entities)
            {
                result.HeatJournals.Add(parser.ParseFrom(entity.Payload) as Razmanager.Protobuf.Internal.Repository.SystemServices.Heat.HeatJournal);
            }

            return result;
        }


        public override async Task<Empty> CreateHeatJournal(HeatJournalCreateRequest request, ServerCallContext context)
        {
            _repositoryDbContext.Add(new HeatJournalEntity
            {
                HeatId = new Guid(request.HeatId),
                Timestamp = request.HeatJournal.HeatJournalState.Timestamp.ToDateTime(),
                SequenceNumber = request.SequenceNumber,
                Payload = request.HeatJournal.ToByteArray(),
            });

            await _repositoryDbContext.SaveChangesAsync().ConfigureAwait(false);

            return new Empty();
        }


        public override async Task<Empty> DeleteHeatJournals(StringValue request, ServerCallContext context)
        {
            await _repositoryDbContext.HeatJournals
                .Where(x => x.HeatId == new Guid(request.Value))
                .ExecuteDeleteAsync();
            return new Empty();
        }


        public override async Task<Empty> DeleteStints(StringValue request, ServerCallContext context)
        {
            var heatIndicatorStints = _repositoryDbContext.HeatIndicatorStints.AsTracking()
                .Where(x => x.HeatIndicator.HeatId == new Guid(request.Value))
                .AsAsyncEnumerable()
                .ConfigureAwait(false);
            await foreach (var heatIndicatorStint in heatIndicatorStints)
            {
                _repositoryDbContext.Remove(heatIndicatorStint);

            }
            await _repositoryDbContext.SaveChangesAsync().ConfigureAwait(false);

            var heatIndicators = _repositoryDbContext.HeatIndicators
                .Where(x => x.HeatId == new Guid(request.Value))
                .Include(x => x.Heat)
                .Include(x => x.EventUser.EventUsers)
                .AsAsyncEnumerable()
                .ConfigureAwait(false);
            await foreach (var heatIndicator in heatIndicators)
            {
                var heatIndicatorStint = new HeatIndicatorStintEntity
                {
                    HeatIndicatorId = heatIndicator.Id,
                    Lap = 1
                };

                if (!string.IsNullOrEmpty(heatIndicator.Heat.PreconfiguredIndicatorsJson))
                {
                    var jsonSerializerOptions = new JsonSerializerOptions
                    {
                        PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
                    };
                    var preconfiguredIndicators = JsonSerializer.Deserialize<List<PreconfiguredIndicator>>(heatIndicator.Heat.PreconfiguredIndicatorsJson, jsonSerializerOptions);
                    if (preconfiguredIndicators is null)
                    {
                        _logger.LogWarning("preconfiguredIndicators is null.");
                        return new Empty();
                    }

                    var preconfiguredIndicator = preconfiguredIndicators
                        .SingleOrDefault(x => x.IndicatorId == heatIndicator.IndicatorId);
                    if (preconfiguredIndicator is null)
                    {
                        _logger.LogWarning($"preconfiguredIndicators is missing a definition for IndicatorId={heatIndicator.IndicatorId}.");
                        return new Empty();
                    }

                    var preconfiguredLapTeamEventUser = preconfiguredIndicator.PreconfiguredLapTeamEventUsers
                        .SingleOrDefault(x => x.Lap == 1);
                    if (preconfiguredLapTeamEventUser is null)
                    {
                        _logger.LogWarning($"preconfiguredIndicators and IndicatorId={heatIndicator.IndicatorId} is missing an EventUser for lap 1.");
                        return new Empty();
                    }

                    var teamEventUser = heatIndicator?.EventUser?.EventUsers
                        .SingleOrDefault(x => x.ShortName == preconfiguredLapTeamEventUser.TeamEventUserShortName);
                    if (teamEventUser is null)
                    {
                        _logger.LogWarning($"preconfiguredIndicators and IndicatorId={heatIndicator.IndicatorId} doesn't have an eventUser with the short name {preconfiguredLapTeamEventUser.TeamEventUserShortName}.");
                        return new Empty();
                    }

                    heatIndicatorStint.EventUserId = teamEventUser.Id;
                }
                //else
                //{
                //    if (heatIndicator.EventUser is not null && heatIndicator.EventUser.EventUsers.Count >= 2)
                //    {
                //        var teamEventUser = heatIndicator.EventUser.EventUsers[new Random().Next(heatIndicator.EventUser!.EventUsers.Count)];
                //        if (teamEventUser is not null)
                //        {
                //            heatIndicatorStint.EventUserId = teamEventUser.Id;
                //        }
                //    }
                //}

                _repositoryDbContext.Add(heatIndicatorStint);
            }
            await _repositoryDbContext.SaveChangesAsync().ConfigureAwait(false);

            return new Empty();
        }
    }

    public class PreconfiguredIndicator
    {
        [Required]
        public int IndicatorId { get; set; }

        public List<PreconfiguredLapTeamEventUser> PreconfiguredLapTeamEventUsers { get; set; } = [];
    }


    public class PreconfiguredLapTeamEventUser
    {
        [Required]
        public uint Lap { get; set; }

        [Required]
        public string TeamEventUserShortName { get; set; } = null!;
    }
}