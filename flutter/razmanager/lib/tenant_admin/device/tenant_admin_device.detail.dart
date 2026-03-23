import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:grpc/grpc.dart' as grpc;
import 'package:uuid/uuid.dart';

import '../../app_model.dart';
import '../../app_progress_indicator.dart';
import '../../protobuf/razmanager/protobuf/public/device.service.v1.pbgrpc.dart' as public;
import '../../protobuf/razmanager/protobuf/public/device_request_response.v1.pb.dart' as public;
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/device.pbgrpc.dart' as crud;
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/common.pb.dart';
import '../../utilities/crud_master_detail_base.dart';
import '../../utilities/intent.dart';

class DeviceConnectionModel extends ChangeNotifier {
  public.DeviceConnectionResponse? deviceConnectionResponse;

  void setDeviceConnectionResponse(public.DeviceConnectionResponse value) {
    deviceConnectionResponse = value;
    notifyListeners();
  }
}

class DeviceSystemInformationModel extends ChangeNotifier {
  public.DeviceSystemInformationResponse? deviceSystemInformationResponse;

  void setDeviceSystemInformationResponse(public.DeviceSystemInformationResponse value) {
    deviceSystemInformationResponse = value;
    notifyListeners();
  }
}

class DeviceSettingsModel extends ChangeNotifier {
  public.DeviceSettingsResponse? deviceSettingsResponse;

  void setDeviceSettingsResponse(public.DeviceSettingsResponse value) {
    deviceSettingsResponse = value;
    notifyListeners();
  }
}

class TenantAdminDeviceDetail extends StatelessWidget {
  const TenantAdminDeviceDetail({super.key, required this.id, required this.oldEtag, required this.refreshItems});

  final String? id;
  final String? oldEtag;
  final AsyncCallback? refreshItems;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DeviceConnectionModel(),
      child: ChangeNotifierProvider(
        create: (context) => DeviceSystemInformationModel(),
        child: ChangeNotifierProvider(
          create: (context) => DeviceSettingsModel(),
          child: _TenantAdminDeviceDetailChild(id: id, oldEtag: oldEtag, refreshItems: refreshItems),
        ),
      ),
    );
  }
}

class _TenantAdminDeviceDetailChild extends CrudMasterDetailBase {
  const _TenantAdminDeviceDetailChild({required super.id, required super.oldEtag, required super.refreshItems});

  @override
  State createState() => _TenantAdminDeviceDetailState();
}

class _TenantAdminDeviceDetailState extends CrudMasterDetailStateBase<crud.DeviceRead> {
  _TenantAdminDeviceDetailState() : super(header: 'Device', child: _TenantAdminDeviceDetailBody());

  final deviceRequestStreamController = StreamController<public.DeviceRequest>();
  grpc.ClientChannel? publicClientChannel;
  grpc.ResponseStream<public.DeviceResponse>? deviceResponseResponseStream;

  public.DeviceServiceClient publicClient() {
    return public.DeviceServiceClient(publicClientChannel!, options: callOptionsFromContext(context));
  }

  crud.DeviceServiceClient client() {
    return crud.DeviceServiceClient(clientChannel!, options: callOptionsFromContext(context));
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();

    publicClientChannel = createClientChannel();

    deviceResponseResponseStream = publicClient().deviceRequestResponse(deviceRequestStreamController.stream);
    deviceResponseResponseStream!.listen((data) {
      debugPrint(data.toString());
      switch (data.whichValue()) {
        case public.DeviceResponse_Value.deviceConnectionResponse:
          context.read<DeviceConnectionModel>().setDeviceConnectionResponse(data.deviceConnectionResponse);
          break;
        case public.DeviceResponse_Value.deviceSystemInformationResponse:
          context.read<DeviceSystemInformationModel>().setDeviceSystemInformationResponse(data.deviceSystemInformationResponse);
          break;
        case public.DeviceResponse_Value.deviceSettingsResponse:
          context.read<DeviceSettingsModel>().setDeviceSettingsResponse(data.deviceSettingsResponse);
          break;
        default:
      }
    });
  }

  @override
  void dispose() async {
    super.dispose();

    try {
      await deviceRequestStreamController.close();

      if (deviceResponseResponseStream != null) {
        await deviceResponseResponseStream!.cancel();
      }

      if (publicClientChannel != null) {
        await publicClientChannel!.shutdown();
      }
    } catch (exception) {
      debugPrint(exception.toString());
    }
  }

  @override
  Future<crud.DeviceRead> initialize() {
    return client().initialize(Empty());
  }

  @override
  Future read(id) async {
    final response = await client().read(IdRequest(id: id));

    deviceRequestStreamController.add(public.DeviceRequest(id: id, correlationId: Uuid().v4(), deviceConnectionRequest: public.DeviceConnectionRequest()));
    deviceRequestStreamController.add(
      public.DeviceRequest(id: id, correlationId: Uuid().v4(), deviceSystemInformationRequest: public.DeviceSystemInformationRequest()),
    );
    deviceRequestStreamController.add(public.DeviceRequest(id: id, correlationId: Uuid().v4(), deviceSettingsReadRequest: public.DeviceSettingsReadRequest()));

    return (response.entity, response.etag);
  }

  @override
  Future<void> save(id) async {
    final proto = crud.DeviceCreateUpdate(
      name: formGroup.control('name').value,
      description: StringValue(value: formGroup.control('description').value),
    );
    await client().update(crud.DeviceUpdateRequest(id: id, entity: proto, etag: etag));

    final deviceSettings = public.DeviceSettings();

    final deviceConfigurationsFormArray = formGroup.control('deviceConfigurations') as FormArray;
    deviceConfigurationsFormArray.forEachChild((formGroup) {
      final deviceConfigurationFg = formGroup as FormGroup;

      final deviceConfigurationSettingsProto = public.DeviceConfigurationSettings(
        id: deviceConfigurationFg.control('id').value,
        name: deviceConfigurationFg.control('name').value,
      );

      final deviceIntegrationsFormArray = formGroup.control('deviceIntegrations') as FormArray;
      deviceIntegrationsFormArray.forEachChild((formGroup) {
        final deviceIntegrationFg = formGroup as FormGroup;
        final deviceIntegrationProto = public.DeviceIntegration();

        switch (deviceIntegrationFg.control('deviceIntegrationTypeId').value as public.DeviceIntegrationTypeId) {
          case public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_GPIO:
            deviceIntegrationProto.deviceIntegrationGpio = public.DeviceIntegrationGpio();
            break;

          case public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_OXIGEN:
            deviceIntegrationProto.deviceIntegrationOxigen = public.DeviceIntegrationOxigen(
              serialPortName: deviceIntegrationFg.control('serialPortName').value,
              oxigenRxLapTimeTypeId: deviceIntegrationFg.control('oxigenRxLapTimeTypeId').value,
              oxigenTxPitLaneLapCountingTypeId: deviceIntegrationFg.control('oxigenTxPitLaneLapCountingTypeId').value,
              oxigenTxPitLaneLapTriggerTypeId: deviceIntegrationFg.control('oxigenTxPitLaneLapTriggerTypeId').value,
              maxControllerId: 20,
            );
            break;

          case public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_SCALEXTRIC_ARC:
            deviceIntegrationProto.deviceIntegrationScalextricArc = public.DeviceIntegrationScalextricArc();
            break;

          case public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_SCALEXTRIC_APB:
            deviceIntegrationProto.deviceIntegrationScalextricApb = public.DeviceIntegrationScalextricApb(
              serialPortName: deviceIntegrationFg.control('serialPortName').value,
            );
            break;

          case public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_SCALEXTRIC_PIT_PRO:
            deviceIntegrationProto.deviceIntegrationScalextricPitPro = public.DeviceIntegrationScalextricPitPro(
              serialPortName: deviceIntegrationFg.control('serialPortName').value,
            );
            break;

          case public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_PHILIPS_HUE:
            deviceIntegrationProto.deviceIntegrationPhilipsHue = public.DeviceIntegrationPhilipsHue();
            break;

          case public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_RGB:
            deviceIntegrationProto.deviceIntegrationRgb = public.DeviceIntegrationRgb();
            break;

          case public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_LAP_MASTER:
            deviceIntegrationProto.deviceIntegrationLapMaster = public.DeviceIntegrationLapMaster(
              serialPortName: deviceIntegrationFg.control('serialPortName').value,
              lanes: deviceIntegrationFg.control('lanes').value,
            );
            break;

          case public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_CHRONO_LOG:
            deviceIntegrationProto.deviceIntegrationChronoLog = public.DeviceIntegrationChronoLog();
            break;

          default:
        }

        deviceConfigurationSettingsProto.deviceIntegrations.add(deviceIntegrationProto);
      });

      deviceSettings.deviceConfigurationSettings.add(deviceConfigurationSettingsProto);
    });

    deviceRequestStreamController.add(
      public.DeviceRequest(
        id: widget.id,
        correlationId: Uuid().v4(),
        deviceSettingsUpsertRequest: public.DeviceSettingsUpsertRequest(deviceSettings: deviceSettings),
      ),
    );
  }

  @override
  Future<void> delete(id) {
    return client().delete(DeleteRequest(id: id, etag: etag));
  }

  @override
  Future<void> createFormGroup(readProto) async {
    formGroup = FormGroup({
      'name': FormControl<String?>(value: readProto.name.hasValue() ? readProto.name.value : null, validators: [Validators.required]),
      'description': FormControl<String?>(value: readProto.description.hasValue() ? readProto.description.value : null),
      'deviceConfigurations': FormArray([]),
    });
  }

  void deviceConfigurationReadFormGroup(public.DeviceConfigurationSettings deviceConfigurationSettings) {
    final deviceConfigurationArray = formGroup.control('deviceConfigurations') as FormArray;
    final deviceConfigurationFg = FormGroup({
      'id': FormControl<String>(value: deviceConfigurationSettings.id),
      'name': FormControl<String?>(value: deviceConfigurationSettings.name, validators: [Validators.required]),
      'deviceIntegrations': FormArray([]),
    });

    for (final deviceIntegration in deviceConfigurationSettings.deviceIntegrations) {
      deviceIntegrationReadFormGroup(deviceConfigurationFg, deviceIntegration);
    }

    deviceConfigurationArray.add(deviceConfigurationFg);
  }

  void deviceConfigurationAddFormGroup() {
    final deviceConfigurationArray = formGroup.control('deviceConfigurations') as FormArray;
    final deviceConfigurationFg = FormGroup({
      'id': FormControl<String>(value: Uuid().v4()),
      'name': FormControl<String?>(value: null, validators: [Validators.required]),
      'deviceIntegrations': FormArray([]),
    });
    deviceConfigurationArray.add(deviceConfigurationFg);
    deviceConfigurationFg.markAsDirty();
  }

  void deviceConfigurationDeleteFormGroup(FormGroup deviceConfigurationFormGroup) {
    final deviceConfigurationArray = formGroup.control('deviceConfigurations') as FormArray;
    deviceConfigurationArray.remove(deviceConfigurationFormGroup);
    deviceConfigurationArray.markAsDirty();
  }

  void deviceIntegrationReadFormGroup(FormGroup deviceConfigurationFormGroup, public.DeviceIntegration deviceIntegration) {
    final deviceIntegrationArray = deviceConfigurationFormGroup.control('deviceIntegrations') as FormArray;
    FormGroup deviceIntegrationFg;
    switch (deviceIntegration.whichValue()) {
      case public.DeviceIntegration_Value.deviceIntegrationGpio:
        deviceIntegrationFg = FormGroup({
          'deviceIntegrationTypeId': FormControl<public.DeviceIntegrationTypeId?>(
            value: public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_GPIO,
            validators: [Validators.required],
          ),
        });
        break;

      case public.DeviceIntegration_Value.deviceIntegrationOxigen:
        deviceIntegrationFg = FormGroup({
          'deviceIntegrationTypeId': FormControl<public.DeviceIntegrationTypeId?>(
            value: public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_OXIGEN,
            validators: [Validators.required],
          ),
          'serialPortName': FormControl<String?>(value: deviceIntegration.deviceIntegrationOxigen.serialPortName),
          'oxigenRxLapTimeTypeId': FormControl<public.OxigenRxLapTimeTypeId?>(value: deviceIntegration.deviceIntegrationOxigen.oxigenRxLapTimeTypeId),
          'oxigenTxPitLaneLapCountingTypeId': FormControl<public.OxigenTxPitLaneLapCountingTypeId?>(
            value: deviceIntegration.deviceIntegrationOxigen.oxigenTxPitLaneLapCountingTypeId,
          ),
          'oxigenTxPitLaneLapTriggerTypeId': FormControl<public.OxigenTxPitLaneLapTriggerTypeId?>(
            value: deviceIntegration.deviceIntegrationOxigen.oxigenTxPitLaneLapTriggerTypeId,
          ),
          'maxControllerId': FormControl<int?>(value: deviceIntegration.deviceIntegrationOxigen.maxControllerId),
        });
        break;

      case public.DeviceIntegration_Value.deviceIntegrationScalextricArc:
        deviceIntegrationFg = FormGroup({
          'deviceIntegrationTypeId': FormControl<public.DeviceIntegrationTypeId?>(
            value: public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_SCALEXTRIC_ARC,
            validators: [Validators.required],
          ),
        });
        break;

      case public.DeviceIntegration_Value.deviceIntegrationScalextricApb:
        deviceIntegrationFg = FormGroup({
          'deviceIntegrationTypeId': FormControl<public.DeviceIntegrationTypeId?>(
            value: public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_SCALEXTRIC_APB,
            validators: [Validators.required],
          ),
          'serialPortName': FormControl<String?>(value: deviceIntegration.deviceIntegrationScalextricApb.serialPortName),
        });
        break;

      case public.DeviceIntegration_Value.deviceIntegrationScalextricPitPro:
        deviceIntegrationFg = FormGroup({
          'deviceIntegrationTypeId': FormControl<public.DeviceIntegrationTypeId?>(
            value: public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_SCALEXTRIC_PIT_PRO,
            validators: [Validators.required],
          ),
          'serialPortName': FormControl<String?>(value: deviceIntegration.deviceIntegrationScalextricPitPro.serialPortName),
        });
        break;

      case public.DeviceIntegration_Value.deviceIntegrationPhilipsHue:
        deviceIntegrationFg = FormGroup({
          'deviceIntegrationTypeId': FormControl<public.DeviceIntegrationTypeId?>(
            value: public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_PHILIPS_HUE,
            validators: [Validators.required],
          ),
        });
        break;

      case public.DeviceIntegration_Value.deviceIntegrationRgb:
        deviceIntegrationFg = FormGroup({
          'deviceIntegrationTypeId': FormControl<public.DeviceIntegrationTypeId?>(
            value: public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_RGB,
            validators: [Validators.required],
          ),
        });
        break;

      case public.DeviceIntegration_Value.deviceIntegrationLapMaster:
        deviceIntegrationFg = FormGroup({
          'deviceIntegrationTypeId': FormControl<public.DeviceIntegrationTypeId?>(
            value: public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_LAP_MASTER,
            validators: [Validators.required],
          ),
          'serialPortName': FormControl<String?>(value: deviceIntegration.deviceIntegrationLapMaster.serialPortName),
          'lanes': FormControl<int?>(value: deviceIntegration.deviceIntegrationLapMaster.lanes),
        });
        break;

      case public.DeviceIntegration_Value.deviceIntegrationChronoLog:
        deviceIntegrationFg = FormGroup({
          'deviceIntegrationTypeId': FormControl<public.DeviceIntegrationTypeId?>(
            value: public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_CHRONO_LOG,
            validators: [Validators.required],
          ),
        });
        break;

      default:
        deviceIntegrationFg = FormGroup({});
    }
    deviceIntegrationArray.add(deviceIntegrationFg);
  }

  void deviceIntegrationAddFormGroup(FormGroup deviceConfigurationFormGroup) {
    final deviceIntegrationArray = deviceConfigurationFormGroup.control('deviceIntegrations') as FormArray;
    final deviceIntegrationFg = FormGroup({
      'deviceIntegrationTypeId': FormControl<public.DeviceIntegrationTypeId?>(value: null, validators: [Validators.required]),
      'serialPortName': FormControl<String?>(value: null),
      'oxigenRxLapTimeTypeId': FormControl<public.OxigenRxLapTimeTypeId?>(value: null),
      'oxigenTxPitLaneLapCountingTypeId': FormControl<public.OxigenTxPitLaneLapCountingTypeId?>(value: null),
      'oxigenTxPitLaneLapTriggerTypeId': FormControl<public.OxigenTxPitLaneLapTriggerTypeId?>(value: null),
      'maxControllerId': FormControl<int?>(value: null),
      'lanes': FormControl<int?>(value: null),
    });
    deviceIntegrationArray.add(deviceIntegrationFg);
    deviceIntegrationFg.markAsDirty();
  }

  void deviceIntegrationDeleteFormGroup(FormGroup deviceIntegrationFormGroup, FormArray deviceIntegrationArray) {
    deviceIntegrationArray.remove(deviceIntegrationFormGroup);
    deviceIntegrationArray.markAsDirty();
  }
}

class _TenantAdminDeviceDetailBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_TenantAdminDeviceDetailState>()!;
    final deviceConfigurationArray = state.formGroup.control('deviceConfigurations') as FormArray;
    return Consumer<DeviceSettingsModel>(
      builder: (context, model, _) {
        deviceConfigurationArray.value = [];

        if (model.deviceSettingsResponse != null) {
          for (final deviceConfigurationSettings in model.deviceSettingsResponse!.deviceSettings.deviceConfigurationSettings) {
            state.deviceConfigurationReadFormGroup(deviceConfigurationSettings);
          }
        }

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter deviceSetState) => DefaultTabController(
            length: 1 + deviceConfigurationArray.controls.length,
            child: Scaffold(
              appBar: AppBar(
                title: Text(state.header),
                flexibleSpace: const AppProgressIndicator(),
                bottom: TabBar(
                  isScrollable: true,
                  tabs: [
                    Tab(text: state.header),
                    ...deviceConfigurationArray.controls.map((deviceConfigurationFormGroup) {
                      final fg = deviceConfigurationFormGroup as FormGroup;
                      final name = fg.control('name').value;
                      return Tab(text: name ?? "New device configuration");
                    }),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: Padding(padding: const EdgeInsets.all(16), child: _TenantAdminDeviceDetailBodyMain()),
                  ),
                  ...deviceConfigurationArray.controls.map(
                    (deviceConfigurationFormGroup) => StatefulBuilder(
                      builder: (BuildContext context, StateSetter deviceConfigurationSetState) {
                        final deviceIntegrationArray = (deviceConfigurationFormGroup as FormGroup).control('deviceIntegrations') as FormArray;
                        return Expanded(
                          child: Stack(
                            children: [
                              SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      _TenantAdminDeviceConfigurationBody(formGroup: deviceConfigurationFormGroup as FormGroup),
                                      ...deviceIntegrationArray.controls.map(
                                        (deviceIntegrationFormGroup) => _TenantAdminDeviceIntegrationBody(
                                          formGroup: deviceIntegrationFormGroup as FormGroup,
                                          deviceIntegrationArray: deviceIntegrationArray,
                                          deviceConfigurationSetState: deviceConfigurationSetState,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      FilledButton.tonalIcon(
                                        icon: const Icon(Icons.add),
                                        label: const Text('Add device integration'),
                                        onPressed: () => deviceConfigurationSetState(() => state.deviceIntegrationAddFormGroup(deviceConfigurationFormGroup)),
                                      ),
                                      SizedBox(height: 16),
                                      FilledButton.tonalIcon(
                                        icon: const Icon(Icons.delete),
                                        label: const Text('Delete device configuration'),
                                        onPressed: () => deviceSetState(() => state.deviceConfigurationDeleteFormGroup(deviceConfigurationFormGroup)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: BottomAppBar(
                child: Consumer<AppModel>(
                  builder: (context, model, _) {
                    return ReactiveFormConsumer(
                      builder: (context, formGroup, _) {
                        return Row(
                          children: [
                            Tooltip(
                              message: 'Ctrl+S - Save',
                              child: FilledButton.icon(
                                icon: const Icon(Icons.save),
                                label: const Text('Save'),
                                onPressed: Actions.handler<SaveIntent>(context, SaveIntent()),
                              ),
                            ),
                            if (!state.add) const SizedBox(width: 16),
                            if (!state.add)
                              Tooltip(
                                message: 'Ctrl+D - Delete',
                                child: FilledButton.tonalIcon(
                                  icon: const Icon(Icons.delete),
                                  label: const Text('Delete'),
                                  onPressed: Actions.handler<DeleteIntent>(context, DeleteIntent()),
                                ),
                              ),
                            const SizedBox(width: 16),
                            FilledButton.tonalIcon(
                              icon: const Icon(Icons.add),
                              label: const Text('Add device configuration'),
                              onPressed: () => deviceSetState(() => state.deviceConfigurationAddFormGroup()),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TenantAdminDeviceDetailBodyMain extends StatelessWidget {
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
        Consumer<DeviceConnectionModel>(
          builder: (_, model, __) => TextField(
            readOnly: true,
            controller: TextEditingController(text: model.deviceConnectionResponse?.connected.toString() ?? '?'),
            decoration: const InputDecoration(labelText: 'Connected', border: InputBorder.none),
          ),
        ),
        Consumer<DeviceSystemInformationModel>(
          builder: (_, model, __) => Column(
            children: [
              if (model.deviceSystemInformationResponse != null && model.deviceSystemInformationResponse!.hardwareModel.hasValue())
                TextField(
                  readOnly: true,
                  controller: TextEditingController(text: model.deviceSystemInformationResponse?.hardwareModel.toString()),
                  decoration: const InputDecoration(labelText: 'Hardware model', border: InputBorder.none),
                ),
              if (model.deviceSystemInformationResponse != null && model.deviceSystemInformationResponse!.hardwareProcessor.hasValue())
                TextField(
                  readOnly: true,
                  controller: TextEditingController(text: model.deviceSystemInformationResponse?.hardwareProcessor.toString()),
                  decoration: const InputDecoration(labelText: 'Hardware processor', border: InputBorder.none),
                ),
              if (model.deviceSystemInformationResponse != null && model.deviceSystemInformationResponse!.hardwareModel.hasValue())
                TextField(
                  readOnly: true,
                  controller: TextEditingController(text: model.deviceSystemInformationResponse?.softwareAssemblyVersion.value.toString()),
                  decoration: const InputDecoration(labelText: 'Software version', border: InputBorder.none),
                ),
              if (model.deviceSystemInformationResponse != null && model.deviceSystemInformationResponse!.softwareSnapVersion.hasValue())
                TextField(
                  readOnly: true,
                  controller: TextEditingController(text: model.deviceSystemInformationResponse?.softwareSnapVersion.value),
                  decoration: const InputDecoration(labelText: 'Software snap version', border: InputBorder.none),
                ),
              if (model.deviceSystemInformationResponse != null && model.deviceSystemInformationResponse!.softwareDotNetVersion.hasValue())
                TextField(
                  readOnly: true,
                  controller: TextEditingController(text: model.deviceSystemInformationResponse?.softwareDotNetVersion.value),
                  decoration: const InputDecoration(labelText: 'Software .NET version', border: InputBorder.none),
                ),
              if (model.deviceSystemInformationResponse != null && model.deviceSystemInformationResponse!.softwareOsVersion.hasValue())
                TextField(
                  readOnly: true,
                  controller: TextEditingController(text: model.deviceSystemInformationResponse?.softwareOsVersion.value),
                  decoration: const InputDecoration(labelText: 'OS version', border: InputBorder.none),
                ),
              if (model.deviceSystemInformationResponse != null && model.deviceSystemInformationResponse!.softwareOsReleaseVersion.hasValue())
                TextField(
                  readOnly: true,
                  controller: TextEditingController(text: model.deviceSystemInformationResponse?.softwareOsReleaseVersion.value),
                  decoration: const InputDecoration(labelText: 'OS release version', border: InputBorder.none),
                ),
              if (model.deviceSystemInformationResponse != null && model.deviceSystemInformationResponse!.serialPortNames.isNotEmpty)
                TextField(
                  readOnly: true,
                  controller: TextEditingController(text: model.deviceSystemInformationResponse?.serialPortNames.join(', ')),
                  decoration: const InputDecoration(labelText: 'Serial ports', border: InputBorder.none),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TenantAdminDeviceConfigurationBody extends StatelessWidget {
  const _TenantAdminDeviceConfigurationBody({required this.formGroup});

  final FormGroup formGroup;

  @override
  Widget build(BuildContext context) {
    //final state = context.findAncestorStateOfType<_TenantAdminDeviceDetailState>()!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ReactiveForm(
          formGroup: formGroup,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReactiveTextField<String?>(
                formControlName: 'name',
                maxLength: 100,
                textCapitalization: TextCapitalization.sentences,
                validationMessages: {ValidationMessage.required: (error) => 'Please enter a name.'},
                decoration: const InputDecoration(labelText: "Name *"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TenantAdminDeviceIntegrationBody extends StatelessWidget {
  const _TenantAdminDeviceIntegrationBody({required this.formGroup, required this.deviceIntegrationArray, required this.deviceConfigurationSetState});

  final FormGroup formGroup;
  final FormArray deviceIntegrationArray;
  final StateSetter deviceConfigurationSetState;

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_TenantAdminDeviceDetailState>()!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ReactiveForm(
          formGroup: formGroup,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: ReactiveDropdownField<public.DeviceIntegrationTypeId?>(
                        formControlName: 'deviceIntegrationTypeId',
                        validationMessages: {ValidationMessage.required: (error) => 'Please select an integration.'},
                        decoration: const InputDecoration(labelText: 'Integration *'),
                        items: const [
                          DropdownMenuItem(value: public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_GPIO, child: Text('GPIO')),
                          DropdownMenuItem(value: public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_OXIGEN, child: Text('oXigen')),
                          DropdownMenuItem(value: public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_SCALEXTRIC_ARC, child: Text('Scalextric ARC')),
                          DropdownMenuItem(
                            value: public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_SCALEXTRIC_APB,
                            child: Text('Scalextric Advanced Powerbase (C7042)'),
                          ),
                          DropdownMenuItem(
                            value: public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_SCALEXTRIC_PIT_PRO,
                            child: Text('Scalextric Pit Pro'),
                          ),
                          DropdownMenuItem(value: public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_PHILIPS_HUE, child: Text('Philips Hue')),
                          DropdownMenuItem(value: public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_RGB, child: Text('RGB LED Matrix')),
                          DropdownMenuItem(value: public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_LAP_MASTER, child: Text('Lap Master')),
                          DropdownMenuItem(value: public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_CHRONO_LOG, child: Text('Chrono log file')),
                        ],
                        onChanged: (control) => setState(() {}),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => deviceConfigurationSetState(() => state.deviceIntegrationDeleteFormGroup(formGroup, deviceIntegrationArray)),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                if (formGroup.control('deviceIntegrationTypeId').value == public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_GPIO)
                  Text('DEVICE_INTEGRATION_TYPE_ID_GPIO')
                else if (formGroup.control('deviceIntegrationTypeId').value == public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_OXIGEN) ...[
                  _SerialPortDropDown(),

                  const SizedBox(height: 16),

                  Text('Lap times *', style: Theme.of(context).textTheme.bodyLarge),
                  ReactiveRadioListTile<public.OxigenRxLapTimeTypeId?>(
                    formControlName: "oxigenRxLapTimeTypeId",
                    value: public.OxigenRxLapTimeTypeId.OXIGEN_RX_LAP_TIME_TYPE_ID_CONTROLLER,
                    title: const Text('Controller'),
                  ),
                  ReactiveRadioListTile<public.OxigenRxLapTimeTypeId?>(
                    formControlName: "oxigenRxLapTimeTypeId",
                    value: public.OxigenRxLapTimeTypeId.OXIGEN_RX_LAP_TIME_TYPE_ID_TIMER,
                    title: const Text('Timer'),
                  ),
                  ReactiveRadioListTile<public.OxigenRxLapTimeTypeId?>(
                    formControlName: "oxigenRxLapTimeTypeId",
                    value: public.OxigenRxLapTimeTypeId.OXIGEN_RX_LAP_TIME_TYPE_ID_NONE,
                    title: const Text("Don't use lap times from oXigen"),
                  ),

                  const SizedBox(height: 16),

                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Pitlane lap counting *', style: Theme.of(context).textTheme.bodyLarge),
                        ReactiveRadioListTile<public.OxigenTxPitLaneLapCountingTypeId?>(
                          formControlName: "oxigenTxPitLaneLapCountingTypeId",
                          value: public.OxigenTxPitLaneLapCountingTypeId.OXIGEN_TX_PIT_LANE_LAP_COUNTING_TYPE_ID_ENABLED,
                          title: const Text('Enabled'),
                          onChanged: (control) => setState(() {}),
                        ),
                        ReactiveRadioListTile<public.OxigenTxPitLaneLapCountingTypeId?>(
                          formControlName: "oxigenTxPitLaneLapCountingTypeId",
                          value: public.OxigenTxPitLaneLapCountingTypeId.OXIGEN_TX_PIT_LANE_LAP_COUNTING_TYPE_ID_DISABLED,
                          title: const Text('Disabled'),
                          onChanged: (control) => setState(() {}),
                        ),

                        const SizedBox(height: 16),

                        Text('Pitlane lap trigger placement *', style: Theme.of(context).textTheme.bodyLarge),
                        ReactiveRadioListTile<public.OxigenTxPitLaneLapTriggerTypeId?>(
                          formControlName: "oxigenTxPitLaneLapTriggerTypeId",
                          value: public.OxigenTxPitLaneLapTriggerTypeId.OXIGEN_TX_PIT_LANE_LAP_TRIGGER_TYPE_ID_PIT_LANE_ENTRY,
                          title: const Text('Entry'),
                        ),
                        ReactiveRadioListTile<public.OxigenTxPitLaneLapTriggerTypeId?>(
                          formControlName: "oxigenTxPitLaneLapTriggerTypeId",
                          value: public.OxigenTxPitLaneLapTriggerTypeId.OXIGEN_TX_PIT_LANE_LAP_TRIGGER_TYPE_ID_PIT_LANE_EXIT,
                          title: const Text('Exit'),
                        ),
                      ],
                    ),
                  ),
                ] else if (formGroup.control('deviceIntegrationTypeId').value == public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_SCALEXTRIC_ARC)
                  Text('ARC settings...')
                else if (formGroup.control('deviceIntegrationTypeId').value == public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_SCALEXTRIC_APB)
                  _SerialPortDropDown()
                else if (formGroup.control('deviceIntegrationTypeId').value == public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_SCALEXTRIC_PIT_PRO)
                  _SerialPortDropDown()
                else if (formGroup.control('deviceIntegrationTypeId').value == public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_PHILIPS_HUE)
                  Text('DEVICE_INTEGRATION_TYPE_ID_PHILIPS_HUE')
                else if (formGroup.control('deviceIntegrationTypeId').value == public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_RGB)
                  Text('DEVICE_INTEGRATION_TYPE_ID_RGB')
                else if (formGroup.control('deviceIntegrationTypeId').value == public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_LAP_MASTER) ...[
                  _SerialPortDropDown(),
                  const SizedBox(height: 16),

                  Text('Number of lanes *', style: Theme.of(context).textTheme.bodyLarge),
                  ReactiveRadioListTile<int?>(formControlName: "lanes", value: 4, title: const Text('4')),
                  ReactiveRadioListTile<int?>(formControlName: "lanes", value: 8, title: const Text('8')),
                ] else if (formGroup.control('deviceIntegrationTypeId').value == public.DeviceIntegrationTypeId.DEVICE_INTEGRATION_TYPE_ID_CHRONO_LOG)
                  Text('Chrono log file settings...'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SerialPortDropDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSystemInformationModel = context.read<DeviceSystemInformationModel>();
    if (deviceSystemInformationModel.deviceSystemInformationResponse != null) {
      return ReactiveDropdownField<String?>(
        formControlName: 'serialPortName',
        validationMessages: {ValidationMessage.required: (error) => 'Please select a serial port.'},
        decoration: const InputDecoration(labelText: 'Serial port *'),
        items: deviceSystemInformationModel.deviceSystemInformationResponse!.serialPortNames.map((x) => DropdownMenuItem(value: x, child: Text(x))).toList(),
      );
    } else {
      return Text('No serial ports found');
    }
  }
}
