using Razmanager.Protobuf.Public.V1;
using System.Text.RegularExpressions;


namespace RazManager.Silo.Grains.Entities.DeviceConfigurationSimulation
{
    public class DeviceConfigurationSimulationGrain : Grain, IDeviceConfigurationSimulationGrain, IRemindable
    {
        private readonly Razmanager.Protobuf.Internal.Repository.SystemServices.DeviceConfiguration.DeviceConfigurationService.DeviceConfigurationServiceClient _serviceClient;
        private Razmanager.Protobuf.Internal.Repository.SystemServices.DeviceConfiguration.DeviceConfigurationRead? _deviceConfiguration;
        private DateTime? _startedAt;
        private readonly List<DeviceConfigurationInputMetadata> _deviceConfigurationInputMetadataList = [];


        public DeviceConfigurationSimulationGrain(Razmanager.Protobuf.Internal.Repository.SystemServices.DeviceConfiguration.DeviceConfigurationService.DeviceConfigurationServiceClient serviceClient)
        {
            _serviceClient = serviceClient;
        }


        public override async Task OnActivateAsync(CancellationToken cancellationToken)
        {
            await RefreshAsync();
        }


        public async Task RefreshAsync()
        {
            _deviceConfiguration = await _serviceClient.ReadAsync(new Google.Protobuf.WellKnownTypes.StringValue { Value = this.GetPrimaryKey().ToString() });
            _startedAt = DateTime.UtcNow;
        }


        public Task<bool> ReadAsync()
        {
            return Task.FromResult(_startedAt.HasValue);
        }


        public async Task StartAsync()
        {
            _startedAt = DateTime.UtcNow;

            foreach (var deviceConfigurationInput in _deviceConfiguration!.DeviceConfiguration.DeviceConfigurationInputs.Where(x => x.DeviceConfigurationInputTypeId == DeviceConfigurationInputTypeId.StartFinishIndicator))
            {
                await ReceiveReminderAsync($"{deviceConfigurationInput.DeviceConfigurationInputTypeId}:{deviceConfigurationInput.DeviceConfigurationInputId}");
            }
            foreach (var deviceConfigurationInput in _deviceConfiguration!.DeviceConfiguration.DeviceConfigurationInputs.Where(x => x.DeviceConfigurationInputTypeId == DeviceConfigurationInputTypeId.Energy))
            {
                await ReceiveReminderAsync($"{deviceConfigurationInput.DeviceConfigurationInputTypeId}:{deviceConfigurationInput.DeviceConfigurationInputId}");
            }
        }


        Task IRemindable.ReceiveReminder(string reminderName, TickStatus status)
        {
            return ReceiveReminderAsync(reminderName);
        }


        private async Task ReceiveReminderAsync(string reminderName)
        {
            var regex = new Regex(@"^([\d\w]+):([\d\w]+)$");
            var match = regex.Match(reminderName);
            if (!match.Success || match.Groups.Count != 3)
            {
                throw new ArgumentException($"Cannot extract DeviceConfigurationInputTypeId and DeviceConfigurationInputId from reminderName: {reminderName}");
            }

            var deviceConfigurationInputTypeId = Enum.Parse<DeviceConfigurationInputTypeId>(match.Groups.Values.SingleOrDefault(x => x.Name == "1")!.Value);
            var deviceConfigurationInputId = Convert.ToUInt32(match.Groups.Values.SingleOrDefault(x => x.Name == "2")!.Value);

            var now = DateTime.UtcNow;

            if (_startedAt.HasValue && _startedAt.Value.AddDays(2) > now)
            {
                var deviceConfigurationInputs = new DeviceConfigurationInputs();
                deviceConfigurationInputs.Items.Add(new DeviceConfigurationInput
                {
                    DeviceConfigurationId = this.GetPrimaryKey().ToString(),
                    CorrelationId = Guid.NewGuid().ToString(),
                    Timestamp = Google.Protobuf.WellKnownTypes.Timestamp.FromDateTime(now),
                    DeviceConfigurationInputTypeId = deviceConfigurationInputTypeId,
                    DeviceConfigurationInputId = deviceConfigurationInputId,
                    IntValue = Convert.ToUInt32(20 + new Random().Next(5))
                });
                _ = GrainFactory.GetGrain<DeviceConfiguration.IDeviceConfigurationGrain>(this.GetPrimaryKey()).DeviceConfigurationInputsAsync(deviceConfigurationInputs, true);


                var deviceConfigurationInputMetadata = _deviceConfigurationInputMetadataList
                    .SingleOrDefault(x => x.DeviceConfigurationInputTypeId == deviceConfigurationInputTypeId &&
                                          x.DeviceConfigurationInputId == deviceConfigurationInputId);
                if (deviceConfigurationInputMetadata is null)
                {
                    deviceConfigurationInputMetadata = new DeviceConfigurationInputMetadata
                    {
                        DeviceConfigurationInputTypeId = deviceConfigurationInputTypeId,
                        DeviceConfigurationInputId = deviceConfigurationInputId
                    };
                    _deviceConfigurationInputMetadataList.Add(deviceConfigurationInputMetadata);
                }

                switch (deviceConfigurationInputTypeId)
                {
                    case DeviceConfigurationInputTypeId.StartFinishIndicator:
                        await this.RegisterOrUpdateReminder(reminderName, TimeSpan.FromSeconds(9.0 + Math.Sin(deviceConfigurationInputMetadata!.StartFinishIndicatorAngle) * 2.0 + new Random().NextDouble()), TimeSpan.FromMinutes(1));
                        deviceConfigurationInputMetadata!.StartFinishIndicatorAngle += new Random().NextDouble() * 0.2;

                        if (_deviceConfiguration!.DeviceConfiguration.DeviceConfigurationInputs
                            .Any(x => x.DeviceConfigurationInputTypeId == DeviceConfigurationInputTypeId.Sector1FinishIndicator &&
                                      x.DeviceConfigurationInputId.HasValue && x.DeviceConfigurationInputId.Value == deviceConfigurationInputId))
                        {
                            await this.RegisterOrUpdateReminder($"{DeviceConfigurationInputTypeId.Sector1FinishIndicator}:{deviceConfigurationInputId}", TimeSpan.FromSeconds(3.0 + (new Random().NextDouble()) * 2.0), TimeSpan.FromMinutes(1));
                        }
                        break;

                    case DeviceConfigurationInputTypeId.Sector1FinishIndicator:
                        break;

                    case DeviceConfigurationInputTypeId.Sector2FinishIndicator:
                        break;

                    case DeviceConfigurationInputTypeId.Energy:
                        await this.RegisterOrUpdateReminder(reminderName, TimeSpan.FromSeconds(5.0 + (new Random().NextDouble())), TimeSpan.FromMinutes(1));
                        break;

                    default:
                        break;
                }
            }
            else
            {
                var reminder = await this.GetReminder(reminderName);
                if (reminder is not null)
                {
                    await this.UnregisterReminder(reminder);
                }
            }
        }


        public Task StopAsync()
        {
            _startedAt = null;
            return Task.CompletedTask;
        }


        private class DeviceConfigurationInputMetadata
        {
            public required DeviceConfigurationInputTypeId DeviceConfigurationInputTypeId { get; set; }
            public required uint DeviceConfigurationInputId { get; set; }
            public double StartFinishIndicatorAngle { get; set; } = new Random().NextDouble() * 2 * Math.PI;
        }
    }
}
