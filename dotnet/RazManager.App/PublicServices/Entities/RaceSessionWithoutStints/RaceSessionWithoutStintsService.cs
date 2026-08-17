using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Orleans;
using Orleans.Streams;
using Razmanager.Protobuf.Public.V1;
using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;


namespace RazManager.App.PublicServices.Entities.RaceSessionWithoutStints
{
    public class RaceSessionWithoutStintsService : Razmanager.Protobuf.Public.V1.RaceSessionWithoutStintsService.RaceSessionWithoutStintsServiceBase
    {
        private readonly Razmanager.Protobuf.Public.V1.RaceSessionWithoutStintsService.RaceSessionWithoutStintsServiceClient _serviceClient;
        private readonly IClusterClient _clusterClient;


        public RaceSessionWithoutStintsService(Razmanager.Protobuf.Public.V1.RaceSessionWithoutStintsService.RaceSessionWithoutStintsServiceClient serviceClient,
                                               Orleans.IClusterClient clusterClient)
        {
            _serviceClient = serviceClient;
            _clusterClient = clusterClient;
        }

        public override async Task Subscribe(StringValue request, IServerStreamWriter<Razmanager.Protobuf.Public.V1.RaceSessionWithoutStints> responseStream, ServerCallContext context)
        {
            // TODO: Validate permissions

            StreamSubscriptionHandle<Razmanager.Protobuf.Public.V1.RaceSessionWithoutStints>? subscriptionHandle = null;
            try
            {
                var proto = await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.RaceSessionWithoutStints.IRaceSessionWithoutStintsGrain>(new Guid(request.Value)).ReadAsync();
                await responseStream.WriteAsync(proto);

                var streamProvider = _clusterClient.GetStreamProvider(RazManager.Silo.Grains.Constants.StreamProvider);
                var stream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.RaceSessionWithoutStints>(RazManager.Silo.Grains.Constants.StreamName.RaceSessionWithoutStints.ToString(), new Guid(request.Value));
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

        public override async Task StateSubscribe(StringValue request, IServerStreamWriter<RaceSessionWithoutStintsState> responseStream, ServerCallContext context)
        {
            // TODO: Validate permissions

            StreamSubscriptionHandle<Razmanager.Protobuf.Public.V1.RaceSessionWithoutStintsState>? subscriptionHandle = null;
            try
            {
                var proto = await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.RaceSessionWithoutStints.IRaceSessionWithoutStintsGrain>(new Guid(request.Value)).ReadStateAsync();
                await responseStream.WriteAsync(proto);

                var streamProvider = _clusterClient.GetStreamProvider(RazManager.Silo.Grains.Constants.StreamProvider);
                var stream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.RaceSessionWithoutStintsState>(RazManager.Silo.Grains.Constants.StreamName.RaceSessionWithoutStintsState.ToString(), new Guid(request.Value));
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
                var proto = await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.RaceSessionWithoutStints.IRaceSessionWithoutStintsGrain>(new Guid(request.Value)).ReadLeaderboardAsync();
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
            await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.RaceSessionWithoutStints.IRaceSessionWithoutStintsGrain>(new Guid(request.Id)).CommandAsync(request.CommandTypeId);
            return new Empty();
        }


        public override async Task<SummaryCommandPermissions> CommandPermissions(StringValue request, ServerCallContext context)
        {
            return await _serviceClient.CommandPermissionsAsync(request);
        }
    }
}
