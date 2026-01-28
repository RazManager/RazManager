// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/points_scheme.proto.

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
import 'points_scheme.pb.dart' as $1;

export 'points_scheme.pb.dart';

@$pb.GrpcServiceName(
    'razmanager.protobuf.internal.repository.crud_services.points_scheme.PointsSchemeService')
class PointsSchemeServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  PointsSchemeServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$1.PointsSchemeRead> initialize(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$initialize, request, options: options);
  }

  $grpc.ResponseFuture<$1.PointsSchemeReadResponse> read(
    $2.IdRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$read, request, options: options);
  }

  $grpc.ResponseFuture<$2.CreateResponse> create(
    $1.PointsSchemeCreateUpdate request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$create, request, options: options);
  }

  $grpc.ResponseFuture<$2.UpdateResponse> update(
    $1.PointsSchemeUpdateRequest request, {
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

  $grpc.ResponseFuture<$1.PointsSchemeListResponse> list(
    $2.ListRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$list, request, options: options);
  }

  $grpc.ResponseFuture<$1.PointsSchemeSelectResponse> select(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$select, request, options: options);
  }

  // method descriptors

  static final _$initialize = $grpc.ClientMethod<$0.Empty, $1.PointsSchemeRead>(
      '/razmanager.protobuf.internal.repository.crud_services.points_scheme.PointsSchemeService/Initialize',
      ($0.Empty value) => value.writeToBuffer(),
      $1.PointsSchemeRead.fromBuffer);
  static final _$read = $grpc.ClientMethod<$2.IdRequest,
          $1.PointsSchemeReadResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.points_scheme.PointsSchemeService/Read',
      ($2.IdRequest value) => value.writeToBuffer(),
      $1.PointsSchemeReadResponse.fromBuffer);
  static final _$create = $grpc.ClientMethod<$1.PointsSchemeCreateUpdate,
          $2.CreateResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.points_scheme.PointsSchemeService/Create',
      ($1.PointsSchemeCreateUpdate value) => value.writeToBuffer(),
      $2.CreateResponse.fromBuffer);
  static final _$update = $grpc.ClientMethod<$1.PointsSchemeUpdateRequest,
          $2.UpdateResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.points_scheme.PointsSchemeService/Update',
      ($1.PointsSchemeUpdateRequest value) => value.writeToBuffer(),
      $2.UpdateResponse.fromBuffer);
  static final _$delete = $grpc.ClientMethod<$2.DeleteRequest, $0.Empty>(
      '/razmanager.protobuf.internal.repository.crud_services.points_scheme.PointsSchemeService/Delete',
      ($2.DeleteRequest value) => value.writeToBuffer(),
      $0.Empty.fromBuffer);
  static final _$list = $grpc.ClientMethod<$2.ListRequest,
          $1.PointsSchemeListResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.points_scheme.PointsSchemeService/List',
      ($2.ListRequest value) => value.writeToBuffer(),
      $1.PointsSchemeListResponse.fromBuffer);
  static final _$select = $grpc.ClientMethod<$0.Empty,
          $1.PointsSchemeSelectResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.points_scheme.PointsSchemeService/Select',
      ($0.Empty value) => value.writeToBuffer(),
      $1.PointsSchemeSelectResponse.fromBuffer);
}

@$pb.GrpcServiceName(
    'razmanager.protobuf.internal.repository.crud_services.points_scheme.PointsSchemeService')
abstract class PointsSchemeServiceBase extends $grpc.Service {
  $core.String get $name =>
      'razmanager.protobuf.internal.repository.crud_services.points_scheme.PointsSchemeService';

  PointsSchemeServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.PointsSchemeRead>(
        'Initialize',
        initialize_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.PointsSchemeRead value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.IdRequest, $1.PointsSchemeReadResponse>(
        'Read',
        read_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.IdRequest.fromBuffer(value),
        ($1.PointsSchemeReadResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$1.PointsSchemeCreateUpdate, $2.CreateResponse>(
            'Create',
            create_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $1.PointsSchemeCreateUpdate.fromBuffer(value),
            ($2.CreateResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$1.PointsSchemeUpdateRequest, $2.UpdateResponse>(
            'Update',
            update_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $1.PointsSchemeUpdateRequest.fromBuffer(value),
            ($2.UpdateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.DeleteRequest, $0.Empty>(
        'Delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.DeleteRequest.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.ListRequest, $1.PointsSchemeListResponse>(
        'List',
        list_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.ListRequest.fromBuffer(value),
        ($1.PointsSchemeListResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.PointsSchemeSelectResponse>(
        'Select',
        select_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.PointsSchemeSelectResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.PointsSchemeRead> initialize_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return initialize($call, await $request);
  }

  $async.Future<$1.PointsSchemeRead> initialize(
      $grpc.ServiceCall call, $0.Empty request);

  $async.Future<$1.PointsSchemeReadResponse> read_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.IdRequest> $request) async {
    return read($call, await $request);
  }

  $async.Future<$1.PointsSchemeReadResponse> read(
      $grpc.ServiceCall call, $2.IdRequest request);

  $async.Future<$2.CreateResponse> create_Pre($grpc.ServiceCall $call,
      $async.Future<$1.PointsSchemeCreateUpdate> $request) async {
    return create($call, await $request);
  }

  $async.Future<$2.CreateResponse> create(
      $grpc.ServiceCall call, $1.PointsSchemeCreateUpdate request);

  $async.Future<$2.UpdateResponse> update_Pre($grpc.ServiceCall $call,
      $async.Future<$1.PointsSchemeUpdateRequest> $request) async {
    return update($call, await $request);
  }

  $async.Future<$2.UpdateResponse> update(
      $grpc.ServiceCall call, $1.PointsSchemeUpdateRequest request);

  $async.Future<$0.Empty> delete_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.DeleteRequest> $request) async {
    return delete($call, await $request);
  }

  $async.Future<$0.Empty> delete(
      $grpc.ServiceCall call, $2.DeleteRequest request);

  $async.Future<$1.PointsSchemeListResponse> list_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.ListRequest> $request) async {
    return list($call, await $request);
  }

  $async.Future<$1.PointsSchemeListResponse> list(
      $grpc.ServiceCall call, $2.ListRequest request);

  $async.Future<$1.PointsSchemeSelectResponse> select_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return select($call, await $request);
  }

  $async.Future<$1.PointsSchemeSelectResponse> select(
      $grpc.ServiceCall call, $0.Empty request);
}
