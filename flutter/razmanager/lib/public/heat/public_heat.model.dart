import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart';
import 'package:provider/provider.dart';

import '../../app_model.dart';
import '../../utilities/color_definitions.dart';
import '../../utilities/grpc_client.dart';
import '../../protobuf/razmanager/protobuf/public/event.v1.pb.dart';
import '../../protobuf/razmanager/protobuf/public/heat.service.v1.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/public/heat.v1.pb.dart';
import '../event/public_event.model.dart';

class HeatModel extends ChangeNotifier with GrpcClient {
  late AppModel _appModel;
  late EventModel _eventModel;

  late String heatId;
  late Iterable<HeatCommandTypeId> heatCommandPermissions;
  Heat? heatProto;
  StreamSubscription<Heat>? _heatStreamSubscription;
  Map<int, EventUser?> heatUsers = {};
  late bool teamHeat;
  Map<int, Color?> heatIndicatorColors = {};

  @override
  void dispose() {
    Future.microtask(releaseHeat);

    super.dispose();
  }

  HeatServiceClient heatServiceClient() {
    return HeatServiceClient(_eventModel!.clientChannel!, options: callOptionsFromAppModel(_appModel!));
  }

  Future<void> refreshHeat({required BuildContext context, required String id}) async {
    _appModel = context.read<AppModel>();
    _eventModel = context.read<EventModel>();
    
    heatId = id;
    debugPrint("refreshHeat $heatId");

    heatCommandPermissions = (await heatServiceClient().commandPermissions(StringValue(value: heatId))).items;

    await heatSubscribe();
  }

  Future<void> releaseHeat() async {
    heatProto = null;
    if (_heatStreamSubscription != null) {
      await _heatStreamSubscription!.cancel();
      _heatStreamSubscription = null;
    }
  }

  Future<void> heatSubscribe() async {
    if (_heatStreamSubscription != null) {
      await _heatStreamSubscription!.cancel();
    }
    _heatStreamSubscription = heatServiceClient().subscribe(StringValue(value: heatId)).listen(
        (data) {
          heatProto = data;

          heatUsers.clear();
          heatUsers.addEntries(heatProto!.heatIndicators
              .map((x) => MapEntry(x.indicatorId, _eventModel!.eventProto!.eventUsers.where((eventUser) => eventUser.id == x.eventUserId).singleOrNull)));

          teamHeat = heatUsers.entries.expand((x) => x.value!.teamUsers).isNotEmpty;

          final defaultHeatIndicatorColors = ColorDefinitions.ordered.toList();

          for (final x in heatProto!.heatIndicators) {
            if (x.hasColor()) {
              defaultHeatIndicatorColors.removeWhere((c) => c.toARGB32() == x.color.value);
            }
          }

          heatIndicatorColors.clear();
          heatIndicatorColors.addEntries(heatProto!.heatIndicators.map((x) {
            Color color;
            if (x.color.hasValue()) {
              color = Color(x.color.value);
            } else {
              color = defaultHeatIndicatorColors.first;
              defaultHeatIndicatorColors.remove(color);
            }
            return MapEntry(x.indicatorId, color);
          }));

          notifyListeners();
        },
        onDone: () => debugPrint('heatSubscribe done'),
        onError: (exception) async {
          debugPrint("heatSubscribe $exception");
          await _eventModel.handleGrpcError(exception);
          heatSubscribe();
        });
  }
}
