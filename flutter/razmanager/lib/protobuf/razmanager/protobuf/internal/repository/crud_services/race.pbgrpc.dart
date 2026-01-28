// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/race.proto.

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
import 'race.pb.dart' as $1;

export 'race.pb.dart';

@$pb.GrpcServiceName(
    'razmanager.protobuf.internal.repository.crud_services.race.RaceService')
class RaceServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  RaceServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$1.RaceRead> initialize(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$initialize, request, options: options);
  }

  $grpc.ResponseFuture<$1.RaceReadResponse> read(
    $2.IdRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$read, request, options: options);
  }

  $grpc.ResponseFuture<$2.CreateResponse> create(
    $1.RaceCreate request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$create, request, options: options);
  }

  $grpc.ResponseFuture<$2.UpdateResponse> update(
    $1.RaceUpdateRequest request, {
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

  $grpc.ResponseFuture<$1.RaceListResponse> list(
    $2.ListRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$list, request, options: options);
  }

  $grpc.ResponseFuture<$1.RaceSelectResponse> select(
    $1.RaceSelectRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$select, request, options: options);
  }

  $grpc.ResponseFuture<$2.CreateResponse> copy(
    $2.IdRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$copy, request, options: options);
  }

  // method descriptors

  static final _$initialize = $grpc.ClientMethod<$0.Empty, $1.RaceRead>(
      '/razmanager.protobuf.internal.repository.crud_services.race.RaceService/Initialize',
      ($0.Empty value) => value.writeToBuffer(),
      $1.RaceRead.fromBuffer);
  static final _$read = $grpc.ClientMethod<$2.IdRequest, $1.RaceReadResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.race.RaceService/Read',
      ($2.IdRequest value) => value.writeToBuffer(),
      $1.RaceReadResponse.fromBuffer);
  static final _$create = $grpc.ClientMethod<$1.RaceCreate, $2.CreateResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.race.RaceService/Create',
      ($1.RaceCreate value) => value.writeToBuffer(),
      $2.CreateResponse.fromBuffer);
  static final _$update = $grpc.ClientMethod<$1.RaceUpdateRequest,
          $2.UpdateResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.race.RaceService/Update',
      ($1.RaceUpdateRequest value) => value.writeToBuffer(),
      $2.UpdateResponse.fromBuffer);
  static final _$delete = $grpc.ClientMethod<$2.DeleteRequest, $0.Empty>(
      '/razmanager.protobuf.internal.repository.crud_services.race.RaceService/Delete',
      ($2.DeleteRequest value) => value.writeToBuffer(),
      $0.Empty.fromBuffer);
  static final _$list = $grpc.ClientMethod<$2.ListRequest, $1.RaceListResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.race.RaceService/List',
      ($2.ListRequest value) => value.writeToBuffer(),
      $1.RaceListResponse.fromBuffer);
  static final _$select = $grpc.ClientMethod<$1.RaceSelectRequest,
          $1.RaceSelectResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.race.RaceService/Select',
      ($1.RaceSelectRequest value) => value.writeToBuffer(),
      $1.RaceSelectResponse.fromBuffer);
  static final _$copy = $grpc.ClientMethod<$2.IdRequest, $2.CreateResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.race.RaceService/Copy',
      ($2.IdRequest value) => value.writeToBuffer(),
      $2.CreateResponse.fromBuffer);
}

@$pb.GrpcServiceName(
    'razmanager.protobuf.internal.repository.crud_services.race.RaceService')
abstract class RaceServiceBase extends $grpc.Service {
  $core.String get $name =>
      'razmanager.protobuf.internal.repository.crud_services.race.RaceService';

  RaceServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.RaceRead>(
        'Initialize',
        initialize_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.RaceRead value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.IdRequest, $1.RaceReadResponse>(
        'Read',
        read_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.IdRequest.fromBuffer(value),
        ($1.RaceReadResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.RaceCreate, $2.CreateResponse>(
        'Create',
        create_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.RaceCreate.fromBuffer(value),
        ($2.CreateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.RaceUpdateRequest, $2.UpdateResponse>(
        'Update',
        update_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.RaceUpdateRequest.fromBuffer(value),
        ($2.UpdateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.DeleteRequest, $0.Empty>(
        'Delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.DeleteRequest.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.ListRequest, $1.RaceListResponse>(
        'List',
        list_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.ListRequest.fromBuffer(value),
        ($1.RaceListResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.RaceSelectRequest, $1.RaceSelectResponse>(
        'Select',
        select_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.RaceSelectRequest.fromBuffer(value),
        ($1.RaceSelectResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.IdRequest, $2.CreateResponse>(
        'Copy',
        copy_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.IdRequest.fromBuffer(value),
        ($2.CreateResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.RaceRead> initialize_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return initialize($call, await $request);
  }

  $async.Future<$1.RaceRead> initialize(
      $grpc.ServiceCall call, $0.Empty request);

  $async.Future<$1.RaceReadResponse> read_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.IdRequest> $request) async {
    return read($call, await $request);
  }

  $async.Future<$1.RaceReadResponse> read(
      $grpc.ServiceCall call, $2.IdRequest request);

  $async.Future<$2.CreateResponse> create_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.RaceCreate> $request) async {
    return create($call, await $request);
  }

  $async.Future<$2.CreateResponse> create(
      $grpc.ServiceCall call, $1.RaceCreate request);

  $async.Future<$2.UpdateResponse> update_Pre($grpc.ServiceCall $call,
      $async.Future<$1.RaceUpdateRequest> $request) async {
    return update($call, await $request);
  }

  $async.Future<$2.UpdateResponse> update(
      $grpc.ServiceCall call, $1.RaceUpdateRequest request);

  $async.Future<$0.Empty> delete_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.DeleteRequest> $request) async {
    return delete($call, await $request);
  }

  $async.Future<$0.Empty> delete(
      $grpc.ServiceCall call, $2.DeleteRequest request);

  $async.Future<$1.RaceListResponse> list_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.ListRequest> $request) async {
    return list($call, await $request);
  }

  $async.Future<$1.RaceListResponse> list(
      $grpc.ServiceCall call, $2.ListRequest request);

  $async.Future<$1.RaceSelectResponse> select_Pre($grpc.ServiceCall $call,
      $async.Future<$1.RaceSelectRequest> $request) async {
    return select($call, await $request);
  }

  $async.Future<$1.RaceSelectResponse> select(
      $grpc.ServiceCall call, $1.RaceSelectRequest request);

  $async.Future<$2.CreateResponse> copy_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.IdRequest> $request) async {
    return copy($call, await $request);
  }

  $async.Future<$2.CreateResponse> copy(
      $grpc.ServiceCall call, $2.IdRequest request);
}
