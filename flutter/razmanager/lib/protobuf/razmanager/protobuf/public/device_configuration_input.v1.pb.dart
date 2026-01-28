// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/device_configuration_input.v1.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $1;
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart'
    as $0;

import 'device_configuration_input_type_id.v1.pbenum.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

enum DeviceConfigurationInput_Value { intValue, boolValue, notSet }

class DeviceConfigurationInput extends $pb.GeneratedMessage {
  factory DeviceConfigurationInput({
    $core.String? deviceConfigurationId,
    $0.StringValue? correlationId,
    $1.Timestamp? timestamp,
    $2.DeviceConfigurationInputTypeId? deviceConfigurationInputTypeId,
    $0.UInt32Value? deviceConfigurationInputId,
    $0.UInt32Value? deviceConfigurationInputSubId,
    $core.int? intValue,
    $core.bool? boolValue,
    $0.StringValue? information,
    $0.DoubleValue? lapTime,
  }) {
    final result = create();
    if (deviceConfigurationId != null)
      result.deviceConfigurationId = deviceConfigurationId;
    if (correlationId != null) result.correlationId = correlationId;
    if (timestamp != null) result.timestamp = timestamp;
    if (deviceConfigurationInputTypeId != null)
      result.deviceConfigurationInputTypeId = deviceConfigurationInputTypeId;
    if (deviceConfigurationInputId != null)
      result.deviceConfigurationInputId = deviceConfigurationInputId;
    if (deviceConfigurationInputSubId != null)
      result.deviceConfigurationInputSubId = deviceConfigurationInputSubId;
    if (intValue != null) result.intValue = intValue;
    if (boolValue != null) result.boolValue = boolValue;
    if (information != null) result.information = information;
    if (lapTime != null) result.lapTime = lapTime;
    return result;
  }

  DeviceConfigurationInput._();

  factory DeviceConfigurationInput.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceConfigurationInput.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, DeviceConfigurationInput_Value>
      _DeviceConfigurationInput_ValueByTag = {
    7: DeviceConfigurationInput_Value.intValue,
    8: DeviceConfigurationInput_Value.boolValue,
    0: DeviceConfigurationInput_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceConfigurationInput',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..oo(0, [7, 8])
    ..aOS(1, _omitFieldNames ? '' : 'deviceConfigurationId')
    ..aOM<$0.StringValue>(2, _omitFieldNames ? '' : 'correlationId',
        subBuilder: $0.StringValue.create)
    ..aOM<$1.Timestamp>(3, _omitFieldNames ? '' : 'timestamp',
        subBuilder: $1.Timestamp.create)
    ..aE<$2.DeviceConfigurationInputTypeId>(
        4, _omitFieldNames ? '' : 'deviceConfigurationInputTypeId',
        enumValues: $2.DeviceConfigurationInputTypeId.values)
    ..aOM<$0.UInt32Value>(
        5, _omitFieldNames ? '' : 'deviceConfigurationInputId',
        subBuilder: $0.UInt32Value.create)
    ..aOM<$0.UInt32Value>(
        6, _omitFieldNames ? '' : 'deviceConfigurationInputSubId',
        subBuilder: $0.UInt32Value.create)
    ..aI(7, _omitFieldNames ? '' : 'intValue', fieldType: $pb.PbFieldType.OU3)
    ..aOB(8, _omitFieldNames ? '' : 'boolValue')
    ..aOM<$0.StringValue>(9, _omitFieldNames ? '' : 'information',
        subBuilder: $0.StringValue.create)
    ..aOM<$0.DoubleValue>(10, _omitFieldNames ? '' : 'lapTime',
        subBuilder: $0.DoubleValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceConfigurationInput clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceConfigurationInput copyWith(
          void Function(DeviceConfigurationInput) updates) =>
      super.copyWith((message) => updates(message as DeviceConfigurationInput))
          as DeviceConfigurationInput;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceConfigurationInput create() => DeviceConfigurationInput._();
  @$core.override
  DeviceConfigurationInput createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceConfigurationInput getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceConfigurationInput>(create);
  static DeviceConfigurationInput? _defaultInstance;

  @$pb.TagNumber(7)
  @$pb.TagNumber(8)
  DeviceConfigurationInput_Value whichValue() =>
      _DeviceConfigurationInput_ValueByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(7)
  @$pb.TagNumber(8)
  void clearValue() => $_clearField($_whichOneof(0));

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
  $1.Timestamp get timestamp => $_getN(2);
  @$pb.TagNumber(3)
  set timestamp($1.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureTimestamp() => $_ensure(2);

  @$pb.TagNumber(4)
  $2.DeviceConfigurationInputTypeId get deviceConfigurationInputTypeId =>
      $_getN(3);
  @$pb.TagNumber(4)
  set deviceConfigurationInputTypeId($2.DeviceConfigurationInputTypeId value) =>
      $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasDeviceConfigurationInputTypeId() => $_has(3);
  @$pb.TagNumber(4)
  void clearDeviceConfigurationInputTypeId() => $_clearField(4);

  @$pb.TagNumber(5)
  $0.UInt32Value get deviceConfigurationInputId => $_getN(4);
  @$pb.TagNumber(5)
  set deviceConfigurationInputId($0.UInt32Value value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasDeviceConfigurationInputId() => $_has(4);
  @$pb.TagNumber(5)
  void clearDeviceConfigurationInputId() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.UInt32Value ensureDeviceConfigurationInputId() => $_ensure(4);

  @$pb.TagNumber(6)
  $0.UInt32Value get deviceConfigurationInputSubId => $_getN(5);
  @$pb.TagNumber(6)
  set deviceConfigurationInputSubId($0.UInt32Value value) =>
      $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasDeviceConfigurationInputSubId() => $_has(5);
  @$pb.TagNumber(6)
  void clearDeviceConfigurationInputSubId() => $_clearField(6);
  @$pb.TagNumber(6)
  $0.UInt32Value ensureDeviceConfigurationInputSubId() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.int get intValue => $_getIZ(6);
  @$pb.TagNumber(7)
  set intValue($core.int value) => $_setUnsignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasIntValue() => $_has(6);
  @$pb.TagNumber(7)
  void clearIntValue() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get boolValue => $_getBF(7);
  @$pb.TagNumber(8)
  set boolValue($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasBoolValue() => $_has(7);
  @$pb.TagNumber(8)
  void clearBoolValue() => $_clearField(8);

  @$pb.TagNumber(9)
  $0.StringValue get information => $_getN(8);
  @$pb.TagNumber(9)
  set information($0.StringValue value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasInformation() => $_has(8);
  @$pb.TagNumber(9)
  void clearInformation() => $_clearField(9);
  @$pb.TagNumber(9)
  $0.StringValue ensureInformation() => $_ensure(8);

  @$pb.TagNumber(10)
  $0.DoubleValue get lapTime => $_getN(9);
  @$pb.TagNumber(10)
  set lapTime($0.DoubleValue value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasLapTime() => $_has(9);
  @$pb.TagNumber(10)
  void clearLapTime() => $_clearField(10);
  @$pb.TagNumber(10)
  $0.DoubleValue ensureLapTime() => $_ensure(9);
}

class DeviceConfigurationInputs extends $pb.GeneratedMessage {
  factory DeviceConfigurationInputs({
    $core.Iterable<DeviceConfigurationInput>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  DeviceConfigurationInputs._();

  factory DeviceConfigurationInputs.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceConfigurationInputs.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceConfigurationInputs',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..pPM<DeviceConfigurationInput>(1, _omitFieldNames ? '' : 'items',
        subBuilder: DeviceConfigurationInput.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceConfigurationInputs clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceConfigurationInputs copyWith(
          void Function(DeviceConfigurationInputs) updates) =>
      super.copyWith((message) => updates(message as DeviceConfigurationInputs))
          as DeviceConfigurationInputs;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceConfigurationInputs create() => DeviceConfigurationInputs._();
  @$core.override
  DeviceConfigurationInputs createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceConfigurationInputs getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceConfigurationInputs>(create);
  static DeviceConfigurationInputs? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<DeviceConfigurationInput> get items => $_getList(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
