namespace RazManager.Silo.Grains.Entities.Device
{
    public class DeviceGrain : Grain, IDeviceGrain
    {
        private readonly Razmanager.Protobuf.Internal.Repository.SystemServices.Device.DeviceService.DeviceServiceClient _serviceClient;
        //private IAsyncStream<DeviceDeviceInformationMessage>? _deviceDeviceInformationStream;
        //private IAsyncStream<DeviceConnectionStatusMessage>? _deviceConnectionStatusStream;


        public DeviceGrain(Razmanager.Protobuf.Internal.Repository.SystemServices.Device.DeviceService.DeviceServiceClient serviceClient)
        {
            _serviceClient = serviceClient;
        }


        //public override Task OnActivateAsync(CancellationToken cancellationToken)
        //{
        //    var streamProvider = this.GetStreamProvider(Constants.StreamProvider);
        //    _deviceDeviceInformationStream = streamProvider.GetStream<DeviceDeviceInformationMessage>(Constants.StreamName.DeviceDeviceInformation.ToString());
        //    _deviceConnectionStatusStream = streamProvider.GetStream<DeviceConnectionStatusMessage>(Constants.StreamName.DeviceConnectionStatus.ToString());

        //    return Task.CompletedTask;
        //}


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


        //public async Task DeviceInformationAsync(DeviceInformationMessage deviceInformation)
        //{
        //    foreach (var deviceConfiguration in deviceInformation.DeviceConfigurations)
        //    {
        //        await GrainFactory.GetGrain<DeviceConfiguration.IDeviceConfigurationGrain>(deviceConfiguration.Id).RefreshAsync();
        //    }

        //    await _deviceDeviceInformationStream!.OnNextAsync(new DeviceDeviceInformationMessage { DeviceId = this.GetPrimaryKey(), DeviceInformation = deviceInformation });
        //}


        //public async Task ConnectedAsync()
        //{
        //    await _serviceClient.ConnectedAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });
        //    await ConnectionStatusChangeAsync(true);
        //}


        //public async Task DisconnectedAsync()
        //{
        //    await _serviceClient.DisconnectedAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });
        //    await ConnectionStatusChangeAsync(false);
        //}


        //private Task ConnectionStatusChangeAsync(bool connected)
        //{
        //    return _deviceConnectionStatusStream!.OnNextAsync(new DeviceConnectionStatusMessage { DeviceId = this.GetPrimaryKey(), Connected = connected });
        //}
    }
}
