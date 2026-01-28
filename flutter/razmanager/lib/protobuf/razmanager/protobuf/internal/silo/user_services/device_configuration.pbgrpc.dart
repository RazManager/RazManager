// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/silo/user_services/device_configuration.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart' as $1;
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart'
    as $2;

import '../../../public/device_configuration_input.v1.pb.dart' as $3;
import '../../../public/device_configuration_output.v1.pb.dart' as $4;
import 'device_configuration.pb.dart' as $0;

export 'device_configuration.pb.dart';

@$pb.GrpcServiceName(
    'razmanager.protobuf.internal.silo.user_services.device_configuration.DeviceConfigurationService')
class DeviceConfigurationServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  DeviceConfigurationServiceClient(super.channel,
      {super.options, super.interceptors});

  $grpc.ResponseFuture<$1.Empty> deviceConfigurationInput(
    $0.DeviceConfigurationDeviceConfigurationInput request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deviceConfigurationInput, request,
        options: options);
  }

  $grpc.ResponseStream<$3.DeviceConfigurationInputs>
      deviceConfigurationInputsSubscribe(
    $2.StringValue request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(_$deviceConfigurationInputsSubscribe,
        $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$4.DeviceConfigurationOutputs>
      deviceConfigurationOutputsSubscribe(
    $2.StringValue request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(_$deviceConfigurationOutputsSubscribe,
        $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$2.BoolValue> deviceConfigurationSimulationGet(
    $2.StringValue request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deviceConfigurationSimulationGet, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.Empty> deviceConfigurationSimulationSet(
    $0.DeviceConfigurationSetSimulationSetRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deviceConfigurationSimulationSet, request,
        options: options);
  }

  // method descriptors

  static final _$deviceConfigurationInput = $grpc.ClientMethod<
          $0.DeviceConfigurationDeviceConfigurationInput, $1.Empty>(
      '/razmanager.protobuf.internal.silo.user_services.device_configuration.DeviceConfigurationService/DeviceConfigurationInput',
      ($0.DeviceConfigurationDeviceConfigurationInput value) =>
          value.writeToBuffer(),
      $1.Empty.fromBuffer);
  static final _$deviceConfigurationInputsSubscribe = $grpc.ClientMethod<
          $2.StringValue, $3.DeviceConfigurationInputs>(
      '/razmanager.protobuf.internal.silo.user_services.device_configuration.DeviceConfigurationService/DeviceConfigurationInputsSubscribe',
      ($2.StringValue value) => value.writeToBuffer(),
      $3.DeviceConfigurationInputs.fromBuffer);
  static final _$deviceConfigurationOutputsSubscribe = $grpc.ClientMethod<
          $2.StringValue, $4.DeviceConfigurationOutputs>(
      '/razmanager.protobuf.internal.silo.user_services.device_configuration.DeviceConfigurationService/DeviceConfigurationOutputsSubscribe',
      ($2.StringValue value) => value.writeToBuffer(),
      $4.DeviceConfigurationOutputs.fromBuffer);
  static final _$deviceConfigurationSimulationGet = $grpc.ClientMethod<
          $2.StringValue, $2.BoolValue>(
      '/razmanager.protobuf.internal.silo.user_services.device_configuration.DeviceConfigurationService/DeviceConfigurationSimulationGet',
      ($2.StringValue value) => value.writeToBuffer(),
      $2.BoolValue.fromBuffer);
  static final _$deviceConfigurationSimulationSet = $grpc.ClientMethod<
          $0.DeviceConfigurationSetSimulationSetRequest, $1.Empty>(
      '/razmanager.protobuf.internal.silo.user_services.device_configuration.DeviceConfigurationService/DeviceConfigurationSimulationSet',
      ($0.DeviceConfigurationSetSimulationSetRequest value) =>
          value.writeToBuffer(),
      $1.Empty.fromBuffer);
}

@$pb.GrpcServiceName(
    'razmanager.protobuf.internal.silo.user_services.device_configuration.DeviceConfigurationService')
abstract class DeviceConfigurationServiceBase extends $grpc.Service {
  $core.String get $name =>
      'razmanager.protobuf.internal.silo.user_services.device_configuration.DeviceConfigurationService';

  DeviceConfigurationServiceBase() {
    $addMethod($grpc.ServiceMethod<
            $0.DeviceConfigurationDeviceConfigurationInput, $1.Empty>(
        'DeviceConfigurationInput',
        deviceConfigurationInput_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeviceConfigurationDeviceConfigurationInput.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$2.StringValue, $3.DeviceConfigurationInputs>(
            'DeviceConfigurationInputsSubscribe',
            deviceConfigurationInputsSubscribe_Pre,
            false,
            true,
            ($core.List<$core.int> value) => $2.StringValue.fromBuffer(value),
            ($3.DeviceConfigurationInputs value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$2.StringValue, $4.DeviceConfigurationOutputs>(
            'DeviceConfigurationOutputsSubscribe',
            deviceConfigurationOutputsSubscribe_Pre,
            false,
            true,
            ($core.List<$core.int> value) => $2.StringValue.fromBuffer(value),
            ($4.DeviceConfigurationOutputs value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.StringValue, $2.BoolValue>(
        'DeviceConfigurationSimulationGet',
        deviceConfigurationSimulationGet_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.StringValue.fromBuffer(value),
        ($2.BoolValue value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<
            $0.DeviceConfigurationSetSimulationSetRequest, $1.Empty>(
        'DeviceConfigurationSimulationSet',
        deviceConfigurationSimulationSet_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeviceConfigurationSetSimulationSetRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$1.Empty> deviceConfigurationInput_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.DeviceConfigurationDeviceConfigurationInput>
          $request) async {
    return deviceConfigurationInput($call, await $request);
  }

  $async.Future<$1.Empty> deviceConfigurationInput($grpc.ServiceCall call,
      $0.DeviceConfigurationDeviceConfigurationInput request);

  $async.Stream<$3.DeviceConfigurationInputs>
      deviceConfigurationInputsSubscribe_Pre($grpc.ServiceCall $call,
          $async.Future<$2.StringValue> $request) async* {
    yield* deviceConfigurationInputsSubscribe($call, await $request);
  }

  $async.Stream<$3.DeviceConfigurationInputs>
      deviceConfigurationInputsSubscribe(
          $grpc.ServiceCall call, $2.StringValue request);

  $async.Stream<$4.DeviceConfigurationOutputs>
      deviceConfigurationOutputsSubscribe_Pre($grpc.ServiceCall $call,
          $async.Future<$2.StringValue> $request) async* {
    yield* deviceConfigurationOutputsSubscribe($call, await $request);
  }

  $async.Stream<$4.DeviceConfigurationOutputs>
      deviceConfigurationOutputsSubscribe(
          $grpc.ServiceCall call, $2.StringValue request);

  $async.Future<$2.BoolValue> deviceConfigurationSimulationGet_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.StringValue> $request) async {
    return deviceConfigurationSimulationGet($call, await $request);
  }

  $async.Future<$2.BoolValue> deviceConfigurationSimulationGet(
      $grpc.ServiceCall call, $2.StringValue request);

  $async.Future<$1.Empty> deviceConfigurationSimulationSet_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.DeviceConfigurationSetSimulationSetRequest>
          $request) async {
    return deviceConfigurationSimulationSet($call, await $request);
  }

  $async.Future<$1.Empty> deviceConfigurationSimulationSet(
      $grpc.ServiceCall call,
      $0.DeviceConfigurationSetSimulationSetRequest request);
}
