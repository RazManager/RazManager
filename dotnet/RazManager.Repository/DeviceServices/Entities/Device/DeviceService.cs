using AutoMapper;
using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.EntityFrameworkCore;
using Razmanager.Protobuf.Public.V1;
using RazManager.Utilities.Exceptions;
using System;
using System.Linq;
using System.Threading.Tasks;


namespace RazManager.Repository.DeviceServices.Entities.Device
{
    public class DeviceService : Razmanager.Protobuf.Internal.Repository.DeviceServices.Device.DeviceService.DeviceServiceBase
    {
        private readonly Stores.Context.RepositoryDbContext _repositoryDbContext;
        private readonly IMapper _mapper;


        public DeviceService(Stores.Context.RepositoryDbContext dbContext,
                             IMapper mapper)
        {
            _repositoryDbContext = dbContext;
            _mapper = mapper;
        }


        public override async Task<Empty> DeviceInformation(Razmanager.Protobuf.Internal.Repository.DeviceServices.Device.DeviceInformationRequest request, ServerCallContext context)
        {
            var entity = await _repositoryDbContext.Devices.AsTracking()
                .Include(x => x.DeviceConfigurations)
                .Include(x => x.DeviceConfigurations).ThenInclude(x => x.DeviceConfigurationInputs)
                .Include(x => x.DeviceConfigurations).ThenInclude(x => x.DeviceConfigurationOutputs)
                .Include(x => x.DeviceConfigurations).ThenInclude(x => x.DeviceConfigurationFeatures)
                .SingleOrDefaultAsync(x => x.Id == new Guid(request.Id));
            if (entity is null)
            {
                throw new NotFoundException();
            }

            _mapper.Map(request.DeviceInformation, entity);

            //entity.Description = DateTimeOffset.UtcNow.ToString();

            //entity.DeviceProperties.RemoveAll(x => true);
            //entity.DeviceProperties = request.DeviceInformation.DeviceProperties.Select(x => new DevicePropertyEntity
            //{
            //    Label = x.Label,
            //    Value = x.Value
            //}).ToList();

            entity.DeviceConfigurations.RemoveAll(x => !request.DeviceInformation.DeviceConfigurations.Any(p => x.Id == new Guid(p.Id)));
            foreach (var deviceConfigurationProto in request.DeviceInformation.DeviceConfigurations)
            {
                var deviceConfigurationEntity = entity.DeviceConfigurations.SingleOrDefault(x => x.Id == new Guid(deviceConfigurationProto.Id));
                if (deviceConfigurationEntity is null)
                {
                    deviceConfigurationEntity = _mapper.Map<Stores.Entities.DeviceConfiguration.DeviceConfigurationEntity>(deviceConfigurationProto);
                    entity.DeviceConfigurations.Add(deviceConfigurationEntity);
                }
                deviceConfigurationEntity.DeviceConfigurationInputs.RemoveAll(x => true);
                deviceConfigurationEntity.DeviceConfigurationOutputs.RemoveAll(x => true);
                deviceConfigurationEntity.DeviceConfigurationFeatures.RemoveAll(x => true);
                _mapper.Map(deviceConfigurationProto, deviceConfigurationEntity);
            }

            await _repositoryDbContext.SaveChangesAsync().ConfigureAwait(false);

            return new Empty();
        }        
    }
}
