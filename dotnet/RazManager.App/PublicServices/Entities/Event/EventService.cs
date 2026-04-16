using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Orleans;
using Orleans.Streams;
using Razmanager.Protobuf.Public.V1;
using RazManager.Utilities.Speech;
using System;
using System.Collections.Generic;
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

        private async Task EventStateSubscribeExisting(Guid id, IServerStreamWriter<Razmanager.Protobuf.Public.V1.EventState> responseStream)
        {
            var proto = await _clusterClient.GetGrain<RazManager.Silo.Grains.Entities.Event.IEventGrain>(id).ReadEventStateAsync();
            await responseStream.WriteAsync(proto);
        }


        public override async Task EventSpeechSubscribe(Razmanager.Protobuf.Public.V1.EventSpeechSubscribeRequest request, IServerStreamWriter<Razmanager.Protobuf.Public.V1.EventSpeech> responseStream, ServerCallContext context)
        {
            // TODO: Validate permissions

            // Define the desired order
            var eventSpeechTypeIdOrder = new Dictionary<EventSpeechTypeId, int>
            {
                [EventSpeechTypeId.PositionLeader] = 1,
                [EventSpeechTypeId.PositionGained] = 2,
                [EventSpeechTypeId.PositionLost] = 3,
                [EventSpeechTypeId.Fastest] = 4,
                [EventSpeechTypeId.Faster] = 5,
                [EventSpeechTypeId.GapAfter] = 6,
                [EventSpeechTypeId.GapBefore] = 7,
                [EventSpeechTypeId.GapNearest] = 8,
                [EventSpeechTypeId.AverageLap] = 9,
                [EventSpeechTypeId.Lap] = 10,
            };

            Dictionary<EventSpeechTypeId, eventSpeechTypeLap> eventSpeechTypes = request.EventSpeechTypeOptions
                .ToDictionary(x => x.EventSpeechTypeId, x => new eventSpeechTypeLap { LapThreshold = x.Laps });

            StreamSubscriptionHandle<Razmanager.Protobuf.Internal.Silo.UserServices.Event.EventSpeechTexts>? subscriptionHandle = null;
            try
            {
                var name = await _eventSpeech.GetNameAsync(request.Locale, request.LocalName);
                if (name is null)
                {
                    throw new ArgumentException("Cannot find the speech name.");
                }

                var streamProvider = _clusterClient.GetStreamProvider(RazManager.Silo.Grains.Constants.StreamProvider);
                var stream = streamProvider.GetStream<Razmanager.Protobuf.Internal.Silo.UserServices.Event.EventSpeechTexts>(RazManager.Silo.Grains.Constants.StreamName.EventSpeechTexts.ToString(), $"{request.EventId}:{request.EventUserId}");
                subscriptionHandle = await stream.SubscribeAsync(async sequentialItemList =>
                {
                    bool spooken = false;
                    await foreach (var sequentialItem in sequentialItemList.ToAsyncEnumerable().WithCancellation(context.CancellationToken))
                    {
                        foreach (var eventSpeechText in sequentialItem.Item.Items.OrderBy(item => eventSpeechTypeIdOrder[item.EventSpeechTypeId]))                       
                        {
                            if (eventSpeechTypes.TryGetValue(eventSpeechText.EventSpeechTypeId, out var eventSpeechTypeLap))
                            {
                                eventSpeechTypeLap.LapCount++;
                                if (eventSpeechText.Time.HasValue)
                                {
                                    eventSpeechTypeLap.Times.Add(eventSpeechText.Time.Value);
                                }

                                if (!spooken && (!eventSpeechTypeLap.LapThreshold.HasValue || eventSpeechTypeLap.LapThreshold.Value <= eventSpeechTypeLap.LapCount))
                                {
                                    SpeechStyle speechStyle;
                                    var slow = false;
                                    switch (eventSpeechText.EventSpeechTypeId)
                                    {
                                        case EventSpeechTypeId.Faster:
                                            speechStyle = SpeechStyle.Faster;
                                            break;

                                        case EventSpeechTypeId.Fastest:
                                            speechStyle = SpeechStyle.Fastest;
                                            break;

                                        case EventSpeechTypeId.PositionLeader:
                                            speechStyle = SpeechStyle.PositionLeader;
                                            break;

                                        case EventSpeechTypeId.PositionGained:
                                            speechStyle = SpeechStyle.PositionGained;
                                            break;

                                        case EventSpeechTypeId.PositionLost:
                                            speechStyle = SpeechStyle.PositionLost;
                                            break;

                                        case EventSpeechTypeId.GapAfter:
                                            speechStyle = SpeechStyle.GapAfter;
                                            break;

                                        case EventSpeechTypeId.GapBefore:
                                            speechStyle = SpeechStyle.GapBefore;
                                            break;

                                        case EventSpeechTypeId.AverageLap:
                                            speechStyle = SpeechStyle.Normal;
                                            var averageTime =Math.Round(eventSpeechTypeLap.Times.Average(), 2);
                                            eventSpeechText.Text = $"Average lap time  {averageTime}";
                                            break;

                                        default:
                                            speechStyle = SpeechStyle.Normal;
                                            slow = eventSpeechText.Slow;
                                            break;
                                    }

                                    var bytes = await _eventSpeech.SpeekAsync(request.Locale, name, eventSpeechText.Text, speechStyle, slow);
                                    if (bytes is not null && bytes.Length > 0)
                                    {
                                        await responseStream.WriteAsync(new Razmanager.Protobuf.Public.V1.EventSpeech { Speech = Google.Protobuf.ByteString.CopyFrom(bytes) });
                                    }

                                    spooken = true;
                                    eventSpeechTypeLap.LapCount = 0;
                                    eventSpeechTypeLap.Times.Clear();
                                }
                            }
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

        class eventSpeechTypeLap
        {
            public required uint? LapThreshold { get; set; }
            public uint LapCount { get; set; } = 0;
            public List<double> Times { get; set; } = [];
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
