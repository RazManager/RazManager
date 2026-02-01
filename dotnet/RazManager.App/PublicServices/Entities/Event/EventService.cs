using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Microsoft.Extensions.Logging;
using Orleans;
using Orleans.Streams;
using Razmanager.Protobuf.Public.V1;
using RazManager.Utilities.Speech;
using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;


namespace RazManager.App.PublicServices.Entities.Event
{
    public class EventService : Razmanager.Protobuf.Public.V1.EventService.EventServiceBase
    {
        private readonly IClusterClient _clusterClient;
        private readonly RazManager.Utilities.Speech.IEventSpeech _eventSpeech;


        public EventService(Orleans.IClusterClient clusterClient,
                            RazManager.Utilities.Speech.IEventSpeech eventSpeech)
        {
            _clusterClient = clusterClient;
            _eventSpeech = eventSpeech;
        }


        public override async Task Subscribe(StringValue request, IServerStreamWriter<Razmanager.Protobuf.Public.V1.Event> responseStream, ServerCallContext context)
        {
            // TODO: Validate permissions

            StreamSubscriptionHandle<Razmanager.Protobuf.Public.V1.Event>? subscriptionHandle = null;
            try
            {
                await SubscribeExisting(new Guid(request.Value), responseStream);

                var streamProvider = _clusterClient.GetStreamProvider(RazManager.Silo.Grains.Constants.StreamProvider);
                var stream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.Event>(RazManager.Silo.Grains.Constants.StreamName.Event.ToString(), new Guid(request.Value));
                subscriptionHandle = await stream.SubscribeAsync(async sequentialItemList =>
                {
                    await foreach (var sequentialItem in sequentialItemList.ToAsyncEnumerable().WithCancellation(context.CancellationToken))
                    {
                        await responseStream.WriteAsync(sequentialItem.Item);
                    }
                });

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
                System.GC.Collect();
            }
        }

        private async Task SubscribeExisting(Guid id, IServerStreamWriter<Razmanager.Protobuf.Public.V1.Event> responseStream)
        {
            var proto = await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.Event.IEventGrain>(id).ReadAsync();
            await responseStream.WriteAsync(proto);
        }


        public override async Task EventStateSubscribe(StringValue request, IServerStreamWriter<Razmanager.Protobuf.Public.V1.EventState> responseStream, ServerCallContext context)
        {
            // TODO: Validate permissions

            StreamSubscriptionHandle<Razmanager.Protobuf.Public.V1.EventState>? subscriptionHandle = null;
            try
            {
                await EventStateSubscribeExisting(new Guid(request.Value), responseStream);

                var streamProvider = _clusterClient.GetStreamProvider(RazManager.Silo.Grains.Constants.StreamProvider);
                var stream = streamProvider.GetStream<Razmanager.Protobuf.Public.V1.EventState>(RazManager.Silo.Grains.Constants.StreamName.EventState.ToString(), new Guid(request.Value));
                subscriptionHandle = await stream.SubscribeAsync(async sequentialItemList =>
                {
                    await foreach (var sequentialItem in sequentialItemList.ToAsyncEnumerable().WithCancellation(context.CancellationToken))
                    {
                        await responseStream.WriteAsync(sequentialItem.Item);
                    }
                });

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
                System.GC.Collect();
            }
        }

        private async Task EventStateSubscribeExisting(Guid id, IServerStreamWriter<Razmanager.Protobuf.Public.V1.EventState> responseStream)
        {
            var proto = await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.Event.IEventGrain>(id).ReadEventStateAsync();
            await responseStream.WriteAsync(proto);
        }


        public override async Task EventUserSpeechSubscribe(Razmanager.Protobuf.Public.V1.EventUserSpeechSubscribeRequest request, IServerStreamWriter<Razmanager.Protobuf.Public.V1.EventSpeech> responseStream, ServerCallContext context)
        {
            // TODO: Validate permissions

            StreamSubscriptionHandle<Razmanager.Protobuf.Internal.Silo.UserServices.Event.EventSpeechData>? subscriptionHandle = null;
            try
            {
                var name = await _eventSpeech.GetNameAsync(request.Locale, request.LocalName);
                if (name is null)
                {
                    throw new ArgumentException("Cannot find the speech name.");
                }

                var streamProvider = _clusterClient.GetStreamProvider(RazManager.Silo.Grains.Constants.StreamProvider);
                var stream = streamProvider.GetStream<Razmanager.Protobuf.Internal.Silo.UserServices.Event.EventSpeechData>(RazManager.Silo.Grains.Constants.StreamName.EventSpeechData.ToString(), $"{request.EventId}:{request.EventUserId}");
                subscriptionHandle = await stream.SubscribeAsync(async sequentialItemList =>
                {
                    await foreach (var sequentialItem in sequentialItemList.ToAsyncEnumerable().WithCancellation(context.CancellationToken))
                    {
                        SpeechStyle speechStyle;
                        switch (sequentialItem.Item.EventSpeechTypeId)
                        {
                            case Razmanager.Protobuf.Internal.Silo.UserServices.Event.EventSpeechTypeId.Faster:
                                speechStyle = SpeechStyle.Faster;
                                break;

                            case Razmanager.Protobuf.Internal.Silo.UserServices.Event.EventSpeechTypeId.Fastest:
                                speechStyle = SpeechStyle.Fastest;
                                break;

                            case Razmanager.Protobuf.Internal.Silo.UserServices.Event.EventSpeechTypeId.PositionLeader:
                                speechStyle = SpeechStyle.PositionLeader;
                                break;

                            case Razmanager.Protobuf.Internal.Silo.UserServices.Event.EventSpeechTypeId.PositionGained:
                                speechStyle = SpeechStyle.PositionGained;
                                break;

                            case Razmanager.Protobuf.Internal.Silo.UserServices.Event.EventSpeechTypeId.PositionLost:
                                speechStyle = SpeechStyle.PositionLost;
                                break;

                            case Razmanager.Protobuf.Internal.Silo.UserServices.Event.EventSpeechTypeId.GapAfter:
                                speechStyle = SpeechStyle.GapAfter;
                                break;

                            case Razmanager.Protobuf.Internal.Silo.UserServices.Event.EventSpeechTypeId.GapBefore:
                                speechStyle = SpeechStyle.GapBefore;
                                break;

                            case Razmanager.Protobuf.Internal.Silo.UserServices.Event.EventSpeechTypeId.BadLap:
                                speechStyle = SpeechStyle.BadLap;
                                break;

                            default:
                                speechStyle = SpeechStyle.Normal;
                                break;
                        }

                        var bytes = await _eventSpeech.SpeekAsync(request.Locale, name, sequentialItem.Item.Text, speechStyle);
                        if (bytes is not null)
                        {
                            await responseStream.WriteAsync(new Razmanager.Protobuf.Public.V1.EventSpeech { Speech = Google.Protobuf.ByteString.CopyFrom(bytes)});
                        }
                    }
                });

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
                System.GC.Collect();
            }
        }


        public override async Task<EventSpeechSettingsReponse> EventSpeechSettings(EventSpeechSettingsRequest request, ServerCallContext context)
        {
            var voices = await _eventSpeech.GetSettingsAsync(request.Locale);
            var result = new EventSpeechSettingsReponse();
            result.Items.AddRange(voices.Select(x => new EventSpeechSettings { Locale = x.locale, LocaleName = x.localeName, LocalName = x.localName }));
            return result;
        }
    }
}
