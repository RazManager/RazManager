import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';

import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/car.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/car_tag.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/common.pb.dart';
import '../../utilities/crud_master_detail_base.dart';
import '../../utilities/crud_master_detail_single_base.dart';
import '../../utilities/image_field.dart';

class TenantAdminCarDetail extends CrudMasterDetailBase {
  const TenantAdminCarDetail({super.key, required super.id, required super.oldEtag, required super.refreshItems});

  @override
  State createState() => _TenantAdminCarState();
}

class _TenantAdminCarState extends CrudMasterDetailSingleStateBase<CarRead> {
  _TenantAdminCarState() : super(header: 'Car', child: _TenantAdminCarDetailBody());

  bool carTagsExists = false;

  CarServiceClient client() {
    return CarServiceClient(clientChannel!, options: callOptionsFromContext(context));
  }

  CarTagServiceClient carTagClient() {
    return CarTagServiceClient(clientChannel!, options: callOptionsFromContext(context));
  }

  @override
  Future<CarRead> initialize() {
    return client().initialize(Empty());
  }

  @override
  Future read(id) async {
    final response = await client().read(IdRequest(id: id));
    return (response.entity, response.etag);
  }

  @override
  Future<void> save(id) {
    List<String> carTagsIds = [];
    final carTagList = formGroup.value['carTags'] as List;
    for (final carTag in carTagList.where((x) => x['selected'])) {
      carTagsIds.add(carTag['id']);
    }

    final proto = CarCreateUpdate(
      name: formGroup.control('name').value,
      number: UInt32Value(value: formGroup.control('number').value),
      description: StringValue(value: formGroup.control('description').value),
      carTagIds: carTagsIds,
    );

    if (formGroup.control('image').dirty && formGroup.control('image').value != null) {
      proto.image = formGroup.control('image').value;
    }

    if (formGroup.control('imageDeleted').dirty && formGroup.control('imageDeleted').value == true) {
      proto.imageDeleted = formGroup.control('imageDeleted').value;
    }

    if (add) {
      return client().create(proto);
    } else {
      return client().update(CarUpdateRequest(id: id, entity: proto, etag: etag));
    }
  }

  @override
  Future<void> delete(id) {
    return client().delete(DeleteRequest(id: id, etag: etag));
  }

  @override
  Future<void> createFormGroup(readProto) async {
    final carTagsSelectReponse = await carTagClient().select(Empty());
    final carTags = carTagsSelectReponse.result;
    carTagsExists = carTags.isNotEmpty;

    formGroup = FormGroup({
      'name': FormControl<String?>(
          value: readProto.name.hasValue() ? readProto.name.value : null, validators: [Validators.required]),
      'number': FormControl<int>(value: readProto.number.hasValue() ? readProto.number.value : null),
      'description': FormControl<String?>(value: readProto.description.hasValue() ? readProto.description.value : null),
      'carTags': FormArray([]),
      'image':
          FormControl<Uint8List?>(value: readProto.image.hasValue() ? Uint8List.fromList(readProto.image.value) : null),
      'imageDeleted': FormControl<bool?>(),
    });

    final carTagsArray = formGroup.control('carTags') as FormArray;
    for (final carTag in carTags) {
      carTagsArray.add(FormGroup({
        'id': FormControl<String>(value: carTag.id),
        'name': FormControl<String>(value: carTag.name),
        'selected': FormControl<bool>(value: readProto.carTagIds.contains(carTag.id))
      }));
    }
  }
}

class _TenantAdminCarDetailBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formGroup = context.findAncestorStateOfType<_TenantAdminCarState>()!.formGroup;
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 600) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: _TenantAdminCarDetailBodyMain()),
            const SizedBox(width: 16),
            Expanded(child: ImageField(formGroup: formGroup))
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_TenantAdminCarDetailBodyMain(), const SizedBox(height: 16), ImageField(formGroup: formGroup)],
        );
      }
    });
  }
}

class _TenantAdminCarDetailBodyMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_TenantAdminCarState>()!;
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
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 100),
          child: ReactiveTextField<int>(
            formControlName: 'number',
            keyboardType: const TextInputType.numberWithOptions(),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 3,
            decoration: const InputDecoration(
              labelText: 'Number',
            ),
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
        Text('Car tags', style: Theme.of(context).textTheme.bodyLarge),
        if (!state.carTagsExists) const Text('(No car tags defined)'),
        if (state.carTagsExists)
          ReactiveFormArray(
              formArrayName: 'carTags',
              builder: (context, formArray, child) {
                final children = <Widget>[];
                formArray.forEachChild((formGroup) {
                  final fg = formGroup as FormGroup;
                  children.add(ReactiveForm(
                      formGroup: fg,
                      child: ReactiveCheckboxListTile(
                          formControlName: 'selected',
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(fg.control('name').value, overflow: TextOverflow.ellipsis))));
                });
                return Column(children: children);
              }),
      ],
    );
  }
}
