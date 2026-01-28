import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';

import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/common.pb.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/device.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/public/device.v1.pb.dart';
import '../../protobuf/razmanager/protobuf/public/device_configuration_input_type_id.v1.pbenum.dart';
import '../../protobuf/razmanager/protobuf/public/device_configuration_output_type_id.v1.pbenum.dart';
import '../../utilities/crud_master_detail_base.dart';
import '../../utilities/crud_master_detail_single_base.dart';
import 'tenant_admin_device_configuration_input_type.dart';

class TenantAdminDeviceIoSimulatedDetail extends CrudMasterDetailBase {
  const TenantAdminDeviceIoSimulatedDetail(
      {super.key, required super.id, required super.oldEtag, required super.refreshItems});

  @override
  State createState() => _TenantAdminDeviceIoSimulatedState();
}

class _TenantAdminDeviceIoSimulatedState extends CrudMasterDetailSingleStateBase<DeviceRead> {
  _TenantAdminDeviceIoSimulatedState()
      : super(header: 'Device - Input/Output (Simulated)', child: _TenantAdminDeviceIoSimulatedDetailBody());

  DeviceServiceClient client() {
    return DeviceServiceClient(clientChannel!, options: callOptionsFromContext(context));
  }

  @override
  Future<DeviceRead> initialize() {
    return client().initialize(Empty());
  }

  @override
  Future read(id) async {
    final response = await client().read(IdRequest(id: id));
    return (response.entity, response.etag);
  }

  @override
  Future<void> save(id) async {
    final deviceConfigurationProto = DeviceConfigurationCreateUpdate();

    final deviceConfigurationInputsFormArray = formGroup.control('deviceConfigurationInputs') as FormArray;
    deviceConfigurationInputsFormArray.forEachChild((deviceConfigurationInputFormGroup) {
      final deviceConfigurationInputFg = deviceConfigurationInputFormGroup as FormGroup;

      final deviceConfigurationInputProto = DeviceDeviceConfigurationInput(
          deviceConfigurationInputTypeId: deviceConfigurationInputFg.control('deviceConfigurationInputTypeId').value);
      if (deviceConfigurationInputFg.control('deviceConfigurationInputId').value != null) {
        deviceConfigurationInputProto.deviceConfigurationInputId =
            UInt32Value(value: deviceConfigurationInputFg.control('deviceConfigurationInputId').value);
      }
      deviceConfigurationProto.deviceConfigurationInputs.add(deviceConfigurationInputProto);
    });

    final deviceConfigurationOutputsFormArray = formGroup.control('deviceConfigurationOutputs') as FormArray;
    deviceConfigurationOutputsFormArray.forEachChild((deviceConfigurationOutputFormGroup) {
      final deviceConfigurationOutputFg = deviceConfigurationOutputFormGroup as FormGroup;

      final deviceConfigurationOutputProto = DeviceDeviceConfigurationOutput(
          deviceConfigurationOutputTypeId:
              deviceConfigurationOutputFg.control('deviceConfigurationOutputTypeId').value);
      if (deviceConfigurationOutputFg.control('deviceConfigurationOutputId').value != null) {
        deviceConfigurationOutputProto.deviceConfigurationOutputId =
            UInt32Value(value: deviceConfigurationOutputFg.control('deviceConfigurationOutputId').value);
      }
      deviceConfigurationProto.deviceConfigurationOutputs.add(deviceConfigurationOutputProto);
    });

    final proto = DeviceCreateUpdate(
        name: formGroup.control('name').value,
        description: StringValue(value: formGroup.control('description').value),
        deviceConfigurations: List<DeviceConfigurationCreateUpdate>.from({deviceConfigurationProto}));

    if (add) {
      await client().create(proto);
    } else {
      await client().update(DeviceUpdateRequest(id: id, entity: proto, etag: etag));
    }
  }

  @override
  Future<void> delete(id) async {
    await client().delete(DeleteRequest(id: id, etag: etag));
  }

  @override
  Future<void> createFormGroup(readProto) async {
    formGroup = FormGroup({
      'name': FormControl<String?>(
          value: readProto.name.hasValue() ? readProto.name.value : null, validators: [Validators.required]),
      'description': FormControl<String?>(value: readProto.description.hasValue() ? readProto.description.value : null),
      'deviceConfigurationInputs': FormArray([]),
      'deviceConfigurationOutputs': FormArray([])
    });

    final deviceConfigurationProto = readProto.deviceConfigurations.firstOrNull;
    if (deviceConfigurationProto != null) {
      for (final deviceConfigurationInputProto in deviceConfigurationProto.deviceConfigurationInputs) {
        deviceConfigurationInputAddFormGroup(proto: deviceConfigurationInputProto, markAsDirty: false);
      }
      for (final deviceConfigurationOutputProto in deviceConfigurationProto.deviceConfigurationOutputs) {
        deviceConfigurationOutputAddFormGroup(proto: deviceConfigurationOutputProto, markAsDirty: false);
      }
    }
  }

  void deviceConfigurationInputAdd() {
    deviceConfigurationInputAddFormGroup(proto: DeviceDeviceConfigurationInput(), markAsDirty: true);
  }

  void deviceConfigurationInputAddFormGroup(
      {required DeviceDeviceConfigurationInput proto, required bool markAsDirty}) {
    final formArray = formGroup.control('deviceConfigurationInputs') as FormArray;
    final fg = FormGroup({
      'deviceConfigurationInputTypeId': FormControl<DeviceConfigurationInputTypeId>(
          value: proto.deviceConfigurationInputTypeId, validators: [Validators.required]),
      'deviceConfigurationInputId': FormControl<int>(
          value: proto.deviceConfigurationInputId.hasValue() ? proto.deviceConfigurationInputId.value : null)
    });
    formArray.add(fg);
    if (markAsDirty) {
      fg.markAsDirty();
    }
  }

  void deviceConfigurationInputDelete(FormGroup deviceConfigurationInputFormGroup) {
    final formArray = formGroup.control('deviceConfigurationInputs') as FormArray;
    formArray.remove(deviceConfigurationInputFormGroup);
    formArray.markAsDirty();
  }

  void deviceConfigurationOutputAdd() {
    final deviceConfigurationOutputArray = formGroup.control('deviceConfigurationOutputs') as FormArray;
    final fg = FormGroup({
      'deviceConfigurationOutputTypeId':
          FormControl<DeviceConfigurationOutputTypeId>(validators: [Validators.required]),
      'deviceConfigurationOutputId': FormControl<int>(),
    });
    deviceConfigurationOutputArray.add(fg);
    fg.markAsDirty();
  }

  void deviceConfigurationOutputAddFormGroup(
      {required DeviceDeviceConfigurationOutput proto, required bool markAsDirty}) {
    final formArray = formGroup.control('deviceConfigurationOutputs') as FormArray;
    final fg = FormGroup({
      'deviceConfigurationOutputTypeId': FormControl<DeviceConfigurationOutputTypeId>(
          value: proto.deviceConfigurationOutputTypeId, validators: [Validators.required]),
      'deviceConfigurationOutputId': FormControl<int>(
          value: proto.deviceConfigurationOutputId.hasValue() ? proto.deviceConfigurationOutputId.value : null)
    });
    formArray.add(fg);
    if (markAsDirty) {
      fg.markAsDirty();
    }
  }

  void deviceConfigurationOutputDelete(FormGroup deviceConfigurationOutputFormGroup) {
    final deviceConfigurationOutputArray = formGroup.control('deviceConfigurationOutputs') as FormArray;
    deviceConfigurationOutputArray.remove(deviceConfigurationOutputFormGroup);
    deviceConfigurationOutputArray.markAsDirty();
  }

  final deviceConfigurationOutputTypes = DeviceConfigurationOutputTypeId.values.map((item) {
    switch (item) {
      case DeviceConfigurationOutputTypeId.DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_START_FINISH_INDICATOR:
        return DeviceConfigurationOutputType(id: item, name: 'Start/finish indicator');
      case DeviceConfigurationOutputTypeId.DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_POWER_ON:
        return DeviceConfigurationOutputType(id: item, name: 'Power on');
      case DeviceConfigurationOutputTypeId.DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_POWER_YELLOW:
        return DeviceConfigurationOutputType(id: item, name: 'Power slow');
      case DeviceConfigurationOutputTypeId.DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_POWER_OFF:
        return DeviceConfigurationOutputType(id: item, name: 'Power off');
      case DeviceConfigurationOutputTypeId.DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_COUNTDOWN_ON:
        return DeviceConfigurationOutputType(id: item, name: 'Countdown on');
      case DeviceConfigurationOutputTypeId.DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_COUNTDOWN_OFF:
        return DeviceConfigurationOutputType(id: item, name: 'Countdown off');
      case DeviceConfigurationOutputTypeId.DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_HEAT_GREEN:
        return DeviceConfigurationOutputType(id: item, name: 'Heat green');
      case DeviceConfigurationOutputTypeId.DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_HEAT_YELLOW:
        return DeviceConfigurationOutputType(id: item, name: 'Heat yellow');
      case DeviceConfigurationOutputTypeId.DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_HEAT_RED:
        return DeviceConfigurationOutputType(id: item, name: 'Heat red');
      case DeviceConfigurationOutputTypeId.DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_HEAT_OFF:
        return DeviceConfigurationOutputType(id: item, name: 'Heat off');
      case DeviceConfigurationOutputTypeId.DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_PITSTOP:
        return DeviceConfigurationOutputType(id: item, name: 'Pitstop');
      case DeviceConfigurationOutputTypeId.DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_ENERGY_LEVEL:
        return DeviceConfigurationOutputType(id: item, name: 'Energy level');
      case DeviceConfigurationOutputTypeId.DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_ENERGY_LAPS_LEFT:
        return DeviceConfigurationOutputType(id: item, name: 'Energy laps left');
      default:
        throw Exception('Missing DeviceConfigurationOutputTypeId: {item}');
    }
  });
}

class _TenantAdminDeviceIoSimulatedDetailBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
            "This is a simulated device, which you can use to simulate input to a track and a heat, and also see how output from a heat controls output to a device connected to a track."),
        const SizedBox(height: 8),
        const Text(
            "Define the device inputs and outputs you want to simulate, save the device, link it to a track, an event and a race, then go to the monitor tab to simulate input and watch what happens."),
        const SizedBox(height: 8),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1300),
          child: ReactiveTextField<String?>(
            formControlName: 'name',
            maxLength: 100,
            textCapitalization: TextCapitalization.sentences,
            validationMessages: {ValidationMessage.required: (error) => 'Please enter a name.'},
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
        const SizedBox(height: 16),
        _TenantAdminDeviceIoSimulatedDeviceConfigurationInput(),
        const SizedBox(height: 16),
        _TenantAdminDeviceIoSimulatedDeviceConfigurationOutput(),
      ],
    );
  }
}

class _TenantAdminDeviceIoSimulatedDeviceConfigurationInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_TenantAdminDeviceIoSimulatedState>()!;
    return ReactiveFormArray(
        formArrayName: 'deviceConfigurationInputs',
        builder: (context, formArray, child) {
          final children = <Widget>[];
          children.add(deviceConfigurationInputRow(
              deviceConfigurationInputTypeId: const Text('Input'),
              deviceConfigurationInputId: const Text('Indicator#')));
          formArray.forEachChild((formGroup) {
            final fg = formGroup as FormGroup;
            children.add(
              ReactiveForm(
                key: UniqueKey(),
                formGroup: fg,
                child: deviceConfigurationInputRow(
                  deviceConfigurationInputTypeId: ReactiveDropdownField<DeviceConfigurationInputTypeId>(
                      formControlName: 'deviceConfigurationInputTypeId',
                      items: DeviceConfigurationInputTypes.all
                          .map((item) => DropdownMenuItem(value: item.id, child: Text(item.name)))
                          .toList()),
                  deviceConfigurationInputId: ReactiveTextField<int>(
                      formControlName: 'deviceConfigurationInputId',
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 2,
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        counterText: '',
                      ),
                      validationMessages: {ValidationMessage.required: (error) => 'Please enter an indicator#.'}),
                  delete: IconButton(
                      icon: const Icon(Icons.delete), onPressed: () => state.deviceConfigurationInputDelete(fg)),
                ),
              ),
            );
          });
          children.add(const SizedBox(height: 16));
          children.add(IconButton.filledTonal(
            icon: const Icon(Icons.add),
            onPressed: () => state.deviceConfigurationInputAdd(),
            tooltip: 'Add a simulated input',
          ));
          return Column(children: children);
        });
  }

  Row deviceConfigurationInputRow(
      {required Widget deviceConfigurationInputTypeId, required Widget deviceConfigurationInputId, Widget? delete}) {
    return Row(
      children: [
        SizedBox(width: 300, child: deviceConfigurationInputTypeId),
        const SizedBox(width: 16),
        SizedBox(width: 70, child: deviceConfigurationInputId),
        const SizedBox(width: 16),
        if (delete != null) delete
      ],
    );
  }
}

class _TenantAdminDeviceIoSimulatedDeviceConfigurationOutput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_TenantAdminDeviceIoSimulatedState>()!;
    return ReactiveFormArray(
        formArrayName: 'deviceConfigurationOutputs',
        builder: (context, formArray, child) {
          final children = <Widget>[];
          children.add(deviceConfigurationOutputRow(
              deviceConfigurationOutputTypeId: const Text('Output'),
              deviceConfigurationOutputId: const Text('Indicator#')));
          formArray.forEachChild((formGroup) {
            final fg = formGroup as FormGroup;
            children.add(
              ReactiveForm(
                key: UniqueKey(),
                formGroup: fg,
                child: deviceConfigurationOutputRow(
                  deviceConfigurationOutputTypeId: ReactiveDropdownField<DeviceConfigurationOutputTypeId>(
                      formControlName: 'deviceConfigurationOutputTypeId',
                      items: state.deviceConfigurationOutputTypes
                          .map((item) => DropdownMenuItem(value: item.id, child: Text(item.name)))
                          .toList()),
                  deviceConfigurationOutputId: ReactiveTextField<int>(
                      formControlName: 'deviceConfigurationOutputId',
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 2,
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        counterText: '',
                      ),
                      validationMessages: {ValidationMessage.required: (error) => 'Please enter an indicator#.'}),
                  delete: IconButton(
                      icon: const Icon(Icons.delete), onPressed: () => state.deviceConfigurationOutputDelete(fg)),
                ),
              ),
            );
          });
          children.add(const SizedBox(height: 16));
          children.add(IconButton.filledTonal(
            icon: const Icon(Icons.add),
            onPressed: () => state.deviceConfigurationOutputAdd(),
            tooltip: 'Add a simulated output',
          ));
          return Column(children: children);
        });
  }

  Row deviceConfigurationOutputRow(
      {required Widget deviceConfigurationOutputTypeId, required Widget deviceConfigurationOutputId, Widget? delete}) {
    return Row(
      children: [
        SizedBox(width: 300, child: deviceConfigurationOutputTypeId),
        const SizedBox(width: 16),
        SizedBox(width: 70, child: deviceConfigurationOutputId),
        const SizedBox(width: 16),
        if (delete != null) delete
      ],
    );
  }
}

class DeviceConfigurationOutputType {
  DeviceConfigurationOutputType({required this.id, required this.name});

  final DeviceConfigurationOutputTypeId id;
  final String name;
}
