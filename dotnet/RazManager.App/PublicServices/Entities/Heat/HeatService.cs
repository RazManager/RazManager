using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.Extensions.Logging;
using Orleans;
using Orleans.Streams;
using Razmanager.Protobuf.Public.V1;
using System;
using System.Diagnostics;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;


namespace RazManager.App.PublicServices.Entities.Heat
{
    public class HeatService : Razmanager.Protobuf.Public.V1.HeatService.HeatServiceBase
    {
        private readonly Razmanager.Protobuf.Public.V1.HeatService.HeatServiceClient _serviceClient;
        private readonly IClusterClient _clusterClient;
        private readonly ILogger<HeatService> _logger;

        public HeatService(Razmanager.Protobuf.Public.V1.HeatService.HeatServiceClient serviceClient,
                           Orleans.IClusterClient clusterClient,
                           ILogger<HeatService> logger)
        {
            _serviceClient = serviceClient;
            _clusterClient = clusterClient;
            _logger = logger;

        }


        public override async Task Subscribe(StringValue request, IServerStreamWriter<Razmanager.Protobuf.Public.V1.Heat> responseStream, ServerCallContext context)
        {
            // TODO: Validate permissions

            StreamSubscriptionHandle<Razmanager.Protobuf.Public.V1.Heat>? subscriptionHandle = null;
            try
            {
                await SubscribeExisting(new Guid(request.Value), responseStream);

                var streamProvider = _clusterClient.GetStreamProvider(RazManager.Silo.Grains.Constants.StreamProvider);
                var stream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.Heat>(RazManager.Silo.Grains.Constants.StreamName.Heat.ToString(), new Guid(request.Value));
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
                if (subscriptionHandle is not null)
                {
                    await subscriptionHandle.UnsubscribeAsync();
                }
            }
        }

        private async Task SubscribeExisting(Guid id, IServerStreamWriter<Razmanager.Protobuf.Public.V1.Heat> responseStream)
        {
            var proto = await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.Heat.IHeatGrain>(id).ReadAsync();
            await responseStream.WriteAsync(proto);
        }


        public override async Task HeatStateSubscribe(StringValue request, IServerStreamWriter<HeatState> responseStream, ServerCallContext context)
        {
            // TODO: Validate permissions

            StreamSubscriptionHandle<Razmanager.Protobuf.Public.V1.HeatState>? subscriptionHandle = null;
            try
            {
                await HeatStateSubscribeExisting(new Guid(request.Value), responseStream);

                var streamProvider = _clusterClient.GetStreamProvider(RazManager.Silo.Grains.Constants.StreamProvider);
                var stream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.HeatState>(RazManager.Silo.Grains.Constants.StreamName.HeatState.ToString(), new Guid(request.Value));
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
                if (subscriptionHandle is not null)
                {
                    await subscriptionHandle.UnsubscribeAsync();
                }
            }
        }

        private async Task HeatStateSubscribeExisting(Guid id, IServerStreamWriter<HeatState> responseStream)
        {
            var proto = await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.Heat.IHeatGrain>(id).ReadHeatStateAsync();
            await responseStream.WriteAsync(proto);
        }


        public override async Task HeatLeaderboardSubscribe(StringValue request, IServerStreamWriter<HeatLeaderboard> responseStream, ServerCallContext context)
        {
            // TODO: Validate permissions

            StreamSubscriptionHandle<Razmanager.Protobuf.Public.V1.HeatLeaderboard>? subscriptionHandle = null;
            try
            {
                await HeatLeaderboardSubscribeExisting(new Guid(request.Value), responseStream);

                var streamProvider = _clusterClient.GetStreamProvider(RazManager.Silo.Grains.Constants.StreamProvider);
                var stream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.HeatLeaderboard>(RazManager.Silo.Grains.Constants.StreamName.HeatLeaderboard.ToString(), new Guid(request.Value));
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
                if (subscriptionHandle is not null)
                {
                    await subscriptionHandle.UnsubscribeAsync();
                }
            }
        }

        private async Task HeatLeaderboardSubscribeExisting(Guid id, IServerStreamWriter<HeatLeaderboard> responseStream)
        {
            var proto = await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.Heat.IHeatGrain>(id).ReadHeatLeaderboardAsync();
            await responseStream.WriteAsync(proto);
        }


        public override async Task HeatAnalysesSubscribe(StringValue request, IServerStreamWriter<HeatAnalyses> responseStream, ServerCallContext context)
        {
            // TODO: Validate permissions

            StreamSubscriptionHandle<Razmanager.Protobuf.Public.V1.HeatAnalyses>? subscriptionHandle = null;
            try
            {
                await HeatAnalysesSubscribeExisting(new Guid(request.Value), responseStream);

                var streamProvider = _clusterClient.GetStreamProvider(RazManager.Silo.Grains.Constants.StreamProvider);
                var stream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.HeatAnalyses>(RazManager.Silo.Grains.Constants.StreamName.HeatAnalyses.ToString(), new Guid(request.Value));
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
                if (subscriptionHandle is not null)
                {
                    await subscriptionHandle.UnsubscribeAsync();
                }
            }
        }

        private async Task HeatAnalysesSubscribeExisting(Guid id, IServerStreamWriter<HeatAnalyses> responseStream)
        {
            var stopwatch = new Stopwatch();
            stopwatch.Restart();
            var proto = await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.Heat.IHeatGrain>(id).ReadHeatAnalysesAsync();
            var readDuration = stopwatch.Elapsed;
            stopwatch.Restart();

            var written = 0;
            while (written < proto.Items.Count)
            {
                var buffer = new HeatAnalyses();

                buffer.Items.AddRange(proto.Items.AsEnumerable().Skip(written).Take(10000));
                written += 10000;

                var progress = Convert.ToDouble(written) / Convert.ToDouble(proto.Items.Count);
                if (progress < 1)
                {
                    buffer.Progress = progress;
                }

                await responseStream.WriteAsync(buffer);
            }


            //var memory = proto.Items.ToArray().AsMemory();

            //var written = 0;
            //while (written < proto.Items.Count)
            //{
            //    var buffer = new HeatAnalyses();

            //    buffer.Items.AddRange(memory.Span.Slice(written, 10000));

            //    written += 10000;

            //    var progress = Convert.ToDouble(written) / Convert.ToDouble(proto.Items.Count);
            //    if (progress < 1)
            //    {
            //        buffer.Progress = progress;
            //    }

            //    //buffer.Items.AddRange(proto.Items.AsEnumerable().Skip(written).Take(10000));

            //    await responseStream.WriteAsync(buffer);
            //}


            //await responseStream.WriteAsync(proto);

            var writeDuration = stopwatch.Elapsed;

            _logger.LogInformation($"HeatAnalysesSubscribeCurrent id={id} items={proto.Items.Count} size={proto.CalculateSize()} readDuration={readDuration} writeDuration={writeDuration}");
        }


        public override async Task HeatStintAnalysesSubscribe(HeatStintAnalysesRequest request, IServerStreamWriter<HeatStintAnalysis> responseStream, ServerCallContext context)
        {
            // TODO: Validate permissions

            StreamSubscriptionHandle<Razmanager.Protobuf.Public.V1.HeatStintAnalysis>? subscriptionHandle = null;
            try
            {
                await HeatStintAnalysesSubscribeExisting(new Guid(request.HeatId), Convert.ToByte(request.IndicatorId), responseStream);

                var streamProvider = _clusterClient.GetStreamProvider(RazManager.Silo.Grains.Constants.StreamProvider);
                var stream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.HeatStintAnalysis>(RazManager.Silo.Grains.Constants.StreamName.HeatStintAnalysis.ToString(), $"{request.HeatId}:{request.IndicatorId}");
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
                if (subscriptionHandle is not null)
                {
                    await subscriptionHandle.UnsubscribeAsync();
                }
            }
        }

        private async Task HeatStintAnalysesSubscribeExisting(Guid id, byte indicatorId, IServerStreamWriter<HeatStintAnalysis> responseStream)
        {
            var proto = await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.Heat.IHeatGrain>(id).ReadHeatStintAnalysisIndicatorStintsAsync(indicatorId);
            await responseStream.WriteAsync(new HeatStintAnalysis
            {
                Refresh = true,
                HeatStintAnalysisIndicatorStints = proto
            });
        }


        public override async Task HeatStintEventUsersSubscribe(HeatStintEventUsersRequest request, IServerStreamWriter<HeatStintEventUsers> responseStream, ServerCallContext context)
        {
            // TODO: Validate permissions

            StreamSubscriptionHandle<Razmanager.Protobuf.Public.V1.HeatStintEventUsers>? subscriptionHandle = null;
            try
            {
                await HeatStintEventUsersSubscribeExisting(new Guid(request.HeatId), responseStream);

                var streamProvider = _clusterClient.GetStreamProvider(RazManager.Silo.Grains.Constants.StreamProvider);
                var stream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.HeatStintEventUsers>(RazManager.Silo.Grains.Constants.StreamName.HeatStintEventUsers.ToString(), request.HeatId);
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
                if (subscriptionHandle is not null)
                {
                    await subscriptionHandle.UnsubscribeAsync();
                }
            }
        }


        private async Task HeatStintEventUsersSubscribeExisting(Guid id, IServerStreamWriter<HeatStintEventUsers> responseStream)
        {
            var proto = await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.Heat.IHeatGrain>(id).ReadHeatStintEventUsersAsync();
            await responseStream.WriteAsync(proto);
        }


        public override async Task<Empty> Command(HeatCommandRequest request, ServerCallContext context)
        {
            await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.Heat.IHeatGrain>(new Guid(request.Id)).CommandAsync(request.HeatCommandTypeId);
            return new Empty();
        }


        public override async Task<HeatCommandPermissions> CommandPermissions(StringValue request, ServerCallContext context)
        {
            return await _serviceClient.CommandPermissionsAsync(request);
        }
    }
}
