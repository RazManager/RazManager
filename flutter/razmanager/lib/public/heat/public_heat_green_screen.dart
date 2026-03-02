import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../app_progress_indicator.dart';
import '../../protobuf/razmanager/protobuf/public/event.v1.pb.dart';
import '../../protobuf/razmanager/protobuf/public/event_user_type_id.v1.pbenum.dart';
import '../../protobuf/razmanager/protobuf/public/heat.v1.pbenum.dart';
import '../../utilities/exception_message.dart';
import '../../utilities/intent.dart';
import '../../utilities/loading.dart';
import '../public_mixin.dart';
import 'public_heat.model.dart';
import 'public_heat_child_base.dart';

class PublicHeatGreenScreen extends StatefulWidget {
  const PublicHeatGreenScreen({super.key, required this.id});

  final String id;

  @override
  State<PublicHeatGreenScreen> createState() => _PublicHeatGreenScreenState();
}

class _PublicHeatGreenScreenState extends State<PublicHeatGreenScreen> {
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
                    child: SafeArea(child: _PublicHeatGreenScreenChild(id: id)),
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

class _PublicHeatGreenScreenChild extends PublicHeatChildBase {
  const _PublicHeatGreenScreenChild({required super.id});

  @override
  State createState() => _PublicHeatGreenScreenChildState();
}

class _PublicHeatGreenScreenChildState extends PublicHeatChildStateBase with ExceptionMessage, PublicFormatter {
  late _PublicHeatGreenScreenState publicHeatState;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();

    publicHeatState = context.findAncestorStateOfType<_PublicHeatGreenScreenState>()!;
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
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HeatModel>(
      builder: (context, heatModel, _) {
        if (heatModel.heatProto != null) {
          heatRefreshed(heatModel: heatModel);
          return Actions(
            actions: {
              CloseIntent: CallbackAction<CloseIntent>(
                onInvoke: (intent) {
                  context.pop();
                  return;
                },
              ),
            },
            child: Scaffold(
              body: Container(
                constraints: const BoxConstraints.expand(),
                decoration: const BoxDecoration(color: Color.fromRGBO(0, 255, 255, 255) ),
                child: Focus(autofocus: true, child: _PublicHeatGreenScreenLeaderboard()),
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

class _PublicHeatGreenScreenLeaderboard extends StatefulWidget {
  const _PublicHeatGreenScreenLeaderboard({super.key});

  @override
  State<_PublicHeatGreenScreenLeaderboard> createState() => _PublicHeatGreenScreenLeaderboardState();
}

class _PublicHeatGreenScreenLeaderboardState extends State<_PublicHeatGreenScreenLeaderboard> with ExceptionMessage, PublicFormatter {
  late PublicHeatChildStateBase publicHeatChildState;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();

    publicHeatChildState = context.findAncestorStateOfType<PublicHeatChildStateBase>()!;
    publicHeatChildState.heatLeaderboardSubscribe();
  }

  Map<_PublicHeatLeaderboardColumnKey, _PublicHeatLeaderboardColumnValue> calculateLeaderboardColumns({
    required double fontSize,
    required bool teamHeat,
    required double heatUsersTeamOrDriversMaxWidth,
    required double heatUsersDriversMaxWidth,
  }) {
    Map<_PublicHeatLeaderboardColumnKey, _PublicHeatLeaderboardColumnValue> result = {};

    result.addEntries(
      {
        _PublicHeatLeaderboardColumnKey.position: _PublicHeatLeaderboardColumnValue(
          text: "Pos",
          width: textWidth("Pos  ${publicHeatChildState.raceModel.showIndicators ? '' : ' '}", fontSize),
        ),
      }.entries,
    );

    if (publicHeatChildState.raceModel.showIndicators) {
      result.addEntries({_PublicHeatLeaderboardColumnKey.indicator: _PublicHeatLeaderboardColumnValue(text: "#", width: fontSize * 1.5)}.entries);
    }

    if (publicHeatChildState.heatModel.heatProto!.heatIndicators.where((x) => x.carClassColor.hasValue()).isNotEmpty) {
      result.addEntries(
        {_PublicHeatLeaderboardColumnKey.indicatorClass: _PublicHeatLeaderboardColumnValue(text: "", width: fontSize + textWidth("  ", fontSize))}.entries,
      );
    } else {}

    result.addEntries(
      {
        _PublicHeatLeaderboardColumnKey.teamOrDriver: _PublicHeatLeaderboardColumnValue(
          text: teamHeat ? "Team" : "Driver",
          width: [textWidth(teamHeat ? "Team   " : "Driver  ", fontSize), heatUsersTeamOrDriversMaxWidth].reduce(max),
        ),
      }.entries,
    );

    if (teamHeat) {
      result.addEntries(
        {
          _PublicHeatLeaderboardColumnKey.teamDriver: _PublicHeatLeaderboardColumnValue(
            text: "Driver",
            width: [textWidth("Driver  ", fontSize), heatUsersDriversMaxWidth].reduce(max),
          ),
        }.entries,
      );
    }

    result.addEntries(
      {_PublicHeatLeaderboardColumnKey.gapInterval: _PublicHeatLeaderboardColumnValue(text: "Gap", width: textWidth("000000", fontSize))}.entries,
    );

    result.addEntries({_PublicHeatLeaderboardColumnKey.flags: _PublicHeatLeaderboardColumnValue(text: "", width: fontSize * 3)}.entries);

    return result;
  }

  Map<_PublicHeatLeaderboardColumnKey, _PublicHeatLeaderboardColumnValue> calculateLeaderboardColumnsSized({
    required double fontSize,
    required bool useShortName,
    required bool hasUserImage,
    required bool teamHeat,
    required Iterable<TeamUser> teamUsers,
  }) {
    var heatUsersTeamOrDriversMaxWidth = publicHeatChildState.calculateHeatUsersTeamOrDriversMaxWidth(
      heatIndicators: publicHeatChildState.heatModel.heatProto!.heatIndicators,
      fontSize: fontSize,
      showIndicators: false,
      useShortName: useShortName,
    );

    var heatUsersDriversMaxWidth = publicHeatChildState.calculateHeatUsersDriversMaxWidth(
      fontSize: fontSize,
      teamUsers: teamUsers,
      useShortName: useShortName,
      userImageWidth: hasUserImage ? fontSize + 8.0 : 0.0,
    );

    return calculateLeaderboardColumns(
      fontSize: fontSize,
      teamHeat: teamHeat,
      heatUsersTeamOrDriversMaxWidth: heatUsersTeamOrDriversMaxWidth,
      heatUsersDriversMaxWidth: heatUsersDriversMaxWidth,
    );
  }

  double leaderBoardLeftMargin(double maxWidth, Map<_PublicHeatLeaderboardColumnKey, _PublicHeatLeaderboardColumnValue> leaderboardColumns) {
    return (maxWidth - leaderboardColumns.entries.map((x) => x.value.width).reduce((value, element) => value + element)) / 2;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                var columnPriorities = [
                  _PublicHeatLeaderboardColumnKey.position,
                  _PublicHeatLeaderboardColumnKey.teamOrDriver,
                  _PublicHeatLeaderboardColumnKey.flags,
                  _PublicHeatLeaderboardColumnKey.gapInterval,
                  _PublicHeatLeaderboardColumnKey.indicator,
                  _PublicHeatLeaderboardColumnKey.indicatorClass,
                  _PublicHeatLeaderboardColumnKey.teamDriver,
                ];

                var hasUserImage = publicHeatChildState.heatModel.heatUsers.entries
                    .where((x) => x.value!.image.hasValue() && x.value!.image.value.isNotEmpty)
                    .isNotEmpty;

                var teamHeat = publicHeatChildState.heatModel.heatUsers.entries
                    .where((x) => x.value!.eventUserTypeId == EventUserTypeId.EVENT_USER_TYPE_ID_TEAM)
                    .isNotEmpty;

                var teamUsers = publicHeatChildState.heatModel.heatUsers.entries.expand((x) => x.value!.teamUsers);

                // Try to size the layout using a fontsize that fits all rows horizontially
                var fontSize = min(
                  constraints.maxHeight / (2 * (publicHeatChildState.heatModel.heatProto!.heatIndicators.length + 2) + 0.5),
                  Theme.of(context).textTheme.headlineLarge!.fontSize!,
                );
                var useShortName = false;
                var leaderboardColumns = calculateLeaderboardColumnsSized(
                  fontSize: fontSize,
                  useShortName: useShortName,
                  hasUserImage: hasUserImage,
                  teamHeat: teamHeat,
                  teamUsers: teamUsers,
                );
                var leftMargin = leaderBoardLeftMargin(constraints.maxWidth / 3, leaderboardColumns);

                if (leftMargin < 0) {
                  // Still didn't fit. Try to use shortnames instead of names.
                  useShortName = true;
                  leaderboardColumns = calculateLeaderboardColumnsSized(
                    fontSize: fontSize,
                    useShortName: useShortName,
                    hasUserImage: hasUserImage,
                    teamHeat: teamHeat,
                    teamUsers: teamUsers,
                  );
                  leftMargin = leaderBoardLeftMargin(constraints.maxWidth / 3, leaderboardColumns);
                }

                // Delete columns until the layout fits horizontally
                do {
                  if (leftMargin < 0) {
                    var last = columnPriorities.removeLast();
                    leaderboardColumns.removeWhere((key, value) => key == last);
                    leftMargin = leaderBoardLeftMargin(constraints.maxWidth / 3, leaderboardColumns);
                  }
                } while (leftMargin < 0);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<HeatStateModel>(
                      builder: (_, heatStateModel, __) {
                        Widget stateWidget;
                        switch (heatStateModel.heatStateType?.id) {
                          case HeatStateTypeId.HEAT_STATE_TYPE_ID_RUNNING:
                            stateWidget = CircleAvatar(backgroundColor: Colors.greenAccent, radius: fontSize / 2);
                            break;

                          case HeatStateTypeId.HEAT_STATE_TYPE_ID_YELLOW:
                          case HeatStateTypeId.HEAT_STATE_TYPE_ID_COUNTDOWN_YELLOW:
                            stateWidget = CircleAvatar(backgroundColor: Colors.yellowAccent, radius: fontSize / 2);

                          case HeatStateTypeId.HEAT_STATE_TYPE_ID_RED:
                          case HeatStateTypeId.HEAT_STATE_TYPE_ID_COUNTDOWN_RED:
                            stateWidget = CircleAvatar(backgroundColor: Colors.redAccent, radius: fontSize / 2);
                            break;

                          case HeatStateTypeId.HEAT_STATE_TYPE_ID_ENDED:
                          case HeatStateTypeId.HEAT_STATE_TYPE_ID_OFF:
                          case HeatStateTypeId.HEAT_STATE_TYPE_ID_CLOSED:
                            stateWidget = Icon(Icons.sports_score, size: fontSize);
                            break;

                          default:
                            stateWidget = SizedBox(width: fontSize);
                            break;
                        }

                        return Consumer<HeatStateHeaderModel>(
                          builder: (_, heatStateHeaderModel, __) {
                            return Container(
                              width: leaderboardColumns.entries.map((x) => x.value.width).reduce((value, element) => value + element),
                              color: Colors.black, //  Theme.of(context).colorScheme.secondaryContainer,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      stateWidget,
                                      if (constraints.maxWidth > 2 * heatStateHeaderModel.timerTextWidth(fontSize * 1.5, "BungeeInline"))
                                        Text(
                                          heatStateHeaderModel.laps.toString(),
                                          style: TextStyle(fontSize: fontSize * 1.5, fontFamily: 'BungeeInline'),
                                        ),
                                      SizedBox(
                                        width: heatStateHeaderModel.timerTextWidth(fontSize * 1.5, "BungeeInline"),
                                        child: Text(
                                          heatStateHeaderModel.timer,
                                          style: TextStyle(fontSize: fontSize * 1.5, fontFamily: 'BungeeInline'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: leaderboardColumns.entries.map((x) {
                                      switch (x.key) {
                                        case _PublicHeatLeaderboardColumnKey.position:
                                          return SizedBox(
                                            width: x.value.width,
                                            child: Center(
                                              child: Text(
                                                x.value.text,
                                                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          );
                                        case _PublicHeatLeaderboardColumnKey.indicator:
                                          return SizedBox(
                                            width: x.value.width,
                                            child: Center(
                                              child: Text(
                                                x.value.text,
                                                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          );
                                        case _PublicHeatLeaderboardColumnKey.indicatorClass:
                                          return SizedBox(width: x.value.width);
                                        case _PublicHeatLeaderboardColumnKey.teamOrDriver:
                                          return SizedBox(
                                            width: x.value.width,
                                            child: Text(
                                              x.value.text,
                                              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                                            ),
                                          );
                                        case _PublicHeatLeaderboardColumnKey.teamDriver:
                                          return SizedBox(
                                            width: x.value.width,
                                            child: Text(
                                              x.value.text,
                                              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                                            ),
                                          );
                                        case _PublicHeatLeaderboardColumnKey.gapInterval:
                                          return SizedBox(
                                            width: x.value.width,
                                            child: Text(
                                              x.value.text,
                                              textAlign: TextAlign.end,
                                              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                                            ),
                                          );
                                        case _PublicHeatLeaderboardColumnKey.flags:
                                          return SizedBox(
                                            width: x.value.width,
                                            child: Text(
                                              x.value.text,
                                              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                                            ),
                                          );
                                      }
                                    }).toList(),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(height: fontSize / 2),
                    Expanded(
                      child: Consumer<HeatLeaderboardModel>(
                        builder: (context, model, _) => Stack(
                          fit: StackFit.expand,
                          children: [
                            if (model.heatLeaderboard != null)
                              ...model.heatLeaderboard!.indicators.map((heatLeaderboardIndicator) {
                                final heatIndicator = publicHeatChildState.heatModel.heatProto!.heatIndicators
                                    .where((x) => x.indicatorId == heatLeaderboardIndicator.indicatorId)
                                    .singleOrNull;
                                final heatUser = publicHeatChildState.heatModel.heatUsers[heatLeaderboardIndicator.indicatorId];
                                final teamUsers = publicHeatChildState.heatModel.heatUsers[heatLeaderboardIndicator.indicatorId]?.teamUsers;
                                TeamUser? teamDriver;
                                if (teamHeat && heatLeaderboardIndicator.teamEventUserId.hasValue()) {
                                  teamDriver = teamUsers!.where((teamUser) => teamUser.id == heatLeaderboardIndicator.teamEventUserId.value).singleOrNull;
                                }
                                // final timeTypeTimeLap = heatLeaderboardIndicator.timeTypeTimes
                                //     .where((x) => x.timeTypeId == HeatIndicatorTimeTypeId.HEAT_INDICATOR_TIME_TYPE_ID_LAP)
                                //     .singleOrNull;
                                final lapsHasValue = heatLeaderboardIndicator.getFieldOrNull(heatLeaderboardIndicator.getTagNumber("laps") ?? -1) != null;
                                // final energyLapsLeftHasValue =
                                //     heatLeaderboardIndicator.getFieldOrNull(heatLeaderboardIndicator.getTagNumber("energyLapsLeft") ?? -1) != null;
                                return AnimatedPositioned(
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeInOut,
                                  top: (heatLeaderboardIndicator.position - 1) * fontSize * 2,
                                  //left: leftMargin,
                                  child: Container(
                                    // decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.redAccent,Theme.of(context)
                                    //      .colorScheme
                                    //      .secondaryContainer], stops: [0.0, 0.2]),),
                                    color:  Colors.black, // Theme.of(context).colorScheme.secondaryContainer,
                                    child: Row(
                                      children: leaderboardColumns.entries.map((x) {
                                        switch (x.key) {
                                          case _PublicHeatLeaderboardColumnKey.position:
                                            return SizedBox(
                                              width: x.value.width,
                                              child: Center(
                                                child: Text(
                                                  lapsHasValue ? heatLeaderboardIndicator.position.toString() : '',
                                                  style: TextStyle(fontSize: fontSize),
                                                ),
                                              ),
                                            );
                                          case _PublicHeatLeaderboardColumnKey.indicator:
                                            return SizedBox(
                                              width: x.value.width,
                                              child: Center(
                                                child: heatIndicator != null && heatIndicator.hasColor()
                                                    ? CircleAvatar(backgroundColor: Color(heatIndicator.color.value), radius: fontSize / 2)
                                                    : Text(heatLeaderboardIndicator.indicatorId.toString(), style: TextStyle(fontSize: fontSize)),
                                              ),
                                            );
                                          case _PublicHeatLeaderboardColumnKey.indicatorClass:
                                            return SizedBox(
                                              width: x.value.width,
                                              child: heatIndicator != null && heatIndicator.carClassColor.hasValue()
                                                  ? Center(
                                                      child: CircleAvatar(backgroundColor: Color(heatIndicator.carClassColor.value), radius: fontSize / 2),
                                                    )
                                                  : null,
                                            );

                                          case _PublicHeatLeaderboardColumnKey.teamOrDriver:
                                            return SizedBox(
                                              width: x.value.width,
                                              child: Row(
                                                children: [
                                                  if (heatIndicator != null && heatIndicator.hasCarImage() && heatIndicator.carImage.value.isNotEmpty) ...[
                                                    CircleAvatar(
                                                      foregroundImage: MemoryImage(Uint8List.fromList(heatIndicator.carImage.value)),
                                                      radius: fontSize / 2,
                                                    ),
                                                    SizedBox(width: 8),
                                                  ],
                                                  if (heatUser != null && heatUser.hasImage() && heatUser.image.value.isNotEmpty) ...[
                                                    CircleAvatar(foregroundImage: MemoryImage(Uint8List.fromList(heatUser.image.value)), radius: fontSize / 2),
                                                    SizedBox(width: 8),
                                                  ] else
                                                    SizedBox(width: hasUserImage ? fontSize + 8.0 : 0.0),
                                                  Expanded(
                                                    child: Text(
                                                      (useShortName ? heatUser?.shortName.value : heatUser?.name.value) ?? '?',
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(fontSize: fontSize),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          case _PublicHeatLeaderboardColumnKey.teamDriver:
                                            return SizedBox(
                                              width: x.value.width,
                                              child: Row(
                                                children: [
                                                  if (teamDriver != null && teamDriver.hasImage() && teamDriver.image.value.isNotEmpty) ...[
                                                    CircleAvatar(
                                                      foregroundImage: MemoryImage(Uint8List.fromList(teamDriver.image.value)),
                                                      radius: fontSize / 2,
                                                    ),
                                                    SizedBox(width: 8),
                                                  ],
                                                  Expanded(
                                                    child: Text(
                                                      (useShortName ? teamDriver?.shortName.value : teamDriver?.name.value) ?? '',
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(fontSize: fontSize),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          case _PublicHeatLeaderboardColumnKey.gapInterval:
                                            return SizedBox(
                                              width: x.value.width,
                                              child: Text(
                                                heatLeaderboardIndicator.gapInterval.value,
                                                textAlign: TextAlign.end,
                                                style: TextStyle(fontSize: fontSize),
                                              ),
                                            );
                                          case _PublicHeatLeaderboardColumnKey.flags:
                                            return SizedBox(
                                              width: x.value.width,
                                              child: Row(
                                                children: [
                                                  SizedBox(width: 8),
                                                  ...heatLeaderboardIndicator.flags.map((x) {
                                                    switch (x) {
                                                      case HeatIndicatorFlag.HEAT_INDICATOR_FLAG_FINISHED:
                                                        return Icon(Icons.sports_score, size: fontSize);
                                                      case HeatIndicatorFlag.HEAT_INDICATOR_FLAG_FASTEST_LAP:
                                                        return Icon(Icons.timer, color: Colors.purpleAccent, size: fontSize);
                                                      default:
                                                        return Icon(Icons.question_mark, size: fontSize);
                                                    }
                                                  }),
                                                ],
                                              ),
                                            );
                                        }
                                      }).toList(),
                                    ),
                                  ),
                                );
                              }),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

enum _PublicHeatLeaderboardColumnKey { position, indicator, indicatorClass, teamOrDriver, teamDriver, gapInterval, flags }

class _PublicHeatLeaderboardColumnValue {
  const _PublicHeatLeaderboardColumnValue({required this.text, required this.width});

  final String text;
  final double width;
}
