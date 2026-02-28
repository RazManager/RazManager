import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razmanager/public/public_mixin.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../utilities/analysis_cartesian_chart.dart';
import '../event/public_event.model.dart';
import 'public_heat.model.dart';
import 'public_heat_child_base.dart';
import '../../protobuf/razmanager/protobuf/public/heat.v1.pb.dart';
import '../../utilities/exception_message.dart';
import '../../utilities/loading.dart';

class PublicHeatAnalyses extends StatefulWidget {
  const PublicHeatAnalyses({super.key});

  @override
  State<PublicHeatAnalyses> createState() => _PublicHeatAnalysesState();
}

class _PublicHeatAnalysesState extends State<PublicHeatAnalyses> with PublicFormatter {
  late double legendWidthName;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();

    final publicHeatChildState = context.findAncestorStateOfType<PublicHeatChildStateBase>()!;
    publicHeatChildState.heatAnalysisSubscribe();

    var fontSize = Theme.of(context).textTheme.bodySmall!.fontSize!;
    legendWidthName = publicHeatChildState.heatModel.heatProto!.heatIndicators
        .map((x) => textWidth(publicHeatChildState.seriesName(indicatorId: x.indicatorId, useShortName: false), fontSize) + 10 + 15 + 20)
        .reduce((value, element) => value + element);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar.secondary(
            tabs: [
              Tab(text: 'Positions'),
              Tab(text: 'Gaps'),
              Tab(text: 'Lap times'),
            ],
          ),
          Expanded(child: TabBarView(children: [_PublicHeatAnalysesPositions(), _PublicHeatAnalysesGaps(), _PublicHeatAnalysesLaps()])),
        ],
      ),
    );
  }
}

abstract class _PublicHeatAnalysesTabBase extends PublicHeatStateDetailBase {}

abstract class _PublicHeatAnalysesTabStateBase extends PublicHeatStateDetailStateBase {
  _PublicHeatAnalysesTabStateBase({required this.child});

  final Widget child;

  @override
  Widget foreground() {
    return Consumer<HeatModel>(
      builder: (context, heatModel, _) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(child: PublicHeatHeatStateHeader()),
            Expanded(
              child: Card(
                child: Padding(padding: const EdgeInsets.all(16.0), child: child),
              ),
            ),
            if (heatModel.heatCommandPermissions.isNotEmpty) PublicHeatBottomNavigationBar(),
          ],
        ),
      ),
    );
  }
}

class _PublicHeatAnalysesPositions extends _PublicHeatAnalysesTabBase {
  @override
  State createState() => _PublicHeatAnalysesPositionsState();
}

class _PublicHeatAnalysesPositionsState extends _PublicHeatAnalysesTabStateBase {
  _PublicHeatAnalysesPositionsState() : super(child: _PublicHeatAnalysesPositionsChart());
}

class _PublicHeatAnalysesPositionsChart extends StatefulWidget {
  @override
  State<_PublicHeatAnalysesPositionsChart> createState() => _PublicHeatAnalysesPositionsChartState();
}

class _PublicHeatAnalysesPositionsChartState extends State<_PublicHeatAnalysesPositionsChart> with ExceptionMessage {
  late final PublicHeatChildStateBase publicHeatChildState;
  ZoomPanBehavior zoomPanBehavior = ZoomPanBehavior(
    zoomMode: ZoomMode.x,
    enablePinching: true,
    enableSelectionZooming: true,
    enableMouseWheelZooming: true,
    enablePanning: true,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    publicHeatChildState = context.findAncestorStateOfType<PublicHeatChildStateBase>()!;
  }

  @override
  void dispose() {
    for (var heatAnalysisPositionSerie in publicHeatChildState.heatAnalysisPositionSeries.entries) {
      heatAnalysisPositionSerie.value.chartSeriesController = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HeatModel>(
      builder: (context, heatModel, _) => Consumer<HeatAnalysisLoadingModel>(
        builder: (context, model, _) {
          if (model.loading) {
            return const Center(child: Loading());
          } else {
            final publicHeatAnalysesState = context.findAncestorStateOfType<_PublicHeatAnalysesState>()!;
            return Row(
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) => SfCartesianChart(
                      key: UniqueKey(),
                      primaryXAxis: NumericAxis(
                        title: const AxisTitle(text: 'Lap'),
                        //numberFormat: NumberFormat.decimalPatternDigits(decimalDigits: 0),
                      ),
                      primaryYAxis: NumericAxis(
                        title: const AxisTitle(text: 'Position'),
                        minimum: 1,
                        maximum: heatModel.heatUsers.length.toDouble(),
                        interval: 1,
                        isInversed: true,
                      ),
                      legend: Legend(isVisible: true, toggleSeriesVisibility: true, position: LegendPosition.bottom, overflowMode: LegendItemOverflowMode.wrap),
                      zoomPanBehavior: zoomPanBehavior,
                      // zoomPanBehavior: ZoomPanBehavior(
                      //   zoomMode: ZoomMode.x,
                      //   enablePinching: true,
                      //   enableSelectionZooming: true,
                      //   enableMouseWheelZooming: true,
                      //   enablePanning: true,
                      // ),
                      series: publicHeatChildState.heatAnalysisPositionSeries.entries
                          .map(
                            (kv) => LineSeries<HeatAnalysisPositionData, int>(
                              onRendererCreated: (controller) {
                                Future.microtask(() {
                                  //debugPrint("_PublicHeatAnalysesPositionsChartState onRendererCreated microtask");
                                  kv.value.chartSeriesController = controller;
                                });
                              },
                              dataSource: kv.value.data,
                              xValueMapper: (data, _) => data.lap,
                              yValueMapper: (data, _) => data.position,
                              animationDuration: 0,
                              name: publicHeatChildState.seriesName(
                                indicatorId: kv.key,
                                useShortName: publicHeatAnalysesState.legendWidthName > constraints.maxWidth,
                              ),
                              color: heatModel.heatIndicatorColors[kv.key],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(icon: const Icon(Icons.zoom_in), tooltip: "Zoom in", onPressed: zoomPanBehavior.zoomIn),
                    IconButton(icon: const Icon(Icons.zoom_out), tooltip: "Zoom out", onPressed: zoomPanBehavior.zoomOut),
                    IconButton(icon: const Icon(Icons.undo), tooltip: "Reset zoom", onPressed: zoomPanBehavior.reset),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class _PublicHeatAnalysesGaps extends _PublicHeatAnalysesTabBase {
  @override
  State createState() => _PublicHeatAnalysesGapsState();
}

class _PublicHeatAnalysesGapsState extends _PublicHeatAnalysesTabStateBase {
  _PublicHeatAnalysesGapsState() : super(child: _PublicHeatAnalysesGapsChart());
}

class _PublicHeatAnalysesGapsChart extends StatefulWidget {
  @override
  State<_PublicHeatAnalysesGapsChart> createState() => _PublicHeatAnalysesGapsChartState();
}

class _PublicHeatAnalysesGapsChartState extends State<_PublicHeatAnalysesGapsChart> with ExceptionMessage, PublicFormatter {
  late final PublicHeatChildStateBase publicHeatChildState;
  ZoomPanBehavior zoomPanBehavior = ZoomPanBehavior(enablePinching: true, enableSelectionZooming: true, enableMouseWheelZooming: true, enablePanning: true);
  bool dataLabelsVisible = false;

  int heatUserKey = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    publicHeatChildState = context.findAncestorStateOfType<PublicHeatChildStateBase>()!;
  }

  @override
  void dispose() {
    publicHeatChildState.heatAnalysisGapReset();

    super.dispose();
  }

  void setNewHeatUserKey(int value) {
    setState(() {
      heatUserKey = value;
      publicHeatChildState.heatAnalysisGapReset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EventModel>(
      builder: (context, eventModel, _) {
        final followHeatUserKey = publicHeatChildState.heatModel.heatUsers.entries
            .where((x) => x.value!.id == publicHeatChildState.eventModel.followEventUserId)
            .singleOrNull
            ?.key;
        if (followHeatUserKey != null && heatUserKey == 0) {
          heatUserKey = followHeatUserKey;
        }

        return Consumer<HeatModel>(
          builder: (context, heatModel, _) => Consumer<HeatAnnounceModel>(
            builder: (context, heatAnnounceModel, _) {
              final indicatorId = heatUserKey == 0 ? heatAnnounceModel.currentLeader?.indicatorId : heatUserKey;
              publicHeatChildState.heatAnalysisGapReset();

              String? currentLeaderHeatUserText;
              final currentLeaderIndicatorId = heatAnnounceModel.currentLeader?.indicatorId;
              if (currentLeaderIndicatorId != null) {
                final currentLeaderHeatUser = heatModel.heatUsers[currentLeaderIndicatorId];
                currentLeaderHeatUserText = " (${currentLeaderHeatUser!.name.value})";
              }

              var fontSize = Theme.of(context).textTheme.labelLarge!.fontSize!;
              var choiceChipWidth =
                  textWidth("Current leader$currentLeaderHeatUserText", fontSize) +
                  publicHeatChildState.heatModel.heatProto!.heatIndicators
                      .map((x) => textWidth(publicHeatChildState.seriesName(indicatorId: x.indicatorId, useShortName: false), fontSize) + 34 + 16)
                      .reduce((value, element) => value + element) +
                  40;

              return Column(
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (choiceChipWidth > constraints.maxWidth) {
                        return DropdownMenu<int>(
                          label: Text(publicHeatChildState.heatModel.teamHeat ? "Team *" : 'Driver *'),
                          inputDecorationTheme: InputDecorationTheme(enabledBorder: null),
                          initialSelection: heatUserKey,
                          dropdownMenuEntries: [
                            DropdownMenuEntry(value: 0, label: "Current leader$currentLeaderHeatUserText"),
                            ...heatModel.heatUsers.entries.map(
                              (kv) => DropdownMenuEntry(
                                value: kv.key,
                                label: publicHeatChildState.seriesName(indicatorId: kv.key, useShortName: false),
                              ),
                            ),
                          ],
                          onSelected: (value) {
                            if (value != null) {
                              setNewHeatUserKey(value);
                            }
                          },
                        );
                      } else {
                        return Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: [
                            ChoiceChip(
                              label: Text("Current leader$currentLeaderHeatUserText"),
                              selected: heatUserKey == 0,
                              onSelected: (value) {
                                setNewHeatUserKey(0);
                              },
                            ),
                            ...heatModel.heatUsers.entries.map(
                              (kv) => ChoiceChip(
                                label: Text(publicHeatChildState.seriesName(indicatorId: kv.key, useShortName: false)),
                                selected: heatUserKey == kv.key,
                                onSelected: (value) {
                                  setState(() {
                                    if (value) {
                                      setNewHeatUserKey(kv.key);
                                    } else {
                                      setNewHeatUserKey(0);
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  Expanded(
                    child: Consumer<HeatAnalysisLoadingModel>(
                      builder: (context, heatAnalysisLoadingModel, _) {
                        if (heatAnalysisLoadingModel.loading) {
                          return const Center(child: Loading());
                        } else {
                          final publicHeatAnalysesState = context.findAncestorStateOfType<_PublicHeatAnalysesState>()!;
                          //zoomPanBehavior.reset();
                          return Row(
                            children: [
                              Expanded(
                                child: LayoutBuilder(
                                  builder: (context, constraints) => SfCartesianChart(
                                    key: UniqueKey(),
                                    primaryXAxis: DateTimeAxis(
                                      title: const AxisTitle(text: 'Heat time'),
                                      dateFormat: DateFormat(DateFormat.HOUR24_MINUTE_SECOND),
                                      isInversed: publicHeatChildState.raceModel.isInversed,
                                      plotBands: publicHeatChildState.heatAnalysisHeatStateTypes
                                          .map(
                                            (x) => PlotBand(
                                              start: x.timerElapsed,
                                              end: x.timerElapsed,
                                              borderColor: switch (x.heatStateTypeId) {
                                                HeatStateTypeId.HEAT_STATE_TYPE_ID_RUNNING => Colors.greenAccent,
                                                HeatStateTypeId.HEAT_STATE_TYPE_ID_YELLOW => Colors.yellowAccent,
                                                HeatStateTypeId.HEAT_STATE_TYPE_ID_RED => Colors.redAccent,
                                                _ => Colors.white,
                                              },
                                            ),
                                          )
                                          .toList(),
                                    ),
                                    primaryYAxis: NumericAxis(
                                      title: AxisTitle(text: 'Gap (s)'),
                                      plotBands: [PlotBand(start: 0, end: 0, borderColor: heatModel.heatIndicatorColors[indicatorId]!)],
                                    ),
                                    legend: const Legend(
                                      isVisible: true,
                                      toggleSeriesVisibility: true,
                                      position: LegendPosition.bottom,
                                      overflowMode: LegendItemOverflowMode.wrap,
                                    ),
                                    trackballBehavior: TrackballBehavior(enable: true, activationMode: ActivationMode.singleTap),
                                    zoomPanBehavior: zoomPanBehavior,
                                    // zoomPanBehavior: ZoomPanBehavior(
                                    //   enablePinching: true,
                                    //   enableSelectionZooming: true,
                                    //   enableMouseWheelZooming: true,
                                    //   enablePanning: true,
                                    // ),
                                    series: [
                                      if (indicatorId != null)
                                        ...publicHeatChildState.heatAnalysisGapSeries[indicatorId]!.entries.map(
                                          (kv) => LineSeries<HeatAnalysisGapData, DateTime>(
                                            onRendererCreated: (controller) {
                                              Future.microtask(() => kv.value.chartSeriesController = controller);
                                            },
                                            dataSource: kv.value.data,
                                            xValueMapper: (data, _) => data.timerElapsed,
                                            yValueMapper: (data, _) => data.gap,
                                            animationDuration: 0,
                                            name: publicHeatChildState.seriesName(
                                              indicatorId: kv.key,
                                              useShortName: publicHeatAnalysesState.legendWidthName > constraints.maxWidth,
                                            ),

                                            color: heatModel.heatIndicatorColors[kv.key],
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(icon: const Icon(Icons.zoom_in), tooltip: "Zoom in", onPressed: zoomPanBehavior.zoomIn),
                                  IconButton(icon: const Icon(Icons.zoom_out), tooltip: "Zoom out", onPressed: zoomPanBehavior.zoomOut),
                                  IconButton(icon: const Icon(Icons.undo), tooltip: "Reset zoom", onPressed: zoomPanBehavior.reset),
                                ],
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class _PublicHeatAnalysesLaps extends _PublicHeatAnalysesTabBase {
  @override
  State createState() => _PublicHeatAnalysesLapsState();
}

class _PublicHeatAnalysesLapsState extends _PublicHeatAnalysesTabStateBase {
  _PublicHeatAnalysesLapsState() : super(child: _PublicHeatAnalysesLapsChart());
}

class _PublicHeatAnalysesLapsChart extends StatefulWidget {
  @override
  State<_PublicHeatAnalysesLapsChart> createState() => _PublicHeatAnalysesLapsChartState();
}

class _PublicHeatAnalysesLapsChartState extends State<_PublicHeatAnalysesLapsChart> with ExceptionMessage {
  late final PublicHeatChildStateBase publicHeatChildState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    publicHeatChildState = context.findAncestorStateOfType<PublicHeatChildStateBase>()!;
  }

  @override
  void dispose() {
    for (var serie in publicHeatChildState.heatAnalysisLapSeries.entries) {
      serie.value.chartSeriesController = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EventModel>(
      builder: (context, eventModel, _) => Consumer<HeatModel>(
        builder: (context, heatModel, _) => Consumer<HeatAnalysisLoadingModel>(
          builder: (context, model, _) {
            if (model.loading) {
              return const Center(child: Loading());
            } else {
              final publicHeatAnalysesState = context.findAncestorStateOfType<_PublicHeatAnalysesState>()!;
              final plotBandHeatStates = publicHeatChildState.heatAnalysisHeatStateTypes
                  .where(
                    (x) =>
                        x.heatStateTypeId == HeatStateTypeId.HEAT_STATE_TYPE_ID_RUNNING ||
                        x.heatStateTypeId == HeatStateTypeId.HEAT_STATE_TYPE_ID_YELLOW ||
                        x.heatStateTypeId == HeatStateTypeId.HEAT_STATE_TYPE_ID_RED,
                  )
                  .toList();

              return LayoutBuilder(
                builder: (context, constraints) => AnalysisCartesianChart(
                  constraints: constraints,
                  primaryXAxis: DateTimeAxis(
                    title: AxisTitle(text: constraints.maxHeight > 500 ? 'Heat time' : null),
                    dateFormat: DateFormat(DateFormat.HOUR24_MINUTE_SECOND),
                    isInversed: publicHeatChildState.raceModel.isInversed,
                    plotBands: plotBandHeatStates
                        .where(
                          (x) => x.heatStateTypeId == HeatStateTypeId.HEAT_STATE_TYPE_ID_YELLOW || x.heatStateTypeId == HeatStateTypeId.HEAT_STATE_TYPE_ID_RED,
                        )
                        .map((x) {
                          final index = plotBandHeatStates.indexOf(x);
                          DateTime end;
                          if (x.heatStateTypeId == HeatStateTypeId.HEAT_STATE_TYPE_ID_RED) {
                            end = x.timerElapsed;
                          } else {
                            if (index == -1 || index + 1 >= plotBandHeatStates.length) {
                              end = x.timerElapsed;
                            } else {
                              end = plotBandHeatStates[index + 1].timerElapsed;
                            }
                          }
                          final color = switch (x.heatStateTypeId) {
                            HeatStateTypeId.HEAT_STATE_TYPE_ID_YELLOW => Colors.yellowAccent,
                            HeatStateTypeId.HEAT_STATE_TYPE_ID_RED => Colors.redAccent,
                            _ => Colors.white,
                          };
                          return PlotBand(start: x.timerElapsed, end: end, borderColor: color, color: color, opacity: 0.5);
                        })
                        .toList(),
                  ),
                  primaryYAxis: NumericAxis(title: AxisTitle(text: constraints.maxWidth > 500 ? 'Lap time (s)' : null)),
                  onLegendTapped: (legendTapArgs) {
                    final chartSerie = legendTapArgs.series as LineSeriesRenderer<HeatAnalysisLapData, DateTime>;
                    final mapSerie = publicHeatChildState.heatAnalysisLapSeries.entries.toList()[legendTapArgs.seriesIndex!];
                    final eventUserId = publicHeatChildState.heatModel.heatUsers[mapSerie.key]!.id;
                    if (chartSerie.isVisible()) {
                      eventModel.followEventUserIds.removeWhere((x) => x == eventUserId);
                    } else {
                      eventModel.followEventUserIds.add(eventUserId);
                    }
                  },
                  seriesGenerator: (isDataLabelVisible) => [
                    ...publicHeatChildState.heatAnalysisLapSeries.entries.map(
                      (kv) => LineSeries<HeatAnalysisLapData, DateTime>(
                        onRendererCreated: (controller) {
                          Future.microtask(() => kv.value.chartSeriesController = controller);
                        },
                        dataSource: kv.value.data,
                        xValueMapper: (data, _) => data.timerElapsed,
                        yValueMapper: (data, _) => data.lapTime,
                        dataLabelSettings: DataLabelSettings(
                          isVisible: isDataLabelVisible,
                          builder: (data, point, series, pointIndex, seriesIndex) {
                            final d = data as HeatAnalysisLapData;
                            if (d.pitlanes > 0) {
                              return Icon(Icons.car_repair, color: heatModel.heatIndicatorColors[kv.key]);
                            } else if (d.deslots > 0) {
                              return Icon(Icons.car_crash, color: heatModel.heatIndicatorColors[kv.key]);
                            }
                            return Text('${d.lap}');
                          },
                        ),
                        animationDuration: 0,
                        name: publicHeatChildState.seriesName(
                          indicatorId: kv.key,
                          useShortName: publicHeatAnalysesState.legendWidthName > constraints.maxWidth,
                        ),
                        color: heatModel.heatIndicatorColors[kv.key],
                        initialIsVisible: eventModel.followEventUserIds.where((x) => x == publicHeatChildState.heatModel.heatUsers[kv.key]!.id).isNotEmpty,
                      ),
                    ),
                  ],
                  showDataLabelButton: true,
                  initialIsDataLabelVisible: publicHeatChildState.eventModel.followEventUserIds.length == 1,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
