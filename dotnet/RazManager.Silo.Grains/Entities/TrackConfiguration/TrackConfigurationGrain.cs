using Orleans.Streams;
using Razmanager.Protobuf.Internal.Repository.Silo.SystemServices.TrackConfiguration;
using Razmanager.Protobuf.Public.V1;


namespace RazManager.Silo.Grains.Entities.TrackConfiguration
{
    public class TrackConfigurationGrain : Grain, ITrackConfigurationGrain
    {
        private readonly Razmanager.Protobuf.Internal.Repository.SystemServices.TrackConfiguration.TrackConfigurationService.TrackConfigurationServiceClient _serviceClient;
        private IEnumerable<Guid> _deviceConfigurationIds = [];
        private IAsyncStream<TrackConfigurationDeviceConfigurationInputs>? _trackConfigurationdeviceConfigurationInputsStream;


        public TrackConfigurationGrain(Razmanager.Protobuf.Internal.Repository.SystemServices.TrackConfiguration.TrackConfigurationService.TrackConfigurationServiceClient serviceClient)
        {
            _serviceClient = serviceClient;
        }


        public override async Task OnActivateAsync(CancellationToken cancellationToken)
        {
            var streamProvider = this.GetStreamProvider(Constants.StreamProvider);
            _trackConfigurationdeviceConfigurationInputsStream = streamProvider.GetStream<TrackConfigurationDeviceConfigurationInputs>(Constants.StreamName.TrackConfigurationDeviceConfigurationInputs.ToString(), this.GetPrimaryKey());

            await RefreshAsync();
        }


        public async Task RefreshAsync()
        {
            var proto = await _serviceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });
            _deviceConfigurationIds = proto.DeviceConfigurationIds.Select(x => new Guid(x));
        }


        public async Task DeviceConfigurationInputsAsync(Guid deviceConfigurationId, DeviceConfigurationInputs deviceConfigurationInputs, bool simulated)
        {
            if (!_deviceConfigurationIds.Any(x => x.Equals(deviceConfigurationId)))
            {
                // This track configuration is no longer connected to the message's deviceConfigurationId, so it should no longer send messages to this track configuration.
                await GrainFactory.GetGrain<DeviceConfiguration.IDeviceConfigurationGrain>(deviceConfigurationId).RefreshAsync();
                return;
            }

            _ = _trackConfigurationdeviceConfigurationInputsStream!.OnNextAsync(new TrackConfigurationDeviceConfigurationInputs
            {
                TrackConfigurationId = this.GetPrimaryKey().ToString(),
                DeviceConfigurationInputs = deviceConfigurationInputs,
                Simulated = simulated
            });

            foreach (var deviceConfigurationInput in deviceConfigurationInputs.Items)
            {
                //Console.WriteLine($"*******************{this.GetType().Name} DeviceConfigurationInputAsync, DeviceConfigurationInputTypeId={deviceConfigurationInput.DeviceConfigurationInputTypeId}, DeviceConfigurationInputId={deviceConfigurationInput.DeviceConfigurationInputId}");

                if (deviceConfigurationInput.DeviceConfigurationInputTypeId == DeviceConfigurationInputTypeId.StartFinishIndicator)
                {
                    foreach (var trackConfigurationDeviceConfigurationId in _deviceConfigurationIds)
                    {
                        var deviceConfigurationOutputs = new DeviceConfigurationOutputs();
                        deviceConfigurationOutputs.Items.Add(new DeviceConfigurationOutput
                        {
                            DeviceConfigurationId = trackConfigurationDeviceConfigurationId.ToString(),
                            CorrelationId = deviceConfigurationInput.CorrelationId,
                            DeviceConfigurationOutputTypeId = DeviceConfigurationOutputTypeId.StartFinishIndicator,
                            DeviceConfigurationOutputId = deviceConfigurationInput.DeviceConfigurationInputId
                        });
                        _ = GrainFactory.GetGrain<DeviceConfiguration.IDeviceConfigurationGrain>(trackConfigurationDeviceConfigurationId).DeviceConfigurationOutputsAsync(deviceConfigurationOutputs);
                    }
                }
            }
        }


        public Task DeviceConfigurationOutputsAsync(DeviceConfigurationOutputs deviceConfigurationOutputs)
        {
            foreach (var deviceConfigurationOutput in deviceConfigurationOutputs.Items)
            {
                Console.WriteLine($"*******************{this.GetType().Name} DeviceConfigurationOutputAsync, DeviceConfigurationOutputTypeId={deviceConfigurationOutput.DeviceConfigurationOutputTypeId}, DeviceConfigurationOutputId={deviceConfigurationOutput.DeviceConfigurationOutputId}");
            }

            foreach (var deviceConfigurationId in _deviceConfigurationIds)
            {
                foreach (var deviceConfigurationOutput in deviceConfigurationOutputs.Items)
                {
                    deviceConfigurationOutput.DeviceConfigurationId = deviceConfigurationId.ToString();
                }
                _ = GrainFactory.GetGrain<DeviceConfiguration.IDeviceConfigurationGrain>(deviceConfigurationId).DeviceConfigurationOutputsAsync(deviceConfigurationOutputs);
            }
            return Task.CompletedTask;
        }


        //public Task HeatOutputAsync(Heat.HeatOutputMessage heatOutput)
        //{
        //    foreach (var deviceConfigurationId in _deviceConfigurationIds)
        //    {
        //        _ = GrainFactory.GetGrain<DeviceConfiguration.IDeviceConfigurationGrain>(deviceConfigurationId).HeatOutputAsync(heatOutput);
        //    }
        //    return Task.CompletedTask;
        //}
    }
}
