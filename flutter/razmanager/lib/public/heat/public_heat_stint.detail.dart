import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/common.pb.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/heat_indicator_stint.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/user_services/heat_indicator.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/public/event_user_type_id.v1.pbenum.dart';
import '../../utilities/crud_master_alert_base.dart';
//import '../../utilities/crud_master_detail_base.dart';

class PublicHeatStintDetail extends CrudMasterAlertBase {
  const PublicHeatStintDetail(
      {super.key, required super.parentId, required super.id});

  @override
  State createState() => _PublicHeatStintDetailState();
}

class _PublicHeatStintDetailState
    extends CrudMasterAlertStateBase<HeatIndicatorStintRead> {
  _PublicHeatStintDetailState()
      : super(header: 'Stint', child: _HeatIndicatorStintDetailBody());

  late HeatIndicatorRead heatIndicator;

  HeatIndicatorStintServiceClient client() {
    return HeatIndicatorStintServiceClient(clientChannel!,
        options: callOptionsFromContext(context));
  }

  @override
  Future<HeatIndicatorStintRead> initialize() async {
    final futures = <Future>[];
    futures.add(client().initialize(Empty()));
    futures.add(HeatIndicatorServiceClient(clientChannel!,
            options: callOptionsFromContext(context))
        .read(StringValue(value: widget.parentId)));
    var response = await Future.wait(futures);
    heatIndicator = (response[1] as HeatIndicatorRead);
    return (response[0] as HeatIndicatorStintRead);
  }

  @override
  Future read(id) async {
    final futures = <Future>[];
    futures.add(client().read(IdRequest(id: id)));
    futures.add(HeatIndicatorServiceClient(clientChannel!,
            options: callOptionsFromContext(context))
        .read(StringValue(value: widget.parentId)));
    var response = await Future.wait(futures);
    heatIndicator = (response[1] as HeatIndicatorRead);    
    return ((response[0] as HeatIndicatorStintReadResponse).entity, (response[0] as HeatIndicatorStintReadResponse).etag);
  }

  @override
  Future<void> save(id) {
    if (add) {
      final proto = HeatIndicatorStintCreate(
          heatIndicatorId: widget.parentId,
          lap: formGroup.control('lap').value,
          eventUserId: formGroup.control('eventUserId').value == null
              ? null
              : StringValue(value: formGroup.control('eventUserId').value),
          comments: StringValue(value: formGroup.control('comments').value));
      return client().create(proto);
    } else {
      final proto = HeatIndicatorStintUpdate(
          lap: formGroup.control('lap').value,
          eventUserId: formGroup.control('eventUserId').value == null
              ? null
              : StringValue(value: formGroup.control('eventUserId').value),
          comments: StringValue(value: formGroup.control('comments').value));
      return client().update(
          HeatIndicatorStintUpdateRequest(id: id, entity: proto, etag: etag));
    }
  }

  @override
  Future<void> delete(id) {
    return client().delete(DeleteRequest(id: id, etag: etag));
  }

  @override
  Future<void> createFormGroup(readProto) async {
    formGroup = FormGroup({
      'lap': FormControl<int>(
          value: readProto.lap == 0 ? null : readProto.lap,
          validators: [Validators.required]),
      'eventUserId': FormControl<String?>(
          value: readProto.eventUserId.hasValue()
              ? readProto.eventUserId.value
              : null),
      'comments': FormControl<String?>(
          value:
              readProto.comments.hasValue() ? readProto.comments.value : null),
    });
  }
}

class _HeatIndicatorStintDetailBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state =
        context.findAncestorStateOfType<_PublicHeatStintDetailState>()!;
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: ReactiveTextField<int>(
            formControlName: 'lap',
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 4,
            decoration: const InputDecoration(
                labelText: 'Lap *'),
          ),
        ),
        if (state.heatIndicator.eventUserTypeId ==
            EventUserTypeId.EVENT_USER_TYPE_ID_TEAM)
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1300),
            child: ReactiveDropdownField<String?>(
                formControlName: 'eventUserId',
                decoration: const InputDecoration(labelText: 'Driver'),
                items: state.heatIndicator.eventUsers
                    .map((x) => DropdownMenuItem(
                          value: x.id,
                          child: Text(x.name),
                        ))
                    .toList()),
          ),
        ReactiveTextField<String?>(
          formControlName: 'comments',
          maxLength: 1000,
          textCapitalization: TextCapitalization.sentences,
          minLines: 2,
          maxLines: 10,
          decoration: const InputDecoration(labelText: "Comments"),
        ),
      ],
    );
  }
}
