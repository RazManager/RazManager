using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Orleans;
using Orleans.Streams;
using Razmanager.Protobuf.Public.V1;
using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;


namespace RazManager.App.PublicServices.Entities.RaceSessionWithStints
{
    public class RaceSessionWithStintsService : Razmanager.Protobuf.Public.V1.RaceSessionWithStintsService.RaceSessionWithStintsServiceBase
    {
        private readonly Razmanager.Protobuf.Public.V1.RaceSessionWithStintsService.RaceSessionWithStintsServiceClient _serviceClient;
        private readonly IClusterClient _clusterClient;


        public RaceSessionWithStintsService(Razmanager.Protobuf.Public.V1.RaceSessionWithStintsService.RaceSessionWithStintsServiceClient serviceClient,
                                            Orleans.IClusterClient clusterClient)
        {
            _serviceClient = serviceClient;
            _clusterClient = clusterClient;
        }

        public override async Task Subscribe(StringValue request, IServerStreamWriter<Razmanager.Protobuf.Public.V1.RaceSessionWithStints> responseStream, ServerCallContext context)
        {
            // TODO: Validate permissions

            StreamSubscriptionHandle<Razmanager.Protobuf.Public.V1.RaceSessionWithStints>? subscriptionHandle = null;
            try
            {
                var proto = await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.RaceSessionWithStints.IRaceSessionWithStintsGrain>(new Guid(request.Value)).ReadAsync();
                await responseStream.WriteAsync(proto);

                var streamProvider = _clusterClient.GetStreamProvider(RazManager.Silo.Grains.Constants.StreamProvider);
                var stream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.RaceSessionWithStints>(RazManager.Silo.Grains.Constants.StreamName.RaceSessionWithStints.ToString(), new Guid(request.Value));
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

        public override async Task StateSubscribe(StringValue request, IServerStreamWriter<RaceSessionWithStintsState> responseStream, ServerCallContext context)
        {
            // TODO: Validate permissions

            StreamSubscriptionHandle<Razmanager.Protobuf.Public.V1.RaceSessionWithStintsState>? subscriptionHandle = null;
            try
            {
                var proto = await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.RaceSessionWithStints.IRaceSessionWithStintsGrain>(new Guid(request.Value)).ReadStateAsync();
                await responseStream.WriteAsync(proto);

                var streamProvider = _clusterClient.GetStreamProvider(RazManager.Silo.Grains.Constants.StreamProvider);
                var stream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.RaceSessionWithStintsState>(RazManager.Silo.Grains.Constants.StreamName.RaceSessionWithStintsState.ToString(), new Guid(request.Value));
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


        public override async Task LeaderboardSubscribe(StringValue request, IServerStreamWriter<RaceSessionLeaderboard> responseStream, ServerCallContext context)
        {
            // TODO: Validate permissions

            StreamSubscriptionHandle<Razmanager.Protobuf.Public.V1.RaceSessionLeaderboard>? subscriptionHandle = null;
            try
            {
                var proto = await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.RaceSessionWithStints.IRaceSessionWithStintsGrain>(new Guid(request.Value)).ReadLeaderboardAsync();
                await responseStream.WriteAsync(proto);

                var streamProvider = _clusterClient.GetStreamProvider(RazManager.Silo.Grains.Constants.StreamProvider);
                var stream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.RaceSessionLeaderboard>(RazManager.Silo.Grains.Constants.StreamName.RaceSessionLeaderboard.ToString(), new Guid(request.Value));
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


        public override async Task<Empty> Command(SummaryCommandRequest request, ServerCallContext context)
        {
            await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.RaceSessionWithStints.IRaceSessionWithStintsGrain>(new Guid(request.Id)).CommandAsync(request.CommandTypeId);
            return new Empty();
        }


        public override async Task<SummaryCommandPermissions> CommandPermissions(StringValue request, ServerCallContext context)
        {
            return await _serviceClient.CommandPermissionsAsync(request);
        }
    }
}
