import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/car_tag.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/common.pb.dart';
import '../../utilities/crud_master_detail_base.dart';
import '../../utilities/crud_master_detail_single_base.dart';

class TenantAdminCarTagDetail extends CrudMasterDetailBase {
  const TenantAdminCarTagDetail({super.key, required super.id, required super.oldEtag, required super.refreshItems});

  @override
  State createState() => _TenantAdminCarTagState();
}

class _TenantAdminCarTagState extends CrudMasterDetailSingleStateBase<CarTagRead> {
  _TenantAdminCarTagState() : super(header: 'Car tag', child: _TenantAdminCarTagDetailBody());

  CarTagServiceClient client() {
    return CarTagServiceClient(clientChannel!, options: callOptionsFromContext(context));
  }

  @override
  Future<CarTagRead> initialize() {
    return client().initialize(Empty());
  }

  @override
  Future read(id) async {
    final response = await client().read(IdRequest(id: id));
    return (response.entity, response.etag);
  }

  @override
  Future<void> save(id) {
    final proto = CarTagCreateUpdate(
        name: formGroup.control('name').value,
        description: StringValue(value: formGroup.control('description').value),
        position: formGroup.control('position').value);
    if (add) {
      return client().create(proto);
    } else {
      return client().update(CarTagUpdateRequest(id: id, entity: proto, etag: etag));
    }
  }

  @override
  Future<void> delete(id) {
    return client().delete(DeleteRequest(id: id, etag: etag));
  }

  @override
  Future<void> createFormGroup(readProto) async {
    formGroup = FormGroup({
      'name': FormControl<String?>(
          value: readProto.name.hasValue() ? readProto.name.value : null, validators: [Validators.required]),
      'description': FormControl<String?>(value: readProto.description.hasValue() ? readProto.description.value : null),
      'position': FormControl<int>(value: readProto.position, validators: [Validators.required]),
    });
  }
}

class _TenantAdminCarTagDetailBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1300),
          child: ReactiveTextField<String?>(
            formControlName: 'name',
            maxLength: 100,
            textCapitalization: TextCapitalization.sentences,
            validationMessages: {ValidationMessage.required: (error) => 'Please enter a name.'},
            decoration: const InputDecoration(labelText: "Name *"),
          ),
        ),
        ReactiveTextField<String?>(
          formControlName: 'description',
          maxLength: 1000,
          textCapitalization: TextCapitalization.sentences,
          minLines: 2,
          maxLines: 10,
          decoration: const InputDecoration(labelText: "Description"),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: ReactiveTextField<int>(
            formControlName: 'position',
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 2,
            decoration: const InputDecoration(
                labelText: 'Position *',
                helperText: 'The position this car tag has when presented in a list together with other car tags'),
          ),
        ),
      ],
    );
  }
}
