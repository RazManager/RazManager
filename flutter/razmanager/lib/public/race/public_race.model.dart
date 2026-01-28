import 'dart:async';

import 'package:flutter/material.dart';
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart';
import 'package:provider/provider.dart';

import '../../app_model.dart';
import '../../protobuf/razmanager/protobuf/public/heat.v1.pb.dart';
import '../../protobuf/razmanager/protobuf/public/race_feature_type_id.v1.pb.dart';
import '../../utilities/grpc_client.dart';
import '../../protobuf/razmanager/protobuf/public/race.service.v1.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/public/race.v1.pb.dart';
import '../event/public_event.model.dart';

class RaceModel extends ChangeNotifier with GrpcClient {
  late AppModel _appModel;
  late EventModel _eventModel;

  late String raceId;
  late Iterable<RaceCommandTypeId> raceCommandPermissions;
  Race? raceProto;
  StreamSubscription<Race>? _raceStreamSubscription;
  late bool isInversed;
  late bool showIndicators;
  late bool motorSimulation;

  @override
  void dispose() {
    Future.microtask(releaseRace);

    super.dispose();
  }

  RaceServiceClient raceServiceClient() {
    return RaceServiceClient(_eventModel!.clientChannel!, options: callOptionsFromAppModel(_appModel!));
  }

  Future<void> refreshRace({required BuildContext context, required String id}) async {
    _appModel = context.read<AppModel>();
    _eventModel = context.read<EventModel>();
    
    raceId = id;
    debugPrint("refreshRace $raceId");

    raceCommandPermissions = (await raceServiceClient().commandPermissions(StringValue(value: raceId))).items;

    await raceSubscribe();
  }

  Future<void> releaseRace() async {
    debugPrint("releaseRace");
    raceProto = null;

    if (_raceStreamSubscription != null) {
      await _raceStreamSubscription!.cancel();
      _raceStreamSubscription == null;
    }
  }

  Future<void> raceSubscribe() async {
    if (_raceStreamSubscription != null) {
      await _raceStreamSubscription!.cancel();
    }
    _raceStreamSubscription = raceServiceClient().subscribe(StringValue(value: raceId)).listen(
        (data) {
          raceProto = data;
          isInversed = raceProto!.raceHeatEndTypeId == HeatEndTypeId.HEAT_END_TYPE_ID_DURATION;
          showIndicators = raceProto!.raceFeatures.where((x) => x == RaceFeatureTypeId.RACE_FEATURE_TYPE_ID_LANE_BASED_ID).isNotEmpty;
          motorSimulation = raceProto!.raceFeatures.where((x) => x == RaceFeatureTypeId.RACE_FEATURE_TYPE_ID_ENERGY).isNotEmpty;

          notifyListeners();
        },
        onDone: () => debugPrint('raceSubscribe done'),
        onError: (exception) async {
          debugPrint("raceSubscribe $exception");
          await _eventModel.handleGrpcError(exception);
          raceSubscribe();
        });
  }
}
