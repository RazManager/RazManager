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
  Future<void> save(id) {
    final proto = crud.DeviceCreateUpdate(
      name: formGroup.control('name').value,
      description: StringValue(value: formGroup.control('description').value),
    );
    return client().update(crud.DeviceUpdateRequest(id: id, entity: proto, etag: etag));
  }

  @override
  Future<void> delete(id) {
    return client().delete(DeleteRequest(id: id, etag: etag));
  }

  void deviceConfigurationAddFormGroup(crud.DeviceConfigurationRead deviceConfigurationProto, bool markAsDirty) {
    final deviceConfigurationArray = formGroup.control('deviceConfigurations') as FormArray;
    final deviceConfigurationFg = FormGroup({
      'id': FormControl<String?>(value: deviceConfigurationProto.id.hasValue() ? deviceConfigurationProto.id.value : null),
      'name': FormControl<String?>(
        value: deviceConfigurationProto.name.hasValue() ? deviceConfigurationProto.name.value : null,
        validators: [Validators.required],
      ),
    });
    deviceConfigurationArray.add(deviceConfigurationFg);

    if (markAsDirty) {
      deviceConfigurationFg.markAsDirty();
    }
  }

  @override
  Future<void> createFormGroup(readProto) async {
    formGroup = FormGroup({
      'name': FormControl<String?>(value: readProto.name.hasValue() ? readProto.name.value : null, validators: [Validators.required]),
      'description': FormControl<String?>(value: readProto.description.hasValue() ? readProto.description.value : null),
      'deviceConfigurations': FormArray([]),
    });
  }

  void deviceConfigurationDelete(FormGroup deviceConfigurationFormGroup) {
    final deviceConfigurationArray = formGroup.control('deviceConfigurations') as FormArray;
    deviceConfigurationArray.remove(deviceConfigurationFormGroup);
    deviceConfigurationArray.markAsDirty();
  }
}

class _TenantAdminDeviceDetailBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_TenantAdminDeviceDetailState>()!;
    final deviceConfigurationArray = state.formGroup.control('deviceConfigurations') as FormArray;
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) => DefaultTabController(
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
                (deviceConfigurationFormGroup) => Stack(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: _TenantAdminDeviceConfigurationBody(formGroup: deviceConfigurationFormGroup as FormGroup),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: FilledButton.tonalIcon(
                          icon: const Icon(Icons.delete),
                          label: const Text('Delete device configuration'),
                          onPressed: () => setState(() => state.deviceConfigurationDelete(deviceConfigurationFormGroup)),
                        ),
                      ),
                    ),
                  ],
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
                            onPressed: () {
                              Actions.handler<SaveIntent>(context, SaveIntent());
                              final deviceConfigurationSettings = public.DeviceConfigurationSettings(id: "91381fc9-ca88-4d48-a9d8-9a876633dc2a", name: "LapM");
                              deviceConfigurationSettings.deviceIntegrations.add(
                                public.DeviceIntegration(deviceIntegrationLapMaster: public.DeviceIntegrationLapMaster(serialPortName: "COM11", lanes: 8)),
                              );
                              final deviceSettings = public.DeviceSettings();
                              deviceSettings.deviceConfigurationSettings.add(deviceConfigurationSettings);
                              state.deviceRequestStreamController.add(
                                public.DeviceRequest(
                                  id: state.widget.id,
                                  correlationId: Uuid().v4(),
                                  deviceSettingsUpsertRequest: public.DeviceSettingsUpsertRequest(deviceSettings: deviceSettings),
                                ),
                              );
                            },
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
                          onPressed: () {
                            //state.tabBarAdded = true;
                            // state.trackConfigurationAddFormGroup(state.trackConfigurationInitialize, true);
                            // setState(() {});

                            //DefaultTabController.of(context).animateTo(1);
                            setState(() => state.deviceConfigurationAddFormGroup(crud.DeviceConfigurationRead(), true));
                          },
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
  }
}

class _TenantAdminDeviceDetailBodyMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_TenantAdminDeviceDetailState>()!;
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
    final state = context.findAncestorStateOfType<_TenantAdminDeviceDetailState>()!;
    return ReactiveForm(
      formGroup: formGroup,
      child: Column(
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
        ],
      ),
    );
  }
}
