// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/device.proto.

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
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart' as $0;

import 'common.pb.dart' as $2;
import 'device.pb.dart' as $1;

export 'device.pb.dart';

@$pb.GrpcServiceName(
    'razmanager.protobuf.internal.repository.crud_services.device.DeviceService')
class DeviceServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  DeviceServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$1.DeviceRead> initialize(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$initialize, request, options: options);
  }

  $grpc.ResponseFuture<$1.DeviceReadResponse> read(
    $2.IdRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$read, request, options: options);
  }

  $grpc.ResponseFuture<$2.CreateResponse> create(
    $1.DeviceCreateUpdate request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$create, request, options: options);
  }

  $grpc.ResponseFuture<$2.UpdateResponse> update(
    $1.DeviceUpdateRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$update, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> delete(
    $2.DeleteRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$delete, request, options: options);
  }

  $grpc.ResponseFuture<$1.DeviceListResponse> list(
    $2.ListRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$list, request, options: options);
  }

  $grpc.ResponseFuture<$1.DeviceCommissioningCertificateResponse>
      certificateRequest(
    $1.DeviceCommissioningCertificateRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$certificateRequest, request, options: options);
  }

  // method descriptors

  static final _$initialize = $grpc.ClientMethod<$0.Empty, $1.DeviceRead>(
      '/razmanager.protobuf.internal.repository.crud_services.device.DeviceService/Initialize',
      ($0.Empty value) => value.writeToBuffer(),
      $1.DeviceRead.fromBuffer);
  static final _$read = $grpc.ClientMethod<$2.IdRequest, $1.DeviceReadResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.device.DeviceService/Read',
      ($2.IdRequest value) => value.writeToBuffer(),
      $1.DeviceReadResponse.fromBuffer);
  static final _$create = $grpc.ClientMethod<$1.DeviceCreateUpdate,
          $2.CreateResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.device.DeviceService/Create',
      ($1.DeviceCreateUpdate value) => value.writeToBuffer(),
      $2.CreateResponse.fromBuffer);
  static final _$update = $grpc.ClientMethod<$1.DeviceUpdateRequest,
          $2.UpdateResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.device.DeviceService/Update',
      ($1.DeviceUpdateRequest value) => value.writeToBuffer(),
      $2.UpdateResponse.fromBuffer);
  static final _$delete = $grpc.ClientMethod<$2.DeleteRequest, $0.Empty>(
      '/razmanager.protobuf.internal.repository.crud_services.device.DeviceService/Delete',
      ($2.DeleteRequest value) => value.writeToBuffer(),
      $0.Empty.fromBuffer);
  static final _$list = $grpc.ClientMethod<$2.ListRequest,
          $1.DeviceListResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.device.DeviceService/List',
      ($2.ListRequest value) => value.writeToBuffer(),
      $1.DeviceListResponse.fromBuffer);
  static final _$certificateRequest = $grpc.ClientMethod<
          $1.DeviceCommissioningCertificateRequest,
          $1.DeviceCommissioningCertificateResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.device.DeviceService/CertificateRequest',
      ($1.DeviceCommissioningCertificateRequest value) => value.writeToBuffer(),
      $1.DeviceCommissioningCertificateResponse.fromBuffer);
}

@$pb.GrpcServiceName(
    'razmanager.protobuf.internal.repository.crud_services.device.DeviceService')
abstract class DeviceServiceBase extends $grpc.Service {
  $core.String get $name =>
      'razmanager.protobuf.internal.repository.crud_services.device.DeviceService';

  DeviceServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.DeviceRead>(
        'Initialize',
        initialize_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.DeviceRead value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.IdRequest, $1.DeviceReadResponse>(
        'Read',
        read_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.IdRequest.fromBuffer(value),
        ($1.DeviceReadResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeviceCreateUpdate, $2.CreateResponse>(
        'Create',
        create_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.DeviceCreateUpdate.fromBuffer(value),
        ($2.CreateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeviceUpdateRequest, $2.UpdateResponse>(
        'Update',
        update_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.DeviceUpdateRequest.fromBuffer(value),
        ($2.UpdateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.DeleteRequest, $0.Empty>(
        'Delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.DeleteRequest.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.ListRequest, $1.DeviceListResponse>(
        'List',
        list_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.ListRequest.fromBuffer(value),
        ($1.DeviceListResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeviceCommissioningCertificateRequest,
            $1.DeviceCommissioningCertificateResponse>(
        'CertificateRequest',
        certificateRequest_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.DeviceCommissioningCertificateRequest.fromBuffer(value),
        ($1.DeviceCommissioningCertificateResponse value) =>
            value.writeToBuffer()));
  }

  $async.Future<$1.DeviceRead> initialize_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return initialize($call, await $request);
  }

  $async.Future<$1.DeviceRead> initialize(
      $grpc.ServiceCall call, $0.Empty request);

  $async.Future<$1.DeviceReadResponse> read_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.IdRequest> $request) async {
    return read($call, await $request);
  }

  $async.Future<$1.DeviceReadResponse> read(
      $grpc.ServiceCall call, $2.IdRequest request);

  $async.Future<$2.CreateResponse> create_Pre($grpc.ServiceCall $call,
      $async.Future<$1.DeviceCreateUpdate> $request) async {
    return create($call, await $request);
  }

  $async.Future<$2.CreateResponse> create(
      $grpc.ServiceCall call, $1.DeviceCreateUpdate request);

  $async.Future<$2.UpdateResponse> update_Pre($grpc.ServiceCall $call,
      $async.Future<$1.DeviceUpdateRequest> $request) async {
    return update($call, await $request);
  }

  $async.Future<$2.UpdateResponse> update(
      $grpc.ServiceCall call, $1.DeviceUpdateRequest request);

  $async.Future<$0.Empty> delete_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.DeleteRequest> $request) async {
    return delete($call, await $request);
  }

  $async.Future<$0.Empty> delete(
      $grpc.ServiceCall call, $2.DeleteRequest request);

  $async.Future<$1.DeviceListResponse> list_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.ListRequest> $request) async {
    return list($call, await $request);
  }

  $async.Future<$1.DeviceListResponse> list(
      $grpc.ServiceCall call, $2.ListRequest request);

  $async.Future<$1.DeviceCommissioningCertificateResponse>
      certificateRequest_Pre(
          $grpc.ServiceCall $call,
          $async.Future<$1.DeviceCommissioningCertificateRequest>
              $request) async {
    return certificateRequest($call, await $request);
  }

  $async.Future<$1.DeviceCommissioningCertificateResponse> certificateRequest(
      $grpc.ServiceCall call, $1.DeviceCommissioningCertificateRequest request);
}
