// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/user_services/tenant.proto.

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

import 'tenant.pb.dart' as $1;

export 'tenant.pb.dart';

@$pb.GrpcServiceName(
    'razmanager.protobuf.internal.repository.user_services.tenant.TenantService')
class TenantServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  TenantServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$1.TenantRead> read(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$read, request, options: options);
  }

  $grpc.ResponseFuture<$1.TenantSelectResponse> select(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$select, request, options: options);
  }

  // method descriptors

  static final _$read = $grpc.ClientMethod<$0.Empty, $1.TenantRead>(
      '/razmanager.protobuf.internal.repository.user_services.tenant.TenantService/Read',
      ($0.Empty value) => value.writeToBuffer(),
      $1.TenantRead.fromBuffer);
  static final _$select = $grpc.ClientMethod<$0.Empty, $1.TenantSelectResponse>(
      '/razmanager.protobuf.internal.repository.user_services.tenant.TenantService/Select',
      ($0.Empty value) => value.writeToBuffer(),
      $1.TenantSelectResponse.fromBuffer);
}

@$pb.GrpcServiceName(
    'razmanager.protobuf.internal.repository.user_services.tenant.TenantService')
abstract class TenantServiceBase extends $grpc.Service {
  $core.String get $name =>
      'razmanager.protobuf.internal.repository.user_services.tenant.TenantService';

  TenantServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.TenantRead>(
        'Read',
        read_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.TenantRead value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.TenantSelectResponse>(
        'Select',
        select_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.TenantSelectResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.TenantRead> read_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return read($call, await $request);
  }

  $async.Future<$1.TenantRead> read($grpc.ServiceCall call, $0.Empty request);

  $async.Future<$1.TenantSelectResponse> select_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return select($call, await $request);
  }

  $async.Future<$1.TenantSelectResponse> select(
      $grpc.ServiceCall call, $0.Empty request);
}
