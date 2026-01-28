// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/heat_indicator_stint.proto.

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
import 'heat_indicator_stint.pb.dart' as $1;

export 'heat_indicator_stint.pb.dart';

@$pb.GrpcServiceName(
    'razmanager.protobuf.internal.repository.crud_services.heat_indicator_stint.HeatIndicatorStintService')
class HeatIndicatorStintServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  HeatIndicatorStintServiceClient(super.channel,
      {super.options, super.interceptors});

  $grpc.ResponseFuture<$1.HeatIndicatorStintRead> initialize(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$initialize, request, options: options);
  }

  $grpc.ResponseFuture<$1.HeatIndicatorStintReadResponse> read(
    $2.IdRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$read, request, options: options);
  }

  $grpc.ResponseFuture<$2.CreateResponse> create(
    $1.HeatIndicatorStintCreate request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$create, request, options: options);
  }

  $grpc.ResponseFuture<$2.UpdateResponse> update(
    $1.HeatIndicatorStintUpdateRequest request, {
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

  // method descriptors

  static final _$initialize = $grpc.ClientMethod<$0.Empty,
          $1.HeatIndicatorStintRead>(
      '/razmanager.protobuf.internal.repository.crud_services.heat_indicator_stint.HeatIndicatorStintService/Initialize',
      ($0.Empty value) => value.writeToBuffer(),
      $1.HeatIndicatorStintRead.fromBuffer);
  static final _$read = $grpc.ClientMethod<$2.IdRequest,
          $1.HeatIndicatorStintReadResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.heat_indicator_stint.HeatIndicatorStintService/Read',
      ($2.IdRequest value) => value.writeToBuffer(),
      $1.HeatIndicatorStintReadResponse.fromBuffer);
  static final _$create = $grpc.ClientMethod<$1.HeatIndicatorStintCreate,
          $2.CreateResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.heat_indicator_stint.HeatIndicatorStintService/Create',
      ($1.HeatIndicatorStintCreate value) => value.writeToBuffer(),
      $2.CreateResponse.fromBuffer);
  static final _$update = $grpc.ClientMethod<$1.HeatIndicatorStintUpdateRequest,
          $2.UpdateResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.heat_indicator_stint.HeatIndicatorStintService/Update',
      ($1.HeatIndicatorStintUpdateRequest value) => value.writeToBuffer(),
      $2.UpdateResponse.fromBuffer);
  static final _$delete = $grpc.ClientMethod<$2.DeleteRequest, $0.Empty>(
      '/razmanager.protobuf.internal.repository.crud_services.heat_indicator_stint.HeatIndicatorStintService/Delete',
      ($2.DeleteRequest value) => value.writeToBuffer(),
      $0.Empty.fromBuffer);
}

@$pb.GrpcServiceName(
    'razmanager.protobuf.internal.repository.crud_services.heat_indicator_stint.HeatIndicatorStintService')
abstract class HeatIndicatorStintServiceBase extends $grpc.Service {
  $core.String get $name =>
      'razmanager.protobuf.internal.repository.crud_services.heat_indicator_stint.HeatIndicatorStintService';

  HeatIndicatorStintServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.HeatIndicatorStintRead>(
        'Initialize',
        initialize_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.HeatIndicatorStintRead value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$2.IdRequest, $1.HeatIndicatorStintReadResponse>(
            'Read',
            read_Pre,
            false,
            false,
            ($core.List<$core.int> value) => $2.IdRequest.fromBuffer(value),
            ($1.HeatIndicatorStintReadResponse value) =>
                value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$1.HeatIndicatorStintCreate, $2.CreateResponse>(
            'Create',
            create_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $1.HeatIndicatorStintCreate.fromBuffer(value),
            ($2.CreateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.HeatIndicatorStintUpdateRequest,
            $2.UpdateResponse>(
        'Update',
        update_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.HeatIndicatorStintUpdateRequest.fromBuffer(value),
        ($2.UpdateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.DeleteRequest, $0.Empty>(
        'Delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.DeleteRequest.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$1.HeatIndicatorStintRead> initialize_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return initialize($call, await $request);
  }

  $async.Future<$1.HeatIndicatorStintRead> initialize(
      $grpc.ServiceCall call, $0.Empty request);

  $async.Future<$1.HeatIndicatorStintReadResponse> read_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.IdRequest> $request) async {
    return read($call, await $request);
  }

  $async.Future<$1.HeatIndicatorStintReadResponse> read(
      $grpc.ServiceCall call, $2.IdRequest request);

  $async.Future<$2.CreateResponse> create_Pre($grpc.ServiceCall $call,
      $async.Future<$1.HeatIndicatorStintCreate> $request) async {
    return create($call, await $request);
  }

  $async.Future<$2.CreateResponse> create(
      $grpc.ServiceCall call, $1.HeatIndicatorStintCreate request);

  $async.Future<$2.UpdateResponse> update_Pre($grpc.ServiceCall $call,
      $async.Future<$1.HeatIndicatorStintUpdateRequest> $request) async {
    return update($call, await $request);
  }

  $async.Future<$2.UpdateResponse> update(
      $grpc.ServiceCall call, $1.HeatIndicatorStintUpdateRequest request);

  $async.Future<$0.Empty> delete_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.DeleteRequest> $request) async {
    return delete($call, await $request);
  }

  $async.Future<$0.Empty> delete(
      $grpc.ServiceCall call, $2.DeleteRequest request);
}
