// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/device_request_response.v1.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart'
    as $0;

import 'device_request_response.v1.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'device_request_response.v1.pbenum.dart';

enum DeviceRequest_Value {
  deviceConnectionRequest,
  deviceSystemInformationRequest,
  deviceSettingsReadRequest,
  deviceSettingsUpsertRequest,
  notSet
}

class DeviceRequest extends $pb.GeneratedMessage {
  factory DeviceRequest({
    $core.String? id,
    $core.String? correlationId,
    DeviceConnectionRequest? deviceConnectionRequest,
    DeviceSystemInformationRequest? deviceSystemInformationRequest,
    DeviceSettingsReadRequest? deviceSettingsReadRequest,
    DeviceSettingsUpsertRequest? deviceSettingsUpsertRequest,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (correlationId != null) result.correlationId = correlationId;
    if (deviceConnectionRequest != null)
      result.deviceConnectionRequest = deviceConnectionRequest;
    if (deviceSystemInformationRequest != null)
      result.deviceSystemInformationRequest = deviceSystemInformationRequest;
    if (deviceSettingsReadRequest != null)
      result.deviceSettingsReadRequest = deviceSettingsReadRequest;
    if (deviceSettingsUpsertRequest != null)
      result.deviceSettingsUpsertRequest = deviceSettingsUpsertRequest;
    return result;
  }

  DeviceRequest._();

  factory DeviceRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, DeviceRequest_Value>
      _DeviceRequest_ValueByTag = {
    3: DeviceRequest_Value.deviceConnectionRequest,
    4: DeviceRequest_Value.deviceSystemInformationRequest,
    5: DeviceRequest_Value.deviceSettingsReadRequest,
    6: DeviceRequest_Value.deviceSettingsUpsertRequest,
    0: DeviceRequest_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..oo(0, [3, 4, 5, 6])
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'correlationId')
    ..aOM<DeviceConnectionRequest>(
        3, _omitFieldNames ? '' : 'deviceConnectionRequest',
        subBuilder: DeviceConnectionRequest.create)
    ..aOM<DeviceSystemInformationRequest>(
        4, _omitFieldNames ? '' : 'deviceSystemInformationRequest',
        subBuilder: DeviceSystemInformationRequest.create)
    ..aOM<DeviceSettingsReadRequest>(
        5, _omitFieldNames ? '' : 'deviceSettingsReadRequest',
        subBuilder: DeviceSettingsReadRequest.create)
    ..aOM<DeviceSettingsUpsertRequest>(
        6, _omitFieldNames ? '' : 'deviceSettingsUpsertRequest',
        subBuilder: DeviceSettingsUpsertRequest.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceRequest copyWith(void Function(DeviceRequest) updates) =>
      super.copyWith((message) => updates(message as DeviceRequest))
          as DeviceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceRequest create() => DeviceRequest._();
  @$core.override
  DeviceRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceRequest>(create);
  static DeviceRequest? _defaultInstance;

  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  @$pb.TagNumber(6)
  DeviceRequest_Value whichValue() =>
      _DeviceRequest_ValueByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  @$pb.TagNumber(6)
  void clearValue() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get correlationId => $_getSZ(1);
  @$pb.TagNumber(2)
  set correlationId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCorrelationId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCorrelationId() => $_clearField(2);

  @$pb.TagNumber(3)
  DeviceConnectionRequest get deviceConnectionRequest => $_getN(2);
  @$pb.TagNumber(3)
  set deviceConnectionRequest(DeviceConnectionRequest value) =>
      $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDeviceConnectionRequest() => $_has(2);
  @$pb.TagNumber(3)
  void clearDeviceConnectionRequest() => $_clearField(3);
  @$pb.TagNumber(3)
  DeviceConnectionRequest ensureDeviceConnectionRequest() => $_ensure(2);

  @$pb.TagNumber(4)
  DeviceSystemInformationRequest get deviceSystemInformationRequest =>
      $_getN(3);
  @$pb.TagNumber(4)
  set deviceSystemInformationRequest(DeviceSystemInformationRequest value) =>
      $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasDeviceSystemInformationRequest() => $_has(3);
  @$pb.TagNumber(4)
  void clearDeviceSystemInformationRequest() => $_clearField(4);
  @$pb.TagNumber(4)
  DeviceSystemInformationRequest ensureDeviceSystemInformationRequest() =>
      $_ensure(3);

  @$pb.TagNumber(5)
  DeviceSettingsReadRequest get deviceSettingsReadRequest => $_getN(4);
  @$pb.TagNumber(5)
  set deviceSettingsReadRequest(DeviceSettingsReadRequest value) =>
      $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasDeviceSettingsReadRequest() => $_has(4);
  @$pb.TagNumber(5)
  void clearDeviceSettingsReadRequest() => $_clearField(5);
  @$pb.TagNumber(5)
  DeviceSettingsReadRequest ensureDeviceSettingsReadRequest() => $_ensure(4);

  @$pb.TagNumber(6)
  DeviceSettingsUpsertRequest get deviceSettingsUpsertRequest => $_getN(5);
  @$pb.TagNumber(6)
  set deviceSettingsUpsertRequest(DeviceSettingsUpsertRequest value) =>
      $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasDeviceSettingsUpsertRequest() => $_has(5);
  @$pb.TagNumber(6)
  void clearDeviceSettingsUpsertRequest() => $_clearField(6);
  @$pb.TagNumber(6)
  DeviceSettingsUpsertRequest ensureDeviceSettingsUpsertRequest() =>
      $_ensure(5);
}

enum DeviceResponse_Value {
  deviceConnectionResponse,
  deviceSystemInformationResponse,
  deviceSettingsResponse,
  notSet
}

class DeviceResponse extends $pb.GeneratedMessage {
  factory DeviceResponse({
    $core.String? correlationId,
    DeviceConnectionResponse? deviceConnectionResponse,
    DeviceSystemInformationResponse? deviceSystemInformationResponse,
    DeviceSettingsResponse? deviceSettingsResponse,
  }) {
    final result = create();
    if (correlationId != null) result.correlationId = correlationId;
    if (deviceConnectionResponse != null)
      result.deviceConnectionResponse = deviceConnectionResponse;
    if (deviceSystemInformationResponse != null)
      result.deviceSystemInformationResponse = deviceSystemInformationResponse;
    if (deviceSettingsResponse != null)
      result.deviceSettingsResponse = deviceSettingsResponse;
    return result;
  }

  DeviceResponse._();

  factory DeviceResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, DeviceResponse_Value>
      _DeviceResponse_ValueByTag = {
    3: DeviceResponse_Value.deviceConnectionResponse,
    4: DeviceResponse_Value.deviceSystemInformationResponse,
    5: DeviceResponse_Value.deviceSettingsResponse,
    0: DeviceResponse_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..oo(0, [3, 4, 5])
    ..aOS(2, _omitFieldNames ? '' : 'correlationId')
    ..aOM<DeviceConnectionResponse>(
        3, _omitFieldNames ? '' : 'deviceConnectionResponse',
        subBuilder: DeviceConnectionResponse.create)
    ..aOM<DeviceSystemInformationResponse>(
        4, _omitFieldNames ? '' : 'deviceSystemInformationResponse',
        subBuilder: DeviceSystemInformationResponse.create)
    ..aOM<DeviceSettingsResponse>(
        5, _omitFieldNames ? '' : 'deviceSettingsResponse',
        subBuilder: DeviceSettingsResponse.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceResponse copyWith(void Function(DeviceResponse) updates) =>
      super.copyWith((message) => updates(message as DeviceResponse))
          as DeviceResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceResponse create() => DeviceResponse._();
  @$core.override
  DeviceResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceResponse>(create);
  static DeviceResponse? _defaultInstance;

  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  DeviceResponse_Value whichValue() =>
      _DeviceResponse_ValueByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  void clearValue() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(2)
  $core.String get correlationId => $_getSZ(0);
  @$pb.TagNumber(2)
  set correlationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(2)
  $core.bool hasCorrelationId() => $_has(0);
  @$pb.TagNumber(2)
  void clearCorrelationId() => $_clearField(2);

  @$pb.TagNumber(3)
  DeviceConnectionResponse get deviceConnectionResponse => $_getN(1);
  @$pb.TagNumber(3)
  set deviceConnectionResponse(DeviceConnectionResponse value) =>
      $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDeviceConnectionResponse() => $_has(1);
  @$pb.TagNumber(3)
  void clearDeviceConnectionResponse() => $_clearField(3);
  @$pb.TagNumber(3)
  DeviceConnectionResponse ensureDeviceConnectionResponse() => $_ensure(1);

  @$pb.TagNumber(4)
  DeviceSystemInformationResponse get deviceSystemInformationResponse =>
      $_getN(2);
  @$pb.TagNumber(4)
  set deviceSystemInformationResponse(DeviceSystemInformationResponse value) =>
      $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasDeviceSystemInformationResponse() => $_has(2);
  @$pb.TagNumber(4)
  void clearDeviceSystemInformationResponse() => $_clearField(4);
  @$pb.TagNumber(4)
  DeviceSystemInformationResponse ensureDeviceSystemInformationResponse() =>
      $_ensure(2);

  @$pb.TagNumber(5)
  DeviceSettingsResponse get deviceSettingsResponse => $_getN(3);
  @$pb.TagNumber(5)
  set deviceSettingsResponse(DeviceSettingsResponse value) =>
      $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasDeviceSettingsResponse() => $_has(3);
  @$pb.TagNumber(5)
  void clearDeviceSettingsResponse() => $_clearField(5);
  @$pb.TagNumber(5)
  DeviceSettingsResponse ensureDeviceSettingsResponse() => $_ensure(3);
}

class DeviceConnectionRequest extends $pb.GeneratedMessage {
  factory DeviceConnectionRequest() => create();

  DeviceConnectionRequest._();

  factory DeviceConnectionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceConnectionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceConnectionRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceConnectionRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceConnectionRequest copyWith(
          void Function(DeviceConnectionRequest) updates) =>
      super.copyWith((message) => updates(message as DeviceConnectionRequest))
          as DeviceConnectionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceConnectionRequest create() => DeviceConnectionRequest._();
  @$core.override
  DeviceConnectionRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceConnectionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceConnectionRequest>(create);
  static DeviceConnectionRequest? _defaultInstance;
}

class DeviceConnectionResponse extends $pb.GeneratedMessage {
  factory DeviceConnectionResponse({
    $core.bool? connected,
  }) {
    final result = create();
    if (connected != null) result.connected = connected;
    return result;
  }

  DeviceConnectionResponse._();

  factory DeviceConnectionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceConnectionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceConnectionResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'connected')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceConnectionResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceConnectionResponse copyWith(
          void Function(DeviceConnectionResponse) updates) =>
      super.copyWith((message) => updates(message as DeviceConnectionResponse))
          as DeviceConnectionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceConnectionResponse create() => DeviceConnectionResponse._();
  @$core.override
  DeviceConnectionResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceConnectionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceConnectionResponse>(create);
  static DeviceConnectionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get connected => $_getBF(0);
  @$pb.TagNumber(1)
  set connected($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConnected() => $_has(0);
  @$pb.TagNumber(1)
  void clearConnected() => $_clearField(1);
}

class DeviceSystemInformationRequest extends $pb.GeneratedMessage {
  factory DeviceSystemInformationRequest() => create();

  DeviceSystemInformationRequest._();

  factory DeviceSystemInformationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceSystemInformationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceSystemInformationRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceSystemInformationRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceSystemInformationRequest copyWith(
          void Function(DeviceSystemInformationRequest) updates) =>
      super.copyWith(
              (message) => updates(message as DeviceSystemInformationRequest))
          as DeviceSystemInformationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceSystemInformationRequest create() =>
      DeviceSystemInformationRequest._();
  @$core.override
  DeviceSystemInformationRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceSystemInformationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceSystemInformationRequest>(create);
  static DeviceSystemInformationRequest? _defaultInstance;
}

class DeviceSystemInformationResponse extends $pb.GeneratedMessage {
  factory DeviceSystemInformationResponse({
    $0.StringValue? hardwareModel,
    $0.StringValue? hardwareProcessor,
    $0.StringValue? softwareAssemblyVersion,
    $0.StringValue? softwareSnapVersion,
    $0.StringValue? softwareDotNetVersion,
    $0.StringValue? softwareOsVersion,
    $0.StringValue? softwareOsReleaseVersion,
    $core.Iterable<$core.String>? serialPortNames,
  }) {
    final result = create();
    if (hardwareModel != null) result.hardwareModel = hardwareModel;
    if (hardwareProcessor != null) result.hardwareProcessor = hardwareProcessor;
    if (softwareAssemblyVersion != null)
      result.softwareAssemblyVersion = softwareAssemblyVersion;
    if (softwareSnapVersion != null)
      result.softwareSnapVersion = softwareSnapVersion;
    if (softwareDotNetVersion != null)
      result.softwareDotNetVersion = softwareDotNetVersion;
    if (softwareOsVersion != null) result.softwareOsVersion = softwareOsVersion;
    if (softwareOsReleaseVersion != null)
      result.softwareOsReleaseVersion = softwareOsReleaseVersion;
    if (serialPortNames != null) result.serialPortNames.addAll(serialPortNames);
    return result;
  }

  DeviceSystemInformationResponse._();

  factory DeviceSystemInformationResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceSystemInformationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceSystemInformationResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOM<$0.StringValue>(1, _omitFieldNames ? '' : 'hardwareModel',
        subBuilder: $0.StringValue.create)
    ..aOM<$0.StringValue>(2, _omitFieldNames ? '' : 'hardwareProcessor',
        subBuilder: $0.StringValue.create)
    ..aOM<$0.StringValue>(3, _omitFieldNames ? '' : 'softwareAssemblyVersion',
        subBuilder: $0.StringValue.create)
    ..aOM<$0.StringValue>(4, _omitFieldNames ? '' : 'softwareSnapVersion',
        subBuilder: $0.StringValue.create)
    ..aOM<$0.StringValue>(5, _omitFieldNames ? '' : 'softwareDotNetVersion',
        subBuilder: $0.StringValue.create)
    ..aOM<$0.StringValue>(6, _omitFieldNames ? '' : 'softwareOsVersion',
        subBuilder: $0.StringValue.create)
    ..aOM<$0.StringValue>(7, _omitFieldNames ? '' : 'softwareOsReleaseVersion',
        subBuilder: $0.StringValue.create)
    ..pPS(8, _omitFieldNames ? '' : 'serialPortNames')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceSystemInformationResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceSystemInformationResponse copyWith(
          void Function(DeviceSystemInformationResponse) updates) =>
      super.copyWith(
              (message) => updates(message as DeviceSystemInformationResponse))
          as DeviceSystemInformationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceSystemInformationResponse create() =>
      DeviceSystemInformationResponse._();
  @$core.override
  DeviceSystemInformationResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceSystemInformationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceSystemInformationResponse>(
          create);
  static DeviceSystemInformationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $0.StringValue get hardwareModel => $_getN(0);
  @$pb.TagNumber(1)
  set hardwareModel($0.StringValue value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasHardwareModel() => $_has(0);
  @$pb.TagNumber(1)
  void clearHardwareModel() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.StringValue ensureHardwareModel() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.StringValue get hardwareProcessor => $_getN(1);
  @$pb.TagNumber(2)
  set hardwareProcessor($0.StringValue value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasHardwareProcessor() => $_has(1);
  @$pb.TagNumber(2)
  void clearHardwareProcessor() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.StringValue ensureHardwareProcessor() => $_ensure(1);

  @$pb.TagNumber(3)
  $0.StringValue get softwareAssemblyVersion => $_getN(2);
  @$pb.TagNumber(3)
  set softwareAssemblyVersion($0.StringValue value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSoftwareAssemblyVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearSoftwareAssemblyVersion() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.StringValue ensureSoftwareAssemblyVersion() => $_ensure(2);

  @$pb.TagNumber(4)
  $0.StringValue get softwareSnapVersion => $_getN(3);
  @$pb.TagNumber(4)
  set softwareSnapVersion($0.StringValue value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasSoftwareSnapVersion() => $_has(3);
  @$pb.TagNumber(4)
  void clearSoftwareSnapVersion() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.StringValue ensureSoftwareSnapVersion() => $_ensure(3);

  @$pb.TagNumber(5)
  $0.StringValue get softwareDotNetVersion => $_getN(4);
  @$pb.TagNumber(5)
  set softwareDotNetVersion($0.StringValue value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasSoftwareDotNetVersion() => $_has(4);
  @$pb.TagNumber(5)
  void clearSoftwareDotNetVersion() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.StringValue ensureSoftwareDotNetVersion() => $_ensure(4);

  @$pb.TagNumber(6)
  $0.StringValue get softwareOsVersion => $_getN(5);
  @$pb.TagNumber(6)
  set softwareOsVersion($0.StringValue value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasSoftwareOsVersion() => $_has(5);
  @$pb.TagNumber(6)
  void clearSoftwareOsVersion() => $_clearField(6);
  @$pb.TagNumber(6)
  $0.StringValue ensureSoftwareOsVersion() => $_ensure(5);

  @$pb.TagNumber(7)
  $0.StringValue get softwareOsReleaseVersion => $_getN(6);
  @$pb.TagNumber(7)
  set softwareOsReleaseVersion($0.StringValue value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasSoftwareOsReleaseVersion() => $_has(6);
  @$pb.TagNumber(7)
  void clearSoftwareOsReleaseVersion() => $_clearField(7);
  @$pb.TagNumber(7)
  $0.StringValue ensureSoftwareOsReleaseVersion() => $_ensure(6);

  @$pb.TagNumber(8)
  $pb.PbList<$core.String> get serialPortNames => $_getList(7);
}

class DeviceSettingsReadRequest extends $pb.GeneratedMessage {
  factory DeviceSettingsReadRequest() => create();

  DeviceSettingsReadRequest._();

  factory DeviceSettingsReadRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceSettingsReadRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceSettingsReadRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceSettingsReadRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceSettingsReadRequest copyWith(
          void Function(DeviceSettingsReadRequest) updates) =>
      super.copyWith((message) => updates(message as DeviceSettingsReadRequest))
          as DeviceSettingsReadRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceSettingsReadRequest create() => DeviceSettingsReadRequest._();
  @$core.override
  DeviceSettingsReadRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceSettingsReadRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceSettingsReadRequest>(create);
  static DeviceSettingsReadRequest? _defaultInstance;
}

class DeviceSettingsUpsertRequest extends $pb.GeneratedMessage {
  factory DeviceSettingsUpsertRequest({
    DeviceSettings? deviceSettings,
  }) {
    final result = create();
    if (deviceSettings != null) result.deviceSettings = deviceSettings;
    return result;
  }

  DeviceSettingsUpsertRequest._();

  factory DeviceSettingsUpsertRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceSettingsUpsertRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceSettingsUpsertRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOM<DeviceSettings>(1, _omitFieldNames ? '' : 'deviceSettings',
        subBuilder: DeviceSettings.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceSettingsUpsertRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceSettingsUpsertRequest copyWith(
          void Function(DeviceSettingsUpsertRequest) updates) =>
      super.copyWith(
              (message) => updates(message as DeviceSettingsUpsertRequest))
          as DeviceSettingsUpsertRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceSettingsUpsertRequest create() =>
      DeviceSettingsUpsertRequest._();
  @$core.override
  DeviceSettingsUpsertRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceSettingsUpsertRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceSettingsUpsertRequest>(create);
  static DeviceSettingsUpsertRequest? _defaultInstance;

  @$pb.TagNumber(1)
  DeviceSettings get deviceSettings => $_getN(0);
  @$pb.TagNumber(1)
  set deviceSettings(DeviceSettings value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDeviceSettings() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceSettings() => $_clearField(1);
  @$pb.TagNumber(1)
  DeviceSettings ensureDeviceSettings() => $_ensure(0);
}

class DeviceSettingsResponse extends $pb.GeneratedMessage {
  factory DeviceSettingsResponse({
    DeviceSettings? deviceSettings,
  }) {
    final result = create();
    if (deviceSettings != null) result.deviceSettings = deviceSettings;
    return result;
  }

  DeviceSettingsResponse._();

  factory DeviceSettingsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceSettingsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceSettingsResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOM<DeviceSettings>(1, _omitFieldNames ? '' : 'deviceSettings',
        subBuilder: DeviceSettings.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceSettingsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceSettingsResponse copyWith(
          void Function(DeviceSettingsResponse) updates) =>
      super.copyWith((message) => updates(message as DeviceSettingsResponse))
          as DeviceSettingsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceSettingsResponse create() => DeviceSettingsResponse._();
  @$core.override
  DeviceSettingsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceSettingsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceSettingsResponse>(create);
  static DeviceSettingsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  DeviceSettings get deviceSettings => $_getN(0);
  @$pb.TagNumber(1)
  set deviceSettings(DeviceSettings value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDeviceSettings() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceSettings() => $_clearField(1);
  @$pb.TagNumber(1)
  DeviceSettings ensureDeviceSettings() => $_ensure(0);
}

class DeviceSettings extends $pb.GeneratedMessage {
  factory DeviceSettings({
    $core.Iterable<DeviceConfigurationSettings>? deviceConfigurationSettings,
  }) {
    final result = create();
    if (deviceConfigurationSettings != null)
      result.deviceConfigurationSettings.addAll(deviceConfigurationSettings);
    return result;
  }

  DeviceSettings._();

  factory DeviceSettings.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceSettings.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceSettings',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..pPM<DeviceConfigurationSettings>(
        1, _omitFieldNames ? '' : 'deviceConfigurationSettings',
        subBuilder: DeviceConfigurationSettings.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceSettings clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceSettings copyWith(void Function(DeviceSettings) updates) =>
      super.copyWith((message) => updates(message as DeviceSettings))
          as DeviceSettings;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceSettings create() => DeviceSettings._();
  @$core.override
  DeviceSettings createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceSettings getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceSettings>(create);
  static DeviceSettings? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<DeviceConfigurationSettings> get deviceConfigurationSettings =>
      $_getList(0);
}

class DeviceConfigurationSettings extends $pb.GeneratedMessage {
  factory DeviceConfigurationSettings({
    $core.String? id,
    $core.String? name,
    $core.Iterable<DeviceIntegration>? deviceIntegrations,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (deviceIntegrations != null)
      result.deviceIntegrations.addAll(deviceIntegrations);
    return result;
  }

  DeviceConfigurationSettings._();

  factory DeviceConfigurationSettings.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceConfigurationSettings.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceConfigurationSettings',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..pPM<DeviceIntegration>(3, _omitFieldNames ? '' : 'deviceIntegrations',
        subBuilder: DeviceIntegration.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceConfigurationSettings clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceConfigurationSettings copyWith(
          void Function(DeviceConfigurationSettings) updates) =>
      super.copyWith(
              (message) => updates(message as DeviceConfigurationSettings))
          as DeviceConfigurationSettings;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceConfigurationSettings create() =>
      DeviceConfigurationSettings._();
  @$core.override
  DeviceConfigurationSettings createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceConfigurationSettings getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceConfigurationSettings>(create);
  static DeviceConfigurationSettings? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<DeviceIntegration> get deviceIntegrations => $_getList(2);
}

enum DeviceIntegration_Value {
  deviceIntegrationGpio,
  deviceIntegrationOxigen,
  deviceIntegrationScalextricArc,
  deviceIntegrationScalextricApb,
  deviceIntegrationScalextricPitPro,
  deviceIntegrationPhilipsHue,
  deviceIntegrationRgb,
  deviceIntegrationLapMaster,
  deviceIntegrationChronoLog,
  deviceIntegrationPerformanceTest,
  notSet
}

class DeviceIntegration extends $pb.GeneratedMessage {
  factory DeviceIntegration({
    DeviceIntegrationGpio? deviceIntegrationGpio,
    DeviceIntegrationOxigen? deviceIntegrationOxigen,
    DeviceIntegrationScalextricArc? deviceIntegrationScalextricArc,
    DeviceIntegrationScalextricApb? deviceIntegrationScalextricApb,
    DeviceIntegrationScalextricPitPro? deviceIntegrationScalextricPitPro,
    DeviceIntegrationPhilipsHue? deviceIntegrationPhilipsHue,
    DeviceIntegrationRgb? deviceIntegrationRgb,
    DeviceIntegrationLapMaster? deviceIntegrationLapMaster,
    DeviceIntegrationChronoLog? deviceIntegrationChronoLog,
    DeviceIntegrationPerformanceTest? deviceIntegrationPerformanceTest,
  }) {
    final result = create();
    if (deviceIntegrationGpio != null)
      result.deviceIntegrationGpio = deviceIntegrationGpio;
    if (deviceIntegrationOxigen != null)
      result.deviceIntegrationOxigen = deviceIntegrationOxigen;
    if (deviceIntegrationScalextricArc != null)
      result.deviceIntegrationScalextricArc = deviceIntegrationScalextricArc;
    if (deviceIntegrationScalextricApb != null)
      result.deviceIntegrationScalextricApb = deviceIntegrationScalextricApb;
    if (deviceIntegrationScalextricPitPro != null)
      result.deviceIntegrationScalextricPitPro =
          deviceIntegrationScalextricPitPro;
    if (deviceIntegrationPhilipsHue != null)
      result.deviceIntegrationPhilipsHue = deviceIntegrationPhilipsHue;
    if (deviceIntegrationRgb != null)
      result.deviceIntegrationRgb = deviceIntegrationRgb;
    if (deviceIntegrationLapMaster != null)
      result.deviceIntegrationLapMaster = deviceIntegrationLapMaster;
    if (deviceIntegrationChronoLog != null)
      result.deviceIntegrationChronoLog = deviceIntegrationChronoLog;
    if (deviceIntegrationPerformanceTest != null)
      result.deviceIntegrationPerformanceTest =
          deviceIntegrationPerformanceTest;
    return result;
  }

  DeviceIntegration._();

  factory DeviceIntegration.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceIntegration.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, DeviceIntegration_Value>
      _DeviceIntegration_ValueByTag = {
    1: DeviceIntegration_Value.deviceIntegrationGpio,
    2: DeviceIntegration_Value.deviceIntegrationOxigen,
    3: DeviceIntegration_Value.deviceIntegrationScalextricArc,
    4: DeviceIntegration_Value.deviceIntegrationScalextricApb,
    5: DeviceIntegration_Value.deviceIntegrationScalextricPitPro,
    6: DeviceIntegration_Value.deviceIntegrationPhilipsHue,
    7: DeviceIntegration_Value.deviceIntegrationRgb,
    8: DeviceIntegration_Value.deviceIntegrationLapMaster,
    100: DeviceIntegration_Value.deviceIntegrationChronoLog,
    101: DeviceIntegration_Value.deviceIntegrationPerformanceTest,
    0: DeviceIntegration_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceIntegration',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6, 7, 8, 100, 101])
    ..aOM<DeviceIntegrationGpio>(
        1, _omitFieldNames ? '' : 'deviceIntegrationGpio',
        subBuilder: DeviceIntegrationGpio.create)
    ..aOM<DeviceIntegrationOxigen>(
        2, _omitFieldNames ? '' : 'deviceIntegrationOxigen',
        subBuilder: DeviceIntegrationOxigen.create)
    ..aOM<DeviceIntegrationScalextricArc>(
        3, _omitFieldNames ? '' : 'deviceIntegrationScalextricArc',
        subBuilder: DeviceIntegrationScalextricArc.create)
    ..aOM<DeviceIntegrationScalextricApb>(
        4, _omitFieldNames ? '' : 'deviceIntegrationScalextricApb',
        subBuilder: DeviceIntegrationScalextricApb.create)
    ..aOM<DeviceIntegrationScalextricPitPro>(
        5, _omitFieldNames ? '' : 'deviceIntegrationScalextricPitPro',
        subBuilder: DeviceIntegrationScalextricPitPro.create)
    ..aOM<DeviceIntegrationPhilipsHue>(
        6, _omitFieldNames ? '' : 'deviceIntegrationPhilipsHue',
        subBuilder: DeviceIntegrationPhilipsHue.create)
    ..aOM<DeviceIntegrationRgb>(
        7, _omitFieldNames ? '' : 'deviceIntegrationRgb',
        subBuilder: DeviceIntegrationRgb.create)
    ..aOM<DeviceIntegrationLapMaster>(
        8, _omitFieldNames ? '' : 'deviceIntegrationLapMaster',
        subBuilder: DeviceIntegrationLapMaster.create)
    ..aOM<DeviceIntegrationChronoLog>(
        100, _omitFieldNames ? '' : 'deviceIntegrationChronoLog',
        subBuilder: DeviceIntegrationChronoLog.create)
    ..aOM<DeviceIntegrationPerformanceTest>(
        101, _omitFieldNames ? '' : 'deviceIntegrationPerformanceTest',
        subBuilder: DeviceIntegrationPerformanceTest.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceIntegration clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceIntegration copyWith(void Function(DeviceIntegration) updates) =>
      super.copyWith((message) => updates(message as DeviceIntegration))
          as DeviceIntegration;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceIntegration create() => DeviceIntegration._();
  @$core.override
  DeviceIntegration createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceIntegration getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceIntegration>(create);
  static DeviceIntegration? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  @$pb.TagNumber(6)
  @$pb.TagNumber(7)
  @$pb.TagNumber(8)
  @$pb.TagNumber(100)
  @$pb.TagNumber(101)
  DeviceIntegration_Value whichValue() =>
      _DeviceIntegration_ValueByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  @$pb.TagNumber(6)
  @$pb.TagNumber(7)
  @$pb.TagNumber(8)
  @$pb.TagNumber(100)
  @$pb.TagNumber(101)
  void clearValue() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  DeviceIntegrationGpio get deviceIntegrationGpio => $_getN(0);
  @$pb.TagNumber(1)
  set deviceIntegrationGpio(DeviceIntegrationGpio value) =>
      $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDeviceIntegrationGpio() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceIntegrationGpio() => $_clearField(1);
  @$pb.TagNumber(1)
  DeviceIntegrationGpio ensureDeviceIntegrationGpio() => $_ensure(0);

  @$pb.TagNumber(2)
  DeviceIntegrationOxigen get deviceIntegrationOxigen => $_getN(1);
  @$pb.TagNumber(2)
  set deviceIntegrationOxigen(DeviceIntegrationOxigen value) =>
      $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasDeviceIntegrationOxigen() => $_has(1);
  @$pb.TagNumber(2)
  void clearDeviceIntegrationOxigen() => $_clearField(2);
  @$pb.TagNumber(2)
  DeviceIntegrationOxigen ensureDeviceIntegrationOxigen() => $_ensure(1);

  @$pb.TagNumber(3)
  DeviceIntegrationScalextricArc get deviceIntegrationScalextricArc =>
      $_getN(2);
  @$pb.TagNumber(3)
  set deviceIntegrationScalextricArc(DeviceIntegrationScalextricArc value) =>
      $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDeviceIntegrationScalextricArc() => $_has(2);
  @$pb.TagNumber(3)
  void clearDeviceIntegrationScalextricArc() => $_clearField(3);
  @$pb.TagNumber(3)
  DeviceIntegrationScalextricArc ensureDeviceIntegrationScalextricArc() =>
      $_ensure(2);

  @$pb.TagNumber(4)
  DeviceIntegrationScalextricApb get deviceIntegrationScalextricApb =>
      $_getN(3);
  @$pb.TagNumber(4)
  set deviceIntegrationScalextricApb(DeviceIntegrationScalextricApb value) =>
      $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasDeviceIntegrationScalextricApb() => $_has(3);
  @$pb.TagNumber(4)
  void clearDeviceIntegrationScalextricApb() => $_clearField(4);
  @$pb.TagNumber(4)
  DeviceIntegrationScalextricApb ensureDeviceIntegrationScalextricApb() =>
      $_ensure(3);

  @$pb.TagNumber(5)
  DeviceIntegrationScalextricPitPro get deviceIntegrationScalextricPitPro =>
      $_getN(4);
  @$pb.TagNumber(5)
  set deviceIntegrationScalextricPitPro(
          DeviceIntegrationScalextricPitPro value) =>
      $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasDeviceIntegrationScalextricPitPro() => $_has(4);
  @$pb.TagNumber(5)
  void clearDeviceIntegrationScalextricPitPro() => $_clearField(5);
  @$pb.TagNumber(5)
  DeviceIntegrationScalextricPitPro ensureDeviceIntegrationScalextricPitPro() =>
      $_ensure(4);

  @$pb.TagNumber(6)
  DeviceIntegrationPhilipsHue get deviceIntegrationPhilipsHue => $_getN(5);
  @$pb.TagNumber(6)
  set deviceIntegrationPhilipsHue(DeviceIntegrationPhilipsHue value) =>
      $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasDeviceIntegrationPhilipsHue() => $_has(5);
  @$pb.TagNumber(6)
  void clearDeviceIntegrationPhilipsHue() => $_clearField(6);
  @$pb.TagNumber(6)
  DeviceIntegrationPhilipsHue ensureDeviceIntegrationPhilipsHue() =>
      $_ensure(5);

  @$pb.TagNumber(7)
  DeviceIntegrationRgb get deviceIntegrationRgb => $_getN(6);
  @$pb.TagNumber(7)
  set deviceIntegrationRgb(DeviceIntegrationRgb value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasDeviceIntegrationRgb() => $_has(6);
  @$pb.TagNumber(7)
  void clearDeviceIntegrationRgb() => $_clearField(7);
  @$pb.TagNumber(7)
  DeviceIntegrationRgb ensureDeviceIntegrationRgb() => $_ensure(6);

  @$pb.TagNumber(8)
  DeviceIntegrationLapMaster get deviceIntegrationLapMaster => $_getN(7);
  @$pb.TagNumber(8)
  set deviceIntegrationLapMaster(DeviceIntegrationLapMaster value) =>
      $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasDeviceIntegrationLapMaster() => $_has(7);
  @$pb.TagNumber(8)
  void clearDeviceIntegrationLapMaster() => $_clearField(8);
  @$pb.TagNumber(8)
  DeviceIntegrationLapMaster ensureDeviceIntegrationLapMaster() => $_ensure(7);

  @$pb.TagNumber(100)
  DeviceIntegrationChronoLog get deviceIntegrationChronoLog => $_getN(8);
  @$pb.TagNumber(100)
  set deviceIntegrationChronoLog(DeviceIntegrationChronoLog value) =>
      $_setField(100, value);
  @$pb.TagNumber(100)
  $core.bool hasDeviceIntegrationChronoLog() => $_has(8);
  @$pb.TagNumber(100)
  void clearDeviceIntegrationChronoLog() => $_clearField(100);
  @$pb.TagNumber(100)
  DeviceIntegrationChronoLog ensureDeviceIntegrationChronoLog() => $_ensure(8);

  @$pb.TagNumber(101)
  DeviceIntegrationPerformanceTest get deviceIntegrationPerformanceTest =>
      $_getN(9);
  @$pb.TagNumber(101)
  set deviceIntegrationPerformanceTest(
          DeviceIntegrationPerformanceTest value) =>
      $_setField(101, value);
  @$pb.TagNumber(101)
  $core.bool hasDeviceIntegrationPerformanceTest() => $_has(9);
  @$pb.TagNumber(101)
  void clearDeviceIntegrationPerformanceTest() => $_clearField(101);
  @$pb.TagNumber(101)
  DeviceIntegrationPerformanceTest ensureDeviceIntegrationPerformanceTest() =>
      $_ensure(9);
}

class DeviceIntegrationGpio extends $pb.GeneratedMessage {
  factory DeviceIntegrationGpio() => create();

  DeviceIntegrationGpio._();

  factory DeviceIntegrationGpio.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceIntegrationGpio.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceIntegrationGpio',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceIntegrationGpio clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceIntegrationGpio copyWith(
          void Function(DeviceIntegrationGpio) updates) =>
      super.copyWith((message) => updates(message as DeviceIntegrationGpio))
          as DeviceIntegrationGpio;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceIntegrationGpio create() => DeviceIntegrationGpio._();
  @$core.override
  DeviceIntegrationGpio createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceIntegrationGpio getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceIntegrationGpio>(create);
  static DeviceIntegrationGpio? _defaultInstance;
}

class DeviceIntegrationOxigen extends $pb.GeneratedMessage {
  factory DeviceIntegrationOxigen({
    $core.String? serialPortName,
    OxigenRxLapTimeTypeId? oxigenRxLapTimeTypeId,
    OxigenTxPitLaneLapCountingTypeId? oxigenTxPitLaneLapCountingTypeId,
    OxigenTxPitLaneLapTriggerTypeId? oxigenTxPitLaneLapTriggerTypeId,
    $core.int? maxControllerId,
  }) {
    final result = create();
    if (serialPortName != null) result.serialPortName = serialPortName;
    if (oxigenRxLapTimeTypeId != null)
      result.oxigenRxLapTimeTypeId = oxigenRxLapTimeTypeId;
    if (oxigenTxPitLaneLapCountingTypeId != null)
      result.oxigenTxPitLaneLapCountingTypeId =
          oxigenTxPitLaneLapCountingTypeId;
    if (oxigenTxPitLaneLapTriggerTypeId != null)
      result.oxigenTxPitLaneLapTriggerTypeId = oxigenTxPitLaneLapTriggerTypeId;
    if (maxControllerId != null) result.maxControllerId = maxControllerId;
    return result;
  }

  DeviceIntegrationOxigen._();

  factory DeviceIntegrationOxigen.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceIntegrationOxigen.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceIntegrationOxigen',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'serialPortName')
    ..aE<OxigenRxLapTimeTypeId>(
        2, _omitFieldNames ? '' : 'oxigenRxLapTimeTypeId',
        enumValues: OxigenRxLapTimeTypeId.values)
    ..aE<OxigenTxPitLaneLapCountingTypeId>(
        3, _omitFieldNames ? '' : 'oxigenTxPitLaneLapCountingTypeId',
        enumValues: OxigenTxPitLaneLapCountingTypeId.values)
    ..aE<OxigenTxPitLaneLapTriggerTypeId>(
        4, _omitFieldNames ? '' : 'oxigenTxPitLaneLapTriggerTypeId',
        enumValues: OxigenTxPitLaneLapTriggerTypeId.values)
    ..aI(5, _omitFieldNames ? '' : 'maxControllerId',
        fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceIntegrationOxigen clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceIntegrationOxigen copyWith(
          void Function(DeviceIntegrationOxigen) updates) =>
      super.copyWith((message) => updates(message as DeviceIntegrationOxigen))
          as DeviceIntegrationOxigen;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceIntegrationOxigen create() => DeviceIntegrationOxigen._();
  @$core.override
  DeviceIntegrationOxigen createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceIntegrationOxigen getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceIntegrationOxigen>(create);
  static DeviceIntegrationOxigen? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get serialPortName => $_getSZ(0);
  @$pb.TagNumber(1)
  set serialPortName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSerialPortName() => $_has(0);
  @$pb.TagNumber(1)
  void clearSerialPortName() => $_clearField(1);

  @$pb.TagNumber(2)
  OxigenRxLapTimeTypeId get oxigenRxLapTimeTypeId => $_getN(1);
  @$pb.TagNumber(2)
  set oxigenRxLapTimeTypeId(OxigenRxLapTimeTypeId value) =>
      $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasOxigenRxLapTimeTypeId() => $_has(1);
  @$pb.TagNumber(2)
  void clearOxigenRxLapTimeTypeId() => $_clearField(2);

  @$pb.TagNumber(3)
  OxigenTxPitLaneLapCountingTypeId get oxigenTxPitLaneLapCountingTypeId =>
      $_getN(2);
  @$pb.TagNumber(3)
  set oxigenTxPitLaneLapCountingTypeId(
          OxigenTxPitLaneLapCountingTypeId value) =>
      $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasOxigenTxPitLaneLapCountingTypeId() => $_has(2);
  @$pb.TagNumber(3)
  void clearOxigenTxPitLaneLapCountingTypeId() => $_clearField(3);

  @$pb.TagNumber(4)
  OxigenTxPitLaneLapTriggerTypeId get oxigenTxPitLaneLapTriggerTypeId =>
      $_getN(3);
  @$pb.TagNumber(4)
  set oxigenTxPitLaneLapTriggerTypeId(OxigenTxPitLaneLapTriggerTypeId value) =>
      $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasOxigenTxPitLaneLapTriggerTypeId() => $_has(3);
  @$pb.TagNumber(4)
  void clearOxigenTxPitLaneLapTriggerTypeId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get maxControllerId => $_getIZ(4);
  @$pb.TagNumber(5)
  set maxControllerId($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMaxControllerId() => $_has(4);
  @$pb.TagNumber(5)
  void clearMaxControllerId() => $_clearField(5);
}

class DeviceIntegrationScalextricArc extends $pb.GeneratedMessage {
  factory DeviceIntegrationScalextricArc() => create();

  DeviceIntegrationScalextricArc._();

  factory DeviceIntegrationScalextricArc.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceIntegrationScalextricArc.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceIntegrationScalextricArc',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceIntegrationScalextricArc clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceIntegrationScalextricArc copyWith(
          void Function(DeviceIntegrationScalextricArc) updates) =>
      super.copyWith(
              (message) => updates(message as DeviceIntegrationScalextricArc))
          as DeviceIntegrationScalextricArc;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceIntegrationScalextricArc create() =>
      DeviceIntegrationScalextricArc._();
  @$core.override
  DeviceIntegrationScalextricArc createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceIntegrationScalextricArc getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceIntegrationScalextricArc>(create);
  static DeviceIntegrationScalextricArc? _defaultInstance;
}

class DeviceIntegrationScalextricApb extends $pb.GeneratedMessage {
  factory DeviceIntegrationScalextricApb({
    $core.String? serialPortName,
  }) {
    final result = create();
    if (serialPortName != null) result.serialPortName = serialPortName;
    return result;
  }

  DeviceIntegrationScalextricApb._();

  factory DeviceIntegrationScalextricApb.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceIntegrationScalextricApb.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceIntegrationScalextricApb',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'serialPortName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceIntegrationScalextricApb clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceIntegrationScalextricApb copyWith(
          void Function(DeviceIntegrationScalextricApb) updates) =>
      super.copyWith(
              (message) => updates(message as DeviceIntegrationScalextricApb))
          as DeviceIntegrationScalextricApb;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceIntegrationScalextricApb create() =>
      DeviceIntegrationScalextricApb._();
  @$core.override
  DeviceIntegrationScalextricApb createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceIntegrationScalextricApb getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceIntegrationScalextricApb>(create);
  static DeviceIntegrationScalextricApb? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get serialPortName => $_getSZ(0);
  @$pb.TagNumber(1)
  set serialPortName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSerialPortName() => $_has(0);
  @$pb.TagNumber(1)
  void clearSerialPortName() => $_clearField(1);
}

class DeviceIntegrationScalextricPitPro extends $pb.GeneratedMessage {
  factory DeviceIntegrationScalextricPitPro({
    $core.String? serialPortName,
  }) {
    final result = create();
    if (serialPortName != null) result.serialPortName = serialPortName;
    return result;
  }

  DeviceIntegrationScalextricPitPro._();

  factory DeviceIntegrationScalextricPitPro.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceIntegrationScalextricPitPro.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceIntegrationScalextricPitPro',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'serialPortName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceIntegrationScalextricPitPro clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceIntegrationScalextricPitPro copyWith(
          void Function(DeviceIntegrationScalextricPitPro) updates) =>
      super.copyWith((message) =>
              updates(message as DeviceIntegrationScalextricPitPro))
          as DeviceIntegrationScalextricPitPro;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceIntegrationScalextricPitPro create() =>
      DeviceIntegrationScalextricPitPro._();
  @$core.override
  DeviceIntegrationScalextricPitPro createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceIntegrationScalextricPitPro getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceIntegrationScalextricPitPro>(
          create);
  static DeviceIntegrationScalextricPitPro? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get serialPortName => $_getSZ(0);
  @$pb.TagNumber(1)
  set serialPortName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSerialPortName() => $_has(0);
  @$pb.TagNumber(1)
  void clearSerialPortName() => $_clearField(1);
}

class DeviceIntegrationPhilipsHue extends $pb.GeneratedMessage {
  factory DeviceIntegrationPhilipsHue() => create();

  DeviceIntegrationPhilipsHue._();

  factory DeviceIntegrationPhilipsHue.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceIntegrationPhilipsHue.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceIntegrationPhilipsHue',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceIntegrationPhilipsHue clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceIntegrationPhilipsHue copyWith(
          void Function(DeviceIntegrationPhilipsHue) updates) =>
      super.copyWith(
              (message) => updates(message as DeviceIntegrationPhilipsHue))
          as DeviceIntegrationPhilipsHue;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceIntegrationPhilipsHue create() =>
      DeviceIntegrationPhilipsHue._();
  @$core.override
  DeviceIntegrationPhilipsHue createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceIntegrationPhilipsHue getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceIntegrationPhilipsHue>(create);
  static DeviceIntegrationPhilipsHue? _defaultInstance;
}

class DeviceIntegrationRgb extends $pb.GeneratedMessage {
  factory DeviceIntegrationRgb() => create();

  DeviceIntegrationRgb._();

  factory DeviceIntegrationRgb.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceIntegrationRgb.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceIntegrationRgb',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceIntegrationRgb clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceIntegrationRgb copyWith(void Function(DeviceIntegrationRgb) updates) =>
      super.copyWith((message) => updates(message as DeviceIntegrationRgb))
          as DeviceIntegrationRgb;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceIntegrationRgb create() => DeviceIntegrationRgb._();
  @$core.override
  DeviceIntegrationRgb createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceIntegrationRgb getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceIntegrationRgb>(create);
  static DeviceIntegrationRgb? _defaultInstance;
}

class DeviceIntegrationLapMaster extends $pb.GeneratedMessage {
  factory DeviceIntegrationLapMaster({
    $core.String? serialPortName,
    $core.int? lanes,
  }) {
    final result = create();
    if (serialPortName != null) result.serialPortName = serialPortName;
    if (lanes != null) result.lanes = lanes;
    return result;
  }

  DeviceIntegrationLapMaster._();

  factory DeviceIntegrationLapMaster.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceIntegrationLapMaster.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceIntegrationLapMaster',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'serialPortName')
    ..aI(2, _omitFieldNames ? '' : 'lanes', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceIntegrationLapMaster clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceIntegrationLapMaster copyWith(
          void Function(DeviceIntegrationLapMaster) updates) =>
      super.copyWith(
              (message) => updates(message as DeviceIntegrationLapMaster))
          as DeviceIntegrationLapMaster;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceIntegrationLapMaster create() => DeviceIntegrationLapMaster._();
  @$core.override
  DeviceIntegrationLapMaster createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceIntegrationLapMaster getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceIntegrationLapMaster>(create);
  static DeviceIntegrationLapMaster? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get serialPortName => $_getSZ(0);
  @$pb.TagNumber(1)
  set serialPortName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSerialPortName() => $_has(0);
  @$pb.TagNumber(1)
  void clearSerialPortName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get lanes => $_getIZ(1);
  @$pb.TagNumber(2)
  set lanes($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLanes() => $_has(1);
  @$pb.TagNumber(2)
  void clearLanes() => $_clearField(2);
}

class DeviceIntegrationChronoLog extends $pb.GeneratedMessage {
  factory DeviceIntegrationChronoLog() => create();

  DeviceIntegrationChronoLog._();

  factory DeviceIntegrationChronoLog.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceIntegrationChronoLog.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceIntegrationChronoLog',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceIntegrationChronoLog clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceIntegrationChronoLog copyWith(
          void Function(DeviceIntegrationChronoLog) updates) =>
      super.copyWith(
              (message) => updates(message as DeviceIntegrationChronoLog))
          as DeviceIntegrationChronoLog;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceIntegrationChronoLog create() => DeviceIntegrationChronoLog._();
  @$core.override
  DeviceIntegrationChronoLog createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceIntegrationChronoLog getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceIntegrationChronoLog>(create);
  static DeviceIntegrationChronoLog? _defaultInstance;
}

class DeviceIntegrationPerformanceTest extends $pb.GeneratedMessage {
  factory DeviceIntegrationPerformanceTest() => create();

  DeviceIntegrationPerformanceTest._();

  factory DeviceIntegrationPerformanceTest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceIntegrationPerformanceTest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceIntegrationPerformanceTest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceIntegrationPerformanceTest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceIntegrationPerformanceTest copyWith(
          void Function(DeviceIntegrationPerformanceTest) updates) =>
      super.copyWith(
              (message) => updates(message as DeviceIntegrationPerformanceTest))
          as DeviceIntegrationPerformanceTest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceIntegrationPerformanceTest create() =>
      DeviceIntegrationPerformanceTest._();
  @$core.override
  DeviceIntegrationPerformanceTest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceIntegrationPerformanceTest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceIntegrationPerformanceTest>(
          create);
  static DeviceIntegrationPerformanceTest? _defaultInstance;
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
