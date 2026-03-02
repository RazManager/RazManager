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
      {
        _PublicHeatLeaderboardColumnKey.laps: _PublicHeatLeaderboardColumnValue(text: "Laps", width: textWidth("  Laps", fontSize)),
        _PublicHeatLeaderboardColumnKey.lapTime: _PublicHeatLeaderboardColumnValue(text: "Last lap", width: textWidth("   Last lap", fontSize)),
        _PublicHeatLeaderboardColumnKey.lapFastestTime: _PublicHeatLeaderboardColumnValue(text: "Fastest", width: textWidth("   Fastest", fontSize)),
        _PublicHeatLeaderboardColumnKey.gapInterval: _PublicHeatLeaderboardColumnValue(text: "Gap", width: textWidth("000000", fontSize) + 8 + fontSize),
        _PublicHeatLeaderboardColumnKey.gapLeader: _PublicHeatLeaderboardColumnValue(text: "Leader", width: textWidth("  Leader", fontSize)),
      }.entries,
    );

    if (publicHeatChildState.raceModel.raceProto!.raceFeatures.where((x) => x == RaceFeatureTypeId.RACE_FEATURE_TYPE_ID_ENERGY).isNotEmpty) {
      result.addEntries(
        {
          _PublicHeatLeaderboardColumnKey.energyPercentage: _PublicHeatLeaderboardColumnValue(text: "", width: textWidth(" 100%", fontSize)),
          _PublicHeatLeaderboardColumnKey.energyIcon: _PublicHeatLeaderboardColumnValue(text: "Energy", width: fontSize),
          _PublicHeatLeaderboardColumnKey.energyLapsLeft: _PublicHeatLeaderboardColumnValue(text: "", width: textWidth("100L ", fontSize) + fontSize),
        }.entries,
      );
    }

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
                  _PublicHeatLeaderboardColumnKey.lapTime,
                  _PublicHeatLeaderboardColumnKey.laps,
                  _PublicHeatLeaderboardColumnKey.teamDriver,
                  _PublicHeatLeaderboardColumnKey.lapFastestTime,
                  _PublicHeatLeaderboardColumnKey.gapLeader,
                  _PublicHeatLeaderboardColumnKey.energyPercentage,
                  _PublicHeatLeaderboardColumnKey.energyIcon,
                  _PublicHeatLeaderboardColumnKey.energyLapsLeft,
                ];

                var hasUserImage = publicHeatChildState.heatModel.heatUsers.entries
                    .where((x) => x.value!.image.hasValue() && x.value!.image.value.isNotEmpty)
                    .isNotEmpty;

                var teamHeat = publicHeatChildState.heatModel.heatUsers.entries
                    .where((x) => x.value!.eventUserTypeId == EventUserTypeId.EVENT_USER_TYPE_ID_TEAM)
                    .isNotEmpty;

                var teamUsers = publicHeatChildState.heatModel.heatUsers.entries.expand((x) => x.value!.teamUsers);

                // Try to size the layout using a fontsize that fits all rows horizontially
                var fontSize = constraints.maxHeight / (2 * (publicHeatChildState.heatModel.heatProto!.heatIndicators.length + 2) + 0.5);
                var useShortName = false;
                var leaderboardColumns = calculateLeaderboardColumnsSized(
                  fontSize: fontSize,
                  useShortName: useShortName,
                  hasUserImage: hasUserImage,
                  teamHeat: teamHeat,
                  teamUsers: teamUsers,
                );
                var leftMargin = leaderBoardLeftMargin(constraints.maxWidth, leaderboardColumns);

                if (publicHeatChildState.eventModel.leaderBoardUseMaxFontSize &&
                    leftMargin < 0 &&
                    Theme.of(context).textTheme.headlineLarge!.fontSize! < fontSize) {
                  // All columns didn't fit. Try to use a lower (but still large) fontsize.
                  fontSize = Theme.of(context).textTheme.headlineLarge!.fontSize!;
                  leaderboardColumns = calculateLeaderboardColumnsSized(
                    fontSize: fontSize,
                    useShortName: useShortName,
                    hasUserImage: hasUserImage,
                    teamHeat: teamHeat,
                    teamUsers: teamUsers,
                  );
                  leftMargin = leaderBoardLeftMargin(constraints.maxWidth, leaderboardColumns);
                }

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
                  leftMargin = leaderBoardLeftMargin(constraints.maxWidth, leaderboardColumns);
                }

                // Delete columns until the layout fits horizontally
                do {
                  if (leftMargin < 0) {
                    var last = columnPriorities.removeLast();
                    leaderboardColumns.removeWhere((key, value) => key == last);
                    leftMargin = leaderBoardLeftMargin(constraints.maxWidth, leaderboardColumns);
                  }
                } while (leftMargin < 0);

                return Column(
                  children: [
                    Consumer<HeatStateHeaderModel>(
                      builder: (_, model, __) {
                        return Container(
                          width: leaderboardColumns.entries.map((x) => x.value.width).reduce((value, element) => value + element),
                          color: Theme.of(context).colorScheme.primaryContainer,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  model.heatStateSymbol(fontSize * 2),
                                  if (constraints.maxWidth > 2 * model.timerTextWidth(fontSize * 2, "BungeeInline"))
                                    Text(
                                      model.laps.toString(),
                                      style: TextStyle(fontSize: fontSize * 2, fontFamily: 'BungeeInline'),
                                    ),
                                  SizedBox(
                                    width: model.timerTextWidth(fontSize * 2, "BungeeInline"),
                                    child: Text(
                                      model.timer,
                                      style: TextStyle(fontSize: fontSize * 2, fontFamily: 'BungeeInline'),
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
                                        child: Text(
                                          x.value.text,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                                        ),
                                      );
                                    case _PublicHeatLeaderboardColumnKey.gapLeader:
                                      return SizedBox(
                                        width: x.value.width,
                                        child: Text(
                                          x.value.text,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                                        ),
                                      );
                                    case _PublicHeatLeaderboardColumnKey.gapInterval:
                                      return SizedBox(
                                        width: x.value.width,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                x.value.text,
                                                textAlign: TextAlign.end,
                                                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(width: 8 + fontSize)
                                          ],
                                        ),
                                      );
                                    case _PublicHeatLeaderboardColumnKey.energyPercentage:
                                      return SizedBox(width: x.value.width);
                                    case _PublicHeatLeaderboardColumnKey.energyIcon:
                                      return Icon(Icons.battery_full, size: fontSize);
                                    case _PublicHeatLeaderboardColumnKey.energyLapsLeft:
                                      return SizedBox(width: x.value.width);
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
                                  left: leftMargin,
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
                                          case _PublicHeatLeaderboardColumnKey.laps:
                                            return SizedBox(
                                              width: x.value.width,
                                              child: Text(
                                                lapsHasValue ? heatLeaderboardIndicator.laps.value.toString() : '',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(fontSize: fontSize),
                                              ),
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
                                                style: TextStyle(fontSize: fontSize),
                                              ),
                                            );
                                          case _PublicHeatLeaderboardColumnKey.gapLeader:
                                            return SizedBox(
                                              width: x.value.width,
                                              child: Text(
                                                heatLeaderboardIndicator.gapLeader.value,
                                                textAlign: TextAlign.end,
                                                style: TextStyle(fontSize: fontSize),
                                              ),
                                            );
                                          case _PublicHeatLeaderboardColumnKey.gapInterval:
                                            return SizedBox(
                                              width: x.value.width,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      heatLeaderboardIndicator.gapInterval.value,
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(fontSize: fontSize),
                                                    ),
                                                  ),
                                                  SizedBox(width: 8),
                                                  if (heatLeaderboardIndicator.gapIntervalFraction.hasValue())
                                                  // Text(
                                                  //     heatLeaderboardIndicator.gapIntervalFraction.value.toString(),
                                                  //     textAlign: TextAlign.end,
                                                  //     style: TextStyle(fontSize: 4),
                                                  // )
                                                    AnimatedRotation(
                                                      turns: -heatLeaderboardIndicator.gapIntervalFraction.value / 2,
                                                      duration: const Duration(seconds: 1),
                                                      child: Icon(Icons.arrow_forward, size: fontSize),
                                                    )
                                                  else
                                                    SizedBox(width: fontSize),
                                                ],
                                              ),
                                            );
                                          case _PublicHeatLeaderboardColumnKey.energyPercentage:
                                            return SizedBox(
                                              width: x.value.width,
                                              child: Text(
                                                "${heatLeaderboardIndicator.energyPercent}%",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(fontSize: fontSize),
                                              ),
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
                                              child: Text(
                                                energyLapsLeftHasValue ? "${heatLeaderboardIndicator.energyLapsLeft.value}L" : '',
                                                textAlign: TextAlign.start,
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
          if (publicHeatChildState.heatModel.heatCommandPermissions.isNotEmpty) PublicHeatBottomNavigationBar(),
        ],
      ),
    );
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
  flags,
}

class _PublicHeatLeaderboardColumnValue {
  const _PublicHeatLeaderboardColumnValue({required this.text, required this.width});

  final String text;
  final double width;
}
