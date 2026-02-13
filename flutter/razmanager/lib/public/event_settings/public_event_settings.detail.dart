import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

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
                  Expanded(child: const Placeholder())
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
          Expanded(child: TabBarView(children: [_PublicEventSettingsDetailSoundSessionPractice(), _PublicEventSettingsDetailSoundSessionQualifying(), _PublicEventSettingsDetailSoundSessionRace()])),
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
    final s = sessionTypeId;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<EventModel>(
          builder: (context, model, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownMenu(
                label: Text('Voice'),
                inputDecorationTheme: InputDecorationTheme(enabledBorder: null),
                initialSelection: model.eventSpeechSetting,
                dropdownMenuEntries: model.eventSpeechSettings.map((x) => DropdownMenuEntry(value: x, label: "${x.localName} - ${x.localeName}")).toList(),
                onSelected: (value) async {
                  if (value != null) {
                    await model.eventSpeechSettingsNotify(value);
                  }
                },
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Switch(
                    value: model.soundEnabled,
                    onChanged: model.soundEnabled || model.soundEnabledToggleEnabled ? (value) => model.soundEnabledNotify(value) : null,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("Sound")),
                  ),
                  const Text(''),
                ],
              ),
              Row(
                children: [
                  Switch(
                    value: model.eventSpeechTypeOptions
                        .where((x) => x.$2.eventSpeechTypeId == EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_POSITION_LEADER)
                        .singleOrNull!
                        .$1,
                    onChanged: null,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("Got into the lead")),
                  ),
                ],
              ),
              Row(
                children: [
                  Switch(
                    value: model.eventSpeechTypeOptions
                        .where((x) => x.$2.eventSpeechTypeId == EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_POSITION_GAINED)
                        .singleOrNull!
                        .$1,
                    onChanged: null,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("Gained position")),
                  ),
                ],
              ),
              Row(
                children: [
                  Switch(
                    value: model.eventSpeechTypeOptions
                        .where((x) => x.$2.eventSpeechTypeId == EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_POSITION_LOST)
                        .singleOrNull!
                        .$1,
                    onChanged: null,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("Lost position")),
                  ),
                  const Text(''),
                ],
              ),
              Row(
                children: [
                  Switch(
                    value: model.eventSpeechTypeOptions.where((x) => x.$2.eventSpeechTypeId == EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_FASTEST).singleOrNull!.$1,
                    onChanged: null,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("Fastest overall lap")),
                  ),
                ],
              ),
              Row(
                children: [
                  Switch(
                    value: model.eventSpeechTypeOptions.where((x) => x.$2.eventSpeechTypeId == EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_FASTER).singleOrNull!.$1,
                    onChanged: null,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("Fastest personal lap")),
                  ),
                ],
              ),
              Row(
                children: [
                  Switch(
                    value: model.eventSpeechTypeOptions.where((x) => x.$2.eventSpeechTypeId == EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_GAP_AFTER).singleOrNull!.$1,
                    onChanged: null,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: SizedBox(width: 150, child: Text("Gap after"))),
                  ),
                  const Text('Laps'),
                  Expanded(child: Slider(min: 1, max: 10, divisions: 10, value: model.eventSpeechTypeOptions.where((x) => x.$2.eventSpeechTypeId == EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_GAP_AFTER).singleOrNull!.$2.laps.value.toDouble(), label: 'Laps', onChanged: null)),
                ],
              ),
              Row(
                children: [
                  Switch(
                    value: model.eventSpeechTypeOptions
                        .where((x) => x.$2.eventSpeechTypeId == EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_GAP_BEFORE)
                        .singleOrNull!
                        .$1,
                    onChanged: null,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: SizedBox(width: 150, child: Text("Gap before"))),
                  ),
                  const Text('Laps'),
                  Expanded(child: Slider(min: 1, max: 10, divisions: 10, value: model.eventSpeechTypeOptions.where((x) => x.$2.eventSpeechTypeId == EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_GAP_BEFORE).singleOrNull!.$2.laps.value.toDouble(), label: 'Laps', onChanged: null)),
                ],
              ),
              Row(
                children: [
                  Switch(
                    value: model.eventSpeechTypeOptions
                        .where((x) => x.$2.eventSpeechTypeId == EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_GAP_NEAREST)
                        .singleOrNull!
                        .$1,
                    onChanged: null,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: SizedBox(width: 150, child: Text("Gap to nearest"))),
                  ),
                  const Text('Laps'),
                  Expanded(child: Slider(min: 1, max: 10, divisions: 10, value: model.eventSpeechTypeOptions.where((x) => x.$2.eventSpeechTypeId == EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_GAP_NEAREST).singleOrNull!.$2.laps.value.toDouble(), label: 'Laps', onChanged: null)),
                ],
              ),
              Row(
                children: [
                  Switch(
                    value: model.eventSpeechTypeOptions
                        .where((x) => x.$2.eventSpeechTypeId == EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_AVERAGE_LAP)
                        .singleOrNull!
                        .$1,
                    onChanged: null,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: SizedBox(width: 150, child: Text("Average lap time"))),
                  ),
                  const Text('Laps'),
                  Expanded(child: Slider(min: 1, max: 10, divisions: 10, value: model.eventSpeechTypeOptions.where((x) => x.$2.eventSpeechTypeId == EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_AVERAGE_LAP).singleOrNull!.$2.laps.value.toDouble(), label: 'Laps', onChanged: null)),
                ],
              ),
              Row(
                children: [
                  Switch(
                    value: model.eventSpeechTypeOptions.where((x) => x.$2.eventSpeechTypeId == EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_LAP).singleOrNull!.$1,
                    onChanged: null,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: SizedBox(width: 150, child: Text("Last lap time"))),
                  ),
                  const Text('Laps'),
                  Expanded(child: Slider(min: 1, max: 10, divisions: 10, value: model.eventSpeechTypeOptions.where((x) => x.$2.eventSpeechTypeId == EventSpeechTypeId.EVENT_SPEECH_TYPE_ID_LAP).singleOrNull!.$2.laps.value.toDouble(), label: 'Laps', onChanged: null)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _PublicEventSettingsDetailSoundSessionPractice extends  _PublicEventSettingsDetailSoundSessionBase {
  const _PublicEventSettingsDetailSoundSessionPractice() : super(sessionTypeId: SessionTypeId.SESSION_TYPE_ID_PRACTICE);
}

class _PublicEventSettingsDetailSoundSessionQualifying extends  _PublicEventSettingsDetailSoundSessionBase {
  const _PublicEventSettingsDetailSoundSessionQualifying() : super(sessionTypeId: SessionTypeId.SESSION_TYPE_ID_QUALIFYING);
}

class _PublicEventSettingsDetailSoundSessionRace extends  _PublicEventSettingsDetailSoundSessionBase {
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
                const Text("Select which drivers/teams that should be shown on the event's Driverboard."),
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
