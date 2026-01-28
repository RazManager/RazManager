import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../app_drawer.dart';
import '../../app_model.dart';
import '../../app_progress_indicator.dart';
import '../../utilities/exception_message.dart';
import '../../utilities/loading.dart';
import 'public_event.model.dart';
import '../public_mixin.dart';

class PublicEvent extends StatefulWidget {
  const PublicEvent({super.key, required this.id});

  final String id;

  @override
  State<PublicEvent> createState() => _PublicEventState();
}

class _PublicEventState extends State<PublicEvent> with ExceptionMessage {
  StreamSubscription<String>? _exceptionStreamSubscription;
  late final EventModel eventModel;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();

    _exceptionStreamSubscription = context.read<AppModel>().exceptionStreamController.stream.listen((message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$runtimeType $message"), duration: const Duration(seconds: 10)));
    });

    eventModel = context.read<EventModel>();
    eventModel.refreshEvent(context: context, id: widget.id);
  }

  @override
  void dispose() {
    if (_exceptionStreamSubscription != null) {
      Future.microtask(_exceptionStreamSubscription!.cancel);
    }

    Future.microtask(eventModel.releaseEvent);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EventModel>(builder: (context, _, __) {
      if (eventModel.eventProto != null) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text(eventModel.eventProto!.name),
              flexibleSpace: const AppProgressIndicator(),
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  tooltip: 'Settings',
                  onPressed: () => context.push('/public/event-settings'),
                ),
                Consumer<EventModel>(builder: (context, model, _) {
                  if (!model.soundEnabled) {
                    return IconButton(
                        icon: const Icon(Icons.volume_off),
                        tooltip: 'Sound on',
                        onPressed: !model.soundEnabledToggleEnabled
                            ? null
                            : () async {
                                await model.soundEnabledNotify(true);
                              });
                  } else {
                    return IconButton(
                        tooltip: 'Sound off',
                        icon: const Icon(Icons.volume_mute),
                        onPressed: () async {
                          await model.soundEnabledNotify(false);
                        });
                  }
                }),
              ],
              bottom: const TabBar(tabs: [Tab(text: 'Races'), Tab(text: 'Event leaderboard')]),
            ),
            body: TabBarView(children: [_PublicEventRaces(), const Text('Event leaderboard...')]),
            drawer: const AppDrawer(),
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            flexibleSpace: const AppProgressIndicator(),
          ),
          body: const Center(child: Loading()),
          drawer: const AppDrawer(),
        );
      }
    });
  }
}

class _PublicEventRaces extends StatefulWidget {
  @override
  State<_PublicEventRaces> createState() => _PublicEventRacesState();
}

class _PublicEventRacesState extends State<_PublicEventRaces> with ExceptionMessage, PublicFormatter {
  @override
  Widget build(BuildContext context) {
    final publicEventState = context.findAncestorStateOfType<_PublicEventState>()!;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        itemCount: publicEventState.eventModel.eventProto!.races.length,
        itemBuilder: (context, index) {
          final item = publicEventState.eventModel.eventProto!.races.elementAt(index);
          return ListTile(
            title: Text(raceDisplayName(race: item)),
            subtitle: Text(item.raceStateType.name),
            onTap: () => context.push('/public/races/${item.id}'),
          );
        },
        separatorBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Divider(),
          );
        },
      ),
    );
  }
}
