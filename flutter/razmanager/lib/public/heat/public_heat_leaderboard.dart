import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../protobuf/razmanager/protobuf/public/event.v1.pb.dart';
import '../../protobuf/razmanager/protobuf/public/event_user_type_id.v1.pbenum.dart';
import '../../protobuf/razmanager/protobuf/public/heat.v1.pb.dart';
import '../../protobuf/razmanager/protobuf/public/race_feature_type_id.v1.pb.dart';
import '../../utilities/exception_message.dart';
import '../public_mixin.dart';
import '../race/public_race.model.dart';
import 'public_heat.model.dart';
import 'public_heat_child_base.dart';

class PublicHeatLeaderboard extends PublicHeatStateDetailBase {
  const PublicHeatLeaderboard({super.key});

  @override
  State createState() => _PublicHeatLeaderboardState();
}

class _PublicHeatLeaderboardState extends PublicHeatStateDetailStateBase {
  @override
  Widget foreground() {
    return _PublicHeatLeaderboardForeground();
  }
}

class _PublicHeatLeaderboardForeground extends StatefulWidget {
  @override
  State<_PublicHeatLeaderboardForeground> createState() => _PublicHeatLeaderboardForegroundState();
}

class _PublicHeatLeaderboardForegroundState extends State<_PublicHeatLeaderboardForeground> with ExceptionMessage, PublicFormatter {
  @override
  didChangeDependencies() {
    super.didChangeDependencies();

    final publicHeatChildState = context.findAncestorStateOfType<PublicHeatChildStateBase>()!;
    publicHeatChildState.heatLeaderboardSubscribe();
  }

  double leaderBoardLeftMargin(double maxWidth, Map<_PublicHeatLeaderboardColumnKey, _PublicHeatLeaderboardColumnValue> leaderboardColumns) {
    return (maxWidth - leaderboardColumns.entries.map((x) => x.value.width).reduce((value, element) => value + element)) / 2;
  }

  Map<_PublicHeatLeaderboardColumnKey, _PublicHeatLeaderboardColumnValue> calculateLeaderboardColumns(
      {required double fontSize,
      required PublicHeatChildStateBase publicHeatChildState,
      required bool teamHeat,
      required double heatUsersTeamOrDriversMaxWidth,
      required double heatUsersDriversMaxWidth}) {
    Map<_PublicHeatLeaderboardColumnKey, _PublicHeatLeaderboardColumnValue> result = {};

    final raceModel = context.read<RaceModel>();
    final heatModel = context.read<HeatModel>();

    var showIndicators = raceModel.raceProto!.raceFeatures.where((x) => x == RaceFeatureTypeId.RACE_FEATURE_TYPE_ID_LANE_BASED_ID).isNotEmpty;

    result.addEntries({
      _PublicHeatLeaderboardColumnKey.position: _PublicHeatLeaderboardColumnValue(text: "Pos", width: textWidth("Pos ${showIndicators ? '' : ' '}", fontSize)),
    }.entries);

    if (showIndicators) {
      result.addEntries({
        _PublicHeatLeaderboardColumnKey.indicator: _PublicHeatLeaderboardColumnValue(text: "#", width: fontSize * 1.5),
      }.entries);
    }

    if (heatModel.heatProto!.heatIndicators.where((x) => x.carClassColor.hasValue()).isNotEmpty) {
      result.addEntries({
        _PublicHeatLeaderboardColumnKey.indicatorClass: _PublicHeatLeaderboardColumnValue(text: "", width: fontSize + textWidth("  ", fontSize)),
      }.entries);
    } else {}

    result.addEntries({
      _PublicHeatLeaderboardColumnKey.teamOrDriver: _PublicHeatLeaderboardColumnValue(
          text: teamHeat ? "Team" : "Driver", width: [textWidth(teamHeat ? "Team  " : "Driver  ", fontSize), heatUsersTeamOrDriversMaxWidth].reduce(max)),
    }.entries);

    if (teamHeat) {
      result.addEntries({
        _PublicHeatLeaderboardColumnKey.teamDriver:
            _PublicHeatLeaderboardColumnValue(text: "Driver", width: [textWidth("Driver  ", fontSize), heatUsersDriversMaxWidth].reduce(max)),
      }.entries);
    }

    result.addEntries({
      _PublicHeatLeaderboardColumnKey.laps: _PublicHeatLeaderboardColumnValue(text: "Laps", width: textWidth("  Laps", fontSize)),
      _PublicHeatLeaderboardColumnKey.lapTime: _PublicHeatLeaderboardColumnValue(text: "Last lap", width: textWidth("   Last lap", fontSize)),
      _PublicHeatLeaderboardColumnKey.lapFastestTime: _PublicHeatLeaderboardColumnValue(text: "Fastest", width: textWidth("   Fastest", fontSize)),
      _PublicHeatLeaderboardColumnKey.gapInterval: _PublicHeatLeaderboardColumnValue(text: "Interval", width: textWidth("   Interval", fontSize)),
      _PublicHeatLeaderboardColumnKey.gapLeader: _PublicHeatLeaderboardColumnValue(text: "Leader", width: textWidth("   Leader", fontSize)),
    }.entries);

    if (raceModel.raceProto!.raceFeatures.where((x) => x == RaceFeatureTypeId.RACE_FEATURE_TYPE_ID_ENERGY).isNotEmpty) {
      result.addEntries({
        _PublicHeatLeaderboardColumnKey.energyPercentage: _PublicHeatLeaderboardColumnValue(text: "", width: textWidth(" 100%", fontSize)),
        _PublicHeatLeaderboardColumnKey.energyIcon: _PublicHeatLeaderboardColumnValue(text: "Energy", width: fontSize),
        _PublicHeatLeaderboardColumnKey.energyLapsLeft: _PublicHeatLeaderboardColumnValue(text: "", width: textWidth("100L ", fontSize) + fontSize),
      }.entries);
    }

    result.addEntries({
      _PublicHeatLeaderboardColumnKey.flags: _PublicHeatLeaderboardColumnValue(text: "", width: fontSize * 3),
    }.entries);

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final publicHeatChildState = context.findAncestorStateOfType<PublicHeatChildStateBase>()!;
    return Consumer<HeatLeaderboardModel>(builder: (context, model, _) {
      final heatModel = context.read<HeatModel>();
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: LayoutBuilder(builder: (context, constraints) {
                var columnPriorities = <_PublicHeatLeaderboardColumnKey>[
                  _PublicHeatLeaderboardColumnKey.position,
                  _PublicHeatLeaderboardColumnKey.teamOrDriver,
                  _PublicHeatLeaderboardColumnKey.laps,
                  _PublicHeatLeaderboardColumnKey.indicator,
                  _PublicHeatLeaderboardColumnKey.indicatorClass,
                  _PublicHeatLeaderboardColumnKey.teamDriver,
                  _PublicHeatLeaderboardColumnKey.flags,
                  _PublicHeatLeaderboardColumnKey.gapInterval,
                  _PublicHeatLeaderboardColumnKey.lapTime,
                  _PublicHeatLeaderboardColumnKey.lapFastestTime,
                  _PublicHeatLeaderboardColumnKey.gapLeader,
                  _PublicHeatLeaderboardColumnKey.energyPercentage,
                  _PublicHeatLeaderboardColumnKey.energyIcon,
                  _PublicHeatLeaderboardColumnKey.energyLapsLeft,
                ];

                final fontSize = constraints.maxHeight / (2 * (heatModel.heatProto!.heatIndicators.length + 2) + 0.5);

                var useShortName = false;

                var userImageWidth =
                    heatModel.heatUsers.entries.where((x) => x.value!.image.hasValue() && x.value!.image.value.isNotEmpty).isEmpty ? 0.0 : fontSize + 8.0;

                var heatUsersTeamOrDriversMaxWidth = publicHeatChildState.calculateHeatUsersTeamOrDriversMaxWidth(
                    heatIndicators: heatModel.heatProto!.heatIndicators, fontSize: fontSize, showIndicators: false, useShortName: useShortName);

                var teamHeat = heatModel.heatUsers.entries.where((x) => x.value!.eventUserTypeId == EventUserTypeId.EVENT_USER_TYPE_ID_TEAM).isNotEmpty;

                var teamUsers = heatModel.heatUsers.entries.expand((x) => x.value!.teamUsers);

                var heatUsersDriversMaxWidth = publicHeatChildState.calculateHeatUsersDriversMaxWidth(
                    fontSize: fontSize, teamUsers: teamUsers, useShortName: useShortName, userImageWidth: userImageWidth);

                var leaderboardColumns = calculateLeaderboardColumns(
                    fontSize: fontSize,
                    publicHeatChildState: publicHeatChildState,
                    teamHeat: teamHeat,
                    heatUsersTeamOrDriversMaxWidth: heatUsersTeamOrDriversMaxWidth,
                    heatUsersDriversMaxWidth: heatUsersDriversMaxWidth);
                var left = leaderBoardLeftMargin(constraints.maxWidth, leaderboardColumns);
                if (left < 0) {
                  useShortName = true;
                  heatUsersTeamOrDriversMaxWidth = publicHeatChildState.calculateHeatUsersTeamOrDriversMaxWidth(
                      heatIndicators: heatModel.heatProto!.heatIndicators, fontSize: fontSize, showIndicators: false, useShortName: useShortName);
                  heatUsersDriversMaxWidth = publicHeatChildState.calculateHeatUsersDriversMaxWidth(
                      fontSize: fontSize, teamUsers: teamUsers, useShortName: useShortName, userImageWidth: userImageWidth);
                  leaderboardColumns = calculateLeaderboardColumns(
                      fontSize: fontSize,
                      publicHeatChildState: publicHeatChildState,
                      teamHeat: teamHeat,
                      heatUsersTeamOrDriversMaxWidth: heatUsersTeamOrDriversMaxWidth,
                      heatUsersDriversMaxWidth: heatUsersDriversMaxWidth);
                  left = leaderBoardLeftMargin(constraints.maxWidth, leaderboardColumns);
                }

                do {
                  if (left < 0) {
                    var last = columnPriorities.removeLast();
                    leaderboardColumns.removeWhere((key, value) => key == last);
                    left = leaderBoardLeftMargin(constraints.maxWidth, leaderboardColumns);
                  }
                } while (left < 0);

                return Opacity(
                  opacity: 0.95,
                  child: Column(
                    children: [
                      Consumer<HeatStateHeaderModel>(builder: (_, model, __) {
                        return Container(
                          width: leaderboardColumns.entries.map((x) => x.value.width).reduce((value, element) => value + element),
                          color: Theme.of(context).colorScheme.primaryContainer,
                          child: Column(
                            children: [
                              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                Text(model.laps.toString(), style: TextStyle(fontSize: fontSize * 2, fontFamily: 'BungeeInline')),
                                SizedBox(
                                  width: model.timerTextWidth(fontSize * 2, "BungeeInline"),
                                  child: Text(model.timer, style: TextStyle(fontSize: fontSize * 2, fontFamily: 'BungeeInline')),
                                ),
                              ]),
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
                                      return SizedBox(
                                        width: x.value.width,
                                      );
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
                                    case _PublicHeatLeaderboardColumnKey.laps:
                                      return SizedBox(
                                        width: x.value.width,
                                        child: Text(
                                          x.value.text,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                                        ),
                                      );
                                    case _PublicHeatLeaderboardColumnKey.lapTime:
                                      return SizedBox(
                                        width: x.value.width,
                                        child: Text(
                                          x.value.text,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                                        ),
                                      );
                                    case _PublicHeatLeaderboardColumnKey.lapFastestTime:
                                      return SizedBox(
                                        width: x.value.width,
                                        child: Text(x.value.text, textAlign: TextAlign.end, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold)),
                                      );
                                    case _PublicHeatLeaderboardColumnKey.gapLeader:
                                      return SizedBox(
                                        width: x.value.width,
                                        child: Text(x.value.text, textAlign: TextAlign.end, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold)),
                                      );
                                    case _PublicHeatLeaderboardColumnKey.gapInterval:
                                      return SizedBox(
                                        width: x.value.width,
                                        child: Text(x.value.text, textAlign: TextAlign.end, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold)),
                                      );
                                    case _PublicHeatLeaderboardColumnKey.energyPercentage:
                                      return SizedBox(
                                        width: x.value.width,
                                      );
                                    case _PublicHeatLeaderboardColumnKey.energyIcon:
                                      return Icon(Icons.battery_full, size: fontSize);
                                    case _PublicHeatLeaderboardColumnKey.energyLapsLeft:
                                      return SizedBox(
                                        width: x.value.width,
                                      );
                                    case _PublicHeatLeaderboardColumnKey.flags:
                                      return SizedBox(
                                        width: x.value.width,
                                        child: Text(x.value.text, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold)),
                                      );
                                  }
                                }).toList(),
                              ),
                            ],
                          ),
                        );
                      }),
                      SizedBox(height: fontSize / 2),
                      Expanded(
                        child: Stack(fit: StackFit.expand, children: [
                          if (model.heatLeaderboard != null)
                            ...model.heatLeaderboard!.indicators.map((heatLeaderboardIndicator) {
                              final heatIndicator =
                                  heatModel.heatProto!.heatIndicators.where((x) => x.indicatorId == heatLeaderboardIndicator.indicatorId).singleOrNull;
                              final heatUser = heatModel.heatUsers[heatLeaderboardIndicator.indicatorId];
                              final teamUsers = heatModel.heatUsers[heatLeaderboardIndicator.indicatorId]?.teamUsers;
                              TeamUser? teamDriver;
                              if (teamHeat && heatLeaderboardIndicator.teamEventUserId.hasValue()) {
                                teamDriver =  teamUsers!.singleWhere((teamUser) => teamUser.id == heatLeaderboardIndicator.teamEventUserId.value);
                              }
                              final timeTypeTimeLap = heatLeaderboardIndicator.timeTypeTimes
                                  .where((x) => x.timeTypeId == HeatIndicatorTimeTypeId.HEAT_INDICATOR_TIME_TYPE_ID_LAP)
                                  .singleOrNull;
                              final lapsHasValue = heatLeaderboardIndicator.getFieldOrNull(heatLeaderboardIndicator.getTagNumber("laps") ?? -1) != null;
                              final energyLapsLeftHasValue =
                                  heatLeaderboardIndicator.getFieldOrNull(heatLeaderboardIndicator.getTagNumber("energyLapsLeft") ?? -1) != null;
                              return AnimatedPositioned(
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeInOut,
                                top: (heatLeaderboardIndicator.position - 1) * fontSize * 2,
                                left: left,
                                child: Container(
                                  // decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.redAccent,Theme.of(context)
                                  //      .colorScheme
                                  //      .secondaryContainer], stops: [0.0, 0.2]),),
                                  color: Theme.of(context).colorScheme.secondaryContainer,
                                  child: Row(
                                    children: leaderboardColumns.entries.map((x) {
                                      switch (x.key) {
                                        case _PublicHeatLeaderboardColumnKey.position:
                                          return SizedBox(
                                            width: x.value.width,
                                            child: Center(
                                              child:
                                                  Text(lapsHasValue ? heatLeaderboardIndicator.position.toString() : '', style: TextStyle(fontSize: fontSize)),
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
                                                  : null);

                                        case _PublicHeatLeaderboardColumnKey.teamOrDriver:
                                          return SizedBox(
                                            width: x.value.width,
                                            child: Row(
                                              children: [
                                                if (heatIndicator != null && heatIndicator.hasCarImage() && heatIndicator.carImage.value.isNotEmpty) ...[
                                                  CircleAvatar(
                                                      foregroundImage: MemoryImage(Uint8List.fromList(heatIndicator.carImage.value)), radius: fontSize / 2),
                                                  SizedBox(width: 8),
                                                ],
                                                if (heatUser != null && heatUser.hasImage() && heatUser.image.value.isNotEmpty) ...[
                                                  CircleAvatar(foregroundImage: MemoryImage(Uint8List.fromList(heatUser.image.value)), radius: fontSize / 2),
                                                  SizedBox(width: 8),
                                                ] else
                                                  SizedBox(width: userImageWidth),
                                                Expanded(
                                                  child: Text((useShortName ? heatUser?.shortName.value : heatUser?.name.value) ?? '?',
                                                      overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: fontSize)),
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
                                                  CircleAvatar(foregroundImage: MemoryImage(Uint8List.fromList(teamDriver.image.value)), radius: fontSize / 2),
                                                  SizedBox(width: 8),
                                                ],
                                                Expanded(
                                                  child: Text((useShortName ? teamDriver?.shortName.value : teamDriver?.name.value) ?? '',
                                                      overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: fontSize)),
                                                ),
                                              ],
                                            ),
                                          );
                                        case _PublicHeatLeaderboardColumnKey.laps:
                                          return SizedBox(
                                            width: x.value.width,
                                            child: Text(lapsHasValue ? heatLeaderboardIndicator.laps.value.toString() : '',
                                                textAlign: TextAlign.end, style: TextStyle(fontSize: fontSize)),
                                          );
                                        case _PublicHeatLeaderboardColumnKey.lapTime:
                                          return SizedBox(
                                            width: x.value.width,
                                            child: Text(
                                              timeTypeTimeLap != null && timeTypeTimeLap.time.hasValue() ? timeTypeTimeLap.time.value.toStringAsFixed(2) : '',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(fontSize: fontSize, color: fastestTimeTypeColor(timeTypeTimeLap)),
                                            ),
                                          );
                                        case _PublicHeatLeaderboardColumnKey.lapFastestTime:
                                          return SizedBox(
                                            width: x.value.width,
                                            child: Text(
                                                timeTypeTimeLap != null && timeTypeTimeLap.fastestTime.hasValue()
                                                    ? timeTypeTimeLap.fastestTime.value.toStringAsFixed(2)
                                                    : '',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(fontSize: fontSize)),
                                          );
                                        case _PublicHeatLeaderboardColumnKey.gapLeader:
                                          return SizedBox(
                                            width: x.value.width,
                                            child:
                                                Text(heatLeaderboardIndicator.gapLeader.value, textAlign: TextAlign.end, style: TextStyle(fontSize: fontSize)),
                                          );
                                        case _PublicHeatLeaderboardColumnKey.gapInterval:
                                          return SizedBox(
                                            width: x.value.width,
                                            child: Text(heatLeaderboardIndicator.gapInterval.value,
                                                textAlign: TextAlign.end, style: TextStyle(fontSize: fontSize)),
                                          );
                                        case _PublicHeatLeaderboardColumnKey.energyPercentage:
                                          return SizedBox(
                                            width: x.value.width,
                                            child: Text("${heatLeaderboardIndicator.energyPercent}%",
                                                textAlign: TextAlign.end, style: TextStyle(fontSize: fontSize)),
                                          );
                                        case _PublicHeatLeaderboardColumnKey.energyIcon:
                                          if (heatLeaderboardIndicator.energyPercent == 0) {
                                            return Icon(Icons.battery_0_bar, size: fontSize, color: Colors.redAccent);
                                          } else if (heatLeaderboardIndicator.energyPercent < 100 / 7) {
                                            return Icon(Icons.battery_1_bar, size: fontSize, color: Colors.redAccent);
                                          } else if (heatLeaderboardIndicator.energyPercent < 200 / 7) {
                                            return Icon(Icons.battery_2_bar, size: fontSize);
                                          } else if (heatLeaderboardIndicator.energyPercent < 300 / 7) {
                                            return Icon(Icons.battery_3_bar, size: fontSize);
                                          } else if (heatLeaderboardIndicator.energyPercent < 400 / 7) {
                                            return Icon(Icons.battery_4_bar, size: fontSize);
                                          } else if (heatLeaderboardIndicator.energyPercent < 500 / 7) {
                                            return Icon(Icons.battery_5_bar, size: fontSize);
                                          } else if (heatLeaderboardIndicator.energyPercent < 600 / 7) {
                                            return Icon(Icons.battery_6_bar, size: fontSize);
                                          } else {
                                            return Icon(Icons.battery_full, size: fontSize);
                                          }
                                        case _PublicHeatLeaderboardColumnKey.energyLapsLeft:
                                          return SizedBox(
                                            width: x.value.width,
                                            child: Text(energyLapsLeftHasValue ? "${heatLeaderboardIndicator.energyLapsLeft.value}L" : '',
                                                textAlign: TextAlign.start, style: TextStyle(fontSize: fontSize)),
                                          );
                                        case _PublicHeatLeaderboardColumnKey.flags:
                                          return SizedBox(
                                              width: x.value.width,
                                              child: Row(children: [
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                ...heatLeaderboardIndicator.flags.map((x) {
                                                  switch (x) {
                                                    case HeatIndicatorFlag.HEAT_INDICATOR_FLAG_FINISHED:
                                                      return Icon(Icons.sports_score, size: fontSize);
                                                    case HeatIndicatorFlag.HEAT_INDICATOR_FLAG_FASTEST_LAP:
                                                      return Icon(Icons.timer, color: Colors.purpleAccent, size: fontSize);
                                                    default:
                                                      return Icon(Icons.question_mark, size: fontSize);
                                                  }
                                                })
                                              ]));
                                      }
                                    }).toList(),
                                  ),
                                ),
                              );
                            }),
                        ]),
                      ),
                    ],
                  ),
                );
              }),
            ),
            if (heatModel.heatCommandPermissions.isNotEmpty) PublicHeatBottomNavigationBar()
          ],
        ),
      );
    });
  }
}

enum _PublicHeatLeaderboardColumnKey {
  position,
  indicator,
  indicatorClass,
  teamOrDriver,
  teamDriver,
  laps,
  lapTime,
  lapFastestTime,
  gapLeader,
  gapInterval,
  energyPercentage,
  energyIcon,
  energyLapsLeft,
  flags
}

class _PublicHeatLeaderboardColumnValue {
  const _PublicHeatLeaderboardColumnValue({required this.text, required this.width});

  final String text;
  final double width;
}
