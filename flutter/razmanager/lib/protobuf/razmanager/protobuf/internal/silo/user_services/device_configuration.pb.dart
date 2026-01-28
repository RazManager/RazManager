// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/silo/user_services/device_configuration.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../../public/device_configuration_input.v1.pb.dart' as $3;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class DeviceConfigurationDeviceConfigurationInput extends $pb.GeneratedMessage {
  factory DeviceConfigurationDeviceConfigurationInput({
    $core.String? id,
    $3.DeviceConfigurationInput? deviceConfigurationInput,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (deviceConfigurationInput != null)
      result.deviceConfigurationInput = deviceConfigurationInput;
    return result;
  }

  DeviceConfigurationDeviceConfigurationInput._();

  factory DeviceConfigurationDeviceConfigurationInput.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceConfigurationDeviceConfigurationInput.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceConfigurationDeviceConfigurationInput',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.silo.user_services.device_configuration'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<$3.DeviceConfigurationInput>(
        2, _omitFieldNames ? '' : 'deviceConfigurationInput',
        subBuilder: $3.DeviceConfigurationInput.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceConfigurationDeviceConfigurationInput clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceConfigurationDeviceConfigurationInput copyWith(
          void Function(DeviceConfigurationDeviceConfigurationInput) updates) =>
      super.copyWith((message) =>
              updates(message as DeviceConfigurationDeviceConfigurationInput))
          as DeviceConfigurationDeviceConfigurationInput;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceConfigurationDeviceConfigurationInput create() =>
      DeviceConfigurationDeviceConfigurationInput._();
  @$core.override
  DeviceConfigurationDeviceConfigurationInput createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceConfigurationDeviceConfigurationInput getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          DeviceConfigurationDeviceConfigurationInput>(create);
  static DeviceConfigurationDeviceConfigurationInput? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $3.DeviceConfigurationInput get deviceConfigurationInput => $_getN(1);
  @$pb.TagNumber(2)
  set deviceConfigurationInput($3.DeviceConfigurationInput value) =>
      $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasDeviceConfigurationInput() => $_has(1);
  @$pb.TagNumber(2)
  void clearDeviceConfigurationInput() => $_clearField(2);
  @$pb.TagNumber(2)
  $3.DeviceConfigurationInput ensureDeviceConfigurationInput() => $_ensure(1);
}

class DeviceConfigurationSetSimulationSetRequest extends $pb.GeneratedMessage {
  factory DeviceConfigurationSetSimulationSetRequest({
    $core.String? id,
    $core.bool? value,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (value != null) result.value = value;
    return result;
  }

  DeviceConfigurationSetSimulationSetRequest._();

  factory DeviceConfigurationSetSimulationSetRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceConfigurationSetSimulationSetRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceConfigurationSetSimulationSetRequest',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.silo.user_services.device_configuration'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOB(2, _omitFieldNames ? '' : 'value')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceConfigurationSetSimulationSetRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceConfigurationSetSimulationSetRequest copyWith(
          void Function(DeviceConfigurationSetSimulationSetRequest) updates) =>
      super.copyWith((message) =>
              updates(message as DeviceConfigurationSetSimulationSetRequest))
          as DeviceConfigurationSetSimulationSetRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceConfigurationSetSimulationSetRequest create() =>
      DeviceConfigurationSetSimulationSetRequest._();
  @$core.override
  DeviceConfigurationSetSimulationSetRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceConfigurationSetSimulationSetRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          DeviceConfigurationSetSimulationSetRequest>(create);
  static DeviceConfigurationSetSimulationSetRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get value => $_getBF(1);
  @$pb.TagNumber(2)
  set value($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
