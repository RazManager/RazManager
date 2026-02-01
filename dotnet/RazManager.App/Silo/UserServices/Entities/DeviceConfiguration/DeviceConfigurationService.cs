using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Microsoft.Extensions.Logging;
using Orleans;
using Polly;
using Razmanager.Protobuf.Internal.Silo.UserServices.DeviceConfiguration;
using System;
using System.Threading;
using System.Threading.Tasks;
using Orleans.Streams;
using Razmanager.Protobuf.Public.V1;


namespace RazManager.App.Silo.UserServices.Entities.DeviceConfiguration
{

    [Authorize(Policy = "TenantAdministrator")]
    public class DeviceConfigurationService : Razmanager.Protobuf.Internal.Silo.UserServices.DeviceConfiguration.DeviceConfigurationService.DeviceConfigurationServiceBase
    {
        private readonly IClusterClient _clusterClient;
        private readonly ILogger<DeviceConfigurationService> _logger;

        public DeviceConfigurationService(Orleans.IClusterClient clusterClient,
                                          ILogger<DeviceConfigurationService> logger)
        {
            _clusterClient = clusterClient;
            _logger = logger;
        }


        public override async Task<Empty> DeviceConfigurationInput(DeviceConfigurationDeviceConfigurationInput request, ServerCallContext context)
        {
            // TODO: Validate permissions
            var deviceConfigurationInputs = new DeviceConfigurationInputs();
            deviceConfigurationInputs.Items.Add(request.DeviceConfigurationInput);
            await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.DeviceConfiguration.IDeviceConfigurationGrain>(new Guid(request.Id)).DeviceConfigurationInputsAsync(deviceConfigurationInputs, true);
            return new Empty();
        }


        public override async Task DeviceConfigurationInputsSubscribe(StringValue request, IServerStreamWriter<Razmanager.Protobuf.Public.V1.DeviceConfigurationInputs> responseStream, ServerCallContext context)
        {
            // TODO: Validate permissions

            var now = DateTimeOffset.UtcNow;
            StreamSubscriptionHandle<Razmanager.Protobuf.Public.V1.DeviceConfigurationInputs>? subscriptionHandle = null;
            try
            {
                Console.WriteLine($"DeviceConfigurationInputsSubscribe Deadline: {context.Deadline}");

                var streamProvider = _clusterClient.GetStreamProvider(RazManager.Silo.Grains.Constants.StreamProvider);

                var stream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.DeviceConfigurationInputs>(RazManager.Silo.Grains.Constants.StreamName.DeviceConfigurationInputs.ToString(), new Guid(request.Value));
                await Policy
                    .Handle<Exception>()
                    .WaitAndRetryForeverAsync(_ => TimeSpan.FromMinutes(1))
                    .ExecuteAsync(async cancellationToken =>
                    {
                        subscriptionHandle = await stream.SubscribeAsync(async sequentialItemList =>
                        {
                            foreach (var sequentialItem in sequentialItemList)
                            {
                                foreach(var item in sequentialItem.Item.Items)
                                {
                                    Console.WriteLine($"*******************{this.GetType().Name} DeviceConfigurationInputsAsync. DeviceConfigurationInputTypeId={item.DeviceConfigurationInputTypeId}, DeviceConfigurationInputId={item.DeviceConfigurationInputId} {item.CorrelationId}");
                                }
                                await responseStream.WriteAsync(sequentialItem.Item);
                            }
                        });
                    }, context.CancellationToken);

                await Task.Delay(Timeout.Infinite, context.CancellationToken);
            }
            catch (System.Threading.Tasks.TaskCanceledException)
            {
            }
            catch (System.OperationCanceledException)
            {
            }
            finally
            {
                if (subscriptionHandle is not null)
                {
                    await subscriptionHandle.UnsubscribeAsync();
                }
                Console.WriteLine($"DeviceConfigurationInputsSubscribe Closed after {(DateTimeOffset.UtcNow - now).TotalSeconds}s.");
            }
        }


        public override async Task DeviceConfigurationOutputsSubscribe(StringValue request, IServerStreamWriter<DeviceConfigurationOutputs> responseStream, ServerCallContext context)
        {
            // TODO: Validate permissions

            var now = DateTimeOffset.UtcNow;
            StreamSubscriptionHandle<Razmanager.Protobuf.Public.V1.DeviceConfigurationOutputs>? subscriptionHandle = null;
            try
            {
                Console.WriteLine($"DeviceConfigurationOutputsSubscribe Deadline: {context.Deadline}");

                var streamProvider = _clusterClient.GetStreamProvider(RazManager.Silo.Grains.Constants.StreamProvider);

                var stream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.DeviceConfigurationOutputs>(RazManager.Silo.Grains.Constants.StreamName.DeviceConfigurationOutputs.ToString(), new Guid(request.Value));
                await Policy
                    .Handle<Exception>()
                    .WaitAndRetryForeverAsync(_ => TimeSpan.FromMinutes(1))
                    .ExecuteAsync(async cancellationToken =>
                    {
                        subscriptionHandle = await stream.SubscribeAsync(async sequentialItemList =>
                        {
                            foreach (var sequentialItem in sequentialItemList)
                            {
                                foreach (var item in sequentialItem.Item.Items)
                                {
                                    Console.WriteLine($"*******************{this.GetType().Name} DeviceConfigurationOutputsAsync. DeviceConfigurationOutputTypeId={item.DeviceConfigurationOutputTypeId}, DeviceConfigurationOutputId={item.DeviceConfigurationOutputId} {item.CorrelationId}");
                                }
                                await responseStream.WriteAsync(sequentialItem.Item);
                            }
                        });
                    }, context.CancellationToken);

                await Task.Delay(Timeout.Infinite, context.CancellationToken);
            }
            catch (System.Threading.Tasks.TaskCanceledException)
            {
            }
            catch (System.OperationCanceledException)
            {
            }
            finally
            {
                if (subscriptionHandle is not null)
                {
                    await subscriptionHandle.UnsubscribeAsync();
                }
                Console.WriteLine($"DeviceConfigurationOutputsSubscribe Closed after {(DateTimeOffset.UtcNow - now).TotalSeconds}s.");
            }
        }


        public override async Task<BoolValue> DeviceConfigurationSimulationGet(StringValue request, ServerCallContext context)
        {
            // TODO: Validate permissions
            var response = await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.DeviceConfigurationSimulation.IDeviceConfigurationSimulationGrain>(new Guid(request.Value)).ReadAsync();
            return new BoolValue { Value = response };
        }


        public override async Task<Empty> DeviceConfigurationSimulationSet(DeviceConfigurationSetSimulationSetRequest request, ServerCallContext context)
        {
            // TODO: Validate permissions
            var grain = _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.DeviceConfigurationSimulation.IDeviceConfigurationSimulationGrain>(new Guid(request.Id));
            if (request.Value)
            {
                await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.DeviceConfigurationSimulation.IDeviceConfigurationSimulationGrain>(new Guid(request.Id)).StartAsync();
            }
            else
            {
                await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.DeviceConfigurationSimulation.IDeviceConfigurationSimulationGrain>(new Guid(request.Id)).StopAsync();
            }

            return new Empty();
        }
    }
}
