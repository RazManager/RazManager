import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart';
import 'package:razmanager/protobuf/razmanager/protobuf/public/session_type_id.v1.pb.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:grpc/grpc.dart' as grpc;
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../app_model.dart';
import '../../protobuf/razmanager/protobuf/public/event_speech_type_id.v1.pbenum.dart';
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
  final SessionTypeId sessionTypeId2 = SessionTypeId.SESSION_TYPE_ID_RACE;
  StreamSubscription<Event>? _eventStreamSubscription;
  StreamSubscription<EventSpeech>? _eventSpeechStreamSubscription;

  late Iterable<EventSpeechSettings> eventSpeechSettings;

  List<SessionTypeSoundSetting> sessionTypeSoundSettings = [];
  List<SessionTypeEventSpeechSettingSetting> sessionTypeEventSpeechSettingSettings = [];
  List<SessionTypeEventSpeechTypeSetting> sessionTypeEventSpeechTypeSettings = [];

  AudioPlayer? _audioPlayer;

  String followEventUserId = "";
  List<String> followEventUserIds = [];
  List<String> eventUserIds = [];

  bool leaderBoardUseMaxFontSize = true;

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

    final sharedPreferenceLeaderBoardUseMaxFontSize = sharedPreferences.getBool('leaderBoardUseMaxFontSize');
    if (sharedPreferenceLeaderBoardUseMaxFontSize != null) {
      leaderBoardUseMaxFontSize = sharedPreferenceLeaderBoardUseMaxFontSize;
    }

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

    sessionTypeSoundSettings.add(
      _getSessionTypeSoundSetting(sharedPreferences: sharedPreferences, sessionTypeId: SessionTypeId.SESSION_TYPE_ID_PRACTICE, enabledDefault: false),
    );

    sessionTypeSoundSettings.add(
      _getSessionTypeSoundSetting(sharedPreferences: sharedPreferences, sessionTypeId: SessionTypeId.SESSION_TYPE_ID_QUALIFYING, enabledDefault: false),
    );

    sessionTypeSoundSettings.add(
      _getSessionTypeSoundSetting(sharedPreferences: sharedPreferences, sessionTypeId: SessionTypeId.SESSION_TYPE_ID_RACE, enabledDefault: false),
    );

    final eventSpeechSettingsResponse = await eventServiceClient().eventSpeechSettings(
      EventSpeechSettingsRequest(locale: _appModel!.locale.replaceAll('_', '-')),
    );
    eventSpeechSettings = eventSpeechSettingsResponse.items;

    sessionTypeEventSpeechSettingSettings.add(
      _getSessionTypeEventSpeechSettingSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_PRACTICE,
        eventSpeechSettingDefault: eventSpeechSettings.first,
      ),
    );

    sessionTypeEventSpeechTypeSettings.add(
      _getSessionTypeEventSpeechTypeSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_PRACTICE,
        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_POSITION_LEADER,
        lapsDefault: -1,
      ),
    );
    sessionTypeEventSpeechTypeSettings.add(
      _getSessionTypeEventSpeechTypeSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_PRACTICE,
        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_POSITION_GAINED,
        lapsDefault: -1,
      ),
    );
    sessionTypeEventSpeechTypeSettings.add(
      _getSessionTypeEventSpeechTypeSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_PRACTICE,
        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_POSITION_LOST,
        lapsDefault: -1,
      ),
    );
    sessionTypeEventSpeechTypeSettings.add(
      _getSessionTypeEventSpeechTypeSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_PRACTICE,
        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_FASTEST,
        lapsDefault: -1,
      ),
    );
    sessionTypeEventSpeechTypeSettings.add(
      _getSessionTypeEventSpeechTypeSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_PRACTICE,
        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_FASTER,
        lapsDefault: -1,
      ),
    );
    sessionTypeEventSpeechTypeSettings.add(
      _getSessionTypeEventSpeechTypeSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_PRACTICE,
        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_GAP_AFTER,
        lapsDefault: -1,
      ),
    );
    sessionTypeEventSpeechTypeSettings.add(
      _getSessionTypeEventSpeechTypeSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_PRACTICE,
        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_GAP_BEFORE,
        lapsDefault: 0,
      ),
    );
    sessionTypeEventSpeechTypeSettings.add(
      _getSessionTypeEventSpeechTypeSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_PRACTICE,
        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_GAP_NEAREST,
        lapsDefault: 0,
      ),
    );
    sessionTypeEventSpeechTypeSettings.add(
      _getSessionTypeEventSpeechTypeSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_PRACTICE,
        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_AVERAGE_LAP,
        lapsDefault: 0,
      ),
    );
    sessionTypeEventSpeechTypeSettings.add(
      _getSessionTypeEventSpeechTypeSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_PRACTICE,
        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_LAP,
        lapsDefault: 1,
      ),
    );

    sessionTypeEventSpeechSettingSettings.add(
      _getSessionTypeEventSpeechSettingSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_QUALIFYING,
        eventSpeechSettingDefault: eventSpeechSettings.first,
      ),
    );

    sessionTypeEventSpeechTypeSettings.add(
      _getSessionTypeEventSpeechTypeSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_QUALIFYING,
        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_POSITION_LEADER,
        lapsDefault: -1,
      ),
    );
    sessionTypeEventSpeechTypeSettings.add(
      _getSessionTypeEventSpeechTypeSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_QUALIFYING,
        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_POSITION_GAINED,
        lapsDefault: -1,
      ),
    );
    sessionTypeEventSpeechTypeSettings.add(
      _getSessionTypeEventSpeechTypeSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_QUALIFYING,
        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_POSITION_LOST,
        lapsDefault: -1,
      ),
    );
    sessionTypeEventSpeechTypeSettings.add(
      _getSessionTypeEventSpeechTypeSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_QUALIFYING,
        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_FASTEST,
        lapsDefault: -1,
      ),
    );
    sessionTypeEventSpeechTypeSettings.add(
      _getSessionTypeEventSpeechTypeSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_QUALIFYING,
        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_FASTER,
        lapsDefault: -1,
      ),
    );
    sessionTypeEventSpeechTypeSettings.add(
      _getSessionTypeEventSpeechTypeSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_QUALIFYING,
        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_GAP_AFTER,
        lapsDefault: 0,
      ),
    );
    sessionTypeEventSpeechTypeSettings.add(
      _getSessionTypeEventSpeechTypeSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_QUALIFYING,
        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_GAP_BEFORE,
        lapsDefault: 0,
      ),
    );
    sessionTypeEventSpeechTypeSettings.add(
      _getSessionTypeEventSpeechTypeSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_QUALIFYING,
        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_GAP_NEAREST,
        lapsDefault: 0,
      ),
    );
    sessionTypeEventSpeechTypeSettings.add(
      _getSessionTypeEventSpeechTypeSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_QUALIFYING,
        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_AVERAGE_LAP,
        lapsDefault: 0,
      ),
    );
    sessionTypeEventSpeechTypeSettings.add(
      _getSessionTypeEventSpeechTypeSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_QUALIFYING,
        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_LAP,
        lapsDefault: 1,
      ),
    );

    sessionTypeEventSpeechSettingSettings.add(
      _getSessionTypeEventSpeechSettingSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_RACE,
        eventSpeechSettingDefault: eventSpeechSettings.first,
      ),
    );

    sessionTypeEventSpeechTypeSettings.add(
      _getSessionTypeEventSpeechTypeSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_RACE,
        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_POSITION_LEADER,
        lapsDefault: -1,
      ),
    );
    sessionTypeEventSpeechTypeSettings.add(
      _getSessionTypeEventSpeechTypeSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_RACE,
        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_POSITION_GAINED,
        lapsDefault: -1,
      ),
    );
    sessionTypeEventSpeechTypeSettings.add(
      _getSessionTypeEventSpeechTypeSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_RACE,
        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_POSITION_LOST,
        lapsDefault: -1,
      ),
    );
    sessionTypeEventSpeechTypeSettings.add(
      _getSessionTypeEventSpeechTypeSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_RACE,
        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_FASTEST,
        lapsDefault: -1,
      ),
    );
    sessionTypeEventSpeechTypeSettings.add(
      _getSessionTypeEventSpeechTypeSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_RACE,
        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_FASTER,
        lapsDefault: -1,
      ),
    );
    sessionTypeEventSpeechTypeSettings.add(
      _getSessionTypeEventSpeechTypeSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_RACE,
        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_GAP_AFTER,
        lapsDefault: 3,
      ),
    );
    sessionTypeEventSpeechTypeSettings.add(
      _getSessionTypeEventSpeechTypeSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_RACE,
        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_GAP_BEFORE,
        lapsDefault: 3,
      ),
    );
    sessionTypeEventSpeechTypeSettings.add(
      _getSessionTypeEventSpeechTypeSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_RACE,
        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_GAP_NEAREST,
        lapsDefault: 0,
      ),
    );
    sessionTypeEventSpeechTypeSettings.add(
      _getSessionTypeEventSpeechTypeSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_RACE,
        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_AVERAGE_LAP,
        lapsDefault: 5,
      ),
    );
    sessionTypeEventSpeechTypeSettings.add(
      _getSessionTypeEventSpeechTypeSetting(
        sharedPreferences: sharedPreferences,
        sessionTypeId: SessionTypeId.SESSION_TYPE_ID_RACE,
        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_LAP,
        lapsDefault: 0,
      ),
    );
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
        } else if (connectionState == grpc.ConnectionState.idle) {
          connectionStreamController.add(false);
        }
      },
      onDone: () => debugPrint('clientChannel done'),
      onError: (exception) {
        debugPrint("clientChannel $exception");
      },
    );

    eventId = id;

    await eventSubscribe();
  }

  Future<void> releaseEvent() async {
    eventProto = null;
    followEventUserId = "";
    followEventUserIds = [];
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
    followEventUserIds = [];
    if (eventUserId == "") {
      await _eventSpeechUnsubscribe();
    } else {
      followEventUserIds = [eventUserId];
      if (sessionTypeSoundSettings.where((x) => x.sessionTypeId == sessionTypeId2).singleOrNull!.enabled && soundToggleEnabled) {
        await _eventSpeechSubscribe();
      }
    }
    notifyListeners();
  }

  Future<void> leaderBoardUseMaxFontSizeNotify(bool value) async {
    leaderBoardUseMaxFontSize = value;

    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('leaderBoardUseMaxFontSize', value);

    notifyListeners();
  }

  Future<void> driverboardDriverBoardSelectionNotify(DriverBoardSelection value) async {
    driverBoardSelection = value;

    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('driverBoardSelection', driverBoardSelection.name);

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

  bool get soundToggleEnabled {
    return followEventUserId != "";
  }

  Future<void> _eventSpeechSubscribe() async {
    debugPrint("eventSpeechSubscribe...");

    if (!sessionTypeSoundSettings.where((x) => x.sessionTypeId == sessionTypeId2).singleOrNull!.enabled || !soundToggleEnabled) {
      return;
    }

    if (_eventSpeechStreamSubscription != null) {
      await _eventSpeechStreamSubscription!.cancel();
    }

    final eventSpeechSetting = sessionTypeEventSpeechSettingSettings.where((x) => x.sessionTypeId == sessionTypeId2).singleOrNull!.eventSpeechSetting;

    _eventSpeechStreamSubscription = eventServiceClient()
        .eventSpeechSubscribe(
          EventSpeechSubscribeRequest(
            eventId: eventProto!.id,
            eventUserId: followEventUserId,
            locale: eventSpeechSetting.locale,
            localName: eventSpeechSetting.localName,
            eventSpeechTypeOptions: sessionTypeEventSpeechTypeSettings
                .where((x) => x.sessionTypeId == sessionTypeId2 && x.laps != 0)
                .map(
                  (x) => EventSpeechTypeOption(
                    eventSpeechTypeId: x.eventSpeechTypeId,
                    laps: x.laps != 0 ? UInt32Value(value: x.laps.abs()) : null,
                  ),
                ),
          ),
        )
        .listen(
          (data) {
            if (data.speech.value.isNotEmpty) {
              _audioPlayer ??= AudioPlayer();
              if (_audioPlayer!.state != PlayerState.playing) {
                // https://github.com/bluefireteam/audioplayers/issues/1269
                //_audioPlayer!.play(UrlSource(Uri.dataFromBytes(Uint8List.fromList(data.speech.value), mimeType: "audio/mpeg").toString()));
                //_audioPlayer!.play(UrlSource("https://luan.xyz/files/audio/nasa_on_a_mission.mp3"));
                _audioPlayer!.play(BytesSource(Uint8List.fromList(data.speech.value)));
              }
            }
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

  SessionTypeSoundSetting _getSessionTypeSoundSetting({
    required SharedPreferences sharedPreferences,
    required SessionTypeId sessionTypeId,
    required bool enabledDefault,
  }) {
    bool enabled = enabledDefault;
    final enabledValue = sharedPreferences.getBool("${sessionTypeId.name}_sound");
    if (enabledValue != null) {
      enabled = enabledValue;
    }

    return SessionTypeSoundSetting(sessionTypeId: sessionTypeId, enabled: enabled);
  }

  Future<void> setSessionTypeSoundSetting({required SessionTypeId sessionTypeId, required bool enabled}) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setBool("${sessionTypeId.name}_sound", enabled);

    final sessionTypeSoundSetting = sessionTypeSoundSettings.where((x) => x.sessionTypeId == sessionTypeId).singleOrNull;
    if (sessionTypeSoundSetting != null) {
      sessionTypeSoundSetting.enabled = enabled;

      if (enabled && soundToggleEnabled) {
        await _eventSpeechSubscribe();
      } else {
        await _eventSpeechUnsubscribe();
      }

      notifyListeners();
    }
  }

  bool get soundEnabled {
    return sessionTypeSoundSettings.where((x) => x.sessionTypeId == sessionTypeId2).singleOrNull!.enabled;
  }

  Future<void> soundEnabledNotify(bool value) async {
    await setSessionTypeSoundSetting(sessionTypeId: sessionTypeId2, enabled: value);
  }

  SessionTypeEventSpeechSettingSetting _getSessionTypeEventSpeechSettingSetting({
    required SharedPreferences sharedPreferences,
    required SessionTypeId sessionTypeId,
    required EventSpeechSettings eventSpeechSettingDefault,
  }) {
    EventSpeechSettings eventSpeechSetting = eventSpeechSettingDefault;
    final eventSpeechSettingLocaleValue = sharedPreferences.getString("${sessionTypeId.name}_locale");
    final eventSpeechSettingLocalNameValue = sharedPreferences.getString("${sessionTypeId.name}_local_name");
    if (eventSpeechSettingLocaleValue != null && eventSpeechSettingLocalNameValue != null) {
      final eventSpeechSettingSetting = eventSpeechSettings
          .where((x) => x.locale == eventSpeechSettingLocaleValue && x.localName == eventSpeechSettingLocalNameValue)
          .singleOrNull;
      if (eventSpeechSettingSetting != null) {
        eventSpeechSetting = eventSpeechSettingSetting;
      }
    }

    return SessionTypeEventSpeechSettingSetting(sessionTypeId: sessionTypeId, eventSpeechSetting: eventSpeechSetting);
  }

  Future<void> setSessionTypeEventSpeechSettingSetting({required SessionTypeId sessionTypeId, required EventSpeechSettings eventSpeechSetting}) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("${sessionTypeId.name}_locale", eventSpeechSetting.locale);
    sharedPreferences.setString("${sessionTypeId.name}_local_name", eventSpeechSetting.localName);

    final sessionTypeEventSpeechSettingSetting = sessionTypeEventSpeechSettingSettings.where((x) => x.sessionTypeId == sessionTypeId).singleOrNull;
    if (sessionTypeEventSpeechSettingSetting != null) {
      sessionTypeEventSpeechSettingSetting.eventSpeechSetting = eventSpeechSetting;
      await _eventSpeechSubscribe();
      notifyListeners();
    }
  }

  SessionTypeEventSpeechTypeSetting _getSessionTypeEventSpeechTypeSetting({
    required SharedPreferences sharedPreferences,
    required SessionTypeId sessionTypeId,
    required EventSpeechTypeId eventSpeechTypeId,
    required int lapsDefault,
  }) {
    int laps = lapsDefault;
    final lapsValue = sharedPreferences.getInt("${sessionTypeId.name}_${eventSpeechTypeId.name}_laps");
    if (lapsValue != null) {
      laps = lapsValue;
    }

    return SessionTypeEventSpeechTypeSetting(sessionTypeId: sessionTypeId, eventSpeechTypeId: eventSpeechTypeId, laps: laps);
  }

  Future<void> setSessionTypeEventSpeechTypeSetting({
    required SessionTypeId sessionTypeId,
    required EventSpeechTypeId eventSpeechTypeId,
    required int laps,
  }) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setInt("${sessionTypeId.name}_${eventSpeechTypeId.name}_laps", laps);

    final sessionTypeEventSpeechTypeSetting = sessionTypeEventSpeechTypeSettings
        .where((x) => x.sessionTypeId == sessionTypeId && x.eventSpeechTypeId == eventSpeechTypeId)
        .singleOrNull;
    if (sessionTypeEventSpeechTypeSetting != null) {
      sessionTypeEventSpeechTypeSetting.laps = laps;
      await _eventSpeechSubscribe();
      notifyListeners();
    }
  }
}

class SessionTypeSoundSetting {
  SessionTypeSoundSetting({required this.sessionTypeId, required this.enabled});

  final SessionTypeId sessionTypeId;
  bool enabled = false;
}

class SessionTypeEventSpeechSettingSetting {
  SessionTypeEventSpeechSettingSetting({required this.sessionTypeId, required this.eventSpeechSetting});

  final SessionTypeId sessionTypeId;
  EventSpeechSettings eventSpeechSetting;
}

class SessionTypeEventSpeechTypeSetting {
  SessionTypeEventSpeechTypeSetting({required this.sessionTypeId, required this.eventSpeechTypeId, required this.laps});

  final SessionTypeId sessionTypeId;
  final EventSpeechTypeId eventSpeechTypeId;
  int laps;
}
