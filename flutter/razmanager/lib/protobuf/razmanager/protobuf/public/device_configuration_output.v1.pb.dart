// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/device_configuration_output.v1.proto.

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

import 'device_configuration_output_type_id.v1.pbenum.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class DeviceConfigurationOutput extends $pb.GeneratedMessage {
  factory DeviceConfigurationOutput({
    $core.String? deviceConfigurationId,
    $0.StringValue? correlationId,
    $1.DeviceConfigurationOutputTypeId? deviceConfigurationOutputTypeId,
    $0.UInt32Value? deviceConfigurationOutputId,
  }) {
    final result = create();
    if (deviceConfigurationId != null)
      result.deviceConfigurationId = deviceConfigurationId;
    if (correlationId != null) result.correlationId = correlationId;
    if (deviceConfigurationOutputTypeId != null)
      result.deviceConfigurationOutputTypeId = deviceConfigurationOutputTypeId;
    if (deviceConfigurationOutputId != null)
      result.deviceConfigurationOutputId = deviceConfigurationOutputId;
    return result;
  }

  DeviceConfigurationOutput._();

  factory DeviceConfigurationOutput.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceConfigurationOutput.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceConfigurationOutput',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'deviceConfigurationId')
    ..aOM<$0.StringValue>(2, _omitFieldNames ? '' : 'correlationId',
        subBuilder: $0.StringValue.create)
    ..aE<$1.DeviceConfigurationOutputTypeId>(
        3, _omitFieldNames ? '' : 'deviceConfigurationOutputTypeId',
        enumValues: $1.DeviceConfigurationOutputTypeId.values)
    ..aOM<$0.UInt32Value>(
        4, _omitFieldNames ? '' : 'deviceConfigurationOutputId',
        subBuilder: $0.UInt32Value.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceConfigurationOutput clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceConfigurationOutput copyWith(
          void Function(DeviceConfigurationOutput) updates) =>
      super.copyWith((message) => updates(message as DeviceConfigurationOutput))
          as DeviceConfigurationOutput;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceConfigurationOutput create() => DeviceConfigurationOutput._();
  @$core.override
  DeviceConfigurationOutput createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceConfigurationOutput getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceConfigurationOutput>(create);
  static DeviceConfigurationOutput? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get deviceConfigurationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set deviceConfigurationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDeviceConfigurationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceConfigurationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.StringValue get correlationId => $_getN(1);
  @$pb.TagNumber(2)
  set correlationId($0.StringValue value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCorrelationId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCorrelationId() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.StringValue ensureCorrelationId() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.DeviceConfigurationOutputTypeId get deviceConfigurationOutputTypeId =>
      $_getN(2);
  @$pb.TagNumber(3)
  set deviceConfigurationOutputTypeId(
          $1.DeviceConfigurationOutputTypeId value) =>
      $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDeviceConfigurationOutputTypeId() => $_has(2);
  @$pb.TagNumber(3)
  void clearDeviceConfigurationOutputTypeId() => $_clearField(3);

  @$pb.TagNumber(4)
  $0.UInt32Value get deviceConfigurationOutputId => $_getN(3);
  @$pb.TagNumber(4)
  set deviceConfigurationOutputId($0.UInt32Value value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasDeviceConfigurationOutputId() => $_has(3);
  @$pb.TagNumber(4)
  void clearDeviceConfigurationOutputId() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.UInt32Value ensureDeviceConfigurationOutputId() => $_ensure(3);
}

class DeviceConfigurationOutputs extends $pb.GeneratedMessage {
  factory DeviceConfigurationOutputs({
    $core.Iterable<DeviceConfigurationOutput>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  DeviceConfigurationOutputs._();

  factory DeviceConfigurationOutputs.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceConfigurationOutputs.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceConfigurationOutputs',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..pPM<DeviceConfigurationOutput>(1, _omitFieldNames ? '' : 'items',
        subBuilder: DeviceConfigurationOutput.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceConfigurationOutputs clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceConfigurationOutputs copyWith(
          void Function(DeviceConfigurationOutputs) updates) =>
      super.copyWith(
              (message) => updates(message as DeviceConfigurationOutputs))
          as DeviceConfigurationOutputs;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceConfigurationOutputs create() => DeviceConfigurationOutputs._();
  @$core.override
  DeviceConfigurationOutputs createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceConfigurationOutputs getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceConfigurationOutputs>(create);
  static DeviceConfigurationOutputs? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<DeviceConfigurationOutput> get items => $_getList(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
