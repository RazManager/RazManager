// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/device.v1.proto.

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

import 'device_configuration_feature_type_id.v1.pbenum.dart' as $1;
import 'device_configuration_input_type_id.v1.pbenum.dart' as $2;
import 'device_configuration_output_type_id.v1.pbenum.dart' as $3;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class DeviceInformation extends $pb.GeneratedMessage {
  factory DeviceInformation({
    $core.String? id,
    $core.String? name,
    $core.Iterable<DeviceProperty>? deviceProperties,
    $core.Iterable<DeviceConfiguration>? deviceConfigurations,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (deviceProperties != null)
      result.deviceProperties.addAll(deviceProperties);
    if (deviceConfigurations != null)
      result.deviceConfigurations.addAll(deviceConfigurations);
    return result;
  }

  DeviceInformation._();

  factory DeviceInformation.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceInformation.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceInformation',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..pPM<DeviceProperty>(3, _omitFieldNames ? '' : 'deviceProperties',
        subBuilder: DeviceProperty.create)
    ..pPM<DeviceConfiguration>(4, _omitFieldNames ? '' : 'deviceConfigurations',
        subBuilder: DeviceConfiguration.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceInformation clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceInformation copyWith(void Function(DeviceInformation) updates) =>
      super.copyWith((message) => updates(message as DeviceInformation))
          as DeviceInformation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceInformation create() => DeviceInformation._();
  @$core.override
  DeviceInformation createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceInformation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceInformation>(create);
  static DeviceInformation? _defaultInstance;

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
  $pb.PbList<DeviceProperty> get deviceProperties => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<DeviceConfiguration> get deviceConfigurations => $_getList(3);
}

class DeviceProperty extends $pb.GeneratedMessage {
  factory DeviceProperty({
    $core.String? label,
    $core.String? value,
  }) {
    final result = create();
    if (label != null) result.label = label;
    if (value != null) result.value = value;
    return result;
  }

  DeviceProperty._();

  factory DeviceProperty.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceProperty.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceProperty',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'label')
    ..aOS(2, _omitFieldNames ? '' : 'value')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceProperty clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceProperty copyWith(void Function(DeviceProperty) updates) =>
      super.copyWith((message) => updates(message as DeviceProperty))
          as DeviceProperty;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceProperty create() => DeviceProperty._();
  @$core.override
  DeviceProperty createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceProperty getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceProperty>(create);
  static DeviceProperty? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get label => $_getSZ(0);
  @$pb.TagNumber(1)
  set label($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLabel() => $_has(0);
  @$pb.TagNumber(1)
  void clearLabel() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get value => $_getSZ(1);
  @$pb.TagNumber(2)
  set value($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => $_clearField(2);
}

class DeviceConfiguration extends $pb.GeneratedMessage {
  factory DeviceConfiguration({
    $core.String? id,
    $core.String? name,
    $core.Iterable<DeviceDeviceConfigurationInput>? deviceConfigurationInputs,
    $core.Iterable<DeviceDeviceConfigurationOutput>? deviceConfigurationOutputs,
    $core.Iterable<$1.DeviceConfigurationFeatureTypeId>?
        deviceConfigurationFeatures,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (deviceConfigurationInputs != null)
      result.deviceConfigurationInputs.addAll(deviceConfigurationInputs);
    if (deviceConfigurationOutputs != null)
      result.deviceConfigurationOutputs.addAll(deviceConfigurationOutputs);
    if (deviceConfigurationFeatures != null)
      result.deviceConfigurationFeatures.addAll(deviceConfigurationFeatures);
    return result;
  }

  DeviceConfiguration._();

  factory DeviceConfiguration.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceConfiguration.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceConfiguration',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..pPM<DeviceDeviceConfigurationInput>(
        3, _omitFieldNames ? '' : 'deviceConfigurationInputs',
        subBuilder: DeviceDeviceConfigurationInput.create)
    ..pPM<DeviceDeviceConfigurationOutput>(
        4, _omitFieldNames ? '' : 'deviceConfigurationOutputs',
        subBuilder: DeviceDeviceConfigurationOutput.create)
    ..pc<$1.DeviceConfigurationFeatureTypeId>(
        5,
        _omitFieldNames ? '' : 'deviceConfigurationFeatures',
        $pb.PbFieldType.KE,
        valueOf: $1.DeviceConfigurationFeatureTypeId.valueOf,
        enumValues: $1.DeviceConfigurationFeatureTypeId.values,
        defaultEnumValue: $1.DeviceConfigurationFeatureTypeId
            .DEVICE_CONFIGURATION_FEATURE_TYPE_ID_UNDEFINED)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceConfiguration clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceConfiguration copyWith(void Function(DeviceConfiguration) updates) =>
      super.copyWith((message) => updates(message as DeviceConfiguration))
          as DeviceConfiguration;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceConfiguration create() => DeviceConfiguration._();
  @$core.override
  DeviceConfiguration createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceConfiguration getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceConfiguration>(create);
  static DeviceConfiguration? _defaultInstance;

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
  $pb.PbList<DeviceDeviceConfigurationInput> get deviceConfigurationInputs =>
      $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<DeviceDeviceConfigurationOutput> get deviceConfigurationOutputs =>
      $_getList(3);

  @$pb.TagNumber(5)
  $pb.PbList<$1.DeviceConfigurationFeatureTypeId>
      get deviceConfigurationFeatures => $_getList(4);
}

class DeviceDeviceConfigurationInput extends $pb.GeneratedMessage {
  factory DeviceDeviceConfigurationInput({
    $2.DeviceConfigurationInputTypeId? deviceConfigurationInputTypeId,
    $0.UInt32Value? deviceConfigurationInputId,
    $0.UInt32Value? deviceConfigurationInputSubId,
  }) {
    final result = create();
    if (deviceConfigurationInputTypeId != null)
      result.deviceConfigurationInputTypeId = deviceConfigurationInputTypeId;
    if (deviceConfigurationInputId != null)
      result.deviceConfigurationInputId = deviceConfigurationInputId;
    if (deviceConfigurationInputSubId != null)
      result.deviceConfigurationInputSubId = deviceConfigurationInputSubId;
    return result;
  }

  DeviceDeviceConfigurationInput._();

  factory DeviceDeviceConfigurationInput.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceDeviceConfigurationInput.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceDeviceConfigurationInput',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aE<$2.DeviceConfigurationInputTypeId>(
        1, _omitFieldNames ? '' : 'deviceConfigurationInputTypeId',
        enumValues: $2.DeviceConfigurationInputTypeId.values)
    ..aOM<$0.UInt32Value>(
        2, _omitFieldNames ? '' : 'deviceConfigurationInputId',
        subBuilder: $0.UInt32Value.create)
    ..aOM<$0.UInt32Value>(
        3, _omitFieldNames ? '' : 'deviceConfigurationInputSubId',
        subBuilder: $0.UInt32Value.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceDeviceConfigurationInput clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceDeviceConfigurationInput copyWith(
          void Function(DeviceDeviceConfigurationInput) updates) =>
      super.copyWith(
              (message) => updates(message as DeviceDeviceConfigurationInput))
          as DeviceDeviceConfigurationInput;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceDeviceConfigurationInput create() =>
      DeviceDeviceConfigurationInput._();
  @$core.override
  DeviceDeviceConfigurationInput createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceDeviceConfigurationInput getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceDeviceConfigurationInput>(create);
  static DeviceDeviceConfigurationInput? _defaultInstance;

  @$pb.TagNumber(1)
  $2.DeviceConfigurationInputTypeId get deviceConfigurationInputTypeId =>
      $_getN(0);
  @$pb.TagNumber(1)
  set deviceConfigurationInputTypeId($2.DeviceConfigurationInputTypeId value) =>
      $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDeviceConfigurationInputTypeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceConfigurationInputTypeId() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.UInt32Value get deviceConfigurationInputId => $_getN(1);
  @$pb.TagNumber(2)
  set deviceConfigurationInputId($0.UInt32Value value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasDeviceConfigurationInputId() => $_has(1);
  @$pb.TagNumber(2)
  void clearDeviceConfigurationInputId() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.UInt32Value ensureDeviceConfigurationInputId() => $_ensure(1);

  @$pb.TagNumber(3)
  $0.UInt32Value get deviceConfigurationInputSubId => $_getN(2);
  @$pb.TagNumber(3)
  set deviceConfigurationInputSubId($0.UInt32Value value) =>
      $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDeviceConfigurationInputSubId() => $_has(2);
  @$pb.TagNumber(3)
  void clearDeviceConfigurationInputSubId() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.UInt32Value ensureDeviceConfigurationInputSubId() => $_ensure(2);
}

class DeviceDeviceConfigurationOutput extends $pb.GeneratedMessage {
  factory DeviceDeviceConfigurationOutput({
    $3.DeviceConfigurationOutputTypeId? deviceConfigurationOutputTypeId,
    $0.UInt32Value? deviceConfigurationOutputId,
  }) {
    final result = create();
    if (deviceConfigurationOutputTypeId != null)
      result.deviceConfigurationOutputTypeId = deviceConfigurationOutputTypeId;
    if (deviceConfigurationOutputId != null)
      result.deviceConfigurationOutputId = deviceConfigurationOutputId;
    return result;
  }

  DeviceDeviceConfigurationOutput._();

  factory DeviceDeviceConfigurationOutput.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceDeviceConfigurationOutput.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceDeviceConfigurationOutput',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aE<$3.DeviceConfigurationOutputTypeId>(
        1, _omitFieldNames ? '' : 'deviceConfigurationOutputTypeId',
        enumValues: $3.DeviceConfigurationOutputTypeId.values)
    ..aOM<$0.UInt32Value>(
        2, _omitFieldNames ? '' : 'deviceConfigurationOutputId',
        subBuilder: $0.UInt32Value.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceDeviceConfigurationOutput clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceDeviceConfigurationOutput copyWith(
          void Function(DeviceDeviceConfigurationOutput) updates) =>
      super.copyWith(
              (message) => updates(message as DeviceDeviceConfigurationOutput))
          as DeviceDeviceConfigurationOutput;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceDeviceConfigurationOutput create() =>
      DeviceDeviceConfigurationOutput._();
  @$core.override
  DeviceDeviceConfigurationOutput createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceDeviceConfigurationOutput getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceDeviceConfigurationOutput>(
          create);
  static DeviceDeviceConfigurationOutput? _defaultInstance;

  @$pb.TagNumber(1)
  $3.DeviceConfigurationOutputTypeId get deviceConfigurationOutputTypeId =>
      $_getN(0);
  @$pb.TagNumber(1)
  set deviceConfigurationOutputTypeId(
          $3.DeviceConfigurationOutputTypeId value) =>
      $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDeviceConfigurationOutputTypeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceConfigurationOutputTypeId() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.UInt32Value get deviceConfigurationOutputId => $_getN(1);
  @$pb.TagNumber(2)
  set deviceConfigurationOutputId($0.UInt32Value value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasDeviceConfigurationOutputId() => $_has(1);
  @$pb.TagNumber(2)
  void clearDeviceConfigurationOutputId() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.UInt32Value ensureDeviceConfigurationOutputId() => $_ensure(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
