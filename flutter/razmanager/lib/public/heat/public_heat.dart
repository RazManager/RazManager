import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../app_progress_indicator.dart';
import '../../utilities/exception_message.dart';
import '../../utilities/intent.dart';
import '../../utilities/loading.dart';
import '../event/public_event.model.dart';
import '../public_mixin.dart';
import '../race/public_race.model.dart';
import 'public_heat.model.dart';
import 'public_heat_child_base.dart';
import 'public_heat_analysis.dart';
import 'public_heat_driverboard.dart';
import 'public_heat_leaderboard.dart';
import 'public_heat_stint.dart';

class PublicHeat extends StatefulWidget {
  const PublicHeat({super.key, required this.id});

  final String id;

  @override
  State<PublicHeat> createState() => PublicHeatState();
}

class PublicHeatState extends State<PublicHeat> {
  late String id;

  @override
  void initState() {
    super.initState();

    id = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HeatStateModel(),
      child: ChangeNotifierProvider(
        create: (context) => HeatStateHeaderModel(),
        child: ChangeNotifierProvider(
          create: (context) => HeatLeaderboardModel(),
          child: ChangeNotifierProvider(
            create: (context) => HeatDriverboardGapModel(),
            child: ChangeNotifierProvider(
              create: (context) => HeatAnnounceModel(),
              child: ChangeNotifierProvider(
                create: (context) => HeatAnalysisLoadingModel(),
                child: ChangeNotifierProvider(
                  create: (context) => HeatStintAnalysisLoadingModel(),
                  child: ChangeNotifierProvider(
                    create: (context) => HeatStintAnalysisListModel(),
                    child: SafeArea(child: PublicHeatChild(id: id)),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PublicHeatChild extends PublicHeatChildBase {
  const PublicHeatChild({super.key, required super.id});

  @override
  State createState() => PublicHeatChildState();
}

class PublicHeatChildState extends PublicHeatChildStateBase with ExceptionMessage, PublicFormatter {
  late PublicHeatState publicHeatState;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();

    publicHeatState = context.findAncestorStateOfType<PublicHeatState>()!;
  }

  @override
  void heatRefreshed({required HeatModel heatModel}) {
    super.heatRefreshed(heatModel: heatModel);

    if (heatLeaderboardStreamSubscription != null) {
      Future.microtask(() async {
        await heatLeaderboardStreamSubscription!.cancel();
        heatLeaderboardStreamSubscription = null;
        await heatLeaderboardSubscribe();
      });
    }

    if (heatAnalysesStreamSubscription != null) {
      Future.microtask(() async {
        await heatAnalysesStreamSubscription!.cancel();
        heatAnalysesStreamSubscription = null;
        await heatAnalysisSubscribe();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HeatModel>(
      builder: (context, heatModel, _) {
        if (heatModel.heatProto != null) {
          if (!initiated) {
            //debugPrint("Calling heatRefreshed ${heatModel.heatId} ${publicHeatState.id} $initiated");
            heatRefreshed(heatModel: heatModel);
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
              length: 5,
              child: LayoutBuilder(
                builder: (context, constraints) => Scaffold(
                  appBar: AppBar(
                    title: Text(
                      constraints.maxWidth > 800
                          ? "${eventModel.eventProto!.name} - ${heatDisplayName(race: raceModel.raceProto, heat: heatModel!.heatProto!)}"
                          : heatDisplayName(race: raceModel.raceProto, heat: heatModel!.heatProto!),
                    ),
                    flexibleSpace: const AppProgressIndicator(),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.settings),
                        tooltip: 'Settings',
                        onPressed: () => context.push('/public/heats/${publicHeatState.id}/event-settings'),
                      ),
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
                      StreamBuilder<bool>(
                        stream: eventModel.connectionStreamController.stream,
                        initialData: true,
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data == true) {
                            return SizedBox.shrink();
                          } else {
                            return Icon(Icons.cloud_off, color: Theme.of(context).colorScheme.error);
                          }
                        },
                      ),
                    ],
                    bottom: TabBar(
                      tabs: [
                        Tab(text: constraints.maxWidth > 800 ? 'Heat leaderboard' : 'Leaderboard'),
                        Tab(text: constraints.maxWidth > 800 ? 'Heat driverboard' : 'Driverboard'),
                        Tab(text: constraints.maxWidth > 800 ? 'Heat analysis' : 'Analysis'),
                        Tab(text: constraints.maxWidth > 800 ? 'Stint analysis' : 'Stints'),
                        Tab(text: constraints.maxWidth > 800 ? 'Heat summary' : 'Summary'),
                        //Tab(text: 'Heat leaderboard stream'),
                      ],
                    ),
                  ),
                  body: Focus(
                    autofocus: true,
                    child: TabBarView(
                      children: [
                        PublicHeatLeaderboard(),
                        PublicHeatDriverboard(),
                        PublicHeatAnalyses(),
                        PublicHeatStint(),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("This space will be used by the heat summary, i.e. a live textual summary of the heat."),
                              const SizedBox(height: 16),
                              Expanded(child: const Placeholder()),
                            ],
                          ),
                        ),

                        //PublicHeatLeaderboardStream(),
                      ],
                    ),
                  ),
                ),
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
