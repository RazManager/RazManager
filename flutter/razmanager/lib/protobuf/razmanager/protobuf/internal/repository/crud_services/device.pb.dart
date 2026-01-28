// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/device.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $5;
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart'
    as $3;

import '../../../public/device.v1.pb.dart' as $4;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class DeviceReadResponse extends $pb.GeneratedMessage {
  factory DeviceReadResponse({
    DeviceRead? entity,
    $core.String? etag,
  }) {
    final result = create();
    if (entity != null) result.entity = entity;
    if (etag != null) result.etag = etag;
    return result;
  }

  DeviceReadResponse._();

  factory DeviceReadResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceReadResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceReadResponse',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.device'),
      createEmptyInstance: create)
    ..aOM<DeviceRead>(1, _omitFieldNames ? '' : 'entity',
        subBuilder: DeviceRead.create)
    ..aOS(2, _omitFieldNames ? '' : 'etag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceReadResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceReadResponse copyWith(void Function(DeviceReadResponse) updates) =>
      super.copyWith((message) => updates(message as DeviceReadResponse))
          as DeviceReadResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceReadResponse create() => DeviceReadResponse._();
  @$core.override
  DeviceReadResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceReadResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceReadResponse>(create);
  static DeviceReadResponse? _defaultInstance;

  @$pb.TagNumber(1)
  DeviceRead get entity => $_getN(0);
  @$pb.TagNumber(1)
  set entity(DeviceRead value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasEntity() => $_has(0);
  @$pb.TagNumber(1)
  void clearEntity() => $_clearField(1);
  @$pb.TagNumber(1)
  DeviceRead ensureEntity() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get etag => $_getSZ(1);
  @$pb.TagNumber(2)
  set etag($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEtag() => $_has(1);
  @$pb.TagNumber(2)
  void clearEtag() => $_clearField(2);
}

class DeviceRead extends $pb.GeneratedMessage {
  factory DeviceRead({
    $3.StringValue? id,
    $3.StringValue? name,
    $3.StringValue? description,
    $core.bool? simulated,
    $core.Iterable<DeviceConfigurationRead>? deviceConfigurations,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (simulated != null) result.simulated = simulated;
    if (deviceConfigurations != null)
      result.deviceConfigurations.addAll(deviceConfigurations);
    return result;
  }

  DeviceRead._();

  factory DeviceRead.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceRead.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceRead',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.device'),
      createEmptyInstance: create)
    ..aOM<$3.StringValue>(1, _omitFieldNames ? '' : 'id',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(2, _omitFieldNames ? '' : 'name',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(3, _omitFieldNames ? '' : 'description',
        subBuilder: $3.StringValue.create)
    ..aOB(4, _omitFieldNames ? '' : 'simulated')
    ..pPM<DeviceConfigurationRead>(
        6, _omitFieldNames ? '' : 'deviceConfigurations',
        subBuilder: DeviceConfigurationRead.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceRead clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceRead copyWith(void Function(DeviceRead) updates) =>
      super.copyWith((message) => updates(message as DeviceRead)) as DeviceRead;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceRead create() => DeviceRead._();
  @$core.override
  DeviceRead createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceRead getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceRead>(create);
  static DeviceRead? _defaultInstance;

  @$pb.TagNumber(1)
  $3.StringValue get id => $_getN(0);
  @$pb.TagNumber(1)
  set id($3.StringValue value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
  @$pb.TagNumber(1)
  $3.StringValue ensureId() => $_ensure(0);

  @$pb.TagNumber(2)
  $3.StringValue get name => $_getN(1);
  @$pb.TagNumber(2)
  set name($3.StringValue value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);
  @$pb.TagNumber(2)
  $3.StringValue ensureName() => $_ensure(1);

  @$pb.TagNumber(3)
  $3.StringValue get description => $_getN(2);
  @$pb.TagNumber(3)
  set description($3.StringValue value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);
  @$pb.TagNumber(3)
  $3.StringValue ensureDescription() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.bool get simulated => $_getBF(3);
  @$pb.TagNumber(4)
  set simulated($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSimulated() => $_has(3);
  @$pb.TagNumber(4)
  void clearSimulated() => $_clearField(4);

  /// repeated public.v1.DeviceProperty device_properties = 5;
  @$pb.TagNumber(6)
  $pb.PbList<DeviceConfigurationRead> get deviceConfigurations => $_getList(4);
}

class DeviceCreateUpdate extends $pb.GeneratedMessage {
  factory DeviceCreateUpdate({
    $core.String? name,
    $3.StringValue? description,
    $core.Iterable<DeviceConfigurationCreateUpdate>? deviceConfigurations,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (deviceConfigurations != null)
      result.deviceConfigurations.addAll(deviceConfigurations);
    return result;
  }

  DeviceCreateUpdate._();

  factory DeviceCreateUpdate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceCreateUpdate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceCreateUpdate',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.device'),
      createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOM<$3.StringValue>(3, _omitFieldNames ? '' : 'description',
        subBuilder: $3.StringValue.create)
    ..pPM<DeviceConfigurationCreateUpdate>(
        6, _omitFieldNames ? '' : 'deviceConfigurations',
        subBuilder: DeviceConfigurationCreateUpdate.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceCreateUpdate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceCreateUpdate copyWith(void Function(DeviceCreateUpdate) updates) =>
      super.copyWith((message) => updates(message as DeviceCreateUpdate))
          as DeviceCreateUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceCreateUpdate create() => DeviceCreateUpdate._();
  @$core.override
  DeviceCreateUpdate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceCreateUpdate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceCreateUpdate>(create);
  static DeviceCreateUpdate? _defaultInstance;

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $3.StringValue get description => $_getN(1);
  @$pb.TagNumber(3)
  set description($3.StringValue value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);
  @$pb.TagNumber(3)
  $3.StringValue ensureDescription() => $_ensure(1);

  @$pb.TagNumber(6)
  $pb.PbList<DeviceConfigurationCreateUpdate> get deviceConfigurations =>
      $_getList(2);
}

class DeviceUpdateRequest extends $pb.GeneratedMessage {
  factory DeviceUpdateRequest({
    $core.String? id,
    DeviceCreateUpdate? entity,
    $core.String? etag,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (entity != null) result.entity = entity;
    if (etag != null) result.etag = etag;
    return result;
  }

  DeviceUpdateRequest._();

  factory DeviceUpdateRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceUpdateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceUpdateRequest',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.device'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<DeviceCreateUpdate>(2, _omitFieldNames ? '' : 'entity',
        subBuilder: DeviceCreateUpdate.create)
    ..aOS(3, _omitFieldNames ? '' : 'etag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceUpdateRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceUpdateRequest copyWith(void Function(DeviceUpdateRequest) updates) =>
      super.copyWith((message) => updates(message as DeviceUpdateRequest))
          as DeviceUpdateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceUpdateRequest create() => DeviceUpdateRequest._();
  @$core.override
  DeviceUpdateRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceUpdateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceUpdateRequest>(create);
  static DeviceUpdateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  DeviceCreateUpdate get entity => $_getN(1);
  @$pb.TagNumber(2)
  set entity(DeviceCreateUpdate value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEntity() => $_has(1);
  @$pb.TagNumber(2)
  void clearEntity() => $_clearField(2);
  @$pb.TagNumber(2)
  DeviceCreateUpdate ensureEntity() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get etag => $_getSZ(2);
  @$pb.TagNumber(3)
  set etag($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEtag() => $_has(2);
  @$pb.TagNumber(3)
  void clearEtag() => $_clearField(3);
}

class DeviceConfigurationRead extends $pb.GeneratedMessage {
  factory DeviceConfigurationRead({
    $core.String? id,
    $core.String? name,
    $core.Iterable<$4.DeviceDeviceConfigurationInput>?
        deviceConfigurationInputs,
    $core.Iterable<$4.DeviceDeviceConfigurationOutput>?
        deviceConfigurationOutputs,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (deviceConfigurationInputs != null)
      result.deviceConfigurationInputs.addAll(deviceConfigurationInputs);
    if (deviceConfigurationOutputs != null)
      result.deviceConfigurationOutputs.addAll(deviceConfigurationOutputs);
    return result;
  }

  DeviceConfigurationRead._();

  factory DeviceConfigurationRead.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceConfigurationRead.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceConfigurationRead',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.device'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..pPM<$4.DeviceDeviceConfigurationInput>(
        3, _omitFieldNames ? '' : 'deviceConfigurationInputs',
        subBuilder: $4.DeviceDeviceConfigurationInput.create)
    ..pPM<$4.DeviceDeviceConfigurationOutput>(
        4, _omitFieldNames ? '' : 'deviceConfigurationOutputs',
        subBuilder: $4.DeviceDeviceConfigurationOutput.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceConfigurationRead clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceConfigurationRead copyWith(
          void Function(DeviceConfigurationRead) updates) =>
      super.copyWith((message) => updates(message as DeviceConfigurationRead))
          as DeviceConfigurationRead;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceConfigurationRead create() => DeviceConfigurationRead._();
  @$core.override
  DeviceConfigurationRead createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceConfigurationRead getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceConfigurationRead>(create);
  static DeviceConfigurationRead? _defaultInstance;

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
  $pb.PbList<$4.DeviceDeviceConfigurationInput> get deviceConfigurationInputs =>
      $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<$4.DeviceDeviceConfigurationOutput>
      get deviceConfigurationOutputs => $_getList(3);
}

class DeviceConfigurationCreateUpdate extends $pb.GeneratedMessage {
  factory DeviceConfigurationCreateUpdate({
    $core.Iterable<$4.DeviceDeviceConfigurationInput>?
        deviceConfigurationInputs,
    $core.Iterable<$4.DeviceDeviceConfigurationOutput>?
        deviceConfigurationOutputs,
  }) {
    final result = create();
    if (deviceConfigurationInputs != null)
      result.deviceConfigurationInputs.addAll(deviceConfigurationInputs);
    if (deviceConfigurationOutputs != null)
      result.deviceConfigurationOutputs.addAll(deviceConfigurationOutputs);
    return result;
  }

  DeviceConfigurationCreateUpdate._();

  factory DeviceConfigurationCreateUpdate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceConfigurationCreateUpdate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceConfigurationCreateUpdate',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.device'),
      createEmptyInstance: create)
    ..pPM<$4.DeviceDeviceConfigurationInput>(
        3, _omitFieldNames ? '' : 'deviceConfigurationInputs',
        subBuilder: $4.DeviceDeviceConfigurationInput.create)
    ..pPM<$4.DeviceDeviceConfigurationOutput>(
        4, _omitFieldNames ? '' : 'deviceConfigurationOutputs',
        subBuilder: $4.DeviceDeviceConfigurationOutput.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceConfigurationCreateUpdate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceConfigurationCreateUpdate copyWith(
          void Function(DeviceConfigurationCreateUpdate) updates) =>
      super.copyWith(
              (message) => updates(message as DeviceConfigurationCreateUpdate))
          as DeviceConfigurationCreateUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceConfigurationCreateUpdate create() =>
      DeviceConfigurationCreateUpdate._();
  @$core.override
  DeviceConfigurationCreateUpdate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceConfigurationCreateUpdate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceConfigurationCreateUpdate>(
          create);
  static DeviceConfigurationCreateUpdate? _defaultInstance;

  @$pb.TagNumber(3)
  $pb.PbList<$4.DeviceDeviceConfigurationInput> get deviceConfigurationInputs =>
      $_getList(0);

  @$pb.TagNumber(4)
  $pb.PbList<$4.DeviceDeviceConfigurationOutput>
      get deviceConfigurationOutputs => $_getList(1);
}

class DeviceListResponse extends $pb.GeneratedMessage {
  factory DeviceListResponse({
    $core.Iterable<DeviceList>? result,
  }) {
    final result$ = create();
    if (result != null) result$.result.addAll(result);
    return result$;
  }

  DeviceListResponse._();

  factory DeviceListResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceListResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceListResponse',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.device'),
      createEmptyInstance: create)
    ..pPM<DeviceList>(1, _omitFieldNames ? '' : 'result',
        subBuilder: DeviceList.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceListResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceListResponse copyWith(void Function(DeviceListResponse) updates) =>
      super.copyWith((message) => updates(message as DeviceListResponse))
          as DeviceListResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceListResponse create() => DeviceListResponse._();
  @$core.override
  DeviceListResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceListResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceListResponse>(create);
  static DeviceListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<DeviceList> get result => $_getList(0);
}

class DeviceList extends $pb.GeneratedMessage {
  factory DeviceList({
    $core.String? id,
    $core.String? name,
    $3.StringValue? description,
    $core.bool? connected,
    $5.Timestamp? lastConnectedAt,
    $core.bool? simulated,
    $core.String? etag,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (connected != null) result.connected = connected;
    if (lastConnectedAt != null) result.lastConnectedAt = lastConnectedAt;
    if (simulated != null) result.simulated = simulated;
    if (etag != null) result.etag = etag;
    return result;
  }

  DeviceList._();

  factory DeviceList.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceList.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceList',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.device'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOM<$3.StringValue>(3, _omitFieldNames ? '' : 'description',
        subBuilder: $3.StringValue.create)
    ..aOB(4, _omitFieldNames ? '' : 'connected')
    ..aOM<$5.Timestamp>(5, _omitFieldNames ? '' : 'lastConnectedAt',
        subBuilder: $5.Timestamp.create)
    ..aOB(6, _omitFieldNames ? '' : 'simulated')
    ..aOS(7, _omitFieldNames ? '' : 'etag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceList clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceList copyWith(void Function(DeviceList) updates) =>
      super.copyWith((message) => updates(message as DeviceList)) as DeviceList;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceList create() => DeviceList._();
  @$core.override
  DeviceList createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceList getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceList>(create);
  static DeviceList? _defaultInstance;

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
  $3.StringValue get description => $_getN(2);
  @$pb.TagNumber(3)
  set description($3.StringValue value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);
  @$pb.TagNumber(3)
  $3.StringValue ensureDescription() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.bool get connected => $_getBF(3);
  @$pb.TagNumber(4)
  set connected($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasConnected() => $_has(3);
  @$pb.TagNumber(4)
  void clearConnected() => $_clearField(4);

  @$pb.TagNumber(5)
  $5.Timestamp get lastConnectedAt => $_getN(4);
  @$pb.TagNumber(5)
  set lastConnectedAt($5.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasLastConnectedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearLastConnectedAt() => $_clearField(5);
  @$pb.TagNumber(5)
  $5.Timestamp ensureLastConnectedAt() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.bool get simulated => $_getBF(5);
  @$pb.TagNumber(6)
  set simulated($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSimulated() => $_has(5);
  @$pb.TagNumber(6)
  void clearSimulated() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get etag => $_getSZ(6);
  @$pb.TagNumber(7)
  set etag($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasEtag() => $_has(6);
  @$pb.TagNumber(7)
  void clearEtag() => $_clearField(7);
}

class DeviceSelect extends $pb.GeneratedMessage {
  factory DeviceSelect({
    $core.String? id,
    $core.String? name,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    return result;
  }

  DeviceSelect._();

  factory DeviceSelect.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceSelect.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceSelect',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.device'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceSelect clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceSelect copyWith(void Function(DeviceSelect) updates) =>
      super.copyWith((message) => updates(message as DeviceSelect))
          as DeviceSelect;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceSelect create() => DeviceSelect._();
  @$core.override
  DeviceSelect createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceSelect getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceSelect>(create);
  static DeviceSelect? _defaultInstance;

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
}

class DeviceCommissioningCertificateRequest extends $pb.GeneratedMessage {
  factory DeviceCommissioningCertificateRequest({
    $core.String? certificateRequestPem,
    $core.String? name,
  }) {
    final result = create();
    if (certificateRequestPem != null)
      result.certificateRequestPem = certificateRequestPem;
    if (name != null) result.name = name;
    return result;
  }

  DeviceCommissioningCertificateRequest._();

  factory DeviceCommissioningCertificateRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceCommissioningCertificateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceCommissioningCertificateRequest',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.device'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'certificateRequestPem')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceCommissioningCertificateRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceCommissioningCertificateRequest copyWith(
          void Function(DeviceCommissioningCertificateRequest) updates) =>
      super.copyWith((message) =>
              updates(message as DeviceCommissioningCertificateRequest))
          as DeviceCommissioningCertificateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceCommissioningCertificateRequest create() =>
      DeviceCommissioningCertificateRequest._();
  @$core.override
  DeviceCommissioningCertificateRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceCommissioningCertificateRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          DeviceCommissioningCertificateRequest>(create);
  static DeviceCommissioningCertificateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get certificateRequestPem => $_getSZ(0);
  @$pb.TagNumber(1)
  set certificateRequestPem($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCertificateRequestPem() => $_has(0);
  @$pb.TagNumber(1)
  void clearCertificateRequestPem() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);
}

class DeviceCommissioningCertificateResponse extends $pb.GeneratedMessage {
  factory DeviceCommissioningCertificateResponse({
    $core.String? certificatePem,
  }) {
    final result = create();
    if (certificatePem != null) result.certificatePem = certificatePem;
    return result;
  }

  DeviceCommissioningCertificateResponse._();

  factory DeviceCommissioningCertificateResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceCommissioningCertificateResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceCommissioningCertificateResponse',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.device'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'certificatePem')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceCommissioningCertificateResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceCommissioningCertificateResponse copyWith(
          void Function(DeviceCommissioningCertificateResponse) updates) =>
      super.copyWith((message) =>
              updates(message as DeviceCommissioningCertificateResponse))
          as DeviceCommissioningCertificateResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceCommissioningCertificateResponse create() =>
      DeviceCommissioningCertificateResponse._();
  @$core.override
  DeviceCommissioningCertificateResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceCommissioningCertificateResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          DeviceCommissioningCertificateResponse>(create);
  static DeviceCommissioningCertificateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get certificatePem => $_getSZ(0);
  @$pb.TagNumber(1)
  set certificatePem($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCertificatePem() => $_has(0);
  @$pb.TagNumber(1)
  void clearCertificatePem() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
