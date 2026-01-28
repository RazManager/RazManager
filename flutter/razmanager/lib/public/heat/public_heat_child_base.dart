import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../app_model.dart';
import '../../protobuf/razmanager/protobuf/public/event.v1.pb.dart';
import '../../protobuf/razmanager/protobuf/public/race.v1.pb.dart';
import '../../protobuf/razmanager/protobuf/public/heat.service.v1.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/public/heat.v1.pb.dart';
import '../../protobuf/razmanager/protobuf/public/race_feature_type_id.v1.pb.dart';
import '../../utilities/exception_message.dart';
import '../../utilities/timer_conversion.dart';
import '../event/public_event.model.dart';
import '../public_mixin.dart';
import '../race/public_race.model.dart';
import 'public_heat.model.dart';

abstract class PublicHeatChildBase extends StatefulWidget {
  const PublicHeatChildBase({super.key, required this.id});

  final String id;
}

abstract class PublicHeatChildStateBase extends State<PublicHeatChildBase> with ExceptionMessage, TimerConversion, PublicFormatter {
  late final String id;
  late final EventModel eventModel;
  late final RaceModel raceModel;
  late final HeatModel heatModel;
  late final HeatStateModel heatStateModel;
  late final HeatStintAnalysisLoadingModel heatStintAnalysisLoadingModel;
  late final HeatStintAnalysisListModel heatStintAnalysisListModel;
  StreamSubscription<EventState>? eventStateStreamSubscription;
  StreamSubscription<HeatState>? heatStateStreamSubscription;
  StreamSubscription<HeatLeaderboard>? heatLeaderboardStreamSubscription;
  StreamSubscription<HeatAnalyses>? heatAnalysesStreamSubscription;
  StreamSubscription<HeatStintAnalysis>? heatStintAnalysesStreamSubscription;
  Map<int, HeatAnalysisPositionSerie> heatAnalysisPositionSeries = {};
  Map<int, Map<int, HeatAnalysisGapSerie>> heatAnalysisGapSeries = {};
  Map<int, HeatAnalysisLapSerie> heatAnalysisLapSeries = {};
  Map<int, Queue<HeatAnalysisLapTimeLapData>> heatAnalysisLapTimeLapQueues = {};
  List<HeatAnalysisHeatStateType> heatAnalysisHeatStateTypes = [];
  List<HeatStintAnalysisIndicatorStint> heatStintAnalysisIndicatorStints = [];
  Map<String, HeatStintAnalysisLapSerie> heatStintAnalysisLapSeries = {};

  int? heatStintAnalysisSubscribeIndicatorId;

  @override
  void initState() {
    super.initState();
    id = widget.id;
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();

    eventModel = context.read<EventModel>();
    raceModel = context.read<RaceModel>();
    heatModel = context.read<HeatModel>();
    heatStateModel = context.read<HeatStateModel>();
    heatStintAnalysisLoadingModel = context.read<HeatStintAnalysisLoadingModel>();
    heatStintAnalysisListModel = context.read<HeatStintAnalysisListModel>();

    heatModel.refreshHeat(context: context, id: widget.id);
  }

  @override
  void dispose() {
    if (eventStateStreamSubscription != null) {
      Future.microtask(eventStateStreamSubscription!.cancel);
    }

    if (heatStateStreamSubscription != null) {
      Future.microtask(heatStateStreamSubscription!.cancel);
    }

    if (heatLeaderboardStreamSubscription != null) {
      Future.microtask(heatLeaderboardStreamSubscription!.cancel);
    }

    if (heatAnalysesStreamSubscription != null) {
      Future.microtask(heatAnalysesStreamSubscription!.cancel);
    }

    if (heatStintAnalysesStreamSubscription != null) {
      Future.microtask(heatStintAnalysesStreamSubscription!.cancel);
    }

    Future.microtask(heatModel.releaseHeat);

    super.dispose();
  }

  void heatRefreshed({required HeatModel heatModel}) {
    debugPrint("heatRefreshed");

    heatClear(heatModel: heatModel);

    Future.microtask(heatStateSubscribe);
  }

  void heatClear({required HeatModel heatModel}) {
    debugPrint("heatClear");

    context.read<HeatDriverboardGapModel>().initialize(heatModel.heatProto!.heatIndicators);

    heatAnalysisHeatStateTypes.clear();

    heatAnalysisPositionSeries.clear();
    heatAnalysisPositionSeries.addEntries(heatModel.heatProto!.heatIndicators.map((x) => MapEntry(x.indicatorId, HeatAnalysisPositionSerie())));

    heatAnalysisGapSeries.clear();
    heatAnalysisGapSeries.addEntries(
      heatModel.heatProto!.heatIndicators.map((heatIndicator) {
        final Map<int, HeatAnalysisGapSerie> otherHeatIndicatorSeries = {};
        otherHeatIndicatorSeries.addEntries(
          heatModel.heatProto!.heatIndicators
              .where((otherHeatIndicator) => otherHeatIndicator.indicatorId != heatIndicator.indicatorId)
              .map((otherHeatIndicator) => MapEntry(otherHeatIndicator.indicatorId, HeatAnalysisGapSerie())),
        );
        return MapEntry(heatIndicator.indicatorId, otherHeatIndicatorSeries);
      }),
    );

    heatAnalysisLapSeries.clear();
    heatAnalysisLapSeries.addEntries(heatModel.heatProto!.heatIndicators.map((x) => MapEntry(x.indicatorId, HeatAnalysisLapSerie())));

    heatAnalysisLapTimeLapQueues.clear();
    heatAnalysisLapTimeLapQueues.addEntries(heatModel.heatProto!.heatIndicators.map((x) => MapEntry(x.indicatorId, Queue<HeatAnalysisLapTimeLapData>())));

    // Cannot be cleared
    //heatStintAnalysisIndicatorStints = [];
    //heatStintAnalysisLapSeries.clear();

    // dispose chartseriescontrollers?
  }

  Future<void> heatStateSubscribe() async {
    if (heatStateStreamSubscription != null) {
      await heatStateStreamSubscription!.cancel();
    }
    heatStateStreamSubscription = heatModel
        .heatServiceClient()
        .heatStateSubscribe(StringValue(value: id))
        .listen(
          (data) {
            context.read<HeatStateModel>().notify(data);
            context.read<HeatStateHeaderModel>().notify(data, raceModel.raceProto!);

            if (data.heatStateType.id == HeatStateTypeId.HEAT_STATE_TYPE_ID_OPENED) {
              heatClear(heatModel: heatModel);
            }
          },
          onDone: () => debugPrint('heatStateSubscribe done'),
          onError: (exception) async {
            debugPrint("heatStateSubscribe $exception");
            await eventModel.handleGrpcError(exception);
            await heatStateSubscribe();
          },
        );
  }

  Future<void> heatLeaderboardSubscribe() async {
    debugPrint("heatLeaderboardSubscribe before check");
    if (heatLeaderboardStreamSubscription != null) {
      return;
    }
    debugPrint("heatLeaderboardSubscribe after check");

    final heatLeaderboardModel = context.read<HeatLeaderboardModel>();
    final heatAnnounceModel = context.read<HeatAnnounceModel>();

    heatLeaderboardStreamSubscription = heatModel
        .heatServiceClient()
        .heatLeaderboardSubscribe(StringValue(value: id))
        .listen(
          (data) {
            heatLeaderboardModel.notify(data);
            heatAnnounceModel.update(data);
          },
          onDone: () => debugPrint('Done...'),
          onError: (exception) async {
            debugPrint("heatLeaderboardSubscribe $exception");
            await heatLeaderboardStreamSubscription!.cancel();
            heatLeaderboardStreamSubscription = null;
            await eventModel.handleGrpcError(exception);
            await heatLeaderboardSubscribe();
          },
        );
  }

  Future<void> heatAnalysisSubscribe() async {
    debugPrint("heatAnalysisSubscribe before check");
    if (heatAnalysesStreamSubscription != null) {
      return;
    }
    debugPrint("heatAnalysisSubscribe after check");

    final heatDriverboardGapModel = context.read<HeatDriverboardGapModel>();
    final heatAnalysisLoadingModel = context.read<HeatAnalysisLoadingModel>();

    heatAnalysisLoadingModel.notify(true);

    final listenStartedAt = DateTime.now();
    heatAnalysesStreamSubscription = heatModel
        .heatServiceClient()
        .heatAnalysesSubscribe(StringValue(value: id))
        .listen(
          (data) {
            if (heatAnalysisLoadingModel.loading) {
              debugPrint('heatAnalysesSubscribe data.items.length: ${data.items.length}, listen loading duration: ${DateTime.now().difference(listenStartedAt)}');
              heatAnalysisLoadingModel.notify(false);
            }

            final dataStartedAt = DateTime.now();

            bool gapUpdate = false;

            for (var item in data.items) {
              DateTime timerElapsed;
              if (!raceModel.isInversed) {
                timerElapsed = dateTimeFromProtobufDuration(item.timerElapsed);
              } else {
                timerElapsed = dateTimeFromDuration(
                  (durationFromProtobufDuration(raceModel.raceProto!.raceHeatEndDurationDuration) - durationFromProtobufDuration(item.timerElapsed)),
                );
              }
              if (item.indicatorId.hasValue()) {
                if (item.hasLap()) {
                  final newHeatAnalysisPositionData = HeatAnalysisPositionData(
                    lap: item.lap.lap,
                    position: item.lap.position,
                    pitlanes: item.lap.pitlanes,
                    carOffTracks: item.lap.carOffTracks,
                  );

                  bool updateLast = false;
                  final heatAnalysisPositionSerie = heatAnalysisPositionSeries[item.indicatorId.value];
                  if (heatAnalysisPositionSerie!.data.length >= 2) {
                    final lastHeatAnalysisPositionData = heatAnalysisPositionSerie.data[heatAnalysisPositionSerie.data.length - 1];
                    final secondLastHeatAnalysisPositionData = heatAnalysisPositionSerie.data[heatAnalysisPositionSerie.data.length - 2];
                    updateLast =
                        lastHeatAnalysisPositionData.position == newHeatAnalysisPositionData.position &&
                        lastHeatAnalysisPositionData.pitlanes == newHeatAnalysisPositionData.pitlanes &&
                        lastHeatAnalysisPositionData.carOffTracks == newHeatAnalysisPositionData.carOffTracks &&
                        secondLastHeatAnalysisPositionData.position == newHeatAnalysisPositionData.position &&
                        secondLastHeatAnalysisPositionData.pitlanes == newHeatAnalysisPositionData.pitlanes &&
                        secondLastHeatAnalysisPositionData.carOffTracks == newHeatAnalysisPositionData.carOffTracks;
                  }

                  if (updateLast) {
                    heatAnalysisPositionSerie.data[heatAnalysisPositionSerie.data.length - 1] = newHeatAnalysisPositionData;
                    heatAnalysisPositionSerie.updatedDataIndexes.add(heatAnalysisPositionSerie.data.length - 1);
                  } else {
                    heatAnalysisPositionSerie.data.add(
                      HeatAnalysisPositionData(
                        lap: item.lap.lap,
                        position: item.lap.position,
                        pitlanes: item.lap.pitlanes,
                        carOffTracks: item.lap.carOffTracks,
                      ),
                    );

                    heatAnalysisPositionSerie.addedDataIndexes.add(heatAnalysisPositionSerie.data.length - 1);
                  }

                  if (item.lap.lap >= 1) {
                    final heatAnalysisLapSerie = heatAnalysisLapSeries[item.indicatorId.value];
                    heatAnalysisLapSerie!.data.add(
                      HeatAnalysisLapData(
                        timerElapsed: timerElapsed,
                        lap: item.lap.lap,
                        lapTime: item.lap.time.hasValue() ? item.lap.time.value : null,
                        pitlanes: item.lap.pitlanes,
                        carOffTracks: item.lap.carOffTracks,
                      ),
                    );
                    heatAnalysisLapSerie.addedDataIndexes.add(heatAnalysisLapSerie.data.length - 1);

                    final heatAnalysisLapTimeLapQueue = heatAnalysisLapTimeLapQueues[item.indicatorId.value];
                    heatAnalysisLapTimeLapQueue!.addLast(
                      HeatAnalysisLapTimeLapData(
                        lap: item.lap.lap,
                        lapTime: item.lap.time.hasValue() ? item.lap.time.value : null,
                        pitlanes: item.lap.pitlanes,
                        carOffTracks: item.lap.carOffTracks,
                      ),
                    );
                    while (heatAnalysisLapTimeLapQueue.length >= 20) {
                      heatAnalysisLapTimeLapQueue.removeFirst();
                    }
                  }
                }

                if (item.hasGap()) {
                  final heatAnalysisGapSerie = heatAnalysisGapSeries[item.indicatorId.value]![item.gap.indicatorId];
                  heatAnalysisGapSerie!.data.add(HeatAnalysisGapData(timerElapsed: timerElapsed, gap: item.gap.value));
                  heatAnalysisGapSerie.addedDataIndexes.add(heatAnalysisGapSerie.data.length - 1);

                  heatDriverboardGapModel.update(indicatorId: item.indicatorId.value, heatAnalysisGap: item.gap);
                  gapUpdate = true;
                }
              }

              if (item.hasHeatStateTypeId()) {
                heatAnalysisHeatStateTypes.add(HeatAnalysisHeatStateType(timerElapsed: timerElapsed, heatStateTypeId: item.heatStateTypeId));
              }
            }

            for (var item in heatAnalysisPositionSeries.entries) {
              if (item.value.addedDataIndexes.isNotEmpty || item.value.updatedDataIndexes.isNotEmpty) {
                //  debugPrint(
                //      'heatAnalysisPositionSeries item.value.chartSeriesController: ${item.key} ${item.value.chartSeriesController} ${item.value.addedDataIndexes.length} ${item.value.updatedDataIndexes.length}');

                item.value.chartSeriesController?.updateDataSource(
                  addedDataIndexes: item.value.addedDataIndexes,
                  updatedDataIndexes: item.value.updatedDataIndexes,
                );
                item.value.addedDataIndexes = [];
                item.value.updatedDataIndexes = [];
              }
            }

            for (var item in heatAnalysisLapSeries.entries) {
              if (item.value.addedDataIndexes.isNotEmpty) {
                // debugPrint(
                //     'heatAnalysisLapSeries item.value.chartSeriesController:  ${item.key}  ${item.value.chartSeriesController} ${item.value.addedDataIndexes.length}');
                item.value.chartSeriesController?.updateDataSource(addedDataIndexes: item.value.addedDataIndexes);
                item.value.addedDataIndexes = [];
              }
            }

            for (var item in heatAnalysisGapSeries.entries) {
              for (var otherItem in item.value.entries) {
                if (otherItem.value.addedDataIndexes.isNotEmpty) {
                  // debugPrint(
                  //     'heatAnalysisGapSeries item.value.chartSeriesController:  ${item.key}  ${otherItem.value.chartSeriesController} ${otherItem.value.addedDataIndexes.length}');
                  otherItem.value.chartSeriesController?.updateDataSource(addedDataIndexes: otherItem.value.addedDataIndexes);
                  otherItem.value.addedDataIndexes = [];
                }
              }
            }

            if (gapUpdate) {
              heatDriverboardGapModel.notify();
            }

            if (heatAnalysisLoadingModel.loading) {
              heatAnalysisLoadingModel.notify(false);
            }
            //debugPrint('heatAnalysesSubscribe data.items.length: ${data.items.length}, process duration: ${DateTime.now().difference(dataStartedAt)}');
          },
          onDone: () => debugPrint('heatAnalysisSubscribe Done...'),
          onError: (exception) async {
            debugPrint("heatAnalysisSubscribe $exception");
            await heatAnalysesStreamSubscription!.cancel();
            heatAnalysesStreamSubscription = null;
            await eventModel.handleGrpcError(exception);
            await heatAnalysisSubscribe();
          },
        );
  }

  void heatAnalysisGapReset() {
    for (var heatAnalysisGapSerie in heatAnalysisGapSeries.entries) {
      for (var otherHeatAnalysisGapSerie in heatAnalysisGapSerie.value.entries) {
        otherHeatAnalysisGapSerie.value.chartSeriesController = null;
      }
    }
  }

  Future<void> heatStintAnalysisSubscribe(int indicatorId) async {
    debugPrint("heatStintAnalysisSubscribe before check");
    if (heatStintAnalysesStreamSubscription != null && heatStintAnalysisSubscribeIndicatorId != null && heatStintAnalysisSubscribeIndicatorId == indicatorId) {
      return;
    }
    heatStintAnalysisSubscribeIndicatorId = indicatorId;
    debugPrint("heatStintAnalysisSubscribe after check");

    if (heatStintAnalysesStreamSubscription != null) {
      await heatStintAnalysesStreamSubscription!.cancel();
    }

    heatStintAnalysisLoadingModel.notify(true);

    heatStintAnalysisIndicatorStints = [];

    heatStintAnalysesStreamSubscription = heatModel
        .heatServiceClient()
        .heatStintAnalysesSubscribe(HeatStintAnalysesRequest(heatId: id, indicatorId: indicatorId))
        .listen(
          (data) {
            if (data.refresh) {
              debugPrint("heatStintAnalysesSubscribe refreshed");
              heatStintAnalysisIndicatorStints = data.heatStintAnalysisIndicatorStints.items;
              heatStintAnalysisLapSeries.clear();
              heatStintAnalysisLapSeries.addEntries(data.heatStintAnalysisIndicatorStints.items.map((x) => MapEntry(x.id, HeatStintAnalysisLapSerie())));
              heatStintAnalysisLoadingModel.notify(false);
              heatStintAnalysisListModel.notify();
            } else {
              debugPrint("heatStintAnalysesSubscribe not refreshed $heatStintAnalysisSubscribeIndicatorId");
              for (var item in data.heatStintAnalysisIndicatorStints.items) {
                final heatStintAnalysisIndicatorStint = heatStintAnalysisIndicatorStints.where((x) => x.id == item.id).singleOrNull;
                //debugPrint("heatStintAnalysesSubscribe not refreshed ${heatStintAnalysisIndicatorStint}");
                if (heatStintAnalysisIndicatorStint != null) {
                  //debugPrint("${item.indicatorId} ${item.lap} ${item.laps.length}");

                  heatStintAnalysisIndicatorStint.duration = item.duration;
                  heatStintAnalysisIndicatorStint.averageTime = item.averageTime;

                  for (var heatStintAnalysisIndicatorStintLap in item.laps) {
                    DateTime timerElapsed;
                    if (!raceModel.isInversed) {
                      timerElapsed = dateTimeFromProtobufDuration(heatStintAnalysisIndicatorStintLap.timerElapsed);
                    } else {
                      timerElapsed = dateTimeFromDuration(
                        (durationFromProtobufDuration(raceModel.raceProto!.raceHeatEndDurationDuration) -
                            durationFromProtobufDuration(heatStintAnalysisIndicatorStintLap.timerElapsed)),
                      );
                    }

                    if (heatStintAnalysisIndicatorStintLap.lap >= 1) {
                      heatStintAnalysisIndicatorStint.laps.add(heatStintAnalysisIndicatorStintLap);
                      final heatAnalysisLapSerie = heatStintAnalysisLapSeries[item.id];
                      heatAnalysisLapSerie!.addedDataIndexes.add(heatStintAnalysisIndicatorStint.laps.length - 1);
                    }
                  }
                }

                for (var item in heatStintAnalysisLapSeries.entries) {
                  if (item.value.addedDataIndexes.isNotEmpty) {
                    // debugPrint(
                    //     'heatAnalysisLapSeries item.value.chartSeriesController:  ${item.key}  ${item.value.chartSeriesController} ${item.value.addedDataIndexes.length}');
                    item.value.chartSeriesController?.updateDataSource(addedDataIndexes: item.value.addedDataIndexes);
                    item.value.addedDataIndexes = [];
                  }
                }

                if (heatStintAnalysisLoadingModel.loading) {
                  heatStintAnalysisLoadingModel.notify(false);
                }

                heatStintAnalysisListModel.notify();
              }
            }
          },
          onDone: () => debugPrint('heatStintAnalysisSubscribe Done...'),
          onError: (exception) async {
            debugPrint("heatStintAnalysisSubscribe $exception");
            if (heatStintAnalysesStreamSubscription != null) {
              await heatStintAnalysesStreamSubscription!.cancel();
            }
            heatStintAnalysesStreamSubscription = null;
            await eventModel.handleGrpcError(exception);
            await heatStintAnalysisSubscribe(indicatorId);
          },
        );
  }

  Future<void> heatStintAnalysisUnsubscribe() async {
    if (heatStintAnalysesStreamSubscription != null) {
      await heatStintAnalysesStreamSubscription!.cancel();
      heatStintAnalysesStreamSubscription = null;
    }
    heatStintAnalysisSubscribeIndicatorId = null;
  }

  Future<void> heatCommand(HeatCommandTypeId heatCommandTypeId) async {
    final appModel = context.read<AppModel>();
    appModel.setBusy(value: true, notify: true);
    try {
      await heatModel.heatServiceClient().command(HeatCommandRequest(id: id, heatCommandTypeId: heatCommandTypeId));
    } on Exception catch (exception) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(exceptionMessage(exception)), duration: const Duration(seconds: 10)));
    } finally {
      appModel.setBusy(value: false, notify: true);
    }
  }

  bool heatCommandStartEnabled() {
    if (heatStateModel.heatStateType == null) {
      return false;
    }
    return heatStateModel.heatStateType!.id == HeatStateTypeId.HEAT_STATE_TYPE_ID_OPENED ||
        heatStateModel.heatStateType!.id == HeatStateTypeId.HEAT_STATE_TYPE_ID_YELLOW ||
        heatStateModel.heatStateType!.id == HeatStateTypeId.HEAT_STATE_TYPE_ID_RED;
  }

  bool heatCommandYellowEnabled() {
    if (heatStateModel.heatStateType == null) {
      return false;
    }
    return heatStateModel.heatStateType!.id == HeatStateTypeId.HEAT_STATE_TYPE_ID_RUNNING ||
        heatStateModel.heatStateType!.id == HeatStateTypeId.HEAT_STATE_TYPE_ID_ENDED;
  }

  bool heatCommandRedEnabled() {
    if (heatStateModel.heatStateType == null) {
      return false;
    }
    return heatStateModel.heatStateType!.id == HeatStateTypeId.HEAT_STATE_TYPE_ID_RUNNING ||
        heatStateModel.heatStateType!.id == HeatStateTypeId.HEAT_STATE_TYPE_ID_COUNTDOWN ||
        heatStateModel.heatStateType!.id == HeatStateTypeId.HEAT_STATE_TYPE_ID_COUNTDOWN_YELLOW ||
        heatStateModel.heatStateType!.id == HeatStateTypeId.HEAT_STATE_TYPE_ID_COUNTDOWN_RED ||
        heatStateModel.heatStateType!.id == HeatStateTypeId.HEAT_STATE_TYPE_ID_YELLOW ||
        heatStateModel.heatStateType!.id == HeatStateTypeId.HEAT_STATE_TYPE_ID_ENDED;
  }

  bool heatCommandEndEnabled() {
    if (heatStateModel.heatStateType == null) {
      return false;
    }
    return heatStateModel.heatStateType!.id == HeatStateTypeId.HEAT_STATE_TYPE_ID_RUNNING ||
        heatStateModel.heatStateType!.id == HeatStateTypeId.HEAT_STATE_TYPE_ID_YELLOW ||
        heatStateModel.heatStateType!.id == HeatStateTypeId.HEAT_STATE_TYPE_ID_RED;
  }

  bool heatCommandReopenEnabled() {
    if (heatStateModel.heatStateType == null) {
      return false;
    }
    return heatStateModel.heatStateType!.id == HeatStateTypeId.HEAT_STATE_TYPE_ID_OFF;
  }

  bool heatCommandCloseEnabled() {
    if (heatStateModel.heatStateType == null) {
      return false;
    }
    return heatStateModel.heatStateType!.id == HeatStateTypeId.HEAT_STATE_TYPE_ID_OPENED ||
        heatStateModel.heatStateType!.id == HeatStateTypeId.HEAT_STATE_TYPE_ID_OFF;
  }

  String seriesName(int indicatorId) {
    final showIndicators = raceModel.raceProto!.raceFeatures.where((x) => x == RaceFeatureTypeId.RACE_FEATURE_TYPE_ID_LANE_BASED_ID).isNotEmpty;

    String result = "";
    if (showIndicators) {
      final allHeatIndicatorsHasColor = heatModel.heatProto!.heatIndicators.where((x) => !x.hasColor()).isEmpty;
      if (!allHeatIndicatorsHasColor) {
        result += "$indicatorId ";
      }
    }

    result += heatModel.heatUsers[indicatorId]!.name.value;

    return result;
  }

  double calculateHeatUsersTeamOrDriversMaxWidth({
    required Iterable<HeatIndicator> heatIndicators,
    required double fontSize,
    required showIndicators,
    required bool useShortName,
  }) {
    final heatIndicatorHeatUsers = heatModel.heatUsers.entries.where(
      (x) => heatIndicators.where((heatIndicator) => x.key == heatIndicator.indicatorId).singleOrNull != null,
    );

    if (heatIndicatorHeatUsers.isEmpty) {
      return 0.0;
    }

    var result = heatIndicatorHeatUsers.map((x) => textWidth("${useShortName ? x.value!.shortName.value : x.value!.name.value} ", fontSize)).reduce(max);

    if (showIndicators && raceModel.raceProto!.raceFeatures.where((x) => x == RaceFeatureTypeId.RACE_FEATURE_TYPE_ID_LANE_BASED_ID).isNotEmpty) {
      result += fontSize + 8.0;
    }

    if (heatIndicatorHeatUsers.where((x) => x.value!.image.hasValue() && x.value!.image.value.isNotEmpty).isNotEmpty) {
      result += fontSize + 8.0;
    }

    if (heatIndicators.where((x) => x.carImage.hasValue() && x.carImage.value.isNotEmpty).isNotEmpty) {
      result += fontSize + 8.0;
    }

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

class HeatAnalysisPositionSerie {
  ChartSeriesController<HeatAnalysisPositionData, int>? chartSeriesController;
  final List<HeatAnalysisPositionData> data = [];
  List<int> addedDataIndexes = [];
  List<int> updatedDataIndexes = [];
}

class HeatAnalysisPositionData {
  const HeatAnalysisPositionData({required this.lap, required this.position, required this.pitlanes, required this.carOffTracks});
  final int lap;
  final int position;
  final int pitlanes;
  final int carOffTracks;
}

class HeatAnalysisGapSerie {
  ChartSeriesController<HeatAnalysisGapData, DateTime>? chartSeriesController;
  final List<HeatAnalysisGapData> data = [];
  List<int> addedDataIndexes = [];
}

class HeatAnalysisGapData {
  const HeatAnalysisGapData({required this.timerElapsed, required this.gap});
  final DateTime timerElapsed;
  final double? gap;
}

class HeatAnalysisLapSerie {
  ChartSeriesController<HeatAnalysisLapData, DateTime>? chartSeriesController;
  final List<HeatAnalysisLapData> data = [];
  List<int> addedDataIndexes = [];
}

class HeatAnalysisLapData {
  const HeatAnalysisLapData({required this.timerElapsed, required this.lap, required this.lapTime, required this.pitlanes, required this.carOffTracks});
  final DateTime timerElapsed;
  final int lap;
  final double? lapTime;
  final int pitlanes;
  final int carOffTracks;
}

class HeatAnalysisLapTimeLapData {
  const HeatAnalysisLapTimeLapData({required this.lap, required this.lapTime, required this.pitlanes, required this.carOffTracks});
  final int lap;
  final double? lapTime;
  final int pitlanes;
  final int carOffTracks;
}

class HeatStintAnalysisLapSerie {
  ChartSeriesController<HeatStintAnalysisIndicatorStintLap, DateTime>? chartSeriesController;
  List<int> addedDataIndexes = [];
}

class HeatAnalysisHeatStateType {
  const HeatAnalysisHeatStateType({required this.timerElapsed, required this.heatStateTypeId});
  final DateTime timerElapsed;
  final HeatStateTypeId heatStateTypeId;
}

class PublicHeatHeatStateHeader extends StatelessWidget {
  const PublicHeatHeatStateHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HeatStateHeaderModel>(
      builder: (_, model, __) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              model.laps.toString(),
              style: TextStyle(fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize, fontFamily: 'BungeeInline'),
            ),
            SizedBox(
              width: model.timerTextWidth(Theme.of(context).textTheme.headlineLarge!.fontSize!, "BungeeInline"),
              child: Text(
                model.timer,
                style: TextStyle(fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize, fontFamily: 'BungeeInline'),
              ),
            ),
          ],
        );
      },
    );
  }
}

abstract class PublicHeatStateDetailBase extends StatefulWidget {
  const PublicHeatStateDetailBase({super.key});
}

abstract class PublicHeatStateDetailStateBase extends State<PublicHeatStateDetailBase> with SingleTickerProviderStateMixin {
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

  BoxDecoration? heatStateBoxDecoration(HeatStateModel model, double animationValue) {
    late final List<Color> colors;
    switch (model.heatStateType?.id) {
      case HeatStateTypeId.HEAT_STATE_TYPE_ID_RUNNING:
        colors = [Colors.green, Colors.greenAccent, Colors.green];
        break;

      case HeatStateTypeId.HEAT_STATE_TYPE_ID_YELLOW:
      case HeatStateTypeId.HEAT_STATE_TYPE_ID_COUNTDOWN_YELLOW:
        colors = [Colors.yellow, Colors.yellowAccent, Colors.yellow];
        break;

      case HeatStateTypeId.HEAT_STATE_TYPE_ID_RED:
      case HeatStateTypeId.HEAT_STATE_TYPE_ID_COUNTDOWN_RED:
        colors = [Colors.red, Colors.redAccent, Colors.red];
        break;

      case HeatStateTypeId.HEAT_STATE_TYPE_ID_ENDED:
      case HeatStateTypeId.HEAT_STATE_TYPE_ID_OFF:
        colors = [Colors.black, Colors.transparent, Colors.black];
        break;

      default:
        return null;
    }
    return BoxDecoration(
      //color: colors.first,
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: colors,
        stops: [
          //max(0, animationController.value - 0.1),
          0,
          animationValue,
          //min(1, animationController.value + 0.1)
          1,
        ],
      ),
      // gradient: RadialGradient(colors: colors, stops: [
      //   //max(0, animationController.value - 0.1),
      //   0,
      //   animationValue,
      //   //min(1, animationController.value + 0.1)
      //   1
      // ]),
    );
  }

  Widget foreground();

  @override
  Widget build(BuildContext context) {
    return Consumer<HeatStateModel>(
      builder: (_, model, __) {
        return AnimatedBuilder(
          animation: _animationController,
          child: foreground(),
          builder: (_, child) {
            return Container(
              decoration: heatStateBoxDecoration(model, _animation.value),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      child!,
                      if (model.heatStateType != null &&
                          (model.heatStateType!.id == HeatStateTypeId.HEAT_STATE_TYPE_ID_COUNTDOWN ||
                              model.heatStateType!.id == HeatStateTypeId.HEAT_STATE_TYPE_ID_COUNTDOWN_YELLOW ||
                              model.heatStateType!.id == HeatStateTypeId.HEAT_STATE_TYPE_ID_COUNTDOWN_RED))
                        StartLights(model: model, constraints: constraints),
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

class StartLights extends StatelessWidget {
  const StartLights({super.key, required this.model, required this.constraints});

  final HeatStateModel model;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    double maxSize = constraints.maxWidth;
    final size = maxSize / 7;
    const rings = 8;
    final r = size / (rings * 4 + 2);
    final List<Widget> leds = [];
    for (var starLight = 1; starLight <= 5; starLight++) {
      for (var ring = 1; ring <= rings; ring++) {
        for (var i = 0; i < 6 * ring; i++) {
          leds.add(
            Positioned(
              left: size / 2 + 2 * r * ring * cos(pi * 2 * i / 6 / ring) - r + (starLight - 1) * size,
              top: size / 2 + 2 * r * ring * sin(pi * 2 * i / 6 / ring) - r,
              child: Container(
                width: r * 2,
                height: r * 2,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      model.startLightId != null && model.startLightId! >= starLight ? Colors.redAccent : Colors.grey,
                      model.startLightId != null && model.startLightId! >= starLight ? Colors.red : Colors.black,
                      Colors.transparent,
                    ],
                    stops: [0, 0.5, 1],
                  ),
                ),
              ),
            ),
          );
        }
      }
    }

    return Positioned(
      left: (constraints.maxWidth - maxSize * 5 / 7) / 2 - 8,
      top: (constraints.maxHeight - maxSize / 7) / 2 - 8,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: maxSize * 5 / 7,
            height: maxSize / 7,
            //color: Theme.of(context).colorScheme.onPrimaryFixed,
            child: Stack(children: [...leds]),
          ),
        ),
      ),
    );
  }
}

class PublicHeatBottomNavigationBar extends StatelessWidget {
  const PublicHeatBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Consumer<HeatStateModel>(
        builder: (context, model, child) {
          final publicHeatChildState = context.findAncestorStateOfType<PublicHeatChildStateBase>()!;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton.filledTonal(
                icon: const Icon(Icons.play_arrow),
                onPressed: publicHeatChildState.heatCommandStartEnabled()
                    ? () => publicHeatChildState.heatCommand(HeatCommandTypeId.HEAT_COMMAND_TYPE_ID_START)
                    : null,
              ),
              const SizedBox(width: 16),
              IconButton.filledTonal(
                icon: Icon(Icons.flag, color: publicHeatChildState.heatCommandYellowEnabled() ? Colors.yellowAccent : const Color.fromARGB(64, 255, 255, 0)),
                onPressed: publicHeatChildState.heatCommandYellowEnabled()
                    ? () => publicHeatChildState.heatCommand(HeatCommandTypeId.HEAT_COMMAND_TYPE_ID_YELLOW)
                    : null,
              ),
              const SizedBox(width: 16),
              IconButton.filledTonal(
                icon: Icon(Icons.flag, color: publicHeatChildState.heatCommandRedEnabled() ? Colors.redAccent : const Color.fromARGB(64, 255, 0, 0)),
                onPressed: publicHeatChildState.heatCommandRedEnabled()
                    ? () => publicHeatChildState.heatCommand(HeatCommandTypeId.HEAT_COMMAND_TYPE_ID_RED)
                    : null,
              ),
              const SizedBox(width: 16),
              IconButton.filledTonal(
                icon: const Icon(Icons.stop),
                onPressed: publicHeatChildState.heatCommandEndEnabled()
                    ? () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: const Text('Do you really want to end this heat?'),
                            actions: [
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                              ),
                              TextButton(
                                child: const Text('End'),
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                              ),
                            ],
                          ),
                        );

                        if (confirmed == true) {
                          publicHeatChildState.heatCommand(HeatCommandTypeId.HEAT_COMMAND_TYPE_ID_END);
                        }
                      }
                    : null,
              ),
              const SizedBox(width: 16),
              IconButton.filledTonal(
                icon: const Icon(Icons.restart_alt),
                onPressed: publicHeatChildState.heatCommandReopenEnabled()
                    ? () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: const Text('Do you really want to restart this heat?'),
                            actions: [
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                              ),
                              TextButton(
                                child: const Text('Restart'),
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                              ),
                            ],
                          ),
                        );

                        if (confirmed == true) {
                          await publicHeatChildState.heatCommand(HeatCommandTypeId.HEAT_COMMAND_TYPE_ID_REOPEN);
                          // if (context.mounted) {
                          //   final refreshModel = context.read<RefreshModel>();
                          //   await publicHeatChildState.refreshData(notify: true);
                          //   refreshModel.refreshed();
                          // }
                        }
                      }
                    : null,
              ),
              const SizedBox(width: 16),
              IconButton.filledTonal(
                icon: const Icon(Icons.done),
                onPressed: publicHeatChildState.heatCommandCloseEnabled()
                    ? () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: const Text('Do you really want to close this heat?'),
                            actions: [
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                              ),
                              TextButton(
                                child: const Text('Close'),
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                              ),
                            ],
                          ),
                        );

                        if (confirmed == true) {
                          publicHeatChildState.heatCommand(HeatCommandTypeId.HEAT_COMMAND_TYPE_ID_CLOSE);
                        }
                      }
                    : null,
              ),
            ],
          );
        },
      ),
    );
  }
}

class HeatStateModel extends ChangeNotifier {
  HeatStateType? heatStateType;
  int? startLightId;

  void notify(HeatState heatState) {
    heatStateType = heatState.heatStateType;
    startLightId = heatState.startLightId;
    notifyListeners();
  }
}

class HeatStateHeaderModel extends ChangeNotifier {
  int laps = 0;
  String timer = "";
  Duration _timerElapsed = Duration.zero;
  Timer? _timer;
  Race? _race;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void notify(HeatState heatState, Race race) {
    laps = heatState.lapsCurrent.value;
    _race = race;

    _timer?.cancel();

    if (_race!.raceHeatEndTypeId == HeatEndTypeId.HEAT_END_TYPE_ID_DURATION &&
        (heatState.heatStateType.id == HeatStateTypeId.HEAT_STATE_TYPE_ID_ENDED ||
            heatState.heatStateType.id == HeatStateTypeId.HEAT_STATE_TYPE_ID_OFF ||
            heatState.heatStateType.id == HeatStateTypeId.HEAT_STATE_TYPE_ID_CLOSED)) {
      _timerElapsed = Duration(
        milliseconds: (_race!.raceHeatEndDurationDuration.seconds.toInt() * 1000 + _race!.raceHeatEndDurationDuration.nanos / 1000000).round(),
      );
    } else if (heatState.timerElapsed.hasNanos()) {
      _timerElapsed = Duration(milliseconds: (heatState.timerElapsed.seconds.toInt() * 1000 + heatState.timerElapsed.nanos / 1000000).round());

      if (heatState.timerIsRunning) {
        _timer = Timer(Duration(milliseconds: (1000 - heatState.timerElapsed.nanos / 1000000).round()), _updateTimer);
      }
    } else {
      _timerElapsed = Duration.zero;
    }

    _formatTimer();

    notifyListeners();
  }

  void _updateTimer() {
    if (_timer != null || !_timer!.isActive) {
      _timer!.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) => _updateTimer());
    }

    _timerElapsed = _timerElapsed + const Duration(seconds: 1);
    _formatTimer();
    notifyListeners();
  }

  void _formatTimer() {
    final formatter = NumberFormat("00");
    final hours = _timerElapsed.inHours.floor();

    Duration duration;
    if (_race!.raceHeatEndTypeId == HeatEndTypeId.HEAT_END_TYPE_ID_DURATION) {
      final raceHeatEndDurationDuration = Duration(
        milliseconds: (_race!.raceHeatEndDurationDuration.seconds.toInt() * 1000 + _race!.raceHeatEndDurationDuration.nanos / 1000000).round(),
      );

      duration = raceHeatEndDurationDuration - _timerElapsed;
    } else {
      duration = _timerElapsed;
    }

    timer = "${hours == 0 ? '' : '$hours:'}${formatter.format(duration.inMinutes % 60)}:${formatter.format(duration.inSeconds % 60)}";
  }

  double timerTextWidth(double fontSize, String? fontFamily) {
    if (_timerElapsed.inHours == 0) {
      return _textWidth("00:00  ", fontSize, fontFamily);
    } else if (_timerElapsed.inHours <= 10) {
      return _textWidth("0:00:00  ", fontSize, fontFamily);
    } else {
      return _textWidth("00:00:00  ", fontSize, fontFamily);
    }
  }

  double _textWidth(String text, double fontSize, String? fontFamily) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, fontFamily: fontFamily),
      ),
      maxLines: 1,
      textDirection: ui.TextDirection.ltr,
    );

    textPainter.layout();
    final size = textPainter.size;

    return size.width;
  }
}

class HeatAnnounceModel extends ChangeNotifier {
  HeatLeaderboardIndicator? currentLeader;

  void update(HeatLeaderboard heatLeaderboard) {
    var notify = false;

    final previousLeader = currentLeader;
    currentLeader = heatLeaderboard.indicators.where((x) => x.position == 1).singleOrNull;
    notify =
        (previousLeader == null && currentLeader != null) ||
        (previousLeader != null && currentLeader != null && previousLeader.indicatorId != currentLeader!.indicatorId);

    if (notify) {
      notifyListeners();
    }
  }
}

class HeatLeaderboardModel extends ChangeNotifier {
  HeatLeaderboard? heatLeaderboard;

  void notify(HeatLeaderboard heatLeaderboard) {
    this.heatLeaderboard = heatLeaderboard;
    notifyListeners();
  }
}

class HeatDriverboardGapModel extends ChangeNotifier {
  Map<int, Map<int, HeatAnalysisGap?>> indicatorGaps = {};

  void initialize(Iterable<HeatIndicator> heatIndicators) {
    debugPrint('_HeatDriverboardGapModel initialize');
    indicatorGaps.clear();
    indicatorGaps.addEntries(
      heatIndicators.map((heatIndicator) {
        final Map<int, HeatAnalysisGap?> otherHeatIndicators = {};
        otherHeatIndicators.addEntries(
          heatIndicators
              .where((otherHeatIndicator) => otherHeatIndicator.indicatorId != heatIndicator.indicatorId)
              .map((otherHeatIndicator) => MapEntry(otherHeatIndicator.indicatorId, null)),
        );
        return MapEntry(heatIndicator.indicatorId, otherHeatIndicators);
      }),
    );
  }

  void update({required int indicatorId, required HeatAnalysisGap heatAnalysisGap}) {
    indicatorGaps[indicatorId]?[heatAnalysisGap.indicatorId] = heatAnalysisGap;
  }

  void notify() {
    notifyListeners();
  }
}

class HeatAnalysisLoadingModel extends ChangeNotifier {
  bool loading = true;

  void notify(bool loading) {
    this.loading = loading;
    if (!loading) {
      notifyListeners();
    }
  }
}

class HeatStintAnalysisLoadingModel extends ChangeNotifier {
  bool loading = true;

  void notify(bool loading) {
    this.loading = loading;
    if (!loading) {
      notifyListeners();
    }
  }
}

class HeatStintAnalysisListModel extends ChangeNotifier {
  void notify() {
    notifyListeners();
  }
}
