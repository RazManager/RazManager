// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/event.service.v1.proto.

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

import 'event.service.v1.pb.dart' as $2;
import 'event.v1.pb.dart' as $1;

export 'event.service.v1.pb.dart';

@$pb.GrpcServiceName('razmanager.protobuf.public.v1.EventService')
class EventServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  EventServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseStream<$1.Event> subscribe(
    $0.StringValue request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$subscribe, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$1.EventState> eventStateSubscribe(
    $0.StringValue request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$eventStateSubscribe, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$2.EventSpeech> eventUserSpeechSubscribe(
    $2.EventUserSpeechSubscribeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$eventUserSpeechSubscribe, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$2.EventSpeechSettingsReponse> eventSpeechSettings(
    $2.EventSpeechSettingsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$eventSpeechSettings, request, options: options);
  }

  // method descriptors

  static final _$subscribe = $grpc.ClientMethod<$0.StringValue, $1.Event>(
      '/razmanager.protobuf.public.v1.EventService/Subscribe',
      ($0.StringValue value) => value.writeToBuffer(),
      $1.Event.fromBuffer);
  static final _$eventStateSubscribe =
      $grpc.ClientMethod<$0.StringValue, $1.EventState>(
          '/razmanager.protobuf.public.v1.EventService/EventStateSubscribe',
          ($0.StringValue value) => value.writeToBuffer(),
          $1.EventState.fromBuffer);
  static final _$eventUserSpeechSubscribe = $grpc.ClientMethod<
          $2.EventUserSpeechSubscribeRequest, $2.EventSpeech>(
      '/razmanager.protobuf.public.v1.EventService/EventUserSpeechSubscribe',
      ($2.EventUserSpeechSubscribeRequest value) => value.writeToBuffer(),
      $2.EventSpeech.fromBuffer);
  static final _$eventSpeechSettings = $grpc.ClientMethod<
          $2.EventSpeechSettingsRequest, $2.EventSpeechSettingsReponse>(
      '/razmanager.protobuf.public.v1.EventService/EventSpeechSettings',
      ($2.EventSpeechSettingsRequest value) => value.writeToBuffer(),
      $2.EventSpeechSettingsReponse.fromBuffer);
}

@$pb.GrpcServiceName('razmanager.protobuf.public.v1.EventService')
abstract class EventServiceBase extends $grpc.Service {
  $core.String get $name => 'razmanager.protobuf.public.v1.EventService';

  EventServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.StringValue, $1.Event>(
        'Subscribe',
        subscribe_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.StringValue.fromBuffer(value),
        ($1.Event value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.StringValue, $1.EventState>(
        'EventStateSubscribe',
        eventStateSubscribe_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.StringValue.fromBuffer(value),
        ($1.EventState value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$2.EventUserSpeechSubscribeRequest, $2.EventSpeech>(
            'EventUserSpeechSubscribe',
            eventUserSpeechSubscribe_Pre,
            false,
            true,
            ($core.List<$core.int> value) =>
                $2.EventUserSpeechSubscribeRequest.fromBuffer(value),
            ($2.EventSpeech value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.EventSpeechSettingsRequest,
            $2.EventSpeechSettingsReponse>(
        'EventSpeechSettings',
        eventSpeechSettings_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.EventSpeechSettingsRequest.fromBuffer(value),
        ($2.EventSpeechSettingsReponse value) => value.writeToBuffer()));
  }

  $async.Stream<$1.Event> subscribe_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.StringValue> $request) async* {
    yield* subscribe($call, await $request);
  }

  $async.Stream<$1.Event> subscribe(
      $grpc.ServiceCall call, $0.StringValue request);

  $async.Stream<$1.EventState> eventStateSubscribe_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.StringValue> $request) async* {
    yield* eventStateSubscribe($call, await $request);
  }

  $async.Stream<$1.EventState> eventStateSubscribe(
      $grpc.ServiceCall call, $0.StringValue request);

  $async.Stream<$2.EventSpeech> eventUserSpeechSubscribe_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$2.EventUserSpeechSubscribeRequest> $request) async* {
    yield* eventUserSpeechSubscribe($call, await $request);
  }

  $async.Stream<$2.EventSpeech> eventUserSpeechSubscribe(
      $grpc.ServiceCall call, $2.EventUserSpeechSubscribeRequest request);

  $async.Future<$2.EventSpeechSettingsReponse> eventSpeechSettings_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$2.EventSpeechSettingsRequest> $request) async {
    return eventSpeechSettings($call, await $request);
  }

  $async.Future<$2.EventSpeechSettingsReponse> eventSpeechSettings(
      $grpc.ServiceCall call, $2.EventSpeechSettingsRequest request);
}
