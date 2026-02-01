using Orleans.Streams;
using Razmanager.Protobuf.Public.V1;


namespace RazManager.Silo.Grains.Entities.DeviceConfiguration
{
    public class DeviceConfigurationGrain : Grain, IDeviceConfigurationGrain
    {
        private readonly Razmanager.Protobuf.Internal.Repository.SystemServices.DeviceConfiguration.DeviceConfigurationService.DeviceConfigurationServiceClient _serviceClient;
        private Razmanager.Protobuf.Internal.Repository.SystemServices.DeviceConfiguration.DeviceConfigurationRead? _deviceConfiguration;
        //private Queue<Guid> _correlationIds = new();
        //private IAsyncStream<DeviceDeviceConfigurationOutputs>? _deviceDeviceConfigurationOutputStream;
        //private IAsyncStream<Heat.HeatOutputMessage>? _deviceHeatOutputStream;
        private IAsyncStream<DeviceConfigurationInputs>? _deviceConfigurationInputsStream;
        private IAsyncStream<DeviceConfigurationOutputs>? _deviceConfigurationsOutputsStream;
        //private IAsyncStream<DeviceConfigurationDeviceConfigurationInput>? _allDeviceConfigurationDeviceConfigurationInputStream;
        //private IAsyncStream<DeviceConfigurationDeviceConfigurationOutput>? _allDeviceConfigurationDeviceConfigurationOutputStream;


        public DeviceConfigurationGrain(Razmanager.Protobuf.Internal.Repository.SystemServices.DeviceConfiguration.DeviceConfigurationService.DeviceConfigurationServiceClient serviceClient)
        {
            _serviceClient = serviceClient;
        }


        public override Task OnActivateAsync(CancellationToken cancellationToken)
        {
            Console.WriteLine($"{this.GetType()} OnActivateAsync");

            var streamProvider = this.GetStreamProvider(Constants.StreamProvider);
            //_deviceDeviceConfigurationOutputStream = streamProvider.GetStream<DeviceConfigurationOutput>(Constants.StreamName.DeviceDeviceConfigurationOutput.ToString(), new Guid(_deviceConfiguration.DeviceId));
            //_deviceHeatOutputStream = streamProvider.GetStream<Heat.HeatOutputMessage>(Constants.StreamName.DeviceHeatOutput.ToString(), new Guid(_deviceConfigurationRead.DeviceId));
            _deviceConfigurationInputsStream = streamProvider.GetStream<DeviceConfigurationInputs>(Constants.StreamName.DeviceConfigurationInputs.ToString(), this.GetPrimaryKey());
            _deviceConfigurationsOutputsStream = streamProvider.GetStream<DeviceConfigurationOutputs>(Constants.StreamName.DeviceConfigurationOutputs.ToString(), this.GetPrimaryKey());
            //_allDeviceConfigurationDeviceConfigurationInputStream = streamProvider.GetStream<DeviceConfigurationDeviceConfigurationInput>(Constants.StreamName.AllDeviceConfigurationDeviceConfigurationInput.ToString());
            //_allDeviceConfigurationDeviceConfigurationOutputStream = streamProvider.GetStream<DeviceConfigurationDeviceConfigurationOutput>(Constants.StreamName.AllDeviceConfigurationDeviceConfigurationOutput.ToString());

            return RefreshAsync();
        }


        public async Task RefreshAsync()
        {
            Console.WriteLine($"{this.GetType()} RefreshAsync");
            _deviceConfiguration = await _serviceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });
        }


        public Task DeviceConfigurationInputsAsync(DeviceConfigurationInputs deviceConfigurationInputs, bool simulated)
        {
            //if (!string.IsNullOrEmpty(deviceConfigurationInput.CorrelationId))
            //{
            //    if (_correlationIds.Contains(new Guid(deviceConfigurationInput.CorrelationId)))
            //    {
            //        return Task.CompletedTask;
            //    }
            //    _correlationIds.Enqueue(new Guid(deviceConfigurationInput.CorrelationId));
            //    while (_correlationIds.Count > 100)
            //    {
            //        _correlationIds.Dequeue();
            //    }
            //}

            foreach (var trackConfigurationId in _deviceConfiguration!.TrackConfigurationIds)
            {
                _ = GrainFactory.GetGrain<TrackConfiguration.ITrackConfigurationGrain>(new Guid(trackConfigurationId)).DeviceConfigurationInputsAsync(this.GetPrimaryKey(), deviceConfigurationInputs, simulated);
            }

            //foreach (var deviceConfigurationInput in deviceConfigurationInputs.Items)
            //{
            //    Console.WriteLine($"*******************{this.GetType().Name} DeviceConfigurationInputsAsync. DeviceConfigurationInputTypeId={deviceConfigurationInput.DeviceConfigurationInputTypeId}, DeviceConfigurationInputId={deviceConfigurationInput.DeviceConfigurationInputId}");
            //}
            _ = _deviceConfigurationInputsStream!.OnNextAsync(deviceConfigurationInputs);

            //_ = _allDeviceConfigurationDeviceConfigurationInputStream!.OnNextAsync(new DeviceConfigurationDeviceConfigurationInput
            //{
            //    DeviceId = _deviceConfigurationRead.DeviceId,
            //    DeviceConfigurationInput = deviceConfigurationInput
            //});

            return Task.CompletedTask;
        }


        public Task DeviceConfigurationOutputsAsync(DeviceConfigurationOutputs deviceConfigurationOutputs)
        {
            var deviceConfigurationOutputsFiltered = new DeviceConfigurationOutputs();

            foreach (var deviceConfigurationOutput in deviceConfigurationOutputs.Items)
            {
                if (_deviceConfiguration!.DeviceConfiguration.DeviceConfigurationOutputs.Any(x => x.DeviceConfigurationOutputTypeId == deviceConfigurationOutput.DeviceConfigurationOutputTypeId &&
                                         ((!x.DeviceConfigurationOutputId.HasValue && !deviceConfigurationOutput.DeviceConfigurationOutputId.HasValue) ||
                                          (x.DeviceConfigurationOutputId.HasValue && deviceConfigurationOutput.DeviceConfigurationOutputId.HasValue &&
                                           x.DeviceConfigurationOutputId.Value == deviceConfigurationOutput.DeviceConfigurationOutputId.Value))))
                {
                    Console.WriteLine($"*******************{this.GetType().Name} DeviceConfigurationOutputAsync. DeviceConfigurationOutputTypeId={deviceConfigurationOutput.DeviceConfigurationOutputTypeId}, DeviceConfigurationOutputId={deviceConfigurationOutput.DeviceConfigurationOutputId}");
                    deviceConfigurationOutputsFiltered.Items.Add(deviceConfigurationOutput);
                }
            }

            if (deviceConfigurationOutputsFiltered.Items.Any())
            {
                //_ = _deviceDeviceConfigurationOutputStream!.OnNextAsync(deviceConfigurationOutput);
                _ = _deviceConfigurationsOutputsStream!.OnNextAsync(deviceConfigurationOutputsFiltered);
                //_ = _allDeviceConfigurationDeviceConfigurationOutputStream!.OnNextAsync(new DeviceConfigurationDeviceConfigurationOutput
                //{
                //    DeviceId = _deviceConfigurationRead.DeviceId,
                //    DeviceConfigurationOutput = deviceConfigurationOutput
                //});
            }

            return Task.CompletedTask;
        }


        //public Task HeatOutputAsync(Heat.HeatOutputMessage heatOutput)
        //{
        //    Console.WriteLine($"*******************{this.GetType().Name} HeatOutputAsync.");
        //    if (_deviceConfigurationRead.DeviceConfiguration.DeviceConfigurationFeatures.Any(x => x == DeviceConfigurationFeatureTypeId.HeatOutput))
        //    {
        //        _ = _deviceHeatOutputStream!.OnNextAsync(heatOutput);
        //    }
        //    return Task.CompletedTask;
        //}
    }
}
