// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/race.service.v1.proto.

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
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart' as $3;
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart'
    as $0;

import 'race.service.v1.pb.dart' as $2;
import 'race.v1.pb.dart' as $1;

export 'race.service.v1.pb.dart';

@$pb.GrpcServiceName('razmanager.protobuf.public.v1.RaceService')
class RaceServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  RaceServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseStream<$1.Race> subscribe(
    $0.StringValue request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$subscribe, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$1.RaceLeaderboard> raceLeaderboardSubscribe(
    $0.StringValue request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$raceLeaderboardSubscribe, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$3.Empty> command(
    $2.RaceCommandRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$command, request, options: options);
  }

  $grpc.ResponseFuture<$1.RaceCommandPermissions> commandPermissions(
    $0.StringValue request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$commandPermissions, request, options: options);
  }

  // method descriptors

  static final _$subscribe = $grpc.ClientMethod<$0.StringValue, $1.Race>(
      '/razmanager.protobuf.public.v1.RaceService/Subscribe',
      ($0.StringValue value) => value.writeToBuffer(),
      $1.Race.fromBuffer);
  static final _$raceLeaderboardSubscribe =
      $grpc.ClientMethod<$0.StringValue, $1.RaceLeaderboard>(
          '/razmanager.protobuf.public.v1.RaceService/RaceLeaderboardSubscribe',
          ($0.StringValue value) => value.writeToBuffer(),
          $1.RaceLeaderboard.fromBuffer);
  static final _$command = $grpc.ClientMethod<$2.RaceCommandRequest, $3.Empty>(
      '/razmanager.protobuf.public.v1.RaceService/Command',
      ($2.RaceCommandRequest value) => value.writeToBuffer(),
      $3.Empty.fromBuffer);
  static final _$commandPermissions =
      $grpc.ClientMethod<$0.StringValue, $1.RaceCommandPermissions>(
          '/razmanager.protobuf.public.v1.RaceService/CommandPermissions',
          ($0.StringValue value) => value.writeToBuffer(),
          $1.RaceCommandPermissions.fromBuffer);
}

@$pb.GrpcServiceName('razmanager.protobuf.public.v1.RaceService')
abstract class RaceServiceBase extends $grpc.Service {
  $core.String get $name => 'razmanager.protobuf.public.v1.RaceService';

  RaceServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.StringValue, $1.Race>(
        'Subscribe',
        subscribe_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.StringValue.fromBuffer(value),
        ($1.Race value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.StringValue, $1.RaceLeaderboard>(
        'RaceLeaderboardSubscribe',
        raceLeaderboardSubscribe_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.StringValue.fromBuffer(value),
        ($1.RaceLeaderboard value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.RaceCommandRequest, $3.Empty>(
        'Command',
        command_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.RaceCommandRequest.fromBuffer(value),
        ($3.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.StringValue, $1.RaceCommandPermissions>(
        'CommandPermissions',
        commandPermissions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.StringValue.fromBuffer(value),
        ($1.RaceCommandPermissions value) => value.writeToBuffer()));
  }

  $async.Stream<$1.Race> subscribe_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.StringValue> $request) async* {
    yield* subscribe($call, await $request);
  }

  $async.Stream<$1.Race> subscribe(
      $grpc.ServiceCall call, $0.StringValue request);

  $async.Stream<$1.RaceLeaderboard> raceLeaderboardSubscribe_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.StringValue> $request) async* {
    yield* raceLeaderboardSubscribe($call, await $request);
  }

  $async.Stream<$1.RaceLeaderboard> raceLeaderboardSubscribe(
      $grpc.ServiceCall call, $0.StringValue request);

  $async.Future<$3.Empty> command_Pre($grpc.ServiceCall $call,
      $async.Future<$2.RaceCommandRequest> $request) async {
    return command($call, await $request);
  }

  $async.Future<$3.Empty> command(
      $grpc.ServiceCall call, $2.RaceCommandRequest request);

  $async.Future<$1.RaceCommandPermissions> commandPermissions_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.StringValue> $request) async {
    return commandPermissions($call, await $request);
  }

  $async.Future<$1.RaceCommandPermissions> commandPermissions(
      $grpc.ServiceCall call, $0.StringValue request);
}
