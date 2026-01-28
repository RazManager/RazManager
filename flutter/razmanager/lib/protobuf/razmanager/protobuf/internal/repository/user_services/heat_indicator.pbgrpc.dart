// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/user_services/heat_indicator.proto.

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
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart'
    as $0;

import 'heat_indicator.pb.dart' as $1;

export 'heat_indicator.pb.dart';

@$pb.GrpcServiceName(
    'razmanager.protobuf.internal.repository.user_services.heat_indicator.HeatIndicatorService')
class HeatIndicatorServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  HeatIndicatorServiceClient(super.channel,
      {super.options, super.interceptors});

  $grpc.ResponseFuture<$1.HeatIndicatorRead> read(
    $0.StringValue request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$read, request, options: options);
  }

  // method descriptors

  static final _$read = $grpc.ClientMethod<$0.StringValue,
          $1.HeatIndicatorRead>(
      '/razmanager.protobuf.internal.repository.user_services.heat_indicator.HeatIndicatorService/Read',
      ($0.StringValue value) => value.writeToBuffer(),
      $1.HeatIndicatorRead.fromBuffer);
}

@$pb.GrpcServiceName(
    'razmanager.protobuf.internal.repository.user_services.heat_indicator.HeatIndicatorService')
abstract class HeatIndicatorServiceBase extends $grpc.Service {
  $core.String get $name =>
      'razmanager.protobuf.internal.repository.user_services.heat_indicator.HeatIndicatorService';

  HeatIndicatorServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.StringValue, $1.HeatIndicatorRead>(
        'Read',
        read_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.StringValue.fromBuffer(value),
        ($1.HeatIndicatorRead value) => value.writeToBuffer()));
  }

  $async.Future<$1.HeatIndicatorRead> read_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.StringValue> $request) async {
    return read($call, await $request);
  }

  $async.Future<$1.HeatIndicatorRead> read(
      $grpc.ServiceCall call, $0.StringValue request);
}
