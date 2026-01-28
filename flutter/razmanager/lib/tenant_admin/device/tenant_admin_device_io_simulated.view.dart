import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart' as grpc;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart';
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../app_model.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/common.pb.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/device.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/internal/silo/user_services/device_configuration.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/public/device.v1.pb.dart';
import '../../protobuf/razmanager/protobuf/public/device_configuration_input.v1.pb.dart';
import '../../protobuf/razmanager/protobuf/public/device_configuration_input_type_id.v1.pbenum.dart';
import '../../protobuf/razmanager/protobuf/public/device_configuration_output.v1.pb.dart';
import '../../utilities/exception_message.dart';
import '../../utilities/grpc_client.dart';
import '../../utilities/view_master_detail_base.dart';
import '../../utilities/view_master_detail_single_base.dart';
import 'tenant_admin_device_configuration_input_type.dart';
import 'tenant_admin_device_configuration_output_type.dart';

class TenantAdminDeviceIoSimulatedView extends ViewMasterDetailBase {
  const TenantAdminDeviceIoSimulatedView({super.key, required super.id});

  @override
  State createState() => _TenantAdminDeviceIoSimulatedState();
}

class _TenantAdminDeviceIoSimulatedState
    extends ViewMasterDetailSingleStateBase<DeviceRead>
    with GrpcClient, ExceptionMessage, TickerProviderStateMixin {
  _TenantAdminDeviceIoSimulatedState()
      : super(
            header: 'Device - Input/Output (Simulated)',
            child: _TenantAdminDeviceIoSimulatedViewBody(),
            bottomNavigationBar: _TenantAdminDeviceIoSimulatedNavigationBar());

  late DeviceConfigurationRead deviceConfigurationProto;
  late List<DeviceConfigurationInputState> deviceConfigurationInputStates;
  late List<DeviceConfigurationOutputState> deviceConfigurationOutputStates;
  grpc.ClientChannel? clientChannel;
  StreamSubscription<DeviceConfigurationInputs>?
      deviceConfigurationInputsStreamSubscription;
  final deviceConfigurationInputStreamController =
      StreamController<DeviceConfigurationInput>();
  StreamSubscription<DeviceConfigurationOutputs>?
      deviceConfigurationOutputsSubscription;
  final deviceConfigurationOutputStreamController =
      StreamController<DeviceConfigurationOutput>();

  bool? simulationStarted;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();

    //try {
    clientChannel = createClientChannel();
    // } on Exception catch (exception) {
    //}
  }

  @override
  void dispose() {
    for (var deviceConfigurationInputState in deviceConfigurationInputStates) {
      deviceConfigurationInputState.animationController.dispose();
    }
    for (var deviceConfigurationOutputState
        in deviceConfigurationOutputStates) {
      deviceConfigurationOutputState.animationController.dispose();
    }

    if (deviceConfigurationInputsStreamSubscription != null) {
      Future.microtask(deviceConfigurationInputsStreamSubscription!.cancel);
    }
    if (deviceConfigurationOutputsSubscription != null) {
      Future.microtask(deviceConfigurationOutputsSubscription!.cancel);
    }

    if (clientChannel != null) {
      Future.microtask(clientChannel!.shutdown);
    }

    super.dispose();
  }

  DeviceServiceClient client() {
    return DeviceServiceClient(clientChannel!, options: callOptionsFromContext(context));
  }

  DeviceConfigurationServiceClient deviceConfigurationServiceClient() {
    // print("backoffStrategy=${clientChannel!.options.backoffStrategy}");
    // print("connectTimeout=${clientChannel!.options.connectTimeout}");
    // print("connectionTimeout=${clientChannel!.options.connectionTimeout}");
    // print("idleTimeout=${clientChannel!.options.idleTimeout}");
    // print("keepAlive=${clientChannel!.options.keepAlive}");
    // print("keepAlive.permitWithoutCalls=${clientChannel!.options.keepAlive.permitWithoutCalls}");
    // print("keepAlive.pingInterval=${clientChannel!.options.keepAlive.pingInterval}");
    // print("keepAlive.shouldSendPings=${clientChannel!.options.keepAlive.shouldSendPings}");
    // print("keepAlive.timeout=${clientChannel!.options.keepAlive.timeout}");
    // print("userAgent=${clientChannel!.options.userAgent}");

    // final co = callOptions(context);
    // print(co.timeout);

    return DeviceConfigurationServiceClient(clientChannel!,
        options: callOptionsFromContext(context));
  }

  @override
  Future<DeviceRead> read(id) async {
    final response = await client().read(IdRequest(id: id));

    deviceConfigurationProto = response.entity.deviceConfigurations.first;

    deviceConfigurationInputStates = deviceConfigurationProto
        .deviceConfigurationInputs
        .asMap()
        .entries
        .map((x) => DeviceConfigurationInputState(
            key: x.key, deviceConfigurationInputProto: x.value, vsync: this))
        .toList();

    deviceConfigurationOutputStates = deviceConfigurationProto
        .deviceConfigurationOutputs
        .asMap()
        .entries
        .map((x) => DeviceConfigurationOutputState(
            key: x.key, deviceConfigurationOutputProto: x.value, vsync: this))
        .toList();

    deviceConfigurationSubscribe();

    final deviceConfigurationSimulationGetResponse =
        await deviceConfigurationServiceClient()
            .deviceConfigurationSimulationGet(
                StringValue(value: deviceConfigurationProto.id));
    simulationStarted = deviceConfigurationSimulationGetResponse.value;

    return response.entity;
  }

  Future<void> deviceConfigurationSubscribe() async {
    //print("deviceConfigurationSubscribe...");

    if (deviceConfigurationInputsStreamSubscription != null) {
      await deviceConfigurationInputsStreamSubscription!.cancel();
    }
    deviceConfigurationInputsStreamSubscription =
        deviceConfigurationServiceClient()
            .deviceConfigurationInputsSubscribe(
                StringValue(value: deviceConfigurationProto.id))
            .listen(
                (data) {
                  for (var item in data.items) {
                    // print(message.deviceConfigurationInput.correlationId);
                    // print(message.deviceConfigurationInput.deviceConfigurationInputTypeId.name);

                    final deviceConfigurationInputState =
                        deviceConfigurationInputStates
                            .where((x) =>
                                x.deviceConfigurationInputProto
                                        .deviceConfigurationInputTypeId ==
                                    item.deviceConfigurationInputTypeId &&
                                (!x.deviceConfigurationInputProto
                                            .deviceConfigurationInputId
                                            .hasValue() &&
                                        !item
                                            .deviceConfigurationInputId
                                            .hasValue() ||
                                    x.deviceConfigurationInputProto
                                            .deviceConfigurationInputId
                                            .hasValue() &&
                                        item.deviceConfigurationInputId
                                            .hasValue() &&
                                        x
                                                .deviceConfigurationInputProto
                                                .deviceConfigurationInputId
                                                .value ==
                                            item.deviceConfigurationInputId
                                                .value))
                            .singleOrNull;
                    if (deviceConfigurationInputState != null) {
                      deviceConfigurationInputState.animationController.reset();
                      deviceConfigurationInputState.animationController.value =
                          1;
                      deviceConfigurationInputState.animationController
                          .reverse();
                      deviceConfigurationInputState.roundtripMs = null;
                      if (deviceConfigurationInputState
                              .deviceConfigurationInput !=
                          null) {
                        if (deviceConfigurationInputState
                                .deviceConfigurationInput!.correlationId
                                .hasValue() &&
                            item.correlationId.hasValue() &&
                            deviceConfigurationInputState
                                    .deviceConfigurationInput!
                                    .correlationId
                                    .value ==
                                item.correlationId.value &&
                            deviceConfigurationInputState.sentAt != null) {
                          deviceConfigurationInputState.roundtripMs =
                              (DateTime.now().millisecondsSinceEpoch -
                                  deviceConfigurationInputState
                                      .sentAt!.millisecondsSinceEpoch);
                        }
                        deviceConfigurationInputState.deviceConfigurationInput =
                            item;
                      }
                      deviceConfigurationInputStreamController.add(item);
                    }
                  }
                  ;
                },
                onDone: () => debugPrint('Done...'),
                onError: (exception) async {
                  debugPrint(exception.runtimeType.toString());
                  //print(exceptionMessage(exception));
                  debugPrint('waiting...');
                  await Future.delayed(const Duration(seconds: 30));
                  debugPrint('restarting...');
                  deviceConfigurationSubscribe();
                });

    if (deviceConfigurationOutputsSubscription != null) {
      await deviceConfigurationOutputsSubscription!.cancel();
    }
    deviceConfigurationOutputsSubscription = deviceConfigurationServiceClient()
        .deviceConfigurationOutputsSubscribe(
            StringValue(value: deviceConfigurationProto.id))
        .listen(
            (data) {
              for (var item in data.items) {
                // print(message.deviceConfigurationInput.correlationId);
                // print(message.deviceConfigurationInput.deviceConfigurationInputTypeId.name);

                final deviceConfigurationOutputState =
                    deviceConfigurationOutputStates
                        .where((x) =>
                            x.deviceConfigurationOutputProto
                                    .deviceConfigurationOutputTypeId ==
                                item.deviceConfigurationOutputTypeId &&
                            (!x.deviceConfigurationOutputProto
                                        .deviceConfigurationOutputId
                                        .hasValue() &&
                                    !item.deviceConfigurationOutputId
                                        .hasValue() ||
                                x.deviceConfigurationOutputProto
                                        .deviceConfigurationOutputId
                                        .hasValue() &&
                                    item.deviceConfigurationOutputId
                                        .hasValue() &&
                                    x
                                            .deviceConfigurationOutputProto
                                            .deviceConfigurationOutputId
                                            .value ==
                                        item.deviceConfigurationOutputId.value))
                        .singleOrNull;

                if (deviceConfigurationOutputState != null) {
                  deviceConfigurationOutputState.animationController.reset();
                  deviceConfigurationOutputState.animationController.value = 1;
                  deviceConfigurationOutputState.animationController.reverse();
                  deviceConfigurationOutputState.roundtripMs = null;

                  if (item.correlationId.hasValue()) {
                    final deviceConfigurationInputState =
                        deviceConfigurationInputStates
                            .where((x) =>
                                x.deviceConfigurationInput != null &&
                                x.deviceConfigurationInput!.correlationId
                                    .hasValue() &&
                                x.deviceConfigurationInput!.correlationId
                                        .value ==
                                    item.correlationId.value &&
                                x.sentAt != null)
                            .singleOrNull;

                    if (deviceConfigurationInputState != null) {
                      deviceConfigurationOutputState.roundtripMs =
                          (DateTime.now().millisecondsSinceEpoch -
                              deviceConfigurationInputState
                                  .sentAt!.millisecondsSinceEpoch);
                    }
                  }
                  deviceConfigurationOutputState.deviceConfigurationOutput =
                      item;
                }

                deviceConfigurationOutputStreamController.add(item);
              }
            },
            onDone: () => print('Done...'),
            onError: (exception) async {
              debugPrint(exception.runtimeType.toString());
              //print(exceptionMessage(exception));
              debugPrint('waiting...');
              await Future.delayed(const Duration(seconds: 30));
              debugPrint('restarting...');
            });
  }

  Future<void> deviceConfigurationDeviceConfigurationInput(
      DeviceConfigurationDeviceConfigurationInput
          deviceConfigurationDeviceConfigurationInput,
      BuildContext context) async {
    final model = context.read<AppModel>();
    model.setBusy(value: true, notify: true);
    try {
      deviceConfigurationInputStates
          .where((x) =>
              x.deviceConfigurationInputProto.deviceConfigurationInputTypeId ==
                  deviceConfigurationDeviceConfigurationInput
                      .deviceConfigurationInput.deviceConfigurationInputTypeId &&
              (!x.deviceConfigurationInputProto.deviceConfigurationInputId
                          .hasValue() &&
                      !deviceConfigurationDeviceConfigurationInput
                          .deviceConfigurationInput.deviceConfigurationInputId
                          .hasValue() ||
                  x.deviceConfigurationInputProto.deviceConfigurationInputId
                          .hasValue() &&
                      deviceConfigurationDeviceConfigurationInput
                          .deviceConfigurationInput.deviceConfigurationInputId
                          .hasValue() &&
                      x.deviceConfigurationInputProto.deviceConfigurationInputId
                              .value ==
                          deviceConfigurationDeviceConfigurationInput
                              .deviceConfigurationInput
                              .deviceConfigurationInputId
                              .value))
          .forEach((x) {
        x.deviceConfigurationInput = deviceConfigurationDeviceConfigurationInput
            .deviceConfigurationInput;
        x.sentAt = DateTime.now();
      });

      await deviceConfigurationServiceClient().deviceConfigurationInput(
          deviceConfigurationDeviceConfigurationInput);
    } on Exception catch (exception) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(exceptionMessage(exception)),
          duration: const Duration(seconds: 10)));
    } finally {
      model.setBusy(value: false, notify: true);
    }
  }

  Future<void> simulationSet(bool value) async {
    final model = context.read<AppModel>();
    model.setBusy(value: true, notify: true);
    try {
      await deviceConfigurationServiceClient().deviceConfigurationSimulationSet(
          DeviceConfigurationSetSimulationSetRequest(
              id: deviceConfigurationProto!.id, value: value));
      simulationStarted = value;
    } on Exception catch (exception) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(exceptionMessage(exception)),
          duration: const Duration(seconds: 10)));
    } finally {
      model.setBusy(value: false, notify: true);
    }
  }
}

class _TenantAdminDeviceIoSimulatedViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state =
        context.findAncestorStateOfType<_TenantAdminDeviceIoSimulatedState>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
            readOnly: true,
            controller: TextEditingController(text: state.readProto.name.value),
            decoration: const InputDecoration(
                labelText: 'Name', border: InputBorder.none)),
        const _TenantAdminDeviceIoSimulatedViewDeviceConfigurationInput(),
        const _TenantAdminDeviceIoSimulatedViewDeviceConfigurationOutput()
      ],
    );
  }
}

class _TenantAdminDeviceIoSimulatedViewDeviceConfigurationInput
    extends StatelessWidget {
  const _TenantAdminDeviceIoSimulatedViewDeviceConfigurationInput();

  @override
  Widget build(BuildContext context) {
    final state =
        context.findAncestorStateOfType<_TenantAdminDeviceIoSimulatedState>()!;
    return StreamBuilder<DeviceConfigurationInput>(
        stream: state.deviceConfigurationInputStreamController.stream,
        initialData: null,
        builder: (context, snapshot) {
          debugPrint(
              'Data: ${snapshot.data?.deviceConfigurationInputTypeId.name} deviceConfigurationInputId: ${snapshot.data?.deviceConfigurationInputId} boolValue:${snapshot.data?.boolValue} intValue:${snapshot.data?.intValue}');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text('Inputs'),
              ...state.deviceConfigurationInputStates
                  .map((deviceConfigurationInputState) => Row(
                        key: ValueKey(deviceConfigurationInputState.key),
                        children: [
                          SizedBox(
                              width: 250,
                              child: deviceConfigurationInputText(
                                  deviceConfigurationInputState)),
                          SizedBox(
                            width: 250,
                            child: deviceConfigurationInputWidget(
                                context: context,
                                deviceConfigurationInputState:
                                    deviceConfigurationInputState),
                          ),
                          const SizedBox(width: 16),
                          FadeTransition(
                            opacity: CurvedAnimation(
                                parent: deviceConfigurationInputState
                                    .animationController,
                                curve: Curves.easeOutExpo,
                                reverseCurve: Curves.easeInOut),
                            child: const Icon(Icons.flash_on),
                          ),
                          const SizedBox(width: 16),
                          SizedBox(
                              width: 100,
                              child: Text(deviceConfigurationInputState.roundtripMs != null ? "${deviceConfigurationInputState.roundtripMs}ms": "")),
                        ],
                      ))
            ],
          );
        });
  }

  Widget deviceConfigurationInputWidget(
      {required BuildContext context,
      required DeviceConfigurationInputState deviceConfigurationInputState}) {
    final state =
        context.findAncestorStateOfType<_TenantAdminDeviceIoSimulatedState>()!;

    switch (deviceConfigurationInputState
        .deviceConfigurationInputProto.deviceConfigurationInputTypeId) {
      case DeviceConfigurationInputTypeId
            .DEVICE_CONFIGURATION_INPUT_TYPE_ID_START_FINISH_INDICATOR:
      case DeviceConfigurationInputTypeId
            .DEVICE_CONFIGURATION_INPUT_TYPE_ID_SECTOR_1_FINISH_INDICATOR:
      case DeviceConfigurationInputTypeId
            .DEVICE_CONFIGURATION_INPUT_TYPE_ID_SECTOR_2_FINISH_INDICATOR:
      case DeviceConfigurationInputTypeId
            .DEVICE_CONFIGURATION_INPUT_TYPE_ID_SPEED_TRAP_START_INDICATOR:
      case DeviceConfigurationInputTypeId
            .DEVICE_CONFIGURATION_INPUT_TYPE_ID_SPEED_TRAP_FINISH_INDICATOR:
      case DeviceConfigurationInputTypeId
            .DEVICE_CONFIGURATION_INPUT_TYPE_ID_EXTRA_INDICATOR:
      case DeviceConfigurationInputTypeId
            .DEVICE_CONFIGURATION_INPUT_TYPE_ID_PITLANE_ENTRY:
      case DeviceConfigurationInputTypeId
            .DEVICE_CONFIGURATION_INPUT_TYPE_ID_PITLANE_EXIT:
      case DeviceConfigurationInputTypeId
            .DEVICE_CONFIGURATION_INPUT_TYPE_ID_PITSTOP_ENTRY:
      case DeviceConfigurationInputTypeId
            .DEVICE_CONFIGURATION_INPUT_TYPE_ID_PITSTOP_EXIT:
      case DeviceConfigurationInputTypeId
            .DEVICE_CONFIGURATION_INPUT_TYPE_ID_YELLOW:
      case DeviceConfigurationInputTypeId
            .DEVICE_CONFIGURATION_INPUT_TYPE_ID_RED:
      case DeviceConfigurationInputTypeId
            .DEVICE_CONFIGURATION_INPUT_TYPE_ID_POWER_OVERLOAD:
        return TextButton(
            child: Text('Test'),
            onPressed: () {
              deviceConfigurationInputState.deviceConfigurationInput =
                  DeviceConfigurationInput(
                      correlationId: StringValue(value: const Uuid().v4()),
                      timestamp: Timestamp.fromDateTime(DateTime.now().toUtc()),
                      deviceConfigurationInputTypeId:
                          deviceConfigurationInputState
                              .deviceConfigurationInputProto
                              .deviceConfigurationInputTypeId,
                      deviceConfigurationInputId: deviceConfigurationInputState
                          .deviceConfigurationInputProto
                          .deviceConfigurationInputId);

              state.deviceConfigurationDeviceConfigurationInput(
                  DeviceConfigurationDeviceConfigurationInput(
                    id: state.deviceConfigurationProto.id,
                    deviceConfigurationInput:
                        deviceConfigurationInputState.deviceConfigurationInput,
                  ),
                  context);
            });
      case DeviceConfigurationInputTypeId
            .DEVICE_CONFIGURATION_INPUT_TYPE_ID_CONTROLLER_ON:
      case DeviceConfigurationInputTypeId
            .DEVICE_CONFIGURATION_INPUT_TYPE_ID_CONTROLLER_BATTERY_OK:
      case DeviceConfigurationInputTypeId
            .DEVICE_CONFIGURATION_INPUT_TYPE_ID_BRAKE:
      case DeviceConfigurationInputTypeId
            .DEVICE_CONFIGURATION_INPUT_TYPE_ID_LANE_CHANGE:
      case DeviceConfigurationInputTypeId
            .DEVICE_CONFIGURATION_INPUT_TYPE_ID_LANE_CHANGE_UP:
      case DeviceConfigurationInputTypeId
            .DEVICE_CONFIGURATION_INPUT_TYPE_ID_LANE_CHANGE_DOWN:
      case DeviceConfigurationInputTypeId
            .DEVICE_CONFIGURATION_INPUT_TYPE_ID_LANE_CHANGE_DOUBLE_TAPPED:
      case DeviceConfigurationInputTypeId
            .DEVICE_CONFIGURATION_INPUT_TYPE_ID_CAR_ON_TRACK:
        return Switch(
          value: deviceConfigurationInputState.deviceConfigurationInput?.boolValue ?? false,
          onChanged: (bool? value) {
            if (value != null) {
              deviceConfigurationInputState.deviceConfigurationInput =
                  DeviceConfigurationInput(
                      correlationId: StringValue(value: const Uuid().v4()),
                      timestamp: Timestamp.fromDateTime(DateTime.now().toUtc()),
                      deviceConfigurationInputTypeId:
                          deviceConfigurationInputState
                              .deviceConfigurationInputProto
                              .deviceConfigurationInputTypeId,
                      deviceConfigurationInputId: deviceConfigurationInputState
                          .deviceConfigurationInputProto
                          .deviceConfigurationInputId,
                      boolValue: value);

              state.deviceConfigurationDeviceConfigurationInput(
                  DeviceConfigurationDeviceConfigurationInput(
                    id: state.deviceConfigurationProto.id,
                    deviceConfigurationInput:
                        deviceConfigurationInputState.deviceConfigurationInput,
                  ),
                  context);
            }
          },
        );
      case DeviceConfigurationInputTypeId
            .DEVICE_CONFIGURATION_INPUT_TYPE_ID_ENERGY:
        return Slider(
          max: 255,
          divisions: 255,
          label: deviceConfigurationInputState.deviceConfigurationInput?.intValue.toString() ?? "",
          value: deviceConfigurationInputState.deviceConfigurationInput?.intValue.toDouble() ?? 0,
          onChanged: (double value) {
              deviceConfigurationInputState.deviceConfigurationInput =
                  DeviceConfigurationInput(
                      correlationId: StringValue(value: const Uuid().v4()),
                      timestamp: Timestamp.fromDateTime(DateTime.now().toUtc()),
                      deviceConfigurationInputTypeId:
                          deviceConfigurationInputState
                              .deviceConfigurationInputProto
                              .deviceConfigurationInputTypeId,
                      deviceConfigurationInputId: deviceConfigurationInputState
                          .deviceConfigurationInputProto
                          .deviceConfigurationInputId,
                      intValue: value.toInt());

              state.deviceConfigurationDeviceConfigurationInput(
                  DeviceConfigurationDeviceConfigurationInput(
                    id: state.deviceConfigurationProto.id,
                    deviceConfigurationInput:
                        deviceConfigurationInputState.deviceConfigurationInput,
                  ),
                  context);
            }
        );
      default:
        throw Exception('Missing DeviceConfigurationInputTypeId: {item}');
    }
  }

  Text deviceConfigurationInputText(
      DeviceConfigurationInputState deviceConfigurationInputState) {
    return Text(
        "${DeviceConfigurationInputType.fromDeviceConfigurationInputTypeId(deviceConfigurationInputState.deviceConfigurationInputProto.deviceConfigurationInputTypeId).name} ${deviceConfigurationInputState.deviceConfigurationInputProto.deviceConfigurationInputId.hasValue() ? deviceConfigurationInputState.deviceConfigurationInputProto.deviceConfigurationInputId.value : ""}");
  }
}

class _TenantAdminDeviceIoSimulatedViewDeviceConfigurationOutput
    extends StatelessWidget {
  const _TenantAdminDeviceIoSimulatedViewDeviceConfigurationOutput();

  @override
  Widget build(BuildContext context) {
    final state =
        context.findAncestorStateOfType<_TenantAdminDeviceIoSimulatedState>()!;
    return StreamBuilder<DeviceConfigurationOutput>(
        stream: state.deviceConfigurationOutputStreamController.stream,
        initialData: null,
        builder: (context, snapshot) {
          print(
              'Data: ${snapshot.data?.deviceConfigurationOutputTypeId.name} ${snapshot.data?.deviceConfigurationOutputId}');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text('Outputs'),
              ...state.deviceConfigurationOutputStates
                  .map((deviceConfigurationOutputState) => Row(
                        key: ValueKey(deviceConfigurationOutputState.key),
                        children: [
                          SizedBox(
                              width: 250,
                              child: Text(
                                  "${DeviceConfigurationOutputType.fromDeviceConfigurationOutputTypeId(deviceConfigurationOutputState.deviceConfigurationOutputProto.deviceConfigurationOutputTypeId).name} ${deviceConfigurationOutputState.deviceConfigurationOutputProto.deviceConfigurationOutputId.hasValue() ? deviceConfigurationOutputState.deviceConfigurationOutputProto.deviceConfigurationOutputId.value : ""}")),
                          const SizedBox(width: 250),
                          const SizedBox(width: 16),
                          FadeTransition(
                            opacity: CurvedAnimation(
                                parent: deviceConfigurationOutputState
                                    .animationController,
                                curve: Curves.easeOutExpo,
                                reverseCurve: Curves.easeInOut),
                            child: const Icon(Icons.flash_on),
                          ),
                          const SizedBox(width: 16),
                          SizedBox(
                              width: 100,
                              child: Text(deviceConfigurationOutputState.roundtripMs != null ? "${deviceConfigurationOutputState.roundtripMs}ms": "")),
                        ],
                      ))
            ],
          );
        });
  }
}

class DeviceConfigurationInputState {
  DeviceConfigurationInputState(
      {required this.key,
      required this.deviceConfigurationInputProto,
      required TickerProvider vsync}) {
    animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: vsync,
    );
  }
  final int key;
  final DeviceDeviceConfigurationInput deviceConfigurationInputProto;
  DeviceConfigurationInput? deviceConfigurationInput;
  DateTime? sentAt;
  int? roundtripMs;
  late AnimationController animationController;
}

class DeviceConfigurationOutputState {
  DeviceConfigurationOutputState(
      {required this.key,
      required this.deviceConfigurationOutputProto,
      required TickerProvider vsync}) {
    animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: vsync,
    );
  }
  final int key;
  final DeviceDeviceConfigurationOutput deviceConfigurationOutputProto;
  DeviceConfigurationOutput? deviceConfigurationOutput;
  int? roundtripMs;
  late AnimationController animationController;
}

class _TenantAdminDeviceIoSimulatedNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state =
        context.findAncestorStateOfType<_TenantAdminDeviceIoSimulatedState>()!;
    return BottomAppBar(
        child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) => Row(
                  children: [
                    FilledButton.tonalIcon(
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Start simulation'),
                      onPressed: state.simulationStarted == null ||
                              !state.simulationStarted!
                          ? () async {
                              await state.simulationSet(true);
                              setState(() {});
                            }
                          : null,
                    ),
                    const SizedBox(width: 16),
                    FilledButton.tonalIcon(
                      icon: const Icon(Icons.stop),
                      label: const Text('Stop simulation'),
                      onPressed: state.simulationStarted != null &&
                              state.simulationStarted!
                          ? () async {
                              await state.simulationSet(false);
                              setState(() {});
                            }
                          : null,
                    ),
                  ],
                )));
  }
}
