using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Orleans;
using Orleans.Streams;
using Razmanager.Protobuf.Public.V1;
using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;


namespace RazManager.App.PublicServices.Entities.Race
{
    public class RaceService : Razmanager.Protobuf.Public.V1.RaceService.RaceServiceBase
    {
        private readonly Razmanager.Protobuf.Public.V1.RaceService.RaceServiceClient _serviceClient;
        private readonly IClusterClient _clusterClient;


        public RaceService(Razmanager.Protobuf.Public.V1.RaceService.RaceServiceClient serviceClient,
                           Orleans.IClusterClient clusterClient)
        {
            _serviceClient = serviceClient;
            _clusterClient = clusterClient;
        }


        public override async Task Subscribe(StringValue request, IServerStreamWriter<Razmanager.Protobuf.Public.V1.Race> responseStream, ServerCallContext context)
        {
            // TODO: Validate permissions

            StreamSubscriptionHandle<Razmanager.Protobuf.Public.V1.Race>? subscriptionHandle = null;
            try
            {
                var proto = await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.Race.IRaceGrain>(new Guid(request.Value)).ReadAsync();
                await responseStream.WriteAsync(proto);

                var streamProvider = _clusterClient.GetStreamProvider(RazManager.Silo.Grains.Constants.StreamProvider);
                var stream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.Race>(RazManager.Silo.Grains.Constants.StreamName.Race.ToString(), new Guid(request.Value));
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


        public override async Task RaceWithoutStintStateSubscribe(RaceSessionRequest request, IServerStreamWriter<RaceWithoutStintState> responseStream, ServerCallContext context)
        {
            // TODO: Validate permissions

            StreamSubscriptionHandle<Razmanager.Protobuf.Public.V1.RaceWithoutStintState>? subscriptionHandle = null;
            try
            {
                var proto = await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.RaceWithoutStint.IRaceWithoutStintGrain>(new Guid(request.Id)).ReadRaceWithoutStintStateAsync(request.SessionTypeId);
                await responseStream.WriteAsync(proto);

                var streamProvider = _clusterClient.GetStreamProvider(RazManager.Silo.Grains.Constants.StreamProvider);
                var stream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.RaceWithoutStintState>(RazManager.Silo.Grains.Constants.StreamName.RaceSessionWithoutStintState.ToString(), new Guid(request.Id));
                subscriptionHandle = await stream.SubscribeAsync(async sequentialItemList =>
                {
                    await foreach (var sequentialItem in sequentialItemList.ToAsyncEnumerable().WithCancellation(context.CancellationToken))
                    {
                        if (sequentialItem.Item.SessionTypeId == request.SessionTypeId)
                        {
                            await responseStream.WriteAsync(sequentialItem.Item);
                        }
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


        public override async Task RaceWithStintStateSubscribe(RaceSessionRequest request, IServerStreamWriter<RaceWithStintState> responseStream, ServerCallContext context)
        {
            // TODO: Validate permissions

            StreamSubscriptionHandle<Razmanager.Protobuf.Public.V1.RaceWithStintState>? subscriptionHandle = null;
            try
            {
                var proto = await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.RaceSessionWithStint.IRaceSessionWithStintGrain>(new Guid(request.Id)).ReadRaceWithStintStateAsync(request.SessionTypeId);
                await responseStream.WriteAsync(proto);

                var streamProvider = _clusterClient.GetStreamProvider(RazManager.Silo.Grains.Constants.StreamProvider);
                var stream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.RaceWithStintState>(RazManager.Silo.Grains.Constants.StreamName.RaceSessionWithStintState.ToString(), new Guid(request.Id));
                subscriptionHandle = await stream.SubscribeAsync(async sequentialItemList =>
                {
                    await foreach (var sequentialItem in sequentialItemList.ToAsyncEnumerable().WithCancellation(context.CancellationToken))
                    {
                        if (sequentialItem.Item.SessionTypeId == request.SessionTypeId)
                        {
                            await responseStream.WriteAsync(sequentialItem.Item);
                        }
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


        public override async Task RaceLeaderboardSubscribe(RaceSessionRequest request, IServerStreamWriter<RaceLeaderboard> responseStream, ServerCallContext context)
        {
            // TODO: Validate permissions

            StreamSubscriptionHandle<Razmanager.Protobuf.Public.V1.RaceLeaderboard>? subscriptionHandle = null;
            try
            {
                var proto = await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.Race.IRaceGrain>(new Guid(request.Id)).ReadRaceLeaderboardAsync(request.SessionTypeId);
                await responseStream.WriteAsync(proto);

                var streamProvider = _clusterClient.GetStreamProvider(RazManager.Silo.Grains.Constants.StreamProvider);
                var stream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.RaceLeaderboard>(RazManager.Silo.Grains.Constants.StreamName.RaceSessionLeaderboard.ToString(), new Guid(request.Id));
                subscriptionHandle = await stream.SubscribeAsync(async sequentialItemList =>
                {
                    await foreach (var sequentialItem in sequentialItemList.ToAsyncEnumerable().WithCancellation(context.CancellationToken))
                    {
                        if (sequentialItem.Item.SessionTypeId == request.SessionTypeId)
                        {
                            await responseStream.WriteAsync(sequentialItem.Item);
                        }
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


        public override async Task<Empty> Command(RaceCommandRequest request, ServerCallContext context)
        {
            await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.Race.IRaceGrain>(new Guid(request.Id)).CommandAsync(request.RaceCommandTypeId);
            return new Empty();
        }


        public override async Task<SummaryCommandPermissions> CommandPermissions(StringValue request, ServerCallContext context)
        {
            return await _serviceClient.CommandPermissionsAsync(request);
        }
    }
}
