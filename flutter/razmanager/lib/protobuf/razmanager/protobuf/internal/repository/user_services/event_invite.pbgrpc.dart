// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/user_services/event_invite.proto.

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
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart' as $1;

import 'event_invite.pb.dart' as $0;

export 'event_invite.pb.dart';

@$pb.GrpcServiceName(
    'razmanager.protobuf.internal.repository.user_services.event_invite.EventInviteService')
class EventInviteServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  EventInviteServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$1.Empty> create(
    $0.EventInviteCreate request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$create, request, options: options);
  }

  // method descriptors

  static final _$create = $grpc.ClientMethod<$0.EventInviteCreate, $1.Empty>(
      '/razmanager.protobuf.internal.repository.user_services.event_invite.EventInviteService/Create',
      ($0.EventInviteCreate value) => value.writeToBuffer(),
      $1.Empty.fromBuffer);
}

@$pb.GrpcServiceName(
    'razmanager.protobuf.internal.repository.user_services.event_invite.EventInviteService')
abstract class EventInviteServiceBase extends $grpc.Service {
  $core.String get $name =>
      'razmanager.protobuf.internal.repository.user_services.event_invite.EventInviteService';

  EventInviteServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.EventInviteCreate, $1.Empty>(
        'Create',
        create_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.EventInviteCreate.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$1.Empty> create_Pre($grpc.ServiceCall $call,
      $async.Future<$0.EventInviteCreate> $request) async {
    return create($call, await $request);
  }

  $async.Future<$1.Empty> create(
      $grpc.ServiceCall call, $0.EventInviteCreate request);
}
