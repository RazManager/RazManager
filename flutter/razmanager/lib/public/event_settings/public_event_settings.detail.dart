import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../utilities/intent.dart';
import '../event/public_event.model.dart';

class PublicEventSettingsDetail extends StatelessWidget {
  const PublicEventSettingsDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: {
        CloseIntent: CallbackAction<CloseIntent>(onInvoke: (intent) {
          context.pop();
          return;
        }),
      },
      child: Focus(
        autofocus: true,
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              title: Text("Event display settings"),
              bottom: TabBar(tabs: [const Tab(text: "Follow"), const Tab(text: "Sound"), const Tab(text: "Leaderboard"), const Tab(text: "Driverboard")]),
            ),
            body: TabBarView(children: [
              _PublicEventSettingsDetailFollow(),
              _PublicEventSettingsDetailSound(),
              const Text("Leaderboard"),
              _PublicEventSettingsDetailDriverBoard(),
            ]),
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
                ...model.eventProto!.eventUsers.map((x) => RadioListTile(value: x.id, title: Text(x.name.value)))
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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Consumer<EventModel>(
        builder: (context, model, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Table(
                defaultColumnWidth: IntrinsicColumnWidth(),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(children: [
                    const Text("Sound  "),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Switch(
                          value: model.soundEnabled,
                          onChanged: model.soundEnabled || model.soundEnabledToggleEnabled ? (value) => model.soundEnabledNotify(value) : null),
                    ),
                  ]),
                  TableRow(
                    children: [
                      const Text("Voice  "),
                      DropdownMenu(
                          inputDecorationTheme: InputDecorationTheme(enabledBorder: null),
                          initialSelection: model.eventSpeechSetting,
                          dropdownMenuEntries:
                              model.eventSpeechSettings.map((x) => DropdownMenuEntry(value: x, label: "${x.localName} - ${x.localeName}")).toList(),
                          onSelected: (value) async {
                            if (value != null) {
                              await model.eventSpeechSettingsNotify(value);
                            }
                          })
                    ],
                  )
                ]),
          ],
        ),
      ),
    );
  }
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
                      ...model.eventProto!.eventUsers.map((x) => CheckboxListTile(
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
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
