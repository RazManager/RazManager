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


namespace RazManager.App.PublicServices.Entities.HeatWithoutStints
{
    public class HeatWithoutStintsService : Razmanager.Protobuf.Public.V1.HeatWithoutStintsService.HeatWithoutStintsServiceBase
    {
        private readonly Razmanager.Protobuf.Public.V1.HeatWithoutStintsService.HeatWithoutStintsServiceClient _serviceClient;
        private readonly IClusterClient _clusterClient;
        private readonly ILogger<HeatWithoutStintsService> _logger;

        public HeatWithoutStintsService(Razmanager.Protobuf.Public.V1.HeatWithoutStintsService.HeatWithoutStintsServiceClient serviceClient,
                           Orleans.IClusterClient clusterClient,
                           ILogger<HeatWithoutStintsService> logger)
        {
            _serviceClient = serviceClient;
            _clusterClient = clusterClient;
            _logger = logger;
        }


        public override async Task Subscribe(StringValue request, IServerStreamWriter<Razmanager.Protobuf.Public.V1.HeatWithoutStints> responseStream, ServerCallContext context)
        {
            // TODO: Validate permissions

            StreamSubscriptionHandle<Razmanager.Protobuf.Public.V1.HeatWithoutStints>? subscriptionHandle = null;
            try
            {
                var proto = await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.HeatWithoutStints.IHeatWithoutStintsGrain>(new Guid(request.Value)).ReadAsync();
                await responseStream.WriteAsync(proto);

                var streamProvider = _clusterClient.GetStreamProvider(RazManager.Silo.Grains.Constants.StreamProvider);
                var stream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.HeatWithoutStints>(RazManager.Silo.Grains.Constants.StreamName.HeatWithoutStints.ToString(), new Guid(request.Value));
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


        public override async Task StateSubscribe(StringValue request, IServerStreamWriter<DetailState> responseStream, ServerCallContext context)
        {
            // TODO: Validate permissions

            StreamSubscriptionHandle<Razmanager.Protobuf.Public.V1.DetailState>? subscriptionHandle = null;
            try
            {
                var proto = await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.HeatWithoutStints.IHeatWithoutStintsGrain>(new Guid(request.Value)).ReadStateAsync();
                await responseStream.WriteAsync(proto);

                var streamProvider = _clusterClient.GetStreamProvider(RazManager.Silo.Grains.Constants.StreamProvider);
                var stream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.DetailState>(RazManager.Silo.Grains.Constants.StreamName.HeatWithoutStintsState.ToString(), new Guid(request.Value));
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


        public override async Task LeaderboardSubscribe(StringValue request, IServerStreamWriter<HeatWithoutStintsLeaderboard> responseStream, ServerCallContext context)
        {
            // TODO: Validate permissions

            StreamSubscriptionHandle<Razmanager.Protobuf.Public.V1.HeatWithoutStintsLeaderboard>? subscriptionHandle = null;
            try
            {
                var proto = await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.HeatWithoutStints.IHeatWithoutStintsGrain>(new Guid(request.Value)).ReadLeaderboardAsync();
                await responseStream.WriteAsync(proto);

                var streamProvider = _clusterClient.GetStreamProvider(RazManager.Silo.Grains.Constants.StreamProvider);
                var stream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.HeatWithoutStintsLeaderboard>(RazManager.Silo.Grains.Constants.StreamName.HeatWithoutStintsLeaderboard.ToString(), new Guid(request.Value));
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
            var proto = await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.HeatWithoutStints.IHeatWithoutStintsGrain>(id).ReadHeatAnalysesAsync();
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
            var proto = await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.HeatWithoutStints.IHeatWithoutStintsGrain>(id).ReadHeatStintAnalysisIndicatorStintsAsync(indicatorId);
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
            var proto = await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.HeatWithoutStints.IHeatWithoutStintsGrain>(id).ReadHeatStintEventUsersAsync();
            await responseStream.WriteAsync(proto);
        }


        public override async Task<Empty> Command(DetailCommandRequest request, ServerCallContext context)
        {
            await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.HeatWithoutStints.IHeatWithoutStintsGrain>(new Guid(request.Id)).CommandAsync(request.CommandTypeId);
            return new Empty();
        }


        public override async Task<DetailCommandPermissions> CommandPermissions(StringValue request, ServerCallContext context)
        {
            return await _serviceClient.CommandPermissionsAsync(request);
        }
    }
}
