// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/track_configuration.proto.

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

import 'track.pb.dart' as $1;
import 'track_configuration.pb.dart' as $2;

export 'track_configuration.pb.dart';

@$pb.GrpcServiceName(
    'razmanager.protobuf.internal.repository.crud_services.track_configuration.TrackConfigurationService')
class TrackConfigurationServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  TrackConfigurationServiceClient(super.channel,
      {super.options, super.interceptors});

  $grpc.ResponseFuture<$1.TrackConfigurationReadCreateUpdate> initialize(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$initialize, request, options: options);
  }

  $grpc.ResponseFuture<$2.TrackConfigurationSelectResponse> select(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$select, request, options: options);
  }

  // method descriptors

  static final _$initialize = $grpc.ClientMethod<$0.Empty,
          $1.TrackConfigurationReadCreateUpdate>(
      '/razmanager.protobuf.internal.repository.crud_services.track_configuration.TrackConfigurationService/Initialize',
      ($0.Empty value) => value.writeToBuffer(),
      $1.TrackConfigurationReadCreateUpdate.fromBuffer);
  static final _$select = $grpc.ClientMethod<$0.Empty,
          $2.TrackConfigurationSelectResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.track_configuration.TrackConfigurationService/Select',
      ($0.Empty value) => value.writeToBuffer(),
      $2.TrackConfigurationSelectResponse.fromBuffer);
}

@$pb.GrpcServiceName(
    'razmanager.protobuf.internal.repository.crud_services.track_configuration.TrackConfigurationService')
abstract class TrackConfigurationServiceBase extends $grpc.Service {
  $core.String get $name =>
      'razmanager.protobuf.internal.repository.crud_services.track_configuration.TrackConfigurationService';

  TrackConfigurationServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.Empty, $1.TrackConfigurationReadCreateUpdate>(
            'Initialize',
            initialize_Pre,
            false,
            false,
            ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
            ($1.TrackConfigurationReadCreateUpdate value) =>
                value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.Empty, $2.TrackConfigurationSelectResponse>(
            'Select',
            select_Pre,
            false,
            false,
            ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
            ($2.TrackConfigurationSelectResponse value) =>
                value.writeToBuffer()));
  }

  $async.Future<$1.TrackConfigurationReadCreateUpdate> initialize_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return initialize($call, await $request);
  }

  $async.Future<$1.TrackConfigurationReadCreateUpdate> initialize(
      $grpc.ServiceCall call, $0.Empty request);

  $async.Future<$2.TrackConfigurationSelectResponse> select_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return select($call, await $request);
  }

  $async.Future<$2.TrackConfigurationSelectResponse> select(
      $grpc.ServiceCall call, $0.Empty request);
}
