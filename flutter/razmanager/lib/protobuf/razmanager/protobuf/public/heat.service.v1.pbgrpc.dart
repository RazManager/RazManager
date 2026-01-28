// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/heat.service.v1.proto.

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

import 'heat.service.v1.pb.dart' as $2;
import 'heat.v1.pb.dart' as $1;

export 'heat.service.v1.pb.dart';

@$pb.GrpcServiceName('razmanager.protobuf.public.v1.HeatService')
class HeatServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  HeatServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseStream<$1.Heat> subscribe(
    $0.StringValue request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$subscribe, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$1.HeatState> heatStateSubscribe(
    $0.StringValue request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$heatStateSubscribe, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$1.HeatLeaderboard> heatLeaderboardSubscribe(
    $0.StringValue request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$heatLeaderboardSubscribe, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$1.HeatAnalyses> heatAnalysesSubscribe(
    $0.StringValue request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$heatAnalysesSubscribe, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$1.HeatStintAnalysis> heatStintAnalysesSubscribe(
    $2.HeatStintAnalysesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$heatStintAnalysesSubscribe, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$3.Empty> command(
    $2.HeatCommandRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$command, request, options: options);
  }

  $grpc.ResponseFuture<$1.HeatCommandPermissions> commandPermissions(
    $0.StringValue request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$commandPermissions, request, options: options);
  }

  // method descriptors

  static final _$subscribe = $grpc.ClientMethod<$0.StringValue, $1.Heat>(
      '/razmanager.protobuf.public.v1.HeatService/Subscribe',
      ($0.StringValue value) => value.writeToBuffer(),
      $1.Heat.fromBuffer);
  static final _$heatStateSubscribe =
      $grpc.ClientMethod<$0.StringValue, $1.HeatState>(
          '/razmanager.protobuf.public.v1.HeatService/HeatStateSubscribe',
          ($0.StringValue value) => value.writeToBuffer(),
          $1.HeatState.fromBuffer);
  static final _$heatLeaderboardSubscribe =
      $grpc.ClientMethod<$0.StringValue, $1.HeatLeaderboard>(
          '/razmanager.protobuf.public.v1.HeatService/HeatLeaderboardSubscribe',
          ($0.StringValue value) => value.writeToBuffer(),
          $1.HeatLeaderboard.fromBuffer);
  static final _$heatAnalysesSubscribe =
      $grpc.ClientMethod<$0.StringValue, $1.HeatAnalyses>(
          '/razmanager.protobuf.public.v1.HeatService/HeatAnalysesSubscribe',
          ($0.StringValue value) => value.writeToBuffer(),
          $1.HeatAnalyses.fromBuffer);
  static final _$heatStintAnalysesSubscribe = $grpc.ClientMethod<
          $2.HeatStintAnalysesRequest, $1.HeatStintAnalysis>(
      '/razmanager.protobuf.public.v1.HeatService/HeatStintAnalysesSubscribe',
      ($2.HeatStintAnalysesRequest value) => value.writeToBuffer(),
      $1.HeatStintAnalysis.fromBuffer);
  static final _$command = $grpc.ClientMethod<$2.HeatCommandRequest, $3.Empty>(
      '/razmanager.protobuf.public.v1.HeatService/Command',
      ($2.HeatCommandRequest value) => value.writeToBuffer(),
      $3.Empty.fromBuffer);
  static final _$commandPermissions =
      $grpc.ClientMethod<$0.StringValue, $1.HeatCommandPermissions>(
          '/razmanager.protobuf.public.v1.HeatService/CommandPermissions',
          ($0.StringValue value) => value.writeToBuffer(),
          $1.HeatCommandPermissions.fromBuffer);
}

@$pb.GrpcServiceName('razmanager.protobuf.public.v1.HeatService')
abstract class HeatServiceBase extends $grpc.Service {
  $core.String get $name => 'razmanager.protobuf.public.v1.HeatService';

  HeatServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.StringValue, $1.Heat>(
        'Subscribe',
        subscribe_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.StringValue.fromBuffer(value),
        ($1.Heat value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.StringValue, $1.HeatState>(
        'HeatStateSubscribe',
        heatStateSubscribe_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.StringValue.fromBuffer(value),
        ($1.HeatState value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.StringValue, $1.HeatLeaderboard>(
        'HeatLeaderboardSubscribe',
        heatLeaderboardSubscribe_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.StringValue.fromBuffer(value),
        ($1.HeatLeaderboard value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.StringValue, $1.HeatAnalyses>(
        'HeatAnalysesSubscribe',
        heatAnalysesSubscribe_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.StringValue.fromBuffer(value),
        ($1.HeatAnalyses value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$2.HeatStintAnalysesRequest, $1.HeatStintAnalysis>(
            'HeatStintAnalysesSubscribe',
            heatStintAnalysesSubscribe_Pre,
            false,
            true,
            ($core.List<$core.int> value) =>
                $2.HeatStintAnalysesRequest.fromBuffer(value),
            ($1.HeatStintAnalysis value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.HeatCommandRequest, $3.Empty>(
        'Command',
        command_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.HeatCommandRequest.fromBuffer(value),
        ($3.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.StringValue, $1.HeatCommandPermissions>(
        'CommandPermissions',
        commandPermissions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.StringValue.fromBuffer(value),
        ($1.HeatCommandPermissions value) => value.writeToBuffer()));
  }

  $async.Stream<$1.Heat> subscribe_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.StringValue> $request) async* {
    yield* subscribe($call, await $request);
  }

  $async.Stream<$1.Heat> subscribe(
      $grpc.ServiceCall call, $0.StringValue request);

  $async.Stream<$1.HeatState> heatStateSubscribe_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.StringValue> $request) async* {
    yield* heatStateSubscribe($call, await $request);
  }

  $async.Stream<$1.HeatState> heatStateSubscribe(
      $grpc.ServiceCall call, $0.StringValue request);

  $async.Stream<$1.HeatLeaderboard> heatLeaderboardSubscribe_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.StringValue> $request) async* {
    yield* heatLeaderboardSubscribe($call, await $request);
  }

  $async.Stream<$1.HeatLeaderboard> heatLeaderboardSubscribe(
      $grpc.ServiceCall call, $0.StringValue request);

  $async.Stream<$1.HeatAnalyses> heatAnalysesSubscribe_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.StringValue> $request) async* {
    yield* heatAnalysesSubscribe($call, await $request);
  }

  $async.Stream<$1.HeatAnalyses> heatAnalysesSubscribe(
      $grpc.ServiceCall call, $0.StringValue request);

  $async.Stream<$1.HeatStintAnalysis> heatStintAnalysesSubscribe_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$2.HeatStintAnalysesRequest> $request) async* {
    yield* heatStintAnalysesSubscribe($call, await $request);
  }

  $async.Stream<$1.HeatStintAnalysis> heatStintAnalysesSubscribe(
      $grpc.ServiceCall call, $2.HeatStintAnalysesRequest request);

  $async.Future<$3.Empty> command_Pre($grpc.ServiceCall $call,
      $async.Future<$2.HeatCommandRequest> $request) async {
    return command($call, await $request);
  }

  $async.Future<$3.Empty> command(
      $grpc.ServiceCall call, $2.HeatCommandRequest request);

  $async.Future<$1.HeatCommandPermissions> commandPermissions_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.StringValue> $request) async {
    return commandPermissions($call, await $request);
  }

  $async.Future<$1.HeatCommandPermissions> commandPermissions(
      $grpc.ServiceCall call, $0.StringValue request);
}
