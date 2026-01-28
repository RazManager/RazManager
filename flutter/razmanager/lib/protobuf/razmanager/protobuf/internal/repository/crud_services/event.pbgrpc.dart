// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/event.proto.

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
import 'event.pb.dart' as $1;

export 'event.pb.dart';

@$pb.GrpcServiceName(
    'razmanager.protobuf.internal.repository.crud_services.event.EventService')
class EventServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  EventServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$1.EventRead> initialize(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$initialize, request, options: options);
  }

  $grpc.ResponseFuture<$1.EventReadResponse> read(
    $2.IdRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$read, request, options: options);
  }

  $grpc.ResponseFuture<$2.CreateResponse> create(
    $1.EventCreateUpdate request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$create, request, options: options);
  }

  $grpc.ResponseFuture<$2.UpdateResponse> update(
    $1.EventUpdateRequest request, {
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

  $grpc.ResponseFuture<$1.EventListResponse> list(
    $2.ListRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$list, request, options: options);
  }

  $grpc.ResponseFuture<$1.EventSelectResponse> select(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$select, request, options: options);
  }

  // method descriptors

  static final _$initialize = $grpc.ClientMethod<$0.Empty, $1.EventRead>(
      '/razmanager.protobuf.internal.repository.crud_services.event.EventService/Initialize',
      ($0.Empty value) => value.writeToBuffer(),
      $1.EventRead.fromBuffer);
  static final _$read = $grpc.ClientMethod<$2.IdRequest, $1.EventReadResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.event.EventService/Read',
      ($2.IdRequest value) => value.writeToBuffer(),
      $1.EventReadResponse.fromBuffer);
  static final _$create = $grpc.ClientMethod<$1.EventCreateUpdate,
          $2.CreateResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.event.EventService/Create',
      ($1.EventCreateUpdate value) => value.writeToBuffer(),
      $2.CreateResponse.fromBuffer);
  static final _$update = $grpc.ClientMethod<$1.EventUpdateRequest,
          $2.UpdateResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.event.EventService/Update',
      ($1.EventUpdateRequest value) => value.writeToBuffer(),
      $2.UpdateResponse.fromBuffer);
  static final _$delete = $grpc.ClientMethod<$2.DeleteRequest, $0.Empty>(
      '/razmanager.protobuf.internal.repository.crud_services.event.EventService/Delete',
      ($2.DeleteRequest value) => value.writeToBuffer(),
      $0.Empty.fromBuffer);
  static final _$list = $grpc.ClientMethod<$2.ListRequest,
          $1.EventListResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.event.EventService/List',
      ($2.ListRequest value) => value.writeToBuffer(),
      $1.EventListResponse.fromBuffer);
  static final _$select = $grpc.ClientMethod<$0.Empty, $1.EventSelectResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.event.EventService/Select',
      ($0.Empty value) => value.writeToBuffer(),
      $1.EventSelectResponse.fromBuffer);
}

@$pb.GrpcServiceName(
    'razmanager.protobuf.internal.repository.crud_services.event.EventService')
abstract class EventServiceBase extends $grpc.Service {
  $core.String get $name =>
      'razmanager.protobuf.internal.repository.crud_services.event.EventService';

  EventServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.EventRead>(
        'Initialize',
        initialize_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.EventRead value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.IdRequest, $1.EventReadResponse>(
        'Read',
        read_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.IdRequest.fromBuffer(value),
        ($1.EventReadResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.EventCreateUpdate, $2.CreateResponse>(
        'Create',
        create_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.EventCreateUpdate.fromBuffer(value),
        ($2.CreateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.EventUpdateRequest, $2.UpdateResponse>(
        'Update',
        update_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.EventUpdateRequest.fromBuffer(value),
        ($2.UpdateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.DeleteRequest, $0.Empty>(
        'Delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.DeleteRequest.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.ListRequest, $1.EventListResponse>(
        'List',
        list_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.ListRequest.fromBuffer(value),
        ($1.EventListResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.EventSelectResponse>(
        'Select',
        select_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.EventSelectResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.EventRead> initialize_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return initialize($call, await $request);
  }

  $async.Future<$1.EventRead> initialize(
      $grpc.ServiceCall call, $0.Empty request);

  $async.Future<$1.EventReadResponse> read_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.IdRequest> $request) async {
    return read($call, await $request);
  }

  $async.Future<$1.EventReadResponse> read(
      $grpc.ServiceCall call, $2.IdRequest request);

  $async.Future<$2.CreateResponse> create_Pre($grpc.ServiceCall $call,
      $async.Future<$1.EventCreateUpdate> $request) async {
    return create($call, await $request);
  }

  $async.Future<$2.CreateResponse> create(
      $grpc.ServiceCall call, $1.EventCreateUpdate request);

  $async.Future<$2.UpdateResponse> update_Pre($grpc.ServiceCall $call,
      $async.Future<$1.EventUpdateRequest> $request) async {
    return update($call, await $request);
  }

  $async.Future<$2.UpdateResponse> update(
      $grpc.ServiceCall call, $1.EventUpdateRequest request);

  $async.Future<$0.Empty> delete_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.DeleteRequest> $request) async {
    return delete($call, await $request);
  }

  $async.Future<$0.Empty> delete(
      $grpc.ServiceCall call, $2.DeleteRequest request);

  $async.Future<$1.EventListResponse> list_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.ListRequest> $request) async {
    return list($call, await $request);
  }

  $async.Future<$1.EventListResponse> list(
      $grpc.ServiceCall call, $2.ListRequest request);

  $async.Future<$1.EventSelectResponse> select_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return select($call, await $request);
  }

  $async.Future<$1.EventSelectResponse> select(
      $grpc.ServiceCall call, $0.Empty request);
}
