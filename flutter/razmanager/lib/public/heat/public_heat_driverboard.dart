import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../protobuf/razmanager/protobuf/public/heat.v1.pb.dart';
import '../../utilities/exception_message.dart';
import '../../utilities/loading.dart';
import '../event/public_event.model.dart';
import '../public_mixin.dart';
import '../race/public_race.model.dart';
import 'public_heat.model.dart';
import 'public_heat_child_base.dart';

class PublicHeatDriverboard extends PublicHeatStateDetailBase {
  const PublicHeatDriverboard({super.key});

  @override
  State createState() => _PublicHeatDriverboardState();
}

class _PublicHeatDriverboardState extends PublicHeatStateDetailStateBase {
  @override
  Widget foreground() {
    return _PublicHeatDriverboardForeground();
  }
}

class _PublicHeatDriverboardForeground extends StatefulWidget {
  @override
  State<_PublicHeatDriverboardForeground> createState() => _PublicHeatDriverboardForegroundState();
}

class _PublicHeatDriverboardForegroundState extends State<_PublicHeatDriverboardForeground> with ExceptionMessage, PublicFormatter {
  late final PublicHeatChildStateBase publicHeatChildState;
  late final double refFontSize;
  Map<int, Queue<double>> heatAnalysisGapMinimumQueues = {};
  Map<int, Queue<double>> heatAnalysisGapMaximumQueues = {};

  //DateTime? gapStartedAt;
  //Iterable<MapEntry<int, HeatAnalysisGap?>> previousGaps = [];

  @override
  didChangeDependencies() {
    super.didChangeDependencies();

    publicHeatChildState = context.findAncestorStateOfType<PublicHeatChildStateBase>()!;
    publicHeatChildState.heatLeaderboardSubscribe();
    publicHeatChildState.heatAnalysisSubscribe();

    final heatModel = context.read<HeatModel>();

    heatAnalysisGapMinimumQueues.addEntries(heatModel.heatProto!.heatIndicators.map((x) => MapEntry(x.indicatorId, Queue<double>())));
    heatAnalysisGapMaximumQueues.addEntries(heatModel.heatProto!.heatIndicators.map((x) => MapEntry(x.indicatorId, Queue<double>())));

    refFontSize = Theme.of(context).textTheme.bodyMedium!.fontSize!;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EventModel>(builder: (_, eventModel, __) {
      final raceModel = context.read<RaceModel>();
      final heatModel = context.read<HeatModel>();

      Iterable<HeatIndicator> heatIndicators;
          final middle = (heatModel.heatProto!.heatIndicators.length / 2).toInt();
      switch (eventModel.driverBoardSelection) {
        case DriverBoardSelection.all:
          heatIndicators = heatModel.heatProto!.heatIndicators;
          break;
        case DriverBoardSelection.firsthalf:
          heatIndicators = heatModel.heatProto!.heatIndicators.getRange(0, middle - 1);
          break;
        case DriverBoardSelection.secondhalf:
          heatIndicators = heatModel.heatProto!.heatIndicators.getRange(middle, heatModel.heatProto!.heatIndicators.length);
          break;
        case DriverBoardSelection.individual:
          heatIndicators = heatModel.heatProto!.heatIndicators.where((x) => eventModel.eventUserIds.contains(x.eventUserId));
          break;
      }

      final refHeatUsersTeamOrDriversMaxWidth = publicHeatChildState.calculateHeatUsersTeamOrDriversMaxWidth(
          heatIndicators: heatIndicators, fontSize: refFontSize, showIndicators: true, useShortName: false);

      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Opacity(opacity: 0.95, child: Card(child: PublicHeatHeatStateHeader())),
            Expanded(
              child: LayoutBuilder(builder: (context, constraint) {
                final indicatorsLength = heatIndicators.length;
                int rows;
                int columns;
                if (indicatorsLength == 0) {
                  return Placeholder();
                } else if (indicatorsLength == 1) {
                  rows = 1;
                  columns = 1;
                } else {
                  var size = sqrt(constraint.maxHeight * constraint.maxWidth / indicatorsLength);
                  rows = (constraint.maxHeight / size).ceil();
                  columns = (indicatorsLength / rows).ceil();
                  size = constraint.maxHeight / rows;
                }

                return Consumer<HeatLeaderboardModel>(
                  builder: (_, heatLeaderboardModel, __) => GridView.count(
                      crossAxisCount: columns,
                      childAspectRatio: (constraint.maxWidth / columns) / (constraint.maxHeight / rows),
                      children: heatIndicators.map((heatIndicator) {
                        final heatLeaderboardIndicator =
                            heatLeaderboardModel.heatLeaderboard?.indicators.where((x) => x.indicatorId == heatIndicator.indicatorId).singleOrNull;
                        final heatUser = heatModel.heatUsers[heatIndicator.indicatorId];
                        final timeTypeTimeLap = heatLeaderboardIndicator!.timeTypeTimes
                            .where((x) => x.timeTypeId == HeatIndicatorTimeTypeId.HEAT_INDICATOR_TIME_TYPE_ID_LAP)
                            .singleOrNull;
                        final lapsHasValue = heatLeaderboardIndicator.getFieldOrNull(heatLeaderboardIndicator.getTagNumber("laps") ?? -1) != null;
                        final energyLapsLeftHasValue =
                            heatLeaderboardIndicator.getFieldOrNull(heatLeaderboardIndicator.getTagNumber("energyLapsLeft") ?? -1) != null;
                        return Opacity(
                          opacity: 0.95,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: LayoutBuilder(builder: (context, constraint) {
                                final nameFontSize = min(refFontSize * constraint.maxWidth / refHeatUsersTeamOrDriversMaxWidth,
                                    Theme.of(context).textTheme.headlineLarge!.fontSize!);
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: IntrinsicWidth(
                                              child: Row(
                                                children: [
                                                  if (raceModel.showIndicators) ...[
                                                    if (heatIndicator.hasColor())
                                                      CircleAvatar(backgroundColor: Color(heatIndicator.color.value), radius: nameFontSize / 2)
                                                    else
                                                      Text(heatIndicator.indicatorId.toString(), style: TextStyle(fontSize: nameFontSize)),
                                                    SizedBox(width: 8),
                                                  ],
                                                  if (heatIndicator.hasCarImage() && heatIndicator.carImage.value.isNotEmpty) ...[
                                                    CircleAvatar(
                                                        foregroundImage: MemoryImage(Uint8List.fromList(heatIndicator.carImage.value)),
                                                        radius: nameFontSize / 2),
                                                    SizedBox(width: 8),
                                                  ],
                                                  if (heatUser != null && heatUser.hasImage() && heatUser.image.value.isNotEmpty) ...[
                                                    CircleAvatar(
                                                        foregroundImage: MemoryImage(Uint8List.fromList(heatUser.image.value)), radius: nameFontSize / 2),
                                                    SizedBox(width: 8),
                                                  ],
                                                  Text(
                                                    heatUser?.name.value ?? '?',
                                                    style: TextStyle(fontSize: nameFontSize),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        ...heatLeaderboardIndicator.flags.map((x) {
                                          switch (x) {
                                            case HeatIndicatorFlag.HEAT_INDICATOR_FLAG_FINISHED:
                                              return Icon(Icons.sports_score);
                                            case HeatIndicatorFlag.HEAT_INDICATOR_FLAG_FASTEST_LAP:
                                              return Icon(Icons.timer, color: Colors.purpleAccent);
                                            default:
                                              return Icon(Icons.question_mark);
                                          }
                                        })
                                      ],
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                        if (constraint.maxWidth > 400)
                                          Consumer<HeatAnalysisLoadingModel>(builder: (context, model, _) {
                                            if (model.loading) {
                                              return const Center(child: Loading());
                                            } else {
                                              return Consumer<HeatDriverboardGapModel>(
                                                builder: (_, model, __) {
                                                  var gaps = model.indicatorGaps[heatIndicator.indicatorId]!.entries.where((x) => x.value != null);

                                                  if (gaps.isNotEmpty) {
                                                    final minAbsGap = gaps.map((x) => x.value!.value.abs()).reduce(min);
                                                    final gapCandidates =
                                                        gaps.where((x) => x.value!.value < minAbsGap * 2.0 && x.value!.value > -minAbsGap * 2.0);

                                                    final heatAnalysisGapMinimumQueue = heatAnalysisGapMinimumQueues[heatIndicator.indicatorId]!;
                                                    heatAnalysisGapMinimumQueue.addLast(gapCandidates.map((x) => x.value!.value).reduce(min));
                                                    while (heatAnalysisGapMinimumQueue.length >= 10) {
                                                      heatAnalysisGapMinimumQueue.removeFirst();
                                                    }

                                                    final heatAnalysisGapMaximumQueue = heatAnalysisGapMaximumQueues[heatIndicator.indicatorId]!;
                                                    heatAnalysisGapMaximumQueue.addLast(gapCandidates.map((x) => x.value!.value).reduce(max));
                                                    while (heatAnalysisGapMaximumQueue.length >= 10) {
                                                      heatAnalysisGapMaximumQueue.removeFirst();
                                                    }

                                                    var minimum = min(heatAnalysisGapMinimumQueue.reduce(min).floor().toDouble(), 0.0);
                                                    var maximum = max(heatAnalysisGapMaximumQueue.reduce(max).ceil().toDouble(), 0.0);

                                                    return Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Expanded(
                                                          child: LayoutBuilder(
                                                            builder: (context, constraint) => ConstrainedBox(
                                                              constraints: BoxConstraints(maxHeight: constraint.maxHeight, maxWidth: 150),
                                                              child: Stack(fit: StackFit.expand, children: [
                                                                ...gaps.map((x) {
                                                                  final heatUser = heatModel.heatUsers[x.key];
                                                                  final hi = heatModel.heatProto!.heatIndicators
                                                                      .where((hi2) => hi2.indicatorId == x.value!.indicatorId)
                                                                      .singleOrNull;
                                                                  return AnimatedPositioned(
                                                                    duration: const Duration(seconds: 1),
                                                                    curve: Curves.easeInOut,
                                                                    top: (maximum - x.value!.value) /
                                                                        (maximum - minimum) *
                                                                        (constraint.maxHeight - refFontSize * 2),
                                                                    child: Row(
                                                                      children: [
                                                                        if (raceModel.showIndicators && hi != null && hi.hasColor()) ...[
                                                                          CircleAvatar(backgroundColor: Color(hi.color.value), radius: refFontSize),
                                                                          SizedBox(
                                                                            width: 8,
                                                                          ),
                                                                        ],
                                                                        if (heatUser!.hasImage() && heatUser.image.value.isNotEmpty) ...[
                                                                          CircleAvatar(
                                                                              foregroundImage: MemoryImage(Uint8List.fromList(heatUser.image.value)),
                                                                              radius: refFontSize),
                                                                          SizedBox(
                                                                            width: 8,
                                                                          ),
                                                                        ],
                                                                        Text(heatUser!.shortName.value),
                                                                        SizedBox(
                                                                          width: 8,
                                                                        ),
                                                                        Text(x.value!.displayValue),
                                                                        if (x.value!.deltaFraction.hasValue()) ...[
                                                                          SizedBox(
                                                                            width: 8,
                                                                          ),
                                                                          AnimatedRotation(
                                                                              turns: -x.value!.deltaFraction.value / 2,
                                                                              duration: const Duration(seconds: 1),
                                                                              child: Icon(Icons.arrow_forward))
                                                                        ]
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                                AnimatedPositioned(
                                                                    duration: const Duration(seconds: 1),
                                                                    curve: Curves.easeInOut,
                                                                    top: maximum / (maximum - minimum) * (constraint.maxHeight - refFontSize * 2),
                                                                    left: 75 - 8,
                                                                    child: (raceModel.showIndicators && heatIndicator.hasColor())
                                                                        ? CircleAvatar(backgroundColor: Color(heatIndicator.color.value), radius: refFontSize)
                                                                        : (heatUser!.hasImage() && heatUser.image.value.isNotEmpty)
                                                                            ? CircleAvatar(
                                                                                foregroundImage: MemoryImage(Uint8List.fromList(heatUser.image.value)),
                                                                                radius: refFontSize)
                                                                            : Icon(Icons.toys, size: refFontSize * 2)),
                                                              ]),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 8),
                                                        const Text('Gaps'),
                                                      ],
                                                    );
                                                  } else {
                                                    return const Text('');
                                                  }
                                                },
                                              );
                                            }
                                          }),
                                        Expanded(
                                          child: LayoutBuilder(builder: (context, constraint) {
                                            double bottomFontSize = refFontSize;
                                            if (constraint.maxHeight > 140 && constraint.maxWidth > 220) {
                                              bottomFontSize = Theme.of(context).textTheme.headlineSmall!.fontSize!;
                                            }
                                            return Column(
                                              children: [
                                                Expanded(
                                                  child: Center(child: LayoutBuilder(builder: (context, constraint) {
                                                    var textSample = "00  0000";
                                                    if (raceModel.motorSimulation) {
                                                      textSample += "  00L";
                                                    }
                                                    final fontSize =
                                                        min(refFontSize * constraint.maxWidth / textWidth(textSample, refFontSize), constraint.maxHeight / 2.0);

                                                    return IntrinsicHeight(
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Text(lapsHasValue ? heatLeaderboardIndicator.position.toString() : '',
                                                                  style: TextStyle(
                                                                    fontSize: fontSize,
                                                                  )),
                                                              Text('Pos')
                                                            ],
                                                          ),
                                                          Column(
                                                            children: [
                                                              Text(lapsHasValue ? heatLeaderboardIndicator.laps.value.toString() : '',
                                                                  style: TextStyle(fontSize: fontSize)),
                                                              Text('Laps')
                                                            ],
                                                          ),
                                                          if (raceModel.motorSimulation)
                                                            Column(
                                                              children: [
                                                                Text(energyLapsLeftHasValue ? "${heatLeaderboardIndicator.energyLapsLeft.value}L" : '',
                                                                    style: TextStyle(fontSize: fontSize)),
                                                                Text('Energy laps left')
                                                              ],
                                                            )
                                                        ],
                                                      ),
                                                    );
                                                  })),
                                                ),
                                                SizedBox(height: 16),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text(
                                                          timeTypeTimeLap != null && timeTypeTimeLap.time.hasValue()
                                                              ? timeTypeTimeLap.time.value.toStringAsFixed(2)
                                                              : '',
                                                          textAlign: TextAlign.end,
                                                          style: TextStyle(fontSize: bottomFontSize, color: fastestTimeTypeColor(timeTypeTimeLap)),
                                                        ),
                                                        Text('Latest')
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          timeTypeTimeLap != null && timeTypeTimeLap.fastestTime.hasValue()
                                                              ? timeTypeTimeLap.fastestTime.value.toStringAsFixed(2)
                                                              : '',
                                                          textAlign: TextAlign.end,
                                                          style: TextStyle(fontSize: bottomFontSize),
                                                        ),
                                                        Text('Fastest')
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          heatLeaderboardIndicator.gapInterval.value,
                                                          style: TextStyle(fontSize: bottomFontSize),
                                                        ),
                                                        Text('Interval')
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          heatLeaderboardIndicator.gapLeader.value,
                                                          style: TextStyle(fontSize: bottomFontSize),
                                                        ),
                                                        Text('Leader')
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          }),
                                        ),
                                        if (raceModel.motorSimulation)
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              ...[
                                                Expanded(
                                                  child: SfLinearGauge(minimum: 0, maximum: 100, orientation: LinearGaugeOrientation.vertical, barPointers: [
                                                    LinearBarPointer(
                                                      value: heatLeaderboardIndicator.energyPercent.toDouble(),
                                                      color: Theme.of(context).colorScheme.primary,
                                                    )
                                                  ]),
                                                ),
                                                const Text('Energy'),
                                              ]
                                            ],
                                          ),
                                      ]),
                                    ),
                                    if (constraint.maxHeight > 300) ...[
                                      SizedBox(height: 16),
                                      Consumer<HeatAnalysisLoadingModel>(builder: (context, model, _) {
                                        if (model.loading) {
                                          return const Center(child: Loading());
                                        } else {
                                          return Expanded(
                                            child: SfCartesianChart(
                                              plotAreaBorderWidth: 0,
                                              primaryXAxis: NumericAxis(
                                                majorGridLines: MajorGridLines(width: 0),
                                              ),
                                              primaryYAxis: NumericAxis(
                                                majorGridLines: MajorGridLines(width: 0),
                                              ),
                                              series: publicHeatChildState.heatAnalysisLapTimeLapQueues.entries
                                                  .where((x) => x.key == heatIndicator.indicatorId)
                                                  .map((kv) => FastLineSeries<HeatAnalysisLapTimeLapData, int>(
                                                        dataSource: kv.value.toList(),
                                                        xValueMapper: (data, _) => data.lap,
                                                        yValueMapper: (data, _) => data.lapTime,
                                                        color: Theme.of(context).colorScheme.primary,
                                                        trendlines: [
                                                          Trendline(
                                                              //width: 1,
                                                              dashArray: [2, 2],
                                                              type: TrendlineType.movingAverage,
                                                              period: 5,
                                                              color: Theme.of(context).colorScheme.secondary,
                                                              isVisibleInLegend: false)
                                                        ],
                                                        dataLabelSettings: DataLabelSettings(
                                                          isVisible: true,
                                                          builder: (data, point, series, pointIndex, seriesIndex) {
                                                            final d = data as HeatAnalysisLapTimeLapData;
                                                            if (d.pitlanes > 0) {
                                                              return Icon(Icons.car_repair);
                                                            } else if (d.pitlanes > 0) {
                                                              return Icon(Icons.car_crash);
                                                            }
                                                            return Text(d.lapTime != null ? d.lapTime.toString() : '');
                                                          },
                                                        ),
                                                      ))
                                                  .toList(),
                                            ),
                                          );
                                        }
                                      })
                                    ]
                                  ],
                                );
                              }),
                            ),
                          ),
                        );
                      }).toList()),
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
