// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/tenant_user.proto.

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

import 'tenant_user.pb.dart' as $0;

export 'tenant_user.pb.dart';

@$pb.GrpcServiceName(
    'razmanager.protobuf.internal.repository.crud_services.tenant_user.TenantUserService')
class TenantUserServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  TenantUserServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.TenantUserSelectResponse> select(
    $0.TenantUserSelectRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$select, request, options: options);
  }

  // method descriptors

  static final _$select = $grpc.ClientMethod<$0.TenantUserSelectRequest,
          $0.TenantUserSelectResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.tenant_user.TenantUserService/Select',
      ($0.TenantUserSelectRequest value) => value.writeToBuffer(),
      $0.TenantUserSelectResponse.fromBuffer);
}

@$pb.GrpcServiceName(
    'razmanager.protobuf.internal.repository.crud_services.tenant_user.TenantUserService')
abstract class TenantUserServiceBase extends $grpc.Service {
  $core.String get $name =>
      'razmanager.protobuf.internal.repository.crud_services.tenant_user.TenantUserService';

  TenantUserServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.TenantUserSelectRequest,
            $0.TenantUserSelectResponse>(
        'Select',
        select_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.TenantUserSelectRequest.fromBuffer(value),
        ($0.TenantUserSelectResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.TenantUserSelectResponse> select_Pre($grpc.ServiceCall $call,
      $async.Future<$0.TenantUserSelectRequest> $request) async {
    return select($call, await $request);
  }

  $async.Future<$0.TenantUserSelectResponse> select(
      $grpc.ServiceCall call, $0.TenantUserSelectRequest request);
}
