using Grpc.Core;
using Microsoft.AspNetCore.Authorization;
using Orleans;
using Orleans.Streams;
using Razmanager.Protobuf.Public.V1;
using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;


namespace RazManager.App.PublicServices.Entities.Device
{
    [Authorize]
    public class DeviceService : Razmanager.Protobuf.Public.V1.DeviceService.DeviceServiceBase
    {
        private readonly IClusterClient _clusterClient;
     

        public DeviceService(Orleans.IClusterClient clusterClient)
        {
            _clusterClient = clusterClient;
        }


        public override async Task DeviceRequestResponse(IAsyncStreamReader<DeviceRequest> requestStream, IServerStreamWriter<DeviceResponse> responseStream, ServerCallContext context)
        {
            using CancellationTokenSource responseTaskCts = new();
            Task? responseTask = null;

            try
            {
                await foreach (var deviceRequest in requestStream.ReadAllAsync(context.CancellationToken))
                {
                    if (responseTask is null)
                    {
                        responseTask = Task.Run(async () =>
                        {
                            StreamSubscriptionHandle<DeviceResponse>? subscriptionHandle = null;
                            try
                            {
                                var streamProvider = _clusterClient.GetStreamProvider(RazManager.Silo.Grains.Constants.StreamProvider);
                                var stream = streamProvider.GetStream<DeviceResponse>(RazManager.Silo.Grains.Constants.StreamName.DeviceResponse.ToString(), new Guid(deviceRequest.Id));
                                subscriptionHandle = await stream.SubscribeAsync(async sequentialItemList =>
                                {
                                    await foreach (var sequentialItem in sequentialItemList.ToAsyncEnumerable().WithCancellation(responseTaskCts.Token))
                                    {
                                        await responseStream.WriteAsync(sequentialItem.Item);
                                    }
                                });

                                await Task.Delay(Timeout.InfiniteTimeSpan, responseTaskCts.Token);
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
                            }
                        }, responseTaskCts.Token);
                    }
                    await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.Device.IDeviceGrain>(new Guid(deviceRequest.Id)).DeviceRequestAsync(deviceRequest);
                }
            }
            catch (System.Threading.Tasks.TaskCanceledException)
            {
            }
            catch (System.OperationCanceledException)
            {
            }
            catch (System.IO.IOException)
            {
            }
            finally
            {
                responseTaskCts.Cancel();
            }
        }
    }
}
