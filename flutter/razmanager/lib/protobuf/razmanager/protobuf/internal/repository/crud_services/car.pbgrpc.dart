// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/car.proto.

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

import 'car.pb.dart' as $1;
import 'common.pb.dart' as $2;

export 'car.pb.dart';

@$pb.GrpcServiceName(
    'razmanager.protobuf.internal.repository.crud_services.car.CarService')
class CarServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  CarServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$1.CarRead> initialize(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$initialize, request, options: options);
  }

  $grpc.ResponseFuture<$1.CarReadResponse> read(
    $2.IdRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$read, request, options: options);
  }

  $grpc.ResponseFuture<$2.CreateResponse> create(
    $1.CarCreateUpdate request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$create, request, options: options);
  }

  $grpc.ResponseFuture<$2.UpdateResponse> update(
    $1.CarUpdateRequest request, {
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

  $grpc.ResponseFuture<$1.CarListResponse> list(
    $1.CarListRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$list, request, options: options);
  }

  $grpc.ResponseFuture<$1.CarSelectResponse> select(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$select, request, options: options);
  }

  // method descriptors

  static final _$initialize = $grpc.ClientMethod<$0.Empty, $1.CarRead>(
      '/razmanager.protobuf.internal.repository.crud_services.car.CarService/Initialize',
      ($0.Empty value) => value.writeToBuffer(),
      $1.CarRead.fromBuffer);
  static final _$read = $grpc.ClientMethod<$2.IdRequest, $1.CarReadResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.car.CarService/Read',
      ($2.IdRequest value) => value.writeToBuffer(),
      $1.CarReadResponse.fromBuffer);
  static final _$create = $grpc.ClientMethod<$1.CarCreateUpdate,
          $2.CreateResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.car.CarService/Create',
      ($1.CarCreateUpdate value) => value.writeToBuffer(),
      $2.CreateResponse.fromBuffer);
  static final _$update = $grpc.ClientMethod<$1.CarUpdateRequest,
          $2.UpdateResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.car.CarService/Update',
      ($1.CarUpdateRequest value) => value.writeToBuffer(),
      $2.UpdateResponse.fromBuffer);
  static final _$delete = $grpc.ClientMethod<$2.DeleteRequest, $0.Empty>(
      '/razmanager.protobuf.internal.repository.crud_services.car.CarService/Delete',
      ($2.DeleteRequest value) => value.writeToBuffer(),
      $0.Empty.fromBuffer);
  static final _$list = $grpc.ClientMethod<$1.CarListRequest,
          $1.CarListResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.car.CarService/List',
      ($1.CarListRequest value) => value.writeToBuffer(),
      $1.CarListResponse.fromBuffer);
  static final _$select = $grpc.ClientMethod<$0.Empty, $1.CarSelectResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.car.CarService/Select',
      ($0.Empty value) => value.writeToBuffer(),
      $1.CarSelectResponse.fromBuffer);
}

@$pb.GrpcServiceName(
    'razmanager.protobuf.internal.repository.crud_services.car.CarService')
abstract class CarServiceBase extends $grpc.Service {
  $core.String get $name =>
      'razmanager.protobuf.internal.repository.crud_services.car.CarService';

  CarServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.CarRead>(
        'Initialize',
        initialize_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.CarRead value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.IdRequest, $1.CarReadResponse>(
        'Read',
        read_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.IdRequest.fromBuffer(value),
        ($1.CarReadResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CarCreateUpdate, $2.CreateResponse>(
        'Create',
        create_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.CarCreateUpdate.fromBuffer(value),
        ($2.CreateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CarUpdateRequest, $2.UpdateResponse>(
        'Update',
        update_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.CarUpdateRequest.fromBuffer(value),
        ($2.UpdateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.DeleteRequest, $0.Empty>(
        'Delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.DeleteRequest.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CarListRequest, $1.CarListResponse>(
        'List',
        list_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.CarListRequest.fromBuffer(value),
        ($1.CarListResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.CarSelectResponse>(
        'Select',
        select_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.CarSelectResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.CarRead> initialize_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return initialize($call, await $request);
  }

  $async.Future<$1.CarRead> initialize(
      $grpc.ServiceCall call, $0.Empty request);

  $async.Future<$1.CarReadResponse> read_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.IdRequest> $request) async {
    return read($call, await $request);
  }

  $async.Future<$1.CarReadResponse> read(
      $grpc.ServiceCall call, $2.IdRequest request);

  $async.Future<$2.CreateResponse> create_Pre($grpc.ServiceCall $call,
      $async.Future<$1.CarCreateUpdate> $request) async {
    return create($call, await $request);
  }

  $async.Future<$2.CreateResponse> create(
      $grpc.ServiceCall call, $1.CarCreateUpdate request);

  $async.Future<$2.UpdateResponse> update_Pre($grpc.ServiceCall $call,
      $async.Future<$1.CarUpdateRequest> $request) async {
    return update($call, await $request);
  }

  $async.Future<$2.UpdateResponse> update(
      $grpc.ServiceCall call, $1.CarUpdateRequest request);

  $async.Future<$0.Empty> delete_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.DeleteRequest> $request) async {
    return delete($call, await $request);
  }

  $async.Future<$0.Empty> delete(
      $grpc.ServiceCall call, $2.DeleteRequest request);

  $async.Future<$1.CarListResponse> list_Pre($grpc.ServiceCall $call,
      $async.Future<$1.CarListRequest> $request) async {
    return list($call, await $request);
  }

  $async.Future<$1.CarListResponse> list(
      $grpc.ServiceCall call, $1.CarListRequest request);

  $async.Future<$1.CarSelectResponse> select_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return select($call, await $request);
  }

  $async.Future<$1.CarSelectResponse> select(
      $grpc.ServiceCall call, $0.Empty request);
}
