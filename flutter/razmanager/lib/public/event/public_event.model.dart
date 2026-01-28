import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:grpc/grpc.dart' as grpc;
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../app_model.dart';
import '../../utilities/grpc_client.dart';
import '../../protobuf/razmanager/protobuf/public/event.service.v1.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/public/event.v1.pb.dart';

enum DriverBoardSelection { all, firsthalf, secondhalf, individual }

class EventModel extends ChangeNotifier with GrpcClient {
  EventModel() {
    initialize();
  }

  AppModel? _appModel;

  grpc.ClientChannel? clientChannel;
  final connectionStreamController = StreamController<bool>.broadcast();
  late String eventId;
  Event? eventProto;
  StreamSubscription<Event>? _eventStreamSubscription;
  StreamSubscription<EventSpeech>? _eventSpeechStreamSubscription;

  late Iterable<EventSpeechSettings> eventSpeechSettings;
  EventSpeechSettings? eventSpeechSetting;
  bool soundEnabled = false;
  AudioPlayer? _audioPlayer;

  String? followEventUserId;
  List<String> eventUserIds = [];

  DriverBoardSelection driverBoardSelection = DriverBoardSelection.all;

  @override
  void dispose() {
    Future.microtask(releaseEvent);
    super.dispose();
  }

  Future<void> handleGrpcError(dynamic exception) async {
    debugPrint("handleGrpcError $exception");
    if (exception is grpc.GrpcError) {
      debugPrint(exception.code.toString());
      switch (exception.code) {
        case 2: //UNKNOWN
          debugPrint("Waiting 1 second...");
          connectionStreamController.add(false);
          await Future.delayed(const Duration(seconds: 1));
          break;

        case 14: // UNAVAILABLE
          debugPrint("Waiting 30 seconds...");
          connectionStreamController.add(false);
          await Future.delayed(const Duration(seconds: 30));
          break;

        default:
          break;
      }
    }
  }

  void initialize() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    final sharedPreferenceDriverBoardSelection = sharedPreferences.getString('driverBoardSelection');
    if (sharedPreferenceDriverBoardSelection != null) {
      driverBoardSelection = DriverBoardSelection.values.byName(sharedPreferenceDriverBoardSelection);
      if (driverBoardSelection == DriverBoardSelection.individual) {
        driverBoardSelection = DriverBoardSelection.all;
      }
    }

    // var sharedPreferenceEventUserIds =
    //     sharedPreferences.getStringList('eventUserIds');
    // if (sharedPreferenceEventUserIds != null) {
    //   eventUserIds = sharedPreferenceEventUserIds;
    // }
  }

  EventServiceClient eventServiceClient() {
    return EventServiceClient(clientChannel!, options: callOptionsFromAppModel(_appModel!));
  }

  Future<void> refreshEvent({required BuildContext context, required String id}) async {
    _appModel = context.read<AppModel>();

    if (clientChannel != null) {
      await clientChannel!.shutdown();
      clientChannel == null;
    }

    clientChannel = createClientChannel();
    clientChannel!.onConnectionStateChanged.listen(
      (connectionState) {
        debugPrint('clientChannel $connectionState');
        if (connectionState == grpc.ConnectionState.ready) {

          connectionStreamController.add(true);
        }
        else if (connectionState == grpc.ConnectionState.idle) {
          connectionStreamController.add(false);
        }
      },
      onDone: () => debugPrint('clientChannel done'),
      onError: (exception) {
        debugPrint("clientChannel $exception");
      },
    );

    eventId = id;

    if (eventSpeechSetting == null) {
      final sharedPreferences = await SharedPreferences.getInstance();
      final eventSpeechLocale = sharedPreferences.getString('eventSpeechLocale');
      final eventSpeechLocalName = sharedPreferences.getString('eventSpeechLocalName');

      final eventSpeechSettingsResponse = await eventServiceClient().eventSpeechSettings(
        EventSpeechSettingsRequest(locale: _appModel!.locale.replaceAll('_', '-')),
      );
      eventSpeechSettings = eventSpeechSettingsResponse.items;

      final eventSpeechSettingRefreshed = eventSpeechSettings.where((x) => x.locale == eventSpeechLocale && x.localName == eventSpeechLocalName).singleOrNull;
      if (eventSpeechSettingRefreshed != null) {
        eventSpeechSetting = eventSpeechSettingRefreshed;
      } else {
        eventSpeechSetting ??= eventSpeechSettings.first;
      }
    }

    await eventSubscribe();
  }

  Future<void> releaseEvent() async {
    eventProto = null;
    followEventUserId = null;
    eventUserIds = [];

    if (_audioPlayer != null) {
      await _audioPlayer!.dispose();
    }

    if (_eventStreamSubscription != null) {
      await _eventStreamSubscription!.cancel();
      _eventStreamSubscription == null;
    }

    if (_eventSpeechStreamSubscription != null) {
      await _eventSpeechStreamSubscription!.cancel();
      _eventSpeechStreamSubscription == null;
    }

    if (clientChannel != null) {
      await clientChannel!.shutdown();
      clientChannel == null;
    }
  }

  Future<void> eventSubscribe() async {
    if (_eventStreamSubscription != null) {
      await _eventStreamSubscription!.cancel();
    }
    _eventStreamSubscription = eventServiceClient()
        .subscribe(StringValue(value: eventId))
        .listen(
          (data) {
            eventProto = data;
            notifyListeners();
          },
          onDone: () => debugPrint('eventSubscribe done'),
          onError: (exception) async {
            debugPrint("eventSubscribe $exception");
            await handleGrpcError(exception);
            await eventSubscribe();
          },
        );
  }

  Future<void> followEventUserIdNotify(String eventUserId) async {
    followEventUserId = eventUserId;
    if (soundEnabled && soundEnabledToggleEnabled) {
      await _eventSpeechSubscribe();
    }
    notifyListeners();
  }

  Future<void> driverboardDriverBoardSelectionNotify(DriverBoardSelection driverBoardSelection) async {
    this.driverBoardSelection = driverBoardSelection;

    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('driverBoardSelection', this.driverBoardSelection.name);

    notifyListeners();
  }

  void driverboardEventUserIdsAddNotify(String eventUserId) {
    eventUserIds.add(eventUserId);

    notifyListeners();
  }

  void driverboardEventUserIdsRemoveNotify(String eventUserId) {
    eventUserIds.remove(eventUserId);

    notifyListeners();
  }

  Future<void> soundEnabledNotify(bool enabled) async {
    soundEnabled = enabled;

    if (enabled) {
      if (soundEnabledToggleEnabled) {
        await _eventSpeechSubscribe();
      }
    } else {
      await _eventSpeechUnsubscribe();
    }

    notifyListeners();
  }

  bool get soundEnabledToggleEnabled {
    return eventSpeechSetting != null && followEventUserId != null;
  }

  Future<void> eventSpeechSettingsNotify(EventSpeechSettings eventSpeechSetting) async {
    this.eventSpeechSetting = eventSpeechSetting;

    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('eventSpeechLocale', eventSpeechSetting.locale);
    sharedPreferences.setString('eventSpeechLocalName', eventSpeechSetting.localName);
    if (soundEnabled && soundEnabledToggleEnabled) {
      await _eventSpeechSubscribe();
    }
  }

  Future<void> _eventSpeechSubscribe() async {
    debugPrint("eventSpeechSubscribe...");
    if (_eventSpeechStreamSubscription != null) {
      await _eventSpeechStreamSubscription!.cancel();
    }
    _eventSpeechStreamSubscription = eventServiceClient()
        .eventUserSpeechSubscribe(
          EventUserSpeechSubscribeRequest(
            eventId: eventProto!.id,
            eventUserId: followEventUserId,
            locale: eventSpeechSetting!.locale,
            localName: eventSpeechSetting!.localName,
          ),
        )
        .listen(
          (data) {
            _audioPlayer ??= AudioPlayer();
            _audioPlayer!.play(BytesSource(Uint8List.fromList(data.speech.value)));
          },
          onDone: () => debugPrint('_eventSpeechSubscribe done'),
          onError: (exception) async {
            debugPrint("_eventSpeechSubscribe $exception");
            //_appModel!.exceptionStreamController.add(exception.toString());
            await handleGrpcError(exception);
            await _eventSpeechSubscribe();
          },
        );
  }

  Future<void> _eventSpeechUnsubscribe() async {
    debugPrint("eventSpeechUnsubscribe...");
    if (_eventSpeechStreamSubscription != null) {
      await _eventSpeechStreamSubscription!.cancel();
      _eventSpeechStreamSubscription == null;
    }

    if (_audioPlayer != null) {
      await _audioPlayer!.dispose();
      _audioPlayer == null;
    }
  }
}
