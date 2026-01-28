import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../race/public_race.model.dart';
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

class _PublicHeatAnalysesState extends State<PublicHeatAnalyses> {
  @override
  didChangeDependencies() {
    super.didChangeDependencies();

    final publicHeatChildState = context.findAncestorStateOfType<PublicHeatChildStateBase>()!;
    publicHeatChildState.heatAnalysisSubscribe();
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
            Opacity(opacity: 0.95, child: Card(child: PublicHeatHeatStateHeader())),
            Expanded(
              child: Opacity(
                opacity: 0.95,
                child: Card(
                  child: Padding(padding: const EdgeInsets.all(16.0), child: child),
                ),
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
  late final PublicHeatChildStateBase publicHeatAnalysesState;
  // ZoomPanBehavior zoomPanBehavior = ZoomPanBehavior(
  //   zoomMode: ZoomMode.x,
  //   enablePinching: true,
  //   enableSelectionZooming: true,
  //   enableMouseWheelZooming: true,
  //   enablePanning: true,
  // );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    publicHeatAnalysesState = context.findAncestorStateOfType<PublicHeatChildStateBase>()!;
  }

  @override
  void dispose() {
    for (var heatAnalysisPositionSerie in publicHeatAnalysesState.heatAnalysisPositionSeries.entries) {
      heatAnalysisPositionSerie.value.chartSeriesController = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //zoomPanBehavior.reset();
    return Consumer<HeatModel>(
      builder: (context, heatModel, _) => Consumer<HeatAnalysisLoadingModel>(
        builder: (context, model, _) {
          if (model.loading) {
            return const Center(child: Loading());
          } else {
            return Stack(
              children: [
                SfCartesianChart(
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
                  legend: const Legend(isVisible: true, toggleSeriesVisibility: true),
                  //zoomPanBehavior: zoomPanBehavior,
                  zoomPanBehavior: ZoomPanBehavior(
    zoomMode: ZoomMode.x,
    enablePinching: true,
    enableSelectionZooming: true,
    enableMouseWheelZooming: true,
    enablePanning: true,
  ),
                  series: publicHeatAnalysesState.heatAnalysisPositionSeries.entries
                      .map(
                        (kv) => FastLineSeries<HeatAnalysisPositionData, int>(
                          onRendererCreated: (controller) {
                            Future.microtask(() {
                              //debugPrint("_PublicHeatAnalysesPositionsChartState onRendererCreated microtask");
                              kv.value.chartSeriesController = controller;
                            });
                          },
                          dataSource: kv.value.data,
                          xValueMapper: (data, _) => data.lap,
                          yValueMapper: (data, _) => data.position,
                          // dataLabelSettings: DataLabelSettings(
                          //   isVisible: true,
                          //   builder:
                          //       (data, point, series, pointIndex, seriesIndex) {
                          //     final d = data as HeatAnalysisPositionData;
                          //     if (d.pitlanes > 0) {
                          //       return Icon(Icons.car_repair);
                          //     } else if (d.pitlanes > 0) {
                          //       return Icon(Icons.car_crash);
                          //     }
                          //     return Text('');
                          //   },
                          // ),
                          animationDuration: 0,
                          name: publicHeatAnalysesState.seriesName(kv.key),
                          color: heatModel.heatIndicatorColors[kv.key],
                        ),
                      )
                      .toList(),
                ),
                // Positioned(
                //   right: 0,
                //   bottom: 0,
                //   child: Column(
                //     children: [
                //       IconButton(
                //         icon: const Icon(Icons.zoom_in),
                //         tooltip: "Zoom in",
                //         onPressed: () {
                //           zoomPanBehavior.zoomIn();
                //         },
                //       ),
                //       IconButton(
                //         icon: const Icon(Icons.zoom_out),
                //         tooltip: "Zoom out",
                //         onPressed: () {
                //           zoomPanBehavior.zoomOut();
                //         },
                //       ),
                //       IconButton(
                //         icon: const Icon(Icons.undo),
                //         tooltip: "Reset zoom",
                //         onPressed: () {
                //           zoomPanBehavior.reset();
                //         },
                //       ),
                //     ],
                //   ),
                // ),
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

class _PublicHeatAnalysesGapsChartState extends State<_PublicHeatAnalysesGapsChart> with ExceptionMessage {
  late final PublicHeatChildStateBase publicHeatAnalysesState;
  //ZoomPanBehavior zoomPanBehavior = ZoomPanBehavior(enablePinching: true, enableSelectionZooming: true, enableMouseWheelZooming: true, enablePanning: true);
  bool dataLabelsVisible = false;

  int heatUserKey = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    publicHeatAnalysesState = context.findAncestorStateOfType<PublicHeatChildStateBase>()!;
  }

  @override
  void dispose() {
    publicHeatAnalysesState.heatAnalysisGapReset();

    super.dispose();
  }

  void setNewHeatUserKey(int value) {
    setState(() {
      heatUserKey = value;
      publicHeatAnalysesState.heatAnalysisGapReset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final raceModel = context.read<RaceModel>();

    //zoomPanBehavior.reset();

    return Consumer<HeatModel>(
      builder: (context, heatModel, _) => Consumer<HeatAnnounceModel>(
        builder: (context, heatAnnounceModel, _) {
          final indicatorId = heatUserKey == 0 ? heatAnnounceModel.currentLeader?.indicatorId : heatUserKey;
          publicHeatAnalysesState.heatAnalysisGapReset();

          String? currentLeaderHeatUserText;
          final currentLeaderIndicatorId = heatAnnounceModel.currentLeader?.indicatorId;
          if (currentLeaderIndicatorId != null) {
            final currentLeaderHeatUser = heatModel.heatUsers[currentLeaderIndicatorId];
            currentLeaderHeatUserText = " (${currentLeaderHeatUser!.name.value})";
          }

          return Column(
            children: [
              Wrap(
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
                      label: Text(publicHeatAnalysesState.seriesName(kv.key)),
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
              ),
              Expanded(
                child: Consumer<HeatAnalysisLoadingModel>(
                  builder: (context, heatAnalysisLoadingModel, _) {
                    if (heatAnalysisLoadingModel.loading) {
                      return const Center(child: Loading());
                    } else {
                      //zoomPanBehavior.reset();
                      return Stack(
                        children: [
                          SfCartesianChart(
                            key: UniqueKey(),
                            primaryXAxis: DateTimeAxis(
                              title: const AxisTitle(text: 'Heat time'),
                              dateFormat: DateFormat(DateFormat.HOUR24_MINUTE_SECOND),
                              isInversed: raceModel.isInversed,
                              plotBands: publicHeatAnalysesState.heatAnalysisHeatStateTypes
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
                            legend: const Legend(isVisible: true, toggleSeriesVisibility: true),
                            trackballBehavior: TrackballBehavior(enable: true, activationMode: ActivationMode.singleTap),
                            //zoomPanBehavior: zoomPanBehavior,
                            zoomPanBehavior: ZoomPanBehavior(
                              enablePinching: true,
                              enableSelectionZooming: true,
                              enableMouseWheelZooming: true,
                              enablePanning: true,
                            ),
                            series: [
                              if (indicatorId != null)
                                ...publicHeatAnalysesState.heatAnalysisGapSeries[indicatorId]!.entries.map(
                                  (kv) => FastLineSeries<HeatAnalysisGapData, DateTime>(
                                    onRendererCreated: (controller) {
                                      Future.microtask(() => kv.value.chartSeriesController = controller);
                                    },
                                    dataSource: kv.value.data,
                                    xValueMapper: (data, _) => data.timerElapsed,
                                    yValueMapper: (data, _) => data.gap,
                                    animationDuration: 0,
                                    name: publicHeatAnalysesState.seriesName(kv.key),
                                    color: heatModel.heatIndicatorColors[kv.key],
                                  ),
                                ),
                            ],
                          ),
                          // Positioned(
                          //   right: 0,
                          //   top: 0,
                          //   child: Row(
                          //     children: [
                          //       IconButton(
                          //         icon: const Icon(Icons.zoom_in),
                          //         tooltip: "Zoom in",
                          //         onPressed: () {
                          //           zoomPanBehavior.zoomIn();
                          //         },
                          //       ),
                          //       IconButton(
                          //         icon: const Icon(Icons.zoom_out),
                          //         tooltip: "Zoom out",
                          //         onPressed: () {
                          //           zoomPanBehavior.zoomOut();
                          //         },
                          //       ),
                          //       IconButton(
                          //         icon: const Icon(Icons.undo),
                          //         tooltip: "Reset zoom",
                          //         onPressed: () {
                          //           zoomPanBehavior.reset();
                          //         },
                          //       ),
                          //     ],
                          //   ),
                          // ),
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
  //ZoomPanBehavior zoomPanBehavior = ZoomPanBehavior(enablePinching: true, enableSelectionZooming: true, enableMouseWheelZooming: true, enablePanning: true);
  bool dataLabelsVisible = false;
  bool? zommingUp;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    publicHeatChildState = context.findAncestorStateOfType<PublicHeatChildStateBase>()!;
  }

  @override
  void dispose() {
    for (var heatAnalysisLapSerie in publicHeatChildState.heatAnalysisLapSeries.entries) {
      heatAnalysisLapSerie.value.chartSeriesController = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final raceModel = context.read<RaceModel>();

    //zoomPanBehavior.reset();
    return Consumer<HeatModel>(
      builder: (context, heatModel, _) => Consumer<HeatAnalysisLoadingModel>(
        builder: (context, model, _) {
          if (model.loading) {
            return const Center(child: Loading());
          } else {
            return Stack(
              children: [
                SfCartesianChart(
                  key: UniqueKey(),
                  primaryXAxis: DateTimeAxis(
                    title: const AxisTitle(text: 'Heat time'),
                    dateFormat: DateFormat(DateFormat.HOUR24_MINUTE_SECOND),
                    isInversed: raceModel.isInversed,
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
                  primaryYAxis: NumericAxis(title: AxisTitle(text: 'Lap time (s)')),
                  legend: const Legend(isVisible: true, toggleSeriesVisibility: true),
                  trackballBehavior: TrackballBehavior(enable: true, activationMode: ActivationMode.singleTap),
                  //zoomPanBehavior: zoomPanBehavior,
                  zoomPanBehavior: ZoomPanBehavior(enablePinching: true, enableSelectionZooming: true, enableMouseWheelZooming: true, enablePanning: true),
                  // onZoomEnd: (zoomPanArgs) {
                  //   if (zoomPanArgs.axis?.isVertical ?? false) {
                  //     debugPrint(
                  //         "onZoomEnd zoomingInProgress=${zoomPanArgs.axis?.zoomingInProgress} currentZoomPosition=${zoomPanArgs.currentZoomPosition} previousZoomPosition=${zoomPanArgs.previousZoomPosition}");
                  //     if (zoomPanArgs.axis?.isInversed ?? false) {
                  //      zoomPanArgs.currentZoomPosition = 1 - zoomPanArgs.currentZoomPosition ;
                  //     }
                  //     zoomPanArgs.currentZoomPosition = 0;
                  //     zoomPanArgs.axis!.initialZoomPosition = 0;
                  //   }
                  // },
                  // onZoomEnd: (zoomPanArgs) {
                  //   if (zoomPanArgs.axis?.isVertical ?? false) {
                  //     debugPrint(
                  //         "onZoomEnd zoomingInProgress=${zoomPanArgs.axis?.zoomingInProgress}");
                  //   }
                  // },
                  // onActualRangeChanged: (rangeChangedArgs) {
                  //   if (rangeChangedArgs.orientation == AxisOrientation.vertical) {
                  //     final change = rangeChangedArgs.visibleMin %
                  //         rangeChangedArgs.visibleInterval /
                  //         rangeChangedArgs.visibleInterval;
                  //     debugPrint(
                  //         "onActualRangeChanged ${rangeChangedArgs.visibleMin % rangeChangedArgs.visibleInterval / rangeChangedArgs.visibleInterval}");

                  //     if (change < 0.5) {
                  //       debugPrint("onActualRangeChanged snap!");
                  //       rangeChangedArgs.visibleMin = rangeChangedArgs.visibleMin -
                  //           (rangeChangedArgs.visibleMin %
                  //               rangeChangedArgs.visibleInterval);
                  //     }
                  //   }
                  // },
                  series: [
                    ...publicHeatChildState.heatAnalysisLapSeries.entries.map(
                      (kv) => FastLineSeries<HeatAnalysisLapData, DateTime>(
                        onRendererCreated: (controller) {
                          Future.microtask(() => kv.value.chartSeriesController = controller);
                        },
                        dataSource: kv.value.data,
                        xValueMapper: (data, _) => data.timerElapsed,
                        yValueMapper: (data, _) => data.lapTime,
                        dataLabelSettings: DataLabelSettings(
                          isVisible: dataLabelsVisible,
                          builder: (data, point, series, pointIndex, seriesIndex) {
                            final d = data as HeatAnalysisLapData;
                            if (d.pitlanes > 0) {
                              return Icon(Icons.car_repair);
                            } else if (d.pitlanes > 0) {
                              return Icon(Icons.car_crash);
                            } else if (dataLabelsVisible) {
                              return Text('${d.lap}');
                            }
                            return Text('');
                          },
                        ),
                        animationDuration: 0,
                        name: publicHeatChildState.seriesName(kv.key),
                        color: heatModel.heatIndicatorColors[kv.key],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Column(
                    children: [
                      IconButton(
                        icon: Icon(dataLabelsVisible ? Icons.cancel : Icons.numbers),
                        tooltip: "Show lap number",
                        onPressed: () {
                          dataLabelsVisible = !dataLabelsVisible;
                          setState(() {});
                        },
                      ),
                      // IconButton(
                      //   icon: const Icon(Icons.zoom_in),
                      //   tooltip: "Zoom in",
                      //   onPressed: () {
                      //     zoomPanBehavior.zoomIn();
                      //   },
                      // ),
                      // IconButton(
                      //   icon: const Icon(Icons.zoom_out),
                      //   tooltip: "Zoom out",
                      //   onPressed: () {
                      //     zoomPanBehavior.zoomOut();
                      //   },
                      // ),
                      // IconButton(
                      //   icon: const Icon(Icons.undo),
                      //   tooltip: "Reset zoom",
                      //   onPressed: () {
                      //     zoomPanBehavior.reset();
                      //   },
                      // ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
