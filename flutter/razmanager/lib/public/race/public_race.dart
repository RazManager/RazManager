import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../app_model.dart';
import '../../app_progress_indicator.dart';
import '../../protobuf/razmanager/protobuf/public/race.service.v1.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/public/race.v1.pb.dart';
import '../../utilities/exception_message.dart';
import '../../utilities/intent.dart';
import '../../utilities/loading.dart';
import '../event/public_event.model.dart';
import '../public_mixin.dart';
import 'public_race.model.dart';
import 'public_race_child_base.dart';
import 'public_race_leaderboard.dart';

class PublicRace extends StatefulWidget {
  const PublicRace({super.key, required this.id});

  final String id;

  @override
  State<PublicRace> createState() => PublicRaceState();
}

class PublicRaceState extends State<PublicRace> {
  late String id;

  @override
  void initState() {
    super.initState();

    id = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RaceStateModel(),
      child: ChangeNotifierProvider(
        create: (context) => RaceStateHeaderModel(),
        child: ChangeNotifierProvider(
          create: (context) => RaceLeaderboardModel(),
            child: SafeArea(child: PublicRaceChild(id: id)),
          ),
        )
      );
  }
}



class PublicRaceChild extends PublicRaceChildBase {
  const PublicRaceChild({super.key, required super.id});

  @override
  State createState() => PublicRaceChildState();
}

class PublicRaceChildState extends PublicRaceChildStateBase with ExceptionMessage, PublicFormatter {
  @override
  void raceRefreshed({required RaceModel raceModel}) {
    super.raceRefreshed(raceModel: raceModel);

    if (raceLeaderboardStreamSubscription != null) {
      Future.microtask(() async {
        await raceLeaderboardStreamSubscription!.cancel();
        raceLeaderboardStreamSubscription = null;
        await raceLeaderboardSubscribe();
      });
    }
  }

  Future<void> raceCommand(RaceCommandTypeId raceCommandTypeId) async {
    final appModel = context.read<AppModel>();
    appModel.setBusy(value: true, notify: true);
    try {
      await raceModel.raceServiceClient().command(RaceCommandRequest(id: widget.id, raceCommandTypeId: raceCommandTypeId));
    } on Exception catch (exception) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(exceptionMessage(exception)), duration: const Duration(seconds: 10)));
    } finally {
      appModel.setBusy(value: false, notify: true);
    }
  }

  bool raceCommandStartEnabled() {
    return raceModel.raceProto!.raceStateType.id == RaceStateTypeId.RACE_STATE_TYPE_ID_PENDING ||
        raceModel.raceProto!.raceStateType.id == RaceStateTypeId.RACE_STATE_TYPE_ID_PAUSED;
  }

  bool raceCommandPauseEnabled() {
    return raceModel.raceProto!.raceStateType.id == RaceStateTypeId.RACE_STATE_TYPE_ID_STARTED;
  }

  bool raceCommandEndEnabled() {
    return raceModel.raceProto!.raceStateType.id == RaceStateTypeId.RACE_STATE_TYPE_ID_STARTED ||
        raceModel.raceProto!.raceStateType.id == RaceStateTypeId.RACE_STATE_TYPE_ID_PAUSED;
  }

  bool raceCommandResetEnabled() {
    return raceModel.raceProto!.raceStateType.id == RaceStateTypeId.RACE_STATE_TYPE_ID_STARTED ||
        raceModel.raceProto!.raceStateType.id == RaceStateTypeId.RACE_STATE_TYPE_ID_PAUSED ||
        raceModel.raceProto!.raceStateType.id == RaceStateTypeId.RACE_STATE_TYPE_ID_ENDED;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RaceModel>(
      builder: (context, raceModel, __) {
        if (raceModel.raceProto != null) {
          if (!initiated) {
            //debugPrint("Calling heatRefreshed ${heatModel.heatId} ${publicHeatState.id} $initiated");
            raceRefreshed(raceModel: raceModel);
          }
          return Actions(
            actions: {
              CloseIntent: CallbackAction<CloseIntent>(
                onInvoke: (intent) {
                  context.pop();
                  return;
                },
              ),
            },
            child: DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(raceDisplayName(event: eventModel.eventProto, race: raceModel.raceProto!)),
                  flexibleSpace: const AppProgressIndicator(),
                  actions: [
                    IconButton(icon: const Icon(Icons.settings), tooltip: 'Settings', onPressed: () => context.push('/public/events/event-settings')),
                    Consumer<EventModel>(
                      builder: (context, model, _) {
                        if (!model.soundEnabled) {
                          return IconButton(
                            icon: const Icon(Icons.volume_off),
                            tooltip: 'Sound on',
                            onPressed: !model.soundToggleEnabled
                                ? null
                                : () async {
                                    await model.soundEnabledNotify(true);
                                  },
                          );
                        } else {
                          return IconButton(
                            tooltip: 'Sound off',
                            icon: const Icon(Icons.volume_mute),
                            onPressed: () async {
                              await model.soundEnabledNotify(false);
                            },
                          );
                        }
                      },
                    ),
                  ],
                  bottom: const TabBar(
                    tabs: [
                      Tab(text: 'Heats'),
                      Tab(text: 'Race leaderboard'),
                      Tab(text: 'Race summary'),
                    ],
                  ),
                ),
                body: Focus(
                  autofocus: true,
                  child: TabBarView(
                    children: [
                      _PublicRaceHeats(),
                      PublicRaceLeaderboard(),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("This space will be used by the race summary, i.e. a live textual summary of all heats/segments for a race."),
                            const SizedBox(height: 16),
                            Expanded(child: const Placeholder()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                bottomNavigationBar: raceModel.raceCommandPermissions.isNotEmpty ? _RaceBottomNavigationBar() : null,
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(flexibleSpace: const AppProgressIndicator()),
            body: const Center(child: Loading()),
          );
        }
      },
    );
  }
}

class _PublicRaceHeats extends StatefulWidget {
  @override
  State<_PublicRaceHeats> createState() => _PublicRaceHeatsState();
}

class _PublicRaceHeatsState extends State<_PublicRaceHeats> with ExceptionMessage, PublicFormatter {
  @override
  Widget build(BuildContext context) {
    final publicRaceChildState = context.findAncestorStateOfType<PublicRaceChildState>()!;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        itemCount: publicRaceChildState.raceModel.raceProto!.heats.length,
        itemBuilder: (context, index) {
          final item = publicRaceChildState.raceModel.raceProto!.heats.elementAt(index);
          return ListTile(
            title: Text(heatDisplayName(heat: item)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.heatStateType.name),
                SizedBox(height: 8),
                ...item.heatIndicators.map((x) {
                  final eventUser = publicRaceChildState.eventModel.eventProto!.eventUsers.where((eventUser) => eventUser.id == x.eventUserId).singleOrNull;
                  return Row(children: [Text(x.indicatorId.toString()), const SizedBox(width: 16), Text(eventUser?.name.value ?? '?')]);
                }),
              ],
            ),
            trailing: publicRaceChildState.raceModel.raceCommandPermissions.isEmpty ? null : TextButton(
              child: const Text('Leaderboard green screen'),
              onPressed: () => context.push('/public/heats-greenscreen/${item.id}'),
            ),
            onTap: () => context.push('/public/heats/${item.id}'),
          );
        },
        separatorBuilder: (context, index) {
          return const Padding(padding: EdgeInsets.only(left: 16, right: 16), child: Divider());
        },
      ),
    );
  }
}

class _RaceBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final publicRaceChildState = context.findAncestorStateOfType<PublicRaceChildState>()!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton.filledTonal(
            icon: const Icon(Icons.play_arrow),
            onPressed: publicRaceChildState.raceCommandStartEnabled() ? () => publicRaceChildState.raceCommand(RaceCommandTypeId.RACE_COMMAND_TYPE_ID_START) : null,
          ),
          const SizedBox(width: 16),
          IconButton.filledTonal(
            icon: const Icon(Icons.pause),
            onPressed: publicRaceChildState.raceCommandPauseEnabled() ? () => publicRaceChildState.raceCommand(RaceCommandTypeId.RACE_COMMAND_TYPE_ID_PAUSE) : null,
          ),
          const SizedBox(width: 16),
          IconButton.filledTonal(
            icon: const Icon(Icons.done),
            onPressed: publicRaceChildState.raceCommandEndEnabled() ? () => publicRaceChildState.raceCommand(RaceCommandTypeId.RACE_COMMAND_TYPE_ID_END) : null,
          ),
          const SizedBox(width: 16),
          IconButton.filledTonal(
            icon: const Icon(Icons.replay),
            onPressed: publicRaceChildState.raceCommandResetEnabled() ? () => publicRaceChildState.raceCommand(RaceCommandTypeId.RACE_COMMAND_TYPE_ID_RESET) : null,
          ),
        ],
      ),
    );
  }
}
