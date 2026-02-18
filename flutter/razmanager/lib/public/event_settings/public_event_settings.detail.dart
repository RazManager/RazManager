import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../protobuf/razmanager/protobuf/public/event_speech_type_id.v1.pbenum.dart';
import '../../protobuf/razmanager/protobuf/public/session_type_id.v1.pbenum.dart';
import '../../utilities/intent.dart';
import '../event/public_event.model.dart';

class PublicEventSettingsDetail extends StatelessWidget {
  const PublicEventSettingsDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: {
        CloseIntent: CallbackAction<CloseIntent>(
          onInvoke: (intent) {
            context.pop();
            return;
          },
        ),
      },
      child: Focus(
        autofocus: true,
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              title: Text("Event display settings"),
              bottom: TabBar(
                tabs: [
                  const Tab(text: "Follow"),
                  const Tab(text: "Sound"),
                  const Tab(text: "Leaderboard"),
                  const Tab(text: "Driverboard"),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                _PublicEventSettingsDetailFollow(),
                _PublicEventSettingsDetailSound(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("This space will be used for configuration of the leaderboard."),
                      const SizedBox(height: 16),
                      Expanded(child: const Placeholder()),
                    ],
                  ),
                ),
                _PublicEventSettingsDetailDriverBoard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PublicEventSettingsDetailFollow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //eventUsers.sort((a, b) => a.name.value.compareTo(b.name.value));
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<EventModel>(
          builder: (context, model, _) => RadioGroup<String>(
            groupValue: model.followEventUserId,
            onChanged: (value) async {
              if (value != null) {
                await model.followEventUserIdNotify(value);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Select which driver/team that should be used for sound, and that should be pre-selected on various views."),
                RadioListTile(value: "", title: Text("Don't follow any specific driver/team")),
                ...model.eventProto!.eventUsers.map((x) => RadioListTile(value: x.id, title: Text(x.name.value))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PublicEventSettingsDetailSound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 2,
      child: Column(
        children: [
          const TabBar.secondary(
            tabs: [
              Tab(text: 'Practice'),
              Tab(text: 'Qualifying'),
              Tab(text: 'Race'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _PublicEventSettingsDetailSoundSessionPractice(),
                _PublicEventSettingsDetailSoundSessionQualifying(),
                _PublicEventSettingsDetailSoundSessionRace(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

abstract class _PublicEventSettingsDetailSoundSessionBase extends StatelessWidget {
  const _PublicEventSettingsDetailSoundSessionBase({required this.sessionTypeId});

  final SessionTypeId sessionTypeId;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<EventModel>(
          builder: (context, model, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('General sound options', style: TextStyle(fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize!)),
              SizedBox(height: 8),
              Row(
                children: [
                  Switch(
                    value: model.sessionTypeSoundSettings.where((x) => x.sessionTypeId == sessionTypeId).singleOrNull!.enabled,
                    onChanged: model.sessionTypeSoundSettings.where((x) => x.sessionTypeId == sessionTypeId).singleOrNull!.enabled || model.soundToggleEnabled
                        ? (value) async => await model.setSessionTypeSoundSetting(sessionTypeId: sessionTypeId, enabled: value)
                        : null,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("Sound")),
                  ),
                  const Text(''),
                ],
              ),
              DropdownMenu(
                label: Text('Voice'),
                inputDecorationTheme: InputDecorationTheme(enabledBorder: null),
                initialSelection: model.sessionTypeEventSpeechSettingSettings.where((x) => x.sessionTypeId == sessionTypeId).singleOrNull!.eventSpeechSetting,
                dropdownMenuEntries: model.eventSpeechSettings.map((x) => DropdownMenuEntry(value: x, label: "${x.localName} - ${x.localeName}")).toList(),
                onSelected: (value) async {
                  if (value != null) {
                    await model.setSessionTypeEventSpeechSettingSetting(sessionTypeId: sessionTypeId, eventSpeechSetting: value);
                  }
                },
              ),
              SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 600) {
                    return Column(
                      children: [
                        _PublicEventSettingsDetailSoundSessionNonLapRelated(sessionTypeId: sessionTypeId),
                        SizedBox(height: 16),
                        _PublicEventSettingsDetailSoundSessionLapRelated(sessionTypeId: sessionTypeId),
                      ],
                    );
                  } else {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _PublicEventSettingsDetailSoundSessionNonLapRelated(sessionTypeId: sessionTypeId),
                        SizedBox(width: 32),
                        _PublicEventSettingsDetailSoundSessionLapRelated(sessionTypeId: sessionTypeId),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PublicEventSettingsDetailSoundSessionNonLapRelated extends StatelessWidget {
  const _PublicEventSettingsDetailSoundSessionNonLapRelated({required this.sessionTypeId});

  final SessionTypeId sessionTypeId;

  @override
  Widget build(BuildContext context) {
    return Consumer<EventModel>(
      builder: (context, model, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Non-lap related sound options', style: TextStyle(fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize!)),
          SizedBox(height: 8),
          Table(
            defaultColumnWidth: IntrinsicColumnWidth(),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  Switch(
                    value: model.sessionTypeEventSpeechTypeSettings
                        .where((x) => x.sessionTypeId == sessionTypeId && x.eventSpeechTypeId == EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_POSITION_LEADER)
                        .singleOrNull!
                        .laps != 0,
                    onChanged: (value) async {
                      await model.setSessionTypeEventSpeechTypeSetting(
                        sessionTypeId: sessionTypeId,
                        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_POSITION_LEADER,
                        laps: value ? -1 : 0,
                      );
                    },
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text("Got into the lead")),
                ],
              ),
              TableRow(
                children: [
                  Switch(
                    value: model.sessionTypeEventSpeechTypeSettings
                        .where((x) => x.sessionTypeId == sessionTypeId && x.eventSpeechTypeId == EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_POSITION_GAINED)
                        .singleOrNull!
                        .laps != 0,
                    onChanged: (value) async {
                      await model.setSessionTypeEventSpeechTypeSetting(
                        sessionTypeId: sessionTypeId,
                        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_POSITION_GAINED,
                        laps: value ? -1 : 0,
                      );
                    },
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text("Gained position")),
                ],
              ),
              TableRow(
                children: [
                  Switch(
                    value: model.sessionTypeEventSpeechTypeSettings
                        .where((x) => x.sessionTypeId == sessionTypeId && x.eventSpeechTypeId == EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_POSITION_LOST)
                        .singleOrNull!
                        .laps != 0,
                    onChanged: (value) async {
                      await model.setSessionTypeEventSpeechTypeSetting(
                        sessionTypeId: sessionTypeId,
                        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_POSITION_LOST,
                        laps: value ? -1 : 0,
                      );
                    },
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text("Lost position")),
                ],
              ),
              TableRow(
                children: [
                  Switch(
                    value: model.sessionTypeEventSpeechTypeSettings
                        .where((x) => x.sessionTypeId == sessionTypeId && x.eventSpeechTypeId == EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_FASTEST)
                        .singleOrNull!
                        .laps != 0,
                    onChanged: (value) async {
                      await model.setSessionTypeEventSpeechTypeSetting(
                        sessionTypeId: sessionTypeId,
                        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_FASTEST,
                        laps: value ? -1 : 0,
                      );
                    },
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text("Fastest overall lap")),
                ],
              ),
              TableRow(
                children: [
                  Switch(
                    value: model.sessionTypeEventSpeechTypeSettings
                        .where((x) => x.sessionTypeId == sessionTypeId && x.eventSpeechTypeId == EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_FASTER)
                        .singleOrNull!
                        .laps != 0,
                    onChanged: (value) async {
                      await model.setSessionTypeEventSpeechTypeSetting(
                        sessionTypeId: sessionTypeId,
                        eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_FASTER,
                        laps: value ? -1 : 0,
                      );
                    },
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text("Fastest personal lap")),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PublicEventSettingsDetailSoundSessionLapRelated extends StatelessWidget {
  const _PublicEventSettingsDetailSoundSessionLapRelated({required this.sessionTypeId});

  final SessionTypeId sessionTypeId;

  @override
  Widget build(BuildContext context) => Consumer<EventModel>(
    builder: (context, model, _) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Lap related sound options', style: TextStyle(fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize!)),
        SizedBox(height: 8),
        DropdownMenuLap(
          labelText: "Gap after",
          getSelection: model.sessionTypeEventSpeechTypeSettings
              .where((x) => x.sessionTypeId == sessionTypeId && x.eventSpeechTypeId == EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_GAP_AFTER)
              .singleOrNull!
              .laps,
          setSelection: (value) async => await model.setSessionTypeEventSpeechTypeSetting(
            sessionTypeId: sessionTypeId,
            eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_GAP_AFTER,
            laps: value,
          ),
        ),
        SizedBox(height: 8),
        DropdownMenuLap(
          labelText: "Gap before (not yet functional)",
          getSelection: model.sessionTypeEventSpeechTypeSettings
              .where((x) => x.sessionTypeId == sessionTypeId && x.eventSpeechTypeId == EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_GAP_BEFORE)
              .singleOrNull!
              .laps,
          setSelection: (value) async => await model.setSessionTypeEventSpeechTypeSetting(
            sessionTypeId: sessionTypeId,
            eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_GAP_BEFORE,
            laps: value,
          ),
        ),
        SizedBox(height: 8),
        DropdownMenuLap(
          labelText: "Gap to nearest (not yet functional)",
          getSelection: model.sessionTypeEventSpeechTypeSettings
              .where((x) => x.sessionTypeId == sessionTypeId && x.eventSpeechTypeId == EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_GAP_NEAREST)
              .singleOrNull!
              .laps,
          setSelection: (value) async => await model.setSessionTypeEventSpeechTypeSetting(
            sessionTypeId: sessionTypeId,
            eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_GAP_NEAREST,
            laps: value,
          ),
        ),
        SizedBox(height: 8),
        DropdownMenuLap(
          labelText: "Average lap time",
          getSelection: model.sessionTypeEventSpeechTypeSettings
              .where((x) => x.sessionTypeId == sessionTypeId && x.eventSpeechTypeId == EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_AVERAGE_LAP)
              .singleOrNull!
              .laps,
          setSelection: (value) async => await model.setSessionTypeEventSpeechTypeSetting(
            sessionTypeId: sessionTypeId,
            eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_AVERAGE_LAP,
            laps: value,
          ),
        ),
        SizedBox(height: 8),
        DropdownMenuLap(
          labelText: "Last lap time",
          getSelection: model.sessionTypeEventSpeechTypeSettings
              .where((x) => x.sessionTypeId == sessionTypeId && x.eventSpeechTypeId == EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_LAP)
              .singleOrNull!
              .laps,
          setSelection: (value) async => await model.setSessionTypeEventSpeechTypeSetting(
            sessionTypeId: sessionTypeId,
            eventSpeechTypeId: EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_LAP,
            laps: value,
          ),
        ),
      ],
    ),
  );
}

class _PublicEventSettingsDetailSoundSessionPractice extends _PublicEventSettingsDetailSoundSessionBase {
  const _PublicEventSettingsDetailSoundSessionPractice() : super(sessionTypeId: SessionTypeId.SESSION_TYPE_ID_PRACTICE);
}

class _PublicEventSettingsDetailSoundSessionQualifying extends _PublicEventSettingsDetailSoundSessionBase {
  const _PublicEventSettingsDetailSoundSessionQualifying() : super(sessionTypeId: SessionTypeId.SESSION_TYPE_ID_QUALIFYING);
}

class _PublicEventSettingsDetailSoundSessionRace extends _PublicEventSettingsDetailSoundSessionBase {
  const _PublicEventSettingsDetailSoundSessionRace() : super(sessionTypeId: SessionTypeId.SESSION_TYPE_ID_RACE);
}

class _PublicEventSettingsDetailDriverBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //eventUsers.sort((a, b) => a.name.value.compareTo(b.name.value));
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<EventModel>(
          builder: (context, model, _) => RadioGroup<DriverBoardSelection>(
            groupValue: model.driverBoardSelection,
            onChanged: (value) async {
              if (value != null) {
                await model.driverboardDriverBoardSelectionNotify(value);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Select which drivers/teams that should be shown on the event's driverboard."),
                RadioListTile(value: DriverBoardSelection.all, title: Text('All')),
                RadioListTile(value: DriverBoardSelection.firsthalf, title: Text('First half')),
                RadioListTile(value: DriverBoardSelection.secondhalf, title: Text('Second half')),
                RadioListTile(value: DriverBoardSelection.individual, title: Text('Individual drivers/teams')),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Column(
                    children: [
                      ...model.eventProto!.eventUsers.map(
                        (x) => CheckboxListTile(
                          value: model.eventUserIds.where((e) => e == x.id).singleOrNull != null,
                          title: Text(x.name.value),
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: model.driverBoardSelection != DriverBoardSelection.individual
                              ? null
                              : (value) {
                                  if (value != null && value) {
                                    model.driverboardEventUserIdsAddNotify(x.id);
                                  } else {
                                    model.driverboardEventUserIdsRemoveNotify(x.id);
                                  }
                                },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DropdownMenuLap extends StatelessWidget {
  const DropdownMenuLap({super.key, required this.labelText, required this.getSelection, required this.setSelection});

  final String labelText;
  final int? getSelection;
  final Future<void> Function(int) setSelection;

  @override
  Widget build(BuildContext context) => DropdownMenu(
    label: Text(labelText),
    inputDecorationTheme: InputDecorationTheme(enabledBorder: null),
    initialSelection: getSelection,
    dropdownMenuEntries: [
      DropdownMenuEntry(value: 0, label: 'No sound'),
      DropdownMenuEntry(value: 1, label: 'Every lap'),
      DropdownMenuEntry(value: 2, label: 'Every 2nd lap'),
      DropdownMenuEntry(value: 3, label: 'Every 3rd lap'),
      DropdownMenuEntry(value: 5, label: 'Every 5th lap'),
      DropdownMenuEntry(value: 10, label: 'Every 10th lap'),
    ],
    onSelected: (value) async {
      if (value != null) {
        await setSelection(value);
      }
    },
  );
}
