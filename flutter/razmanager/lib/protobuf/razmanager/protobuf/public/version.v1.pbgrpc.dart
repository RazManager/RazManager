// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/version.v1.proto.

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

import 'version.v1.pb.dart' as $0;

export 'version.v1.pb.dart';

@$pb.GrpcServiceName('razmanager.protobuf.public.v1.VersionService')
class VersionServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  VersionServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.VersionAllResponse> all(
    $0.VersionAllRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$all, request, options: options);
  }

  $grpc.ResponseFuture<$0.VersionNewerResponse> newer(
    $0.VersionNewerRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$newer, request, options: options);
  }

  // method descriptors

  static final _$all =
      $grpc.ClientMethod<$0.VersionAllRequest, $0.VersionAllResponse>(
          '/razmanager.protobuf.public.v1.VersionService/All',
          ($0.VersionAllRequest value) => value.writeToBuffer(),
          $0.VersionAllResponse.fromBuffer);
  static final _$newer =
      $grpc.ClientMethod<$0.VersionNewerRequest, $0.VersionNewerResponse>(
          '/razmanager.protobuf.public.v1.VersionService/Newer',
          ($0.VersionNewerRequest value) => value.writeToBuffer(),
          $0.VersionNewerResponse.fromBuffer);
}

@$pb.GrpcServiceName('razmanager.protobuf.public.v1.VersionService')
abstract class VersionServiceBase extends $grpc.Service {
  $core.String get $name => 'razmanager.protobuf.public.v1.VersionService';

  VersionServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.VersionAllRequest, $0.VersionAllResponse>(
        'All',
        all_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.VersionAllRequest.fromBuffer(value),
        ($0.VersionAllResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.VersionNewerRequest, $0.VersionNewerResponse>(
            'Newer',
            newer_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.VersionNewerRequest.fromBuffer(value),
            ($0.VersionNewerResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.VersionAllResponse> all_Pre($grpc.ServiceCall $call,
      $async.Future<$0.VersionAllRequest> $request) async {
    return all($call, await $request);
  }

  $async.Future<$0.VersionAllResponse> all(
      $grpc.ServiceCall call, $0.VersionAllRequest request);

  $async.Future<$0.VersionNewerResponse> newer_Pre($grpc.ServiceCall $call,
      $async.Future<$0.VersionNewerRequest> $request) async {
    return newer($call, await $request);
  }

  $async.Future<$0.VersionNewerResponse> newer(
      $grpc.ServiceCall call, $0.VersionNewerRequest request);
}
