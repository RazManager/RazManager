// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/device.service.v1.proto.

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

import 'device.v1.pb.dart' as $0;
import 'device_request_response.v1.pb.dart' as $2;

export 'device.service.v1.pb.dart';

@$pb.GrpcServiceName('razmanager.protobuf.public.v1.DeviceService')
class DeviceServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  DeviceServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$1.Empty> deviceInformation(
    $0.DeviceInformation request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deviceInformation, request, options: options);
  }

  $grpc.ResponseStream<$2.DeviceResponse> deviceRequestResponse(
    $async.Stream<$2.DeviceRequest> request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(_$deviceRequestResponse, request,
        options: options);
  }

  $grpc.ResponseStream<$2.DeviceRequest> deviceResponseRequest(
    $async.Stream<$2.DeviceResponse> request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(_$deviceResponseRequest, request,
        options: options);
  }

  // method descriptors

  static final _$deviceInformation =
      $grpc.ClientMethod<$0.DeviceInformation, $1.Empty>(
          '/razmanager.protobuf.public.v1.DeviceService/DeviceInformation',
          ($0.DeviceInformation value) => value.writeToBuffer(),
          $1.Empty.fromBuffer);
  static final _$deviceRequestResponse =
      $grpc.ClientMethod<$2.DeviceRequest, $2.DeviceResponse>(
          '/razmanager.protobuf.public.v1.DeviceService/DeviceRequestResponse',
          ($2.DeviceRequest value) => value.writeToBuffer(),
          $2.DeviceResponse.fromBuffer);
  static final _$deviceResponseRequest =
      $grpc.ClientMethod<$2.DeviceResponse, $2.DeviceRequest>(
          '/razmanager.protobuf.public.v1.DeviceService/DeviceResponseRequest',
          ($2.DeviceResponse value) => value.writeToBuffer(),
          $2.DeviceRequest.fromBuffer);
}

@$pb.GrpcServiceName('razmanager.protobuf.public.v1.DeviceService')
abstract class DeviceServiceBase extends $grpc.Service {
  $core.String get $name => 'razmanager.protobuf.public.v1.DeviceService';

  DeviceServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.DeviceInformation, $1.Empty>(
        'DeviceInformation',
        deviceInformation_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeviceInformation.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.DeviceRequest, $2.DeviceResponse>(
        'DeviceRequestResponse',
        deviceRequestResponse,
        true,
        true,
        ($core.List<$core.int> value) => $2.DeviceRequest.fromBuffer(value),
        ($2.DeviceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.DeviceResponse, $2.DeviceRequest>(
        'DeviceResponseRequest',
        deviceResponseRequest,
        true,
        true,
        ($core.List<$core.int> value) => $2.DeviceResponse.fromBuffer(value),
        ($2.DeviceRequest value) => value.writeToBuffer()));
  }

  $async.Future<$1.Empty> deviceInformation_Pre($grpc.ServiceCall $call,
      $async.Future<$0.DeviceInformation> $request) async {
    return deviceInformation($call, await $request);
  }

  $async.Future<$1.Empty> deviceInformation(
      $grpc.ServiceCall call, $0.DeviceInformation request);

  $async.Stream<$2.DeviceResponse> deviceRequestResponse(
      $grpc.ServiceCall call, $async.Stream<$2.DeviceRequest> request);

  $async.Stream<$2.DeviceRequest> deviceResponseRequest(
      $grpc.ServiceCall call, $async.Stream<$2.DeviceResponse> request);
}
