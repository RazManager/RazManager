using Orleans.Streams;
using Razmanager.Protobuf.Public.V1;


namespace RazManager.Silo.Grains.Entities.Device
{
    public class DeviceGrain : Grain, IDeviceGrain
    {
        private readonly Razmanager.Protobuf.Internal.Repository.SystemServices.Device.DeviceService.DeviceServiceClient _serviceClient;
        private IAsyncStream<DeviceRequest>? _deviceRequestStream;
        private IAsyncStream<DeviceResponse>? _deviceResponseStream;
        private bool _connected = false;


        public DeviceGrain(Razmanager.Protobuf.Internal.Repository.SystemServices.Device.DeviceService.DeviceServiceClient serviceClient)
        {
            _serviceClient = serviceClient;
        }


        public override Task OnActivateAsync(CancellationToken cancellationToken)
        {
            var streamProvider = this.GetStreamProvider(Constants.StreamProvider);
            _deviceRequestStream = streamProvider.GetStream<DeviceRequest>(Constants.StreamName.DeviceRequest.ToString(), this.GetPrimaryKey());
            _deviceResponseStream = streamProvider.GetStream<DeviceResponse>(Constants.StreamName.DeviceResponse.ToString(), this.GetPrimaryKey());
            return Task.CompletedTask;
        }


        public async Task RefreshAsync()
        {
            var proto = await _serviceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });

            foreach (var deviceConfigurationId in proto.DeviceConfigurationIds)
            {
                await GrainFactory.GetGrain<DeviceConfiguration.IDeviceConfigurationGrain>(new Guid(deviceConfigurationId)).RefreshAsync();

                if (proto.Simulated)
                {
                    await GrainFactory.GetGrain<DeviceConfigurationSimulation.IDeviceConfigurationSimulationGrain>(new Guid(deviceConfigurationId)).RefreshAsync();
                }
            }
        }


        public Task<bool> ConnectedReadAsync()
        {
            return Task.FromResult(_connected);
        }


        public async Task ConnectedUpdateAsync(bool connected)
        {
            _connected = connected;
            _ = _deviceResponseStream!.OnNextAsync(new DeviceResponse { CorrelationId = Guid.NewGuid().ToString(), DeviceConnectionResponse = new DeviceConnectionResponse { Connected = _connected } });
            if (connected)
            {
                _ = _serviceClient.UpdateAsync(new Razmanager.Protobuf.Internal.Repository.SystemServices.Device.DeviceUpdateRequest
                {
                    Id = this.GetPrimaryKey().ToString(),
                    LastConnectedAt = Google.Protobuf.WellKnownTypes.Timestamp.FromDateTime(DateTime.UtcNow)
                });
            }
        }


        public async Task DeviceRequestAsync(DeviceRequest deviceRequest)
        {
            if (deviceRequest.ValueCase == DeviceRequest.ValueOneofCase.DeviceConnectionRequest)
            {
                _ = _deviceResponseStream!.OnNextAsync(new DeviceResponse { CorrelationId = deviceRequest.CorrelationId, DeviceConnectionResponse = new DeviceConnectionResponse { Connected = _connected }});
            }
            else
            {
                _ = _deviceRequestStream!.OnNextAsync(deviceRequest);
            }
        }


        public async Task DeviceResponseAsync(DeviceResponse deviceResponse)
        {
            await _deviceResponseStream!.OnNextAsync(deviceResponse);
        }
    }
}
