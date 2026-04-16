using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Microsoft.Extensions.Logging;
using Orleans;
using Orleans.Streams;
using Razmanager.Protobuf.Public.V1;
using RazManager.Device.Utilities;
using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;


namespace RazManager.Device.Services.Device
{
    [Authorize]
    public class DeviceService : Razmanager.Protobuf.Public.V1.DeviceService.DeviceServiceBase
    {
        private readonly Razmanager.Protobuf.Internal.Repository.DeviceServices.Device.DeviceService.DeviceServiceClient _serviceClient;
        private readonly IClusterClient _clusterClient;
        private readonly IHttpContextOptions _httpContextOptions;
        private readonly ILogger<DeviceService> _logger;


        public DeviceService(Razmanager.Protobuf.Internal.Repository.DeviceServices.Device.DeviceService.DeviceServiceClient serviceClient,
                             IClusterClient clusterClient,
                             IHttpContextOptions httpContextOptions,
                             ILogger<DeviceService> logger)
        {
            _serviceClient = serviceClient;
            _clusterClient = clusterClient;
            _httpContextOptions = httpContextOptions;
            _logger = logger;
        }


        public override async Task<Empty> DeviceInformation(DeviceInformation request, ServerCallContext context)
        {
            try
            {
                await _serviceClient.DeviceInformationAsync(
                    new Razmanager.Protobuf.Internal.Repository.DeviceServices.Device.DeviceInformationRequest
                    { 
                        Id = _httpContextOptions.DeviceId.ToString(),
                        DeviceInformation = request
                    },
                    null, null, context.CancellationToken);

                foreach (var deviceConfiguration in request.DeviceConfigurations)
                {
                    await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.DeviceConfiguration.IDeviceConfigurationGrain>(new Guid(deviceConfiguration.Id)).RefreshAsync();
                }
                return new Empty();
            }
            catch (Exception exception)
            {
                _logger.LogError(exception, exception.Message);
                throw new RpcException(new Status(StatusCode.Internal, exception.Message));
            }
        }


        public override async Task DeviceResponseRequest(IAsyncStreamReader<DeviceResponse> requestStream, IServerStreamWriter<DeviceRequest> responseStream, ServerCallContext context)
        {
            _ = Task.Run(async () =>
            {
                await foreach (var deviceResponse in requestStream.ReadAllAsync())
                {
                    await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.Device.IDeviceGrain>(_httpContextOptions.DeviceId).DeviceResponseAsync(deviceResponse);
                }
            }, context.CancellationToken);

            await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.Device.IDeviceGrain>(_httpContextOptions.DeviceId).ConnectedUpdateAsync(true);

            StreamSubscriptionHandle<Razmanager.Protobuf.Public.V1.DeviceRequest>? subscriptionHandle = null;
            try
            {
                var streamProvider = _clusterClient.GetStreamProvider(RazManager.Silo.Grains.Constants.StreamProvider);
                var stream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.DeviceRequest>(RazManager.Silo.Grains.Constants.StreamName.DeviceRequest.ToString(), _httpContextOptions.DeviceId);
                subscriptionHandle = await stream.SubscribeAsync(async sequentialItemList =>
                {
                    await foreach (var sequentialItem in sequentialItemList.ToAsyncEnumerable().WithCancellation(context.CancellationToken))
                    {
                        await responseStream.WriteAsync(sequentialItem.Item);
                    }
                });

                await Task.Delay(Timeout.InfiniteTimeSpan, context.CancellationToken);
            }
            catch (System.Threading.Tasks.TaskCanceledException)
            {
            }
            catch (System.OperationCanceledException)
            {
            }
            finally
            {
                await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.Device.IDeviceGrain>(_httpContextOptions.DeviceId).ConnectedUpdateAsync(false);
                if (subscriptionHandle is not null)
                {
                    await subscriptionHandle.UnsubscribeAsync();
                }
            }
        }
    }
}