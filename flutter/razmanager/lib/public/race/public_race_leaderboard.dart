import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../protobuf/razmanager/protobuf/public/event.v1.pb.dart';
import '../../protobuf/razmanager/protobuf/public/heat.v1.pb.dart';
import '../../utilities/exception_message.dart';
import '../public_mixin.dart';
import 'public_race_child_base.dart';

class PublicRaceLeaderboard extends PublicRaceStateDetailBase {
  const PublicRaceLeaderboard({super.key});

  @override
  State createState() => _PublicRaceLeaderboardState();
}

class _PublicRaceLeaderboardState extends PublicRaceStateDetailStateBase {
  @override
  Widget foreground() {
    return _PublicRaceLeaderboardForeground();
  }
}

class _PublicRaceLeaderboardForeground extends StatefulWidget {
  @override
  State<_PublicRaceLeaderboardForeground> createState() => _PublicRaceLeaderboardForegroundState();
}

class _PublicRaceLeaderboardForegroundState extends State<_PublicRaceLeaderboardForeground> with ExceptionMessage, PublicFormatter {
  late PublicRaceChildStateBase publicRaceChildState;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();

    publicRaceChildState = context.findAncestorStateOfType<PublicRaceChildStateBase>()!;
    publicRaceChildState.raceLeaderboardSubscribe();
  }

  Map<_PublicRaceLeaderboardColumnKey, _PublicRaceLeaderboardColumnValue> calculateLeaderboardColumns({
    required double fontSize,
    required bool teamRace,
    required double raceUsersTeamOrDriversMaxWidth,
    required double raceUsersDriversMaxWidth,
  }) {
    Map<_PublicRaceLeaderboardColumnKey, _PublicRaceLeaderboardColumnValue> result = {};

    result.addEntries(
      {
        _PublicRaceLeaderboardColumnKey.position: _PublicRaceLeaderboardColumnValue(
          text: "Pos",
          width: textWidth("Pos  ${publicRaceChildState.raceModel.showIndicators ? '' : ' '}", fontSize),
        ),
      }.entries,
    );

    // if (publicRaceChildState.raceModel.showIndicators) {
    //   result.addEntries({_PublicRaceLeaderboardColumnKey.indicator: _PublicRaceLeaderboardColumnValue(text: "#", width: fontSize * 1.5)}.entries);
    // }

    // if (publicRaceChildState.heatModel.heatProto!.heatIndicators.where((x) => x.carClassColor.hasValue()).isNotEmpty) {
    //   result.addEntries(
    //     {_PublicHeatLeaderboardColumnKey.indicatorClass: _PublicHeatLeaderboardColumnValue(text: "", width: fontSize + textWidth("  ", fontSize))}.entries,
    //   );
    // } else {}

    result.addEntries(
      {
        _PublicRaceLeaderboardColumnKey.teamOrDriver: _PublicRaceLeaderboardColumnValue(
          text: teamRace ? "Team" : "Driver",
          width: [textWidth(teamRace ? "Team   " : "Driver  ", fontSize), raceUsersTeamOrDriversMaxWidth].reduce(max),
        ),
      }.entries,
    );

    if (teamRace) {
      result.addEntries(
        {
          _PublicRaceLeaderboardColumnKey.teamDriver: _PublicRaceLeaderboardColumnValue(
            text: "Driver",
            width: [textWidth("Driver  ", fontSize), raceUsersDriversMaxWidth].reduce(max),
          ),
        }.entries,
      );
    }

    result.addEntries(
      {
        _PublicRaceLeaderboardColumnKey.lapsCompleted: _PublicRaceLeaderboardColumnValue(text: "Laps", width: textWidth("  Laps", fontSize)),
        _PublicRaceLeaderboardColumnKey.lapsPredicted: _PublicRaceLeaderboardColumnValue(text: "Predicted", width: textWidth("  Predicted", fontSize)),
        _PublicRaceLeaderboardColumnKey.gapLapsPredictedInterval: _PublicRaceLeaderboardColumnValue(
          text: "Gap",
          width: textWidth("000000", fontSize) + 8 + fontSize + 11 * fontSize,
        ),
        _PublicRaceLeaderboardColumnKey.gapLapsPredictedLeader: _PublicRaceLeaderboardColumnValue(text: "Leader", width: textWidth("  Leader", fontSize)),
        _PublicRaceLeaderboardColumnKey.indicators: _PublicRaceLeaderboardColumnValue(
          text: "Lanes",
          width: fontSize * (publicRaceChildState.raceModel.raceProto?.raceIndicators.length ?? 0) + 8,
        ),
        _PublicRaceLeaderboardColumnKey.flags: _PublicRaceLeaderboardColumnValue(text: "", width: fontSize * 3),
      }.entries,
    );

    return result;
  }

  Map<_PublicRaceLeaderboardColumnKey, _PublicRaceLeaderboardColumnValue> calculateLeaderboardColumnsSized({
    required double fontSize,
    required bool useShortName,
    required bool hasUserImage,
    required bool teamRace,
    required Iterable<TeamUser> teamUsers,
  }) {
    var heatUsersTeamOrDriversMaxWidth = publicRaceChildState.calculateRaceUsersTeamOrDriversMaxWidth(
      fontSize: fontSize,
      showIndicators: false,
      useShortName: useShortName,
    );

    var heatUsersDriversMaxWidth = publicRaceChildState.calculateHeatUsersDriversMaxWidth(
      fontSize: fontSize,
      teamUsers: teamUsers,
      useShortName: useShortName,
      userImageWidth: hasUserImage ? fontSize + 8.0 : 0.0,
    );

    return calculateLeaderboardColumns(
      fontSize: fontSize,
      teamRace: teamRace,
      raceUsersTeamOrDriversMaxWidth: heatUsersTeamOrDriversMaxWidth,
      raceUsersDriversMaxWidth: heatUsersDriversMaxWidth,
    );
  }

  double leaderBoardLeftMargin(double maxWidth, Map<_PublicRaceLeaderboardColumnKey, _PublicRaceLeaderboardColumnValue> leaderboardColumns) {
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
                  _PublicRaceLeaderboardColumnKey.position,
                  _PublicRaceLeaderboardColumnKey.teamOrDriver,
                  _PublicRaceLeaderboardColumnKey.flags,
                  _PublicRaceLeaderboardColumnKey.gapLapsPredictedInterval,
                  _PublicRaceLeaderboardColumnKey.lapsPredicted,
                  _PublicRaceLeaderboardColumnKey.indicators,
                  _PublicRaceLeaderboardColumnKey.lapsCompleted,
                  _PublicRaceLeaderboardColumnKey.teamDriver,
                  _PublicRaceLeaderboardColumnKey.gapLapsPredictedLeader,
                ];

                var hasUserImage = publicRaceChildState.raceModel.raceUsers.where((x) => x.image.hasValue() && x.image.value.isNotEmpty).isNotEmpty;

                final indicatorColumns = 1; //publicRaceChildState.eventModel.raceLeaderBoardIndicatorColumns;
                final indicatorMaxWidth = constraints.maxWidth / indicatorColumns - ((indicatorColumns - 1) * 16);
                final indicatorMaxRows = (publicRaceChildState.raceModel.raceUsers.length / indicatorColumns).ceil();

                // Try to size the layout using a fontsize that fits all rows horizontially
                var fontSize = constraints.maxHeight / (2 * (indicatorMaxRows + 2) + 0.5);
                var useShortName = false;
                var leaderboardColumns = calculateLeaderboardColumnsSized(
                  fontSize: fontSize,
                  useShortName: useShortName,
                  hasUserImage: hasUserImage,
                  teamRace: publicRaceChildState.raceModel.teamRace,
                  teamUsers: publicRaceChildState.raceModel.teamUsers,
                );
                var leftMargin = leaderBoardLeftMargin(indicatorMaxWidth, leaderboardColumns);

                if (publicRaceChildState.eventModel.leaderBoardUseMaxFontSize &&
                    leftMargin < 0 &&
                    Theme.of(context).textTheme.headlineLarge!.fontSize! < fontSize) {
                  // All columns didn't fit. Try to use a lower (but still large) fontsize.
                  fontSize = Theme.of(context).textTheme.headlineLarge!.fontSize!;
                  leaderboardColumns = calculateLeaderboardColumnsSized(
                    fontSize: fontSize,
                    useShortName: useShortName,
                    hasUserImage: hasUserImage,
                    teamRace: publicRaceChildState.raceModel.teamRace,
                    teamUsers: publicRaceChildState.raceModel.teamUsers,
                  );
                  leftMargin = leaderBoardLeftMargin(indicatorMaxWidth, leaderboardColumns);
                }

                if (leftMargin < 0) {
                  // Still didn't fit. Try to use shortnames instead of names.
                  useShortName = true;
                  leaderboardColumns = calculateLeaderboardColumnsSized(
                    fontSize: fontSize,
                    useShortName: useShortName,
                    hasUserImage: hasUserImage,
                    teamRace: publicRaceChildState.raceModel.teamRace,
                    teamUsers: publicRaceChildState.raceModel.teamUsers,
                  );
                  leftMargin = leaderBoardLeftMargin(indicatorMaxWidth, leaderboardColumns);
                }

                // Delete columns until the layout fits horizontally
                do {
                  if (leftMargin < 0) {
                    var last = columnPriorities.removeLast();
                    leaderboardColumns.removeWhere((key, value) => key == last);
                    leftMargin = leaderBoardLeftMargin(indicatorMaxWidth, leaderboardColumns);
                  }
                } while (leftMargin < 0);

                final leaderboardColumnWidgets = leaderboardColumns.entries.map((x) {
                  switch (x.key) {
                    case _PublicRaceLeaderboardColumnKey.position:
                      return SizedBox(
                        width: x.value.width,
                        child: Center(
                          child: Text(
                            x.value.text,
                            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    case _PublicRaceLeaderboardColumnKey.teamOrDriver:
                      return SizedBox(
                        width: x.value.width,
                        child: Text(
                          x.value.text,
                          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                        ),
                      );
                    case _PublicRaceLeaderboardColumnKey.teamDriver:
                      return SizedBox(
                        width: x.value.width,
                        child: Text(
                          x.value.text,
                          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                        ),
                      );
                    case _PublicRaceLeaderboardColumnKey.lapsCompleted:
                      return SizedBox(
                        width: x.value.width,
                        child: Text(
                          x.value.text,
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                        ),
                      );
                    case _PublicRaceLeaderboardColumnKey.lapsPredicted:
                      return SizedBox(
                        width: x.value.width,
                        child: Text(
                          x.value.text,
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                        ),
                      );
                    case _PublicRaceLeaderboardColumnKey.gapLapsPredictedInterval:
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
                            SizedBox(width: 8 + fontSize),
                          ],
                        ),
                      );
                    case _PublicRaceLeaderboardColumnKey.gapLapsPredictedLeader:
                      return SizedBox(
                        width: x.value.width,
                        child: Text(
                          x.value.text,
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                        ),
                      );
                    case _PublicRaceLeaderboardColumnKey.indicators:
                      return SizedBox(
                        width: x.value.width,
                        child: Center(
                          child: Text(
                            x.value.text,
                            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    case _PublicRaceLeaderboardColumnKey.flags:
                      return SizedBox(
                        width: x.value.width,
                        child: Text(
                          x.value.text,
                          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                        ),
                      );
                  }
                }).toList();

                final leaderboardColumnsWidth = leaderboardColumns.entries.map((x) => x.value.width).reduce((value, element) => value + element);

                final Map<int, (double, double)> positions = {};
                for (var i = 1; i <= publicRaceChildState.raceModel.raceUsers.length; i++) {
                  final x = ((i - 1) / indicatorMaxRows).floor() * (leaderboardColumnsWidth + 16);
                  final y = ((i - 1) % indicatorMaxRows) * 2 * fontSize;
                  positions.addEntries({MapEntry(i, (x, y))});
                }

                return Center(
                  child: SizedBox(
                    width: leaderboardColumnsWidth * indicatorColumns + ((indicatorColumns - 1) * 16),
                    child: Column(
                      children: [
                        Consumer<RaceStateHeaderModel>(
                          builder: (_, model, __) {
                            return Container(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Heat ${model.raceState?.heatNumber.value}",
                                        style: TextStyle(fontSize: fontSize * 2, fontFamily: 'BungeeInline'),
                                      ),
                                      model.heatStateSymbol(fontSize * 2),
                                      // if (constraints.maxWidth > 2 * model.timerTextWidth(fontSize * 2, "BungeeInline"))
                                      //   Text(
                                      //     model.laps.toString(),
                                      //     style: TextStyle(fontSize: fontSize * 2, fontFamily: 'BungeeInline'),
                                      //   ),
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
                                    children: [
                                      ...leaderboardColumnWidgets,
                                      if (indicatorColumns == 2) ...[SizedBox(width: 16), ...leaderboardColumnWidgets],
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(height: fontSize / 2),
                        Expanded(
                          child: Consumer<RaceLeaderboardModel>(
                            builder: (context, model, _) => Stack(
                              fit: StackFit.expand,
                              children: [
                                if (model.raceLeaderboard != null)
                                  ...model.raceLeaderboard!.eventUsers.map((raceLeaderboardEventUser) {
                                    final raceUser = publicRaceChildState.raceModel.raceUsers
                                        .where((x) => x.id == raceLeaderboardEventUser.eventUserId)
                                        .singleOrNull;
                                    final teamUsers = raceUser?.teamUsers;
                                    TeamUser? teamDriver;
                                    if (publicRaceChildState.raceModel.teamRace && raceLeaderboardEventUser.teamEventUserId.hasValue()) {
                                      teamDriver = teamUsers!.where((teamUser) => teamUser.id == raceLeaderboardEventUser.teamEventUserId.value).singleOrNull;
                                    }
                                    return AnimatedPositioned(
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.easeInOut,
                                      // top: (heatLeaderboardIndicator.position - 1) * fontSize * 2,
                                      // left: leftMargin,
                                      top: positions[raceLeaderboardEventUser.position]?.$2,
                                      left: positions[raceLeaderboardEventUser.position]?.$1,
                                      child: Container(
                                        // decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.redAccent,Theme.of(context)
                                        //      .colorScheme
                                        //      .secondaryContainer], stops: [0.0, 0.2]),),
                                        color: Theme.of(context).colorScheme.secondaryContainer,
                                        child: Row(
                                          children: leaderboardColumns.entries.map((x) {
                                            switch (x.key) {
                                              case _PublicRaceLeaderboardColumnKey.position:
                                                return SizedBox(
                                                  width: x.value.width,
                                                  child: Center(
                                                    child: Text(
                                                      raceLeaderboardEventUser.lapsCompleted.hasValue() ? raceLeaderboardEventUser.position.toString() : '',
                                                      style: TextStyle(fontSize: fontSize),
                                                    ),
                                                  ),
                                                );
                                              case _PublicRaceLeaderboardColumnKey.teamOrDriver:
                                                return SizedBox(
                                                  width: x.value.width,
                                                  child: Row(
                                                    children: [
                                                      // if (heatIndicator != null && heatIndicator.hasCarImage() && heatIndicator.carImage.value.isNotEmpty) ...[
                                                      //   CircleAvatar(
                                                      //     foregroundImage: MemoryImage(Uint8List.fromList(heatIndicator.carImage.value)),
                                                      //     radius: fontSize / 2,
                                                      //   ),
                                                      //   SizedBox(width: 8),
                                                      // ],
                                                      if (raceUser != null && raceUser.hasImage() && raceUser.image.value.isNotEmpty) ...[
                                                        CircleAvatar(
                                                          foregroundImage: MemoryImage(Uint8List.fromList(raceUser.image.value)),
                                                          radius: fontSize / 2,
                                                        ),
                                                        SizedBox(width: 8),
                                                      ] else
                                                        SizedBox(width: hasUserImage ? fontSize + 8.0 : 0.0),
                                                      Expanded(
                                                        child: Text(
                                                          (useShortName ? raceUser?.shortName.value : raceUser?.name.value) ?? '?',
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(fontSize: fontSize),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              case _PublicRaceLeaderboardColumnKey.teamDriver:
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
                                              case _PublicRaceLeaderboardColumnKey.lapsCompleted:
                                                return SizedBox(
                                                  width: x.value.width,
                                                  child: Text(
                                                    raceLeaderboardEventUser.lapsCompleted.hasValue() ? raceLeaderboardEventUser.lapsCompleted.value : '',
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(fontSize: fontSize),
                                                  ),
                                                );
                                              case _PublicRaceLeaderboardColumnKey.lapsPredicted:
                                                return SizedBox(
                                                  width: x.value.width,
                                                  child: Text(
                                                    raceLeaderboardEventUser.hasLapsPredicted() ? raceLeaderboardEventUser.lapsPredicted.value : '',
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(fontSize: fontSize),
                                                  ),
                                                );
                                              case _PublicRaceLeaderboardColumnKey.gapLapsPredictedInterval:
                                                return SizedBox(
                                                  width: x.value.width,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          raceLeaderboardEventUser.gapLapsPredictedInterval.hasValue()
                                                              ? raceLeaderboardEventUser.gapLapsPredictedInterval.value
                                                              : '',
                                                          textAlign: TextAlign.end,
                                                          style: TextStyle(fontSize: fontSize),
                                                        ),
                                                      ),
                                                      SizedBox(width: 8),
                                                      if (raceLeaderboardEventUser.gapLapsPredictedIntervalFraction.hasValue())
                                                        AnimatedRotation(
                                                          turns: min(max(-raceLeaderboardEventUser.gapLapsPredictedIntervalFraction.value / 10, -0.25), 0.25),
                                                          duration: const Duration(seconds: 1),
                                                          child: Icon(Icons.arrow_forward, size: fontSize),
                                                        )
                                                      else
                                                        SizedBox(width: fontSize),
                                                      SizedBox(
                                                        width: 10 * fontSize,
                                                        child: Text(raceLeaderboardEventUser.gapLapsPredictedIntervalFraction.toString()),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              case _PublicRaceLeaderboardColumnKey.gapLapsPredictedLeader:
                                                return SizedBox(
                                                  width: x.value.width,
                                                  child: Text(
                                                    raceLeaderboardEventUser.gapLapsPredictedLeader.hasValue()
                                                        ? raceLeaderboardEventUser.gapLapsPredictedLeader.value.toString()
                                                        : '',
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(fontSize: fontSize),
                                                  ),
                                                );
                                              case _PublicRaceLeaderboardColumnKey.indicators:
                                                return SizedBox(
                                                  width: x.value.width,
                                                  child: Consumer<RaceStateModel>(
                                                    builder: (_, model, _) {
                                                      final raceEventUserState = model.raceState?.raceEventUserStates
                                                          .where((x) => x.eventUserId == raceLeaderboardEventUser.eventUserId)
                                                          .singleOrNull;
                                                      return Row(
                                                        children: [
                                                          SizedBox(width: 8),
                                                          ...publicRaceChildState.raceModel.raceProto!.raceIndicators.map((x) {
                                                            return Stack(
                                                              children: [
                                                                x.hasColor()
                                                                    ? CircleAvatar(backgroundColor: Color(x.color.value), radius: fontSize / 2)
                                                                    : Text(x.indicatorId.toString(), style: TextStyle(fontSize: fontSize)),
                                                                if (raceEventUserState != null &&
                                                                    raceEventUserState.indicatorIdsFinished.contains(x.indicatorId))
                                                                  Icon(Icons.done, size: fontSize, blendMode: BlendMode.difference)
                                                                else if (raceEventUserState != null &&
                                                                    raceEventUserState.indicatorIdCurrent.value == x.indicatorId)
                                                                  Icon(Icons.toys_outlined, size: fontSize, blendMode: BlendMode.difference),
                                                              ],
                                                            );
                                                          }),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                );
                                              case _PublicRaceLeaderboardColumnKey.flags:
                                                return SizedBox(
                                                  width: x.value.width,
                                                  child: Row(
                                                    children: [
                                                      SizedBox(width: 8),
                                                      ...raceLeaderboardEventUser.flags.map((x) {
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
                    ),
                  ),
                );
              },
            ),
          ),
          //if (publicRaceChildState.heatModel.heatCommandPermissions.isNotEmpty) PublicHeatBottomNavigationBar(),
        ],
      ),
    );
  }
}

enum _PublicRaceLeaderboardColumnKey {
  position,
  //indicator,
  //indicatorClass,
  teamOrDriver,
  teamDriver,
  lapsCompleted,
  lapsPredicted,
  //lapTime,
  //lapFastestTime,
  gapLapsPredictedInterval,
  gapLapsPredictedLeader,
  //energyPercentage,
  //energyIcon,
  //energyLapsLeft,
  indicators,
  flags,
}

class _PublicRaceLeaderboardColumnValue {
  const _PublicRaceLeaderboardColumnValue({required this.text, required this.width});

  final String text;
  final double width;
}
