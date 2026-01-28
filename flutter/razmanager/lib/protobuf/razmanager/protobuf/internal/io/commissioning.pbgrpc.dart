// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/io/commissioning.proto.

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

import 'commissioning.pb.dart' as $1;

export 'commissioning.pb.dart';

@$pb.GrpcServiceName(
    'razmanager.protobuf.internal.io.commissioning.CommissioningService')
class CommissioningServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  CommissioningServiceClient(super.channel,
      {super.options, super.interceptors});

  $grpc.ResponseFuture<$1.CommissioningCertificateRequest> certificateRequest(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$certificateRequest, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> certificateResponse(
    $1.CommissioningCertificateResponse request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$certificateResponse, request, options: options);
  }

  // method descriptors

  static final _$certificateRequest = $grpc.ClientMethod<$0.Empty,
          $1.CommissioningCertificateRequest>(
      '/razmanager.protobuf.internal.io.commissioning.CommissioningService/CertificateRequest',
      ($0.Empty value) => value.writeToBuffer(),
      $1.CommissioningCertificateRequest.fromBuffer);
  static final _$certificateResponse = $grpc.ClientMethod<
          $1.CommissioningCertificateResponse, $0.Empty>(
      '/razmanager.protobuf.internal.io.commissioning.CommissioningService/CertificateResponse',
      ($1.CommissioningCertificateResponse value) => value.writeToBuffer(),
      $0.Empty.fromBuffer);
}

@$pb.GrpcServiceName(
    'razmanager.protobuf.internal.io.commissioning.CommissioningService')
abstract class CommissioningServiceBase extends $grpc.Service {
  $core.String get $name =>
      'razmanager.protobuf.internal.io.commissioning.CommissioningService';

  CommissioningServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.Empty, $1.CommissioningCertificateRequest>(
            'CertificateRequest',
            certificateRequest_Pre,
            false,
            false,
            ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
            ($1.CommissioningCertificateRequest value) =>
                value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$1.CommissioningCertificateResponse, $0.Empty>(
            'CertificateResponse',
            certificateResponse_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $1.CommissioningCertificateResponse.fromBuffer(value),
            ($0.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$1.CommissioningCertificateRequest> certificateRequest_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return certificateRequest($call, await $request);
  }

  $async.Future<$1.CommissioningCertificateRequest> certificateRequest(
      $grpc.ServiceCall call, $0.Empty request);

  $async.Future<$0.Empty> certificateResponse_Pre($grpc.ServiceCall $call,
      $async.Future<$1.CommissioningCertificateResponse> $request) async {
    return certificateResponse($call, await $request);
  }

  $async.Future<$0.Empty> certificateResponse(
      $grpc.ServiceCall call, $1.CommissioningCertificateResponse request);
}
