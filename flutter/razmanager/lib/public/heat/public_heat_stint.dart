import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:protobuf/well_known_types/google/protobuf/duration.pb.dart' as protobuf_duration;

import '../../app_model.dart';
import '../../utilities/color_definitions.dart';
import '../../utilities/loading.dart';
import '../../utilities/timer_conversion.dart';
import '../race/public_race.model.dart';
import 'public_heat.model.dart';
import 'public_heat_child_base.dart';
import '../../protobuf/razmanager/protobuf/public/event.v1.pb.dart';
import '../../protobuf/razmanager/protobuf/public/heat.v1.pb.dart';
import '../../utilities/exception_message.dart';
import '../../utilities/grpc_client.dart';
import 'public_heat_stint.detail.dart';

class PublicHeatStintModel extends ChangeNotifier {
  PublicHeatStintModel(BuildContext context) {
    _context = context;
  }

  late BuildContext _context;
  int? heatUserKey;
  //List<HeatIndicatorStint> heatIndicatorStints = [];
  String? heatIndicatorId;
  List<TeamUser>? teamUsers;
  //TrendlineType trendlineType = TrendlineType.linear;

  void notify(int? heatUserKey) {
    this.heatUserKey = heatUserKey;
    final publicHeatChildState = _context.findAncestorStateOfType<PublicHeatChildStateBase>()!;
    final heatModel = _context.read<HeatModel>();

    if (heatUserKey != null) {
      // heatIndicatorStints = publicHeatChildState.heatProto.heatIndicators
      //     .singleWhere((x) => x.indicatorId == heatUserKey)
      //     .heatIndicatorStints;
      heatIndicatorId = heatModel.heatProto!.heatIndicators.singleWhere((x) => x.indicatorId == heatUserKey).id;
      publicHeatChildState.heatStintAnalysisSubscribe(heatUserKey);

      teamUsers = heatModel.heatUsers[heatUserKey]?.teamUsers;
    } else {
      publicHeatChildState.heatStintAnalysisUnsubscribe;
      heatIndicatorId = null;
      teamUsers = null;
    }
    notifyListeners();
  }
}

class PublicHeatStint extends StatefulWidget {
  const PublicHeatStint({super.key});

  @override
  State<PublicHeatStint> createState() => _PublicHeatStintState();
}

class _PublicHeatStintState extends State<PublicHeatStint> {
  late final PublicHeatChildStateBase publicHeatChildState;
  late final HeatModel heatModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    publicHeatChildState = context.findAncestorStateOfType<PublicHeatChildStateBase>()!;
    heatModel = context.read<HeatModel>();
  }

  @override
  void dispose() {
    if (publicHeatChildState.heatStintAnalysesStreamSubscription != null) {
      Future.microtask(publicHeatChildState.heatStintAnalysesStreamSubscription!.cancel);
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: 2 + (heatModel.teamHeat ? 1 : 0),
    child: Column(
      children: [
        TabBar.secondary(
          tabs: [
            Tab(text: 'Stints'),
            Tab(text: 'Lap times'),
            if (heatModel.teamHeat) Tab(text: 'Drivers'),
          ],
        ),
        ChangeNotifierProvider(
          create: (context) => PublicHeatStintModel(context),
          child: Expanded(child: TabBarView(children: [_PublicHeatStintList(), _PublicHeatStintLaps(), if (heatModel.teamHeat) _PublicHeatStintCompare()])),
        ),
      ],
    ),
  );
}

abstract class _PublicHeatStintTabBase extends PublicHeatStateDetailBase {}

abstract class _PublicHeatStintTabStateBase extends PublicHeatStateDetailStateBase {
  _PublicHeatStintTabStateBase({required this.child});

  final Widget child;
  // late final PublicHeatChildStateBase publicHeatChildState;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   publicHeatChildState = context.findAncestorStateOfType<PublicHeatChildStateBase>()!;
  // }

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
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Consumer<PublicHeatStintModel>(
                      builder: (context, model, _) => Column(
                        children: [
                          Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            children: [
                              ...heatModel.heatUsers.entries.map(
                                (x) => ChoiceChip(
                                  label: Text(heatModel.heatUsers[x.key]?.name.value ?? '?'),
                                  selected: model.heatUserKey == x.key,
                                  onSelected: (value) {
                                    if (value) {
                                      model.notify(x.key);
                                    } else {
                                      model.notify(null);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          if (model.heatUserKey == null)
                            Row(children: [Text("Please select a ${heatModel.teamHeat ? 'team' : 'driver'}.")])
                          else
                            Consumer<HeatStintAnalysisLoadingModel>(
                              builder: (context, model, _) {
                                if (model.loading) {
                                  return const Center(child: Loading());
                                } else {
                                  return child;
                                }
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
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

class _PublicHeatStintList extends _PublicHeatStintTabBase {
  @override
  State createState() => _PublicHeatStintListState();
}

class _PublicHeatStintListState extends _PublicHeatStintTabStateBase {
  _PublicHeatStintListState() : super(child: _PublicHeatStintListChild());
}

class _PublicHeatStintListChild extends StatefulWidget {
  @override
  State<_PublicHeatStintListChild> createState() => _PublicHeatStintListChildState();
}

class _PublicHeatStintListChildState extends State<_PublicHeatStintListChild> with GrpcClient, ExceptionMessage {
  late final PublicHeatChildStateBase publicHeatChildState;
  late final AppModel appModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    publicHeatChildState = context.findAncestorStateOfType<PublicHeatChildStateBase>()!;
    appModel = context.read<AppModel>();
  }

  Future<void> heatIndicatorStintDetail({String? id}) async {
    final heatIndicatorId = context.read<PublicHeatStintModel>().heatIndicatorId;
    await showDialog(
      context: context,
      builder: (context) {
        return PublicHeatStintDetail(parentId: heatIndicatorId, id: id ?? 'add');
      },
    );
  }

  @override
  Widget build(BuildContext context) => Expanded(
    child: Consumer<PublicHeatStintModel>(
      builder: (context, model, _) => Consumer<HeatStintAnalysisListModel>(
        builder: (context, _, __) => Row(
          key: UniqueKey(),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: LayoutBuilder(
                        builder: (BuildContext context, BoxConstraints constraints) => DataTable(
                          columnSpacing: 16,
                          columns: [
                            DataColumn(label: Text('Lap'), numeric: true),
                            DataColumn(label: Text('Laps'), numeric: true),
                            DataColumn(label: Text('Average'), numeric: true),
                            DataColumn(label: Text('Deslots'), numeric: true),
                            DataColumn(label: Text('Started at'), numeric: true),
                            DataColumn(label: Text('Duration'), numeric: true),
                            if (model.teamUsers != null && model.teamUsers!.isNotEmpty) DataColumn(label: Text('Driver')),
                            DataColumn(label: Text('Comments')),
                            if (appModel.isAuthenticated()) DataColumn(label: Text('')),
                          ],
                          rows: publicHeatChildState.heatStintAnalysisIndicatorStints
                              .map(
                                (x) => DataRow(
                                  cells: [
                                    DataCell(Text(x.lap.toString())),
                                    DataCell(Text(x.laps.isNotEmpty ? x.laps.length.toString() : "")),
                                    DataCell(Text(x.averageTime.hasValue() ? x.averageTime.value.toString() : "")),
                                    DataCell(
                                      Text(x.laps.isEmpty ? "" : x.laps.map((x) => x.carOffTracks).reduce((value, element) => value + element).toString()),
                                    ),
                                    DataCell(Text(x.laps.firstOrNull != null ? formatTimer(x.laps.firstOrNull!.timerElapsed) : "")),
                                    DataCell(Text(formatTimer(x.duration))),
                                    if (model.teamUsers != null && model.teamUsers!.isNotEmpty)
                                      DataCell(
                                        Text(
                                          x.eventUserId.hasValue()
                                              ? model.teamUsers!.singleWhere((teamUser) => teamUser.id == x.eventUserId.value).name.value
                                              : '',
                                        ),
                                      ),
                                    DataCell(Text(x.comments.hasValue() ? x.comments.value : '')),
                                    if (appModel.isAuthenticated())
                                      DataCell(
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () => heatIndicatorStintDetail(id: x.id),
                                        ),
                                      ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                if (appModel.isAuthenticated()) ...[
                  SizedBox(height: 16),
                  FilledButton.tonalIcon(
                    icon: const Icon(Icons.add),
                    label: const Text('Add a stint'),
                    onPressed: model.heatUserKey == null ? null : () async => await heatIndicatorStintDetail(),
                  ),
                ],
              ],
            ),
            if (model.teamUsers != null && model.teamUsers!.isNotEmpty)
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: SfCircularChart(
                        title: ChartTitle(text: 'Laps'),
                        legend: Legend(isVisible: true),
                        series: [
                          PieSeries<MapEntry<String, int>, String>(
                            dataSource: eventUserLaps(model),
                            xValueMapper: (data, _) => data.key,
                            yValueMapper: (data, _) => data.value,
                            pointColorMapper: (_, i) => ColorDefinitions.ordered.elementAt(i),
                            dataLabelSettings: DataLabelSettings(isVisible: true, textStyle: TextStyle(fontWeight: FontWeight.bold)),
                            animationDuration: 0,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SfCircularChart(
                        title: ChartTitle(text: 'Duration'),
                        legend: Legend(isVisible: true),
                        series: [
                          PieSeries<MapEntry<String, Duration>, String>(
                            dataSource: eventUserDuration(model),
                            xValueMapper: (data, _) => data.key,
                            yValueMapper: (data, _) => data.value.inSeconds,
                            pointColorMapper: (_, i) => ColorDefinitions.ordered.elementAt(i),
                            dataLabelSettings: DataLabelSettings(isVisible: true, textStyle: TextStyle(fontWeight: FontWeight.bold)),
                            dataLabelMapper: (datum, index) => formatDuration(datum.value),
                            animationDuration: 0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    ),
  );

  String formatTimer(protobuf_duration.Duration? value) {
    if (value == null || !value.hasNanos()) {
      return "";
    }

    var duration = Duration(milliseconds: (value.seconds.toInt() * 1000 + value.nanos / 1000000).round());

    final formatter = NumberFormat("00");
    final hours = duration.inHours.floor();
    return "${hours == 0 ? '' : '$hours:'}${formatter.format(duration.inMinutes % 60)}:${formatter.format(duration.inSeconds % 60)}";
  }

  Duration protobufDurationToDuration(protobuf_duration.Duration? value) {
    if (value == null || !value.hasNanos()) {
      return Duration();
    }

    return Duration(milliseconds: (value.seconds.toInt() * 1000 + value.nanos / 1000000).round());
  }

  String formatDuration(Duration value) {
    final formatter = NumberFormat("00");
    final hours = value.inHours.floor();
    return "${hours == 0 ? '' : '$hours:'}${formatter.format(value.inMinutes % 60)}:${formatter.format(value.inSeconds % 60)}";
  }

  List<MapEntry<String, int>> eventUserLaps(PublicHeatStintModel model) {
    return groupBy(publicHeatChildState.heatStintAnalysisIndicatorStints, (x) => x.eventUserId)
        .map((key, value) {
          return MapEntry(
            key.hasValue() && model.teamUsers != null ? model.teamUsers!.singleWhere((teamUser) => teamUser.id == key.value).name.value : '',
            value.map((x) => x.laps.length).reduce((value, element) => value + element),
          );
        })
        .entries
        .toList();
  }

  List<MapEntry<String, Duration>> eventUserDuration(PublicHeatStintModel model) {
    return groupBy(publicHeatChildState.heatStintAnalysisIndicatorStints, (x) => x.eventUserId)
        .map((key, value) {
          return MapEntry(
            key.hasValue() && model.teamUsers != null ? model.teamUsers!.singleWhere((teamUser) => teamUser.id == key.value).name.value : '',
            value.map((x) => protobufDurationToDuration(x.duration)).reduce((value, element) => value + element),
          );
        })
        .entries
        .toList();
  }

  Map<T, List<S>> groupBy<S, T>(Iterable<S> values, T Function(S) key) {
    var map = <T, List<S>>{};
    for (var element in values) {
      (map[key(element)] ??= []).add(element);
    }
    return map;
  }
}

class _PublicHeatStintLaps extends _PublicHeatStintTabBase {
  @override
  State createState() => _PublicHeatStintLapsState();
}

class _PublicHeatStintLapsState extends _PublicHeatStintTabStateBase {
  _PublicHeatStintLapsState() : super(child: _PublicHeatStintLapsChart());
}

class _PublicHeatStintLapsChart extends StatefulWidget {
  @override
  State<_PublicHeatStintLapsChart> createState() => _PublicHeatStintLapsChartState();
}

class _PublicHeatStintLapsChartState extends State<_PublicHeatStintLapsChart> with ExceptionMessage, TimerConversion {
  late final _PublicHeatStintTabStateBase publicHeatStintTabState;
  late final PublicHeatChildStateBase publicHeatChildState;
  //ZoomPanBehavior zoomPanBehavior = ZoomPanBehavior(enablePinching: true, enableSelectionZooming: true, enableMouseWheelZooming: true, enablePanning: true);
  bool dataLabelsVisible = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    publicHeatStintTabState = context.findAncestorStateOfType<_PublicHeatStintTabStateBase>()!;
    publicHeatChildState = context.findAncestorStateOfType<PublicHeatChildStateBase>()!;
  }

  @override
  void dispose() {
    for (var heatStintAnalysisLapSerie in publicHeatChildState.heatStintAnalysisLapSeries.entries) {
      heatStintAnalysisLapSerie.value.chartSeriesController = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<PublicHeatStintModel>(
        builder: (context, model, _) {
          final raceModel = context.read<RaceModel>();
          final publicHeatChildState = context.findAncestorStateOfType<PublicHeatChildStateBase>()!;

          // reset legends...
          //zoomPanBehavior.reset();
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
                zoomPanBehavior: ZoomPanBehavior(enablePinching: true, enableSelectionZooming: true, enableMouseWheelZooming: true, enablePanning: true),
                //onZooming: (zoomingArgs) => debugPrint("onZooming: ${zoomingArgs.currentZoomFactor}"),
                // onActualRangeChanged: (rangeChangedArgs) {
                //   if (rangeChangedArgs.orientation == AxisOrientation.vertical) {
                //     rangeChangedArgs.visibleMin = rangeChangedArgs.visibleMin - (rangeChangedArgs.visibleMin % rangeChangedArgs.visibleInterval);
                //   }
                // },
                series: [
                  ...publicHeatChildState.heatStintAnalysisIndicatorStints.indexed.map(
                    (item) => FastLineSeries<HeatStintAnalysisIndicatorStintLap, DateTime>(
                      onRendererCreated: (controller) {
                        final heatAnalysisLapSerie = publicHeatChildState.heatStintAnalysisLapSeries[item.$2.id];
                        //debugPrint("heatAnalysisLapSerie ${item.$2.id} ${publicHeatChildState.heatStintAnalysisLapSeries.length} $heatAnalysisLapSerie");
                        // if (heatAnalysisLapSerie == null) {
                        //   for (var element in publicHeatChildState.heatStintAnalysisLapSeries.entries) {
                        //     debugPrint("element ${element.key} ${element.value} ");
                        //   }
                        // }
                        Future.microtask(() => heatAnalysisLapSerie!.chartSeriesController = controller);
                      },
                      dataSource: item.$2.laps,
                      xValueMapper: (data, _) => dateTimeFromProtobufDuration(data.timerElapsed),
                      yValueMapper: (data, _) => data.time.hasValue() ? data.time.value : null,
                      dataLabelSettings: DataLabelSettings(
                        isVisible: dataLabelsVisible,
                        builder: (data, point, series, pointIndex, seriesIndex) {
                          final d = data as HeatStintAnalysisIndicatorStintLap;
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
                      trendlines: [
                        Trendline(
                          //width: 1,
                          dashArray: [2, 2],
                          type: TrendlineType.movingAverage,
                          period: 5,
                          color: Theme.of(context).colorScheme.secondary,
                          isVisibleInLegend: false,
                        ),
                      ],
                      animationDuration: 0,
                      name: legend(model, item.$2),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Row(
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
        },
      ),
    );
  }

  String legend(PublicHeatStintModel model, HeatStintAnalysisIndicatorStint item) {
    var result = "Lap ${item.lap}";

    TeamUser? teamUser;

    if (model.teamUsers != null && item.eventUserId.hasValue()) {
      teamUser = model.teamUsers?.singleWhere((teamUser) => teamUser.id == item.eventUserId.value);
    }
    if (teamUser != null) {
      result += ", ${teamUser.name.value}";
    }

    if (item.comments.hasValue()) {
      result += ", ${item.comments.value}";
    }

    return result;
  }
}

class _PublicHeatStintCompare extends _PublicHeatStintTabBase {
  @override
  State createState() => _PublicHeatStintCompareState();
}

class _PublicHeatStintCompareState extends _PublicHeatStintTabStateBase {
  _PublicHeatStintCompareState() : super(child: _PublicHeatStintCompareChart());
}

class _PublicHeatStintCompareChart extends StatefulWidget {
  @override
  State<_PublicHeatStintCompareChart> createState() => _PublicHeatStintCompareChartState();
}

class _PublicHeatStintCompareChartState extends State<_PublicHeatStintCompareChart> with ExceptionMessage {
  late final _PublicHeatStintTabStateBase publicHeatStintTabState;
  late final PublicHeatChildStateBase publicHeatChildState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    publicHeatStintTabState = context.findAncestorStateOfType<_PublicHeatStintTabStateBase>()!;
    publicHeatChildState = context.findAncestorStateOfType<PublicHeatChildStateBase>()!;
  }

  @override
  Widget build(BuildContext context) => Expanded(
    child: Consumer<PublicHeatStintModel>(
      builder: (context, model, _) => SfCartesianChart(
        key: UniqueKey(),
        primaryXAxis: NumericAxis(title: const AxisTitle(text: 'Stint')),
        primaryYAxis: NumericAxis(title: AxisTitle(text: 'Lap time (s)')),
        legend: const Legend(isVisible: true, toggleSeriesVisibility: true),
        trackballBehavior: TrackballBehavior(enable: true, activationMode: ActivationMode.singleTap),
        zoomPanBehavior: ZoomPanBehavior(enablePanning: true, enableMouseWheelZooming: true, enablePinching: true, enableSelectionZooming: true),
        series: [
          ...groupBy(
            publicHeatChildState.heatStintAnalysisIndicatorStints.where((x) => x.averageTime.hasValue()).indexed,
            (x) => x.$2.eventUserId,
          ).entries.indexed.map(
            (item) => LineSeries<(int, HeatStintAnalysisIndicatorStint), int>(
              dataSource: item.$2.value,
              xValueMapper: (data, _) => data.$1 + 1,
              yValueMapper: (data, _) => data.$2.averageTime.value,
              color: ColorDefinitions.ordered.elementAt(item.$1),
              dataLabelMapper: (data, _) => data.$2.lap.toString(),
              dataLabelSettings: DataLabelSettings(isVisible: true),
              //dataLabelMapper: (data, _) => data.flags,
              // dataLabelSettings: DataLabelSettings(
              //   isVisible: true,
              //   labelAlignment: ChartDataLabelAlignment.top,
              //   builder: (data, point, series, pointIndex, seriesIndex) {
              //     final d = data as _HeatAnalysisLap;
              //     if (d.flags.isEmpty) {
              //       return Text('${d.lap}');
              //     } else {
              //       return Icon(Icons.warning,
              //           color: publicHeatChildState
              //               .heatIndicatorColors[kv.key]);
              //     }
              //   },
              // ),
              animationDuration: 0,
              name: legend(model, item.$2.value.first.$2.eventUserId),
            ),
          ),
        ],
      ),
    ),
  );

  String legend(PublicHeatStintModel model, StringValue item) {
    TeamUser? teamUser;

    if (model.teamUsers != null && item.hasValue()) {
      teamUser = model.teamUsers?.singleWhere((teamUser) => teamUser.id == item.value);
    }
    if (teamUser == null) {
      return "";
    }

    return teamUser.name.value;
  }

  Map<T, List<S>> groupBy<S, T>(Iterable<S> values, T Function(S) key) {
    var map = <T, List<S>>{};
    for (var element in values) {
      (map[key(element)] ??= []).add(element);
    }
    return map;
  }
}
