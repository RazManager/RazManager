import 'dart:async';
import 'dart:collection';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:protobuf/well_known_types/google/protobuf/duration.pb.dart' as protobuf_duration;

import '../../app_model.dart';
import '../../utilities/color_definitions.dart';
import '../../utilities/loading.dart';
import '../../utilities/timer_conversion.dart';
import '../public_mixin.dart';
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
  String? heatIndicatorId;
  List<TeamUser>? teamUsers;

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
  late bool smallLayout;

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
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      smallLayout = constraints.maxWidth < 1000 && heatModel.teamHeat;
      return DefaultTabController(
        length: 2 + (heatModel.teamHeat ? 2 : 0), // + (smallLayout ? 1 : 0)
        child: Column(
          children: [
            TabBar.secondary(
              tabs: [
                Tab(text: 'Stints'),
                if (heatModel.teamHeat) Tab(text: smallLayout ? 'Percentages' : 'Driver percentages'),
                Tab(text: 'Lap times'),
                if (heatModel.teamHeat) Tab(text: smallLayout ? 'Averages' : 'Driver averages'),
              ],
            ),
            ChangeNotifierProvider(
              create: (context) => PublicHeatStintModel(context),
              child: Expanded(
                child: TabBarView(
                  children: [
                    _PublicHeatStintStints(),
                    //if (smallLayout) _PublicHeatStintDriverPercentages(),
                    if (heatModel.teamHeat) _PublicHeatStintDriverPercentages(),
                    _PublicHeatStintLaps(),
                    if (heatModel.teamHeat) _PublicHeatStintCompare(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

abstract class _PublicHeatStintTabBase extends PublicHeatStateDetailBase {}

abstract class _PublicHeatStintTabStateBase extends PublicHeatStateDetailStateBase with PublicFormatter {
  _PublicHeatStintTabStateBase({required this.child});

  final Widget child;
  late final PublicHeatChildStateBase publicHeatChildState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    publicHeatChildState = context.findAncestorStateOfType<PublicHeatChildStateBase>()!;
  }

  @override
  Widget foreground() {
    var fontSize = Theme.of(context).textTheme.labelLarge!.fontSize!;
    var choiceChipWidth =
        publicHeatChildState.heatModel.heatProto!.heatIndicators
            .map((x) => textWidth(publicHeatChildState.seriesName(indicatorId: x.indicatorId, useShortName: false), fontSize) + 34 + 16)
            .reduce((value, element) => value + element) +
        40;

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
                          LayoutBuilder(
                            builder: (context, constraints) {
                              if (choiceChipWidth > constraints.maxWidth) {
                                return DropdownMenu<int>(
                                  label: Text(publicHeatChildState.heatModel.teamHeat ? "Team *" : 'Driver *'),
                                  inputDecorationTheme: InputDecorationTheme(enabledBorder: null),
                                  initialSelection: model.heatUserKey,
                                  dropdownMenuEntries: heatModel.heatUsers.entries
                                      .map(
                                        (kv) => DropdownMenuEntry(
                                          value: kv.key,
                                          label: publicHeatChildState.seriesName(indicatorId: kv.key, useShortName: false),
                                        ),
                                      )
                                      .toList(),
                                  onSelected: (value) {
                                    if (value != null) {
                                      model.notify(value);
                                    }
                                  },
                                );
                              } else {
                                return Wrap(
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
                                );
                              }
                            },
                          ),
                          SizedBox(height: 16),
                          if (model.heatUserKey == null)
                            Row(children: [Text("Please select a ${heatModel.teamHeat ? 'team' : 'driver'}.")])
                          else
                            Expanded(
                              child: Consumer<HeatStintAnalysisLoadingModel>(
                                builder: (context, model, _) {
                                  if (model.loading) {
                                    return const Center(child: Loading());
                                  } else {
                                    return child;
                                  }
                                },
                              ),
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

class _PublicHeatStintStints extends _PublicHeatStintTabBase {
  @override
  State createState() => _PublicHeatStintStintsState();
}

class _PublicHeatStintStintsState extends _PublicHeatStintTabStateBase {
  _PublicHeatStintStintsState() : super(child: _PublicHeatStintStintsLayout());
}

class _PublicHeatStintStintsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final publicHeatStintState = context.findAncestorStateOfType<_PublicHeatStintState>()!;
    return Consumer<PublicHeatStintModel>(
      builder: (context, model, _) => LayoutBuilder(
        builder: (context, constraints) {
          // if (!publicHeatStintState.smallLayout && model.teamUsers != null && model.teamUsers!.isNotEmpty) {
          //   return Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       _PublicHeatStintList(),
          //       Column(children: [_PublicHeatStintDriverPercentagesLapsChart(), _PublicHeatStintDriverPercentagesDurationChart()]),
          //     ],
          //   );
          // } else {
          //return const Placeholder();
          return _PublicHeatStintList();
          //}
        },
      ),
    );
  }
}

class _PublicHeatStintList extends StatefulWidget {
  @override
  State<_PublicHeatStintList> createState() => _PublicHeatStintListState();
}

class _PublicHeatStintListState extends State<_PublicHeatStintList> with GrpcClient, ExceptionMessage {
  late final PublicHeatChildStateBase publicHeatChildState;
  late final AppModel appModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    publicHeatChildState = context.findAncestorStateOfType<PublicHeatChildStateBase>()!;
    appModel = context.read<AppModel>();
  }

  Future<void> heatIndicatorStintDetail(String? id) async {
    final heatIndicatorId = context.read<PublicHeatStintModel>().heatIndicatorId;
    await showDialog(
      context: context,
      builder: (context) {
        return PublicHeatStintDetail(parentId: heatIndicatorId, id: id ?? 'add');
      },
    );
  }

  @override
  Widget build(BuildContext context) => Consumer<PublicHeatStintModel>(
    builder: (context, model, _) => Consumer<HeatStintAnalysisListModel>(
      builder: (context, _, __) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: SfDataGridTheme(
              data: SfDataGridThemeData(frozenPaneLineWidth: 0, frozenPaneElevation: 0, frozenPaneLineColor: Colors.transparent),
              child: SfDataGrid(
                source: StintsDataSource(stints: publicHeatChildState.heatStintAnalysisIndicatorStints, model: model, edit: heatIndicatorStintDetail),
                columns: stintColumns(model),
                allowSorting: true,
                allowFiltering: true,
                showColumnHeaderIconOnHover: true,
                columnWidthMode: ColumnWidthMode.fitByCellValue,
                columnWidthCalculationRange: ColumnWidthCalculationRange.allRows,
                footerFrozenColumnsCount: 1,
                //gridLinesVisibility: GridLinesVisibility.,
                //headerGridLinesVisibility: GridLinesVisibility.both,
              ),
            ),
          ),
          if (appModel.isAuthenticated()) ...[
            SizedBox(height: 16),
            FilledButton.tonalIcon(
              icon: const Icon(Icons.add),
              label: const Text('Add a stint'),
              onPressed: model.heatUserKey == null ? null : () async => await heatIndicatorStintDetail(null),
            ),
          ],
        ],
      ),
    ),
  );

  List<GridColumn> stintColumns(PublicHeatStintModel model) => [
    GridColumn(
      columnName: 'lap',
      //autoFitPadding: EdgeInsets.only(left: 32),
      label: Container(
        //padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerRight,
        child: Text('Lap', overflow: TextOverflow.ellipsis),
      ),
    ),
    GridColumn(
      columnName: 'laps',
      //autoFitPadding: EdgeInsets.only(left: 32),
      label: Container(
        //padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerRight,
        child: Text('Laps', overflow: TextOverflow.ellipsis),
      ),
    ),
    GridColumn(
      columnName: 'average',
      //autoFitPadding: EdgeInsets.only(left: 32),
      label: Container(
        //padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerRight,
        child: Text('Average', overflow: TextOverflow.ellipsis),
      ),
    ),
    GridColumn(
      columnName: 'deslots',
      autoFitPadding: EdgeInsets.only(left: 48),
      //width: 70,
      //columnWidthMode: ColumnWidthMode.fitByColumnName,
      label: Container(
        //padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerRight,
        child: Text('Deslots', overflow: TextOverflow.ellipsis),
      ),
    ),
    GridColumn(
      //width: 80,
      columnName: 'startedAt',
      label: Container(
        //padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerRight,
        child: Text('Started at', overflow: TextOverflow.ellipsis),
      ),
    ),
    GridColumn(
      columnName: 'duration',
      //autoFitPadding: EdgeInsets.only(left: 48),
      label: Container(
        //padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerRight,
        child: Text('Duration', overflow: TextOverflow.ellipsis),
      ),
    ),
    GridColumn(
      columnName: 'teamUser',
      //autoFitPadding: EdgeInsets.only(left: 100),
      visible: model.teamUsers != null && model.teamUsers!.isNotEmpty,
      label: Container(
        padding: EdgeInsets.only(left: 16.0),
        alignment: Alignment.centerLeft,
        child: Text('Driver', overflow: TextOverflow.ellipsis),
      ),
    ),
    GridColumn(
      columnName: 'comments',
      columnWidthMode: ColumnWidthMode.lastColumnFill,
      label: Container(
        padding: EdgeInsets.only(left: 16.0),
        //padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: Text('Comments', overflow: TextOverflow.ellipsis),
      ),
    ),
    GridColumn(
      columnName: 'edit',
      width: 80,
      visible: appModel.isAuthenticated(),
      label: Text(''), //    Container(
      //padding: EdgeInsets.symmetric(horizontal: 16.0),
      //alignment: Alignment.center,
      //child: Text('Comments', overflow: TextOverflow.ellipsis),
      //),
    ),
  ];
}

class StintsDataSource extends DataGridSource {
  StintsDataSource({required List<HeatStintAnalysisIndicatorStint> stints, required PublicHeatStintModel model, required this.edit}) {
    dataGridRows = stints
        .map(
          (x) => DataGridRow(
            cells: [
              DataGridCell(columnName: 'lap', value: x.lap),
              DataGridCell(columnName: 'laps', value: x.laps.isNotEmpty ? x.laps.length.toString() : ""),
              DataGridCell(columnName: 'average', value: x.averageTime.hasValue() ? x.averageTime.value.toString() : ""),
              DataGridCell(
                columnName: 'deslots',
                value: x.laps.isEmpty ? "" : x.laps.map((x) => x.deslots).reduce((value, element) => value + element).toString(),
              ),
              DataGridCell(columnName: 'startedAt', value: x.laps.firstOrNull != null ? formatTimer(x.laps.firstOrNull!.timerElapsed) : ""),
              DataGridCell(columnName: 'duration', value: formatTimer(x.duration)),
              DataGridCell(
                columnName: 'teamUser',
                value: x.eventUserId.hasValue() && model.teamUsers!.where((teamUser) => teamUser.id == x.eventUserId.value).singleOrNull != null
                    ? model.teamUsers!.singleWhere((teamUser) => teamUser.id == x.eventUserId.value).name.value
                    : '',
              ),
              DataGridCell(columnName: 'comments', value: x.comments.hasValue() ? x.comments.value : ''),
              DataGridCell(columnName: 'edit', value: x.id),
            ],
          ),
        )
        .toList();
  }

  final Future<void> Function(String? id) edit;
  late List<DataGridRow> dataGridRows;

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) => DataGridRowAdapter(
    cells: row
        .getCells()
        .map(
          (dataGridCell) => Container(
            alignment: (dataGridCell.columnName == 'teamUser' || dataGridCell.columnName == 'comments') ? Alignment.centerLeft : Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: dataGridCell.columnName != 'edit'
                ? Text(dataGridCell.value.toString(), overflow: TextOverflow.ellipsis)
                : IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => edit(dataGridCell.value), // heatIndicatorStintDetail(id: dataGridCell.value),
                  ),
          ),
        )
        .toList(),
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
}

class _PublicHeatStintDriverPercentages extends _PublicHeatStintTabBase {
  @override
  State createState() => _PublicHeatStintDriverPercentagesState();
}

class _PublicHeatStintDriverPercentagesState extends _PublicHeatStintTabStateBase {
  _PublicHeatStintDriverPercentagesState() : super(child: _PublicHeatStintDriverPercentagesChild());
}

class _PublicHeatStintDriverPercentagesChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxHeight * 1.5 < constraints.maxWidth) {
          return Row(
            children: [
              Flexible(child: _PublicHeatStintDriverPercentagesLapsChart()),
              Flexible(child: _PublicHeatStintDriverPercentagesDurationChart()),
            ],
          );
        } else {
          return Column(
            children: [
              Flexible(child: _PublicHeatStintDriverPercentagesLapsChart()),
              Flexible(child: _PublicHeatStintDriverPercentagesDurationChart()),
            ],
          );
        }
      },
    );
  }
}

class _PublicHeatStintDriverPercentagesLapsChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PublicHeatStintModel>(
      builder: (context, model, _) => Consumer<HeatStintAnalysisListModel>(
        builder: (context, _, __) => SfCircularChart(
          title: ChartTitle(text: 'Laps'),
          legend: Legend(isVisible: true),
          series: [
            PieSeries<MapEntry<String, int>, String>(
              dataSource: eventUserLaps(context, model),
              xValueMapper: (data, _) => data.key,
              yValueMapper: (data, _) => data.value,
              pointColorMapper: (_, i) => ColorDefinitions.ordered.elementAt(i),
              dataLabelSettings: DataLabelSettings(isVisible: true, textStyle: TextStyle(fontWeight: FontWeight.bold)),
              animationDuration: 0,
            ),
          ],
        ),
      ),
    );
  }

  List<MapEntry<String, int>> eventUserLaps(BuildContext context, PublicHeatStintModel model) {
    final publicHeatChildState = context.findAncestorStateOfType<PublicHeatChildStateBase>()!;
    return groupBy(publicHeatChildState.heatStintAnalysisIndicatorStints, (x) => x.eventUserId)
        .map((key, value) {
          final teamUser = key.hasValue() ? model.teamUsers?.where((teamUser) => teamUser.id == key.value).singleOrNull : null;
          return MapEntry(teamUser != null ? teamUser.name.value : '', value.map((x) => x.laps.length).reduce((value, element) => value + element));
        })
        .entries
        .toList();
  }
}

class _PublicHeatStintDriverPercentagesDurationChart extends StatelessWidget with TimerConversion {
  @override
  Widget build(BuildContext context) {
    return Consumer<PublicHeatStintModel>(
      builder: (context, model, _) => Consumer<HeatStintAnalysisListModel>(
        builder: (context, _, __) => SfCircularChart(
          title: ChartTitle(text: 'Duration'),
          legend: Legend(isVisible: true),
          series: [
            PieSeries<MapEntry<String, Duration>, String>(
              dataSource: eventUserDuration(context, model),
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
    );
  }

  List<MapEntry<String, Duration>> eventUserDuration(BuildContext context, PublicHeatStintModel model) {
    final publicHeatChildState = context.findAncestorStateOfType<PublicHeatChildStateBase>()!;
    return groupBy(publicHeatChildState.heatStintAnalysisIndicatorStints, (x) => x.eventUserId)
        .map((key, value) {
          final teamUser = key.hasValue() ? model.teamUsers?.where((teamUser) => teamUser.id == key.value).singleOrNull : null;
          return MapEntry(
            teamUser != null ? teamUser.name.value : '',
            value.map((x) => durationFromProtobufDuration(x.duration)).reduce((value, element) => value + element),
          );
        })
        .entries
        .toList();
  }

  String formatDuration(Duration value) {
    final formatter = NumberFormat("00");
    final hours = value.inHours.floor();
    return "${hours == 0 ? '' : '$hours:'}${formatter.format(value.inMinutes % 60)}:${formatter.format(value.inSeconds % 60)}";
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
    return Consumer<PublicHeatStintModel>(
      builder: (context, model, _) {
        final raceModel = context.read<RaceModel>();
        final publicHeatChildState = context.findAncestorStateOfType<PublicHeatChildStateBase>()!;

        // reset legends...
        //zoomPanBehavior.reset();
        return Row(
          children: [
            Expanded(
              child: SfCartesianChart(
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
                legend: const Legend(isVisible: true, toggleSeriesVisibility: true, position: LegendPosition.bottom, overflowMode: LegendItemOverflowMode.wrap),
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
                          } else if (d.deslots > 0) {
                            return Icon(Icons.car_crash);
                          }
                          return Text('${d.lap}');
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
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.zoom_in),
                  tooltip: "Zoom in",
                  onPressed: null, // () { zoomPanBehavior.zoomIn(); },
                ),
                IconButton(
                  icon: const Icon(Icons.zoom_out),
                  tooltip: "Zoom out",
                  onPressed: null, // () { zoomPanBehavior.zoomOut(); },
                ),
                IconButton(
                  icon: const Icon(Icons.undo),
                  tooltip: "Reset zoom",
                  onPressed: null, // () { zoomPanBehavior.reset(); },
                ),
                IconButton(
                  icon: Icon(dataLabelsVisible ? Icons.clear : Icons.info),
                  tooltip: "Show pit stops, deslots, and lap numbers",
                  onPressed: () {
                    dataLabelsVisible = !dataLabelsVisible;
                    setState(() {});
                  },
                ),
              ],
            ),
          ],
        );
      },
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
  Widget build(BuildContext context) => Consumer<PublicHeatStintModel>(
    builder: (context, model, _) => SfCartesianChart(
      key: UniqueKey(),
      primaryXAxis: NumericAxis(title: const AxisTitle(text: 'Stint')),
      primaryYAxis: NumericAxis(title: AxisTitle(text: 'Lap time (s)')),
      legend: const Legend(isVisible: true, toggleSeriesVisibility: true, position: LegendPosition.bottom, overflowMode: LegendItemOverflowMode.wrap),
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
            animationDuration: 0,
            name: legend(model, item.$2.value.first.$2.eventUserId),
          ),
        ),
      ],
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
