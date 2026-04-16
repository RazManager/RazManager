import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razmanager/protobuf/razmanager/protobuf/public/session_type_id.v1.pbenum.dart';
import 'package:razmanager/public/heat/public_heat_child_base.dart';

import '../../app_model.dart';
import '../../protobuf/razmanager/protobuf/public/event.v1.pb.dart';
import '../../protobuf/razmanager/protobuf/public/race.service.v1.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/public/race.v1.pb.dart';
import '../../protobuf/razmanager/protobuf/public/heat.v1.pb.dart';
import '../../protobuf/razmanager/protobuf/public/race_feature_type_id.v1.pb.dart';
import '../../utilities/exception_message.dart';
import '../../utilities/timer_conversion.dart';
import '../event/public_event.model.dart';
import '../public_mixin.dart';
import 'public_race.model.dart';

abstract class PublicRaceChildBase extends StatefulWidget {
  const PublicRaceChildBase({super.key, required this.id});

  final String id;
}

abstract class PublicRaceChildStateBase extends State<PublicRaceChildBase> with ExceptionMessage, TimerConversion, PublicFormatter {
  late final String id;
  late final AppModel appModel;
  late final EventModel eventModel;
  late final RaceModel raceModel;
  //late final HeatStateModel heatStateModel;
  StreamSubscription<EventState>? eventStateStreamSubscription;
  StreamSubscription<RaceState>? raceStateStreamSubscription;
  StreamSubscription<RaceLeaderboard>? raceLeaderboardStreamSubscription;
  bool initiated = false;

  @override
  void initState() {
    super.initState();
    id = widget.id;
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();

    appModel = context.read<AppModel>();
    eventModel = context.read<EventModel>();
    raceModel = context.read<RaceModel>();

    raceModel.refreshRace(context: context, id: widget.id);
  }

  @override
  void dispose() {
    if (eventStateStreamSubscription != null) {
      Future.microtask(eventStateStreamSubscription!.cancel);
    }

    if (raceStateStreamSubscription != null) {
      Future.microtask(raceStateStreamSubscription!.cancel);
    }

    if (raceLeaderboardStreamSubscription != null) {
      Future.microtask(raceLeaderboardStreamSubscription!.cancel);
    }

    Future.microtask(raceModel.releaseRace);

    super.dispose();
  }

  void raceRefreshed({required RaceModel raceModel}) {
    //debugPrint("heatRefreshed");

    raceClear(raceModel: raceModel);

    Future.microtask(raceStateSubscribe);
  }

  void raceClear({required RaceModel raceModel}) {
    //debugPrint("heatClear");

    initiated = true;
  }

  Future<void> raceStateSubscribe() async {
    if (raceStateStreamSubscription != null) {
      await raceStateStreamSubscription!.cancel();
    }
    raceStateStreamSubscription = raceModel
        .raceServiceClient()
        .raceStateSubscribe(RaceSessionRequest(id: id, sessionTypeId: SessionTypeId.SESSION_TYPE_ID_RACE))
        .listen(
          (data) {
            context.read<RaceStateModel>().notify(data);
            context.read<RaceStateHeaderModel>().notifyRace(data, raceModel.raceProto!);

            if (data.raceStateType.id == RaceStateTypeId.RACE_STATE_TYPE_ID_STARTED) {
              raceClear(raceModel: raceModel);
            }
          },
          //onDone: () => debugPrint('heatStateSubscribe done'),
          onError: (exception) async {
            debugPrint("raceStateSubscribe $exception");
            await eventModel.handleGrpcError(exception);
            await raceStateSubscribe();
          },
        );
  }

  Future<void> raceLeaderboardSubscribe() async {
    //debugPrint("heatLeaderboardSubscribe before check");
    if (raceLeaderboardStreamSubscription != null) {
      return;
    }
    //debugPrint("heatLeaderboardSubscribe after check");

    final raceLeaderboardModel = context.read<RaceLeaderboardModel>();

    raceLeaderboardStreamSubscription = raceModel
        .raceServiceClient()
        .raceLeaderboardSubscribe(RaceSessionRequest(id: id, sessionTypeId: SessionTypeId.SESSION_TYPE_ID_RACE))
        .listen(
          (data) {
            raceLeaderboardModel.notify(data);
          },
          //onDone: () => debugPrint('Done...'),
          onError: (exception) async {
            debugPrint("raceLeaderboardSubscribe $exception");
            await raceLeaderboardStreamSubscription!.cancel();
            raceLeaderboardStreamSubscription = null;
            await eventModel.handleGrpcError(exception);
            await raceLeaderboardSubscribe();
          },
        );
  }

  double calculateRaceUsersTeamOrDriversMaxWidth({required double fontSize, required showIndicators, required bool useShortName}) {
    if (raceModel.raceUsers.isEmpty) {
      return 0.0;
    }

    var result = raceModel.raceUsers.map((x) => textWidth("${useShortName ? x.shortName.value : x.name.value} ", fontSize)).reduce(max);

    if (showIndicators && raceModel.raceProto!.raceFeatures.where((x) => x == RaceFeatureTypeId.RACE_FEATURE_TYPE_ID_LANE_BASED_ID).isNotEmpty) {
      result += fontSize + 8.0;
    }

    if (raceModel.raceUsers.where((x) => x.image.hasValue() && x.image.value.isNotEmpty).isNotEmpty) {
      result += fontSize + 8.0;
    }

    // if (raceModel.raceUsers.where((x) => x.carImage.hasValue() && x.carImage.value.isNotEmpty).isNotEmpty) {
    //   result += fontSize + 8.0;
    // }

    return result;
  }

  double calculateHeatUsersDriversMaxWidth({
    required double fontSize,
    required Iterable<TeamUser> teamUsers,
    required bool useShortName,
    required double userImageWidth,
  }) {
    var result = teamUsers.isEmpty
        ? 0.0
        : teamUsers.map((x) => textWidth("${useShortName ? x.shortName.value : x.name.value} ", fontSize)).reduce(max) + userImageWidth;

    return result;
  }
}

class PublicRaceRaceStateHeader extends StatelessWidget {
  const PublicRaceRaceStateHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final fontSize = Theme.of(context).textTheme.headlineLarge!.fontSize!;
    return Consumer<RaceStateHeaderModel>(
      builder: (_, model, __) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            model.heatStateSymbol(fontSize),
            Text(
              model.laps.toString(),
              style: TextStyle(fontSize: fontSize, fontFamily: 'BungeeInline'),
            ),
            SizedBox(
              width: model.timerTextWidth(fontSize, "BungeeInline"),
              child: Text(
                model.timer,
                style: TextStyle(fontSize: fontSize, fontFamily: 'BungeeInline'),
              ),
            ),
          ],
        );
      },
    );
  }
}


abstract class PublicRaceStateDetailBase extends StatefulWidget {
  const PublicRaceStateDetailBase({super.key});
}

abstract class PublicRaceStateDetailStateBase extends State<PublicRaceStateDetailBase> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(duration: const Duration(seconds: 10), vsync: this)..repeat(reverse: true);

    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget foreground();

  @override
  Widget build(BuildContext context) {
    return Consumer<RaceStateModel>(
      builder: (_, model, __) {
        return AnimatedBuilder(
          animation: _animationController,
          child: foreground(),
          builder: (_, child) {
            return Container(
              //decoration: heatStateBoxDecoration(model, _animation.value),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      child!,
                      // if (model.raceState?.heatState.heatStateType != null &&
                      //     (model.raceState?.heatState.heatStateType.id == HeatStateTypeId.HEAT_STATE_TYPE_ID_COUNTDOWN ||
                      //         model.raceState?.heatState.heatStateType.id == HeatStateTypeId.HEAT_STATE_TYPE_ID_COUNTDOWN_YELLOW ||
                      //         model.raceState?.heatState.heatStateType.id == HeatStateTypeId.HEAT_STATE_TYPE_ID_COUNTDOWN_RED))
                      //   //StartLights(model: model.raceState?.heatState, constraints: constraints),
                    ],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class RaceStateModel extends ChangeNotifier {
  RaceState? raceState;

  void notify(RaceState raceState) {
    this.raceState = raceState;
    notifyListeners();
  }
}


class RaceStateHeaderModel extends HeatStateHeaderModel {
  RaceState? raceState;

  void notifyRace(RaceState raceState, Race race) {
    this.raceState = raceState;
    notify(raceState.heatState, race);
  }
}

class RaceLeaderboardModel extends ChangeNotifier {
  RaceLeaderboard? raceLeaderboard;

  void notify(RaceLeaderboard raceLeaderboard) {
    this.raceLeaderboard = raceLeaderboard;
    notifyListeners();
  }
}
