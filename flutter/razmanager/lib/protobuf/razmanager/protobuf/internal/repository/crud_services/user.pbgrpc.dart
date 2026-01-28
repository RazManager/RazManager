// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/user.proto.

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

import 'common.pb.dart' as $2;
import 'user.pb.dart' as $1;

export 'user.pb.dart';

@$pb.GrpcServiceName(
    'razmanager.protobuf.internal.repository.crud_services.user.UserService')
class UserServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  UserServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$1.UserReadResponse> read(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$read, request, options: options);
  }

  $grpc.ResponseFuture<$2.CreateResponse> create(
    $1.UserCreate request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$create, request, options: options);
  }

  $grpc.ResponseFuture<$2.UpdateResponse> update(
    $1.UserUpdateRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$update, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> delete(
    $2.EtagRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$delete, request, options: options);
  }

  // method descriptors

  static final _$read = $grpc.ClientMethod<$0.Empty, $1.UserReadResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.user.UserService/Read',
      ($0.Empty value) => value.writeToBuffer(),
      $1.UserReadResponse.fromBuffer);
  static final _$create = $grpc.ClientMethod<$1.UserCreate, $2.CreateResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.user.UserService/Create',
      ($1.UserCreate value) => value.writeToBuffer(),
      $2.CreateResponse.fromBuffer);
  static final _$update = $grpc.ClientMethod<$1.UserUpdateRequest,
          $2.UpdateResponse>(
      '/razmanager.protobuf.internal.repository.crud_services.user.UserService/Update',
      ($1.UserUpdateRequest value) => value.writeToBuffer(),
      $2.UpdateResponse.fromBuffer);
  static final _$delete = $grpc.ClientMethod<$2.EtagRequest, $0.Empty>(
      '/razmanager.protobuf.internal.repository.crud_services.user.UserService/Delete',
      ($2.EtagRequest value) => value.writeToBuffer(),
      $0.Empty.fromBuffer);
}

@$pb.GrpcServiceName(
    'razmanager.protobuf.internal.repository.crud_services.user.UserService')
abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name =>
      'razmanager.protobuf.internal.repository.crud_services.user.UserService';

  UserServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.UserReadResponse>(
        'Read',
        read_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.UserReadResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UserCreate, $2.CreateResponse>(
        'Create',
        create_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.UserCreate.fromBuffer(value),
        ($2.CreateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UserUpdateRequest, $2.UpdateResponse>(
        'Update',
        update_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.UserUpdateRequest.fromBuffer(value),
        ($2.UpdateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.EtagRequest, $0.Empty>(
        'Delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.EtagRequest.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$1.UserReadResponse> read_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return read($call, await $request);
  }

  $async.Future<$1.UserReadResponse> read(
      $grpc.ServiceCall call, $0.Empty request);

  $async.Future<$2.CreateResponse> create_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.UserCreate> $request) async {
    return create($call, await $request);
  }

  $async.Future<$2.CreateResponse> create(
      $grpc.ServiceCall call, $1.UserCreate request);

  $async.Future<$2.UpdateResponse> update_Pre($grpc.ServiceCall $call,
      $async.Future<$1.UserUpdateRequest> $request) async {
    return update($call, await $request);
  }

  $async.Future<$2.UpdateResponse> update(
      $grpc.ServiceCall call, $1.UserUpdateRequest request);

  $async.Future<$0.Empty> delete_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.EtagRequest> $request) async {
    return delete($call, await $request);
  }

  $async.Future<$0.Empty> delete(
      $grpc.ServiceCall call, $2.EtagRequest request);
}
