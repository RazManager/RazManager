// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/device_configuration.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'device.pb.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class DeviceConfigurationSelectResponse extends $pb.GeneratedMessage {
  factory DeviceConfigurationSelectResponse({
    $core.Iterable<DeviceConfigurationSelect>? result,
  }) {
    final result$ = create();
    if (result != null) result$.result.addAll(result);
    return result$;
  }

  DeviceConfigurationSelectResponse._();

  factory DeviceConfigurationSelectResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceConfigurationSelectResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceConfigurationSelectResponse',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.device_configuration'),
      createEmptyInstance: create)
    ..pPM<DeviceConfigurationSelect>(1, _omitFieldNames ? '' : 'result',
        subBuilder: DeviceConfigurationSelect.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceConfigurationSelectResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceConfigurationSelectResponse copyWith(
          void Function(DeviceConfigurationSelectResponse) updates) =>
      super.copyWith((message) =>
              updates(message as DeviceConfigurationSelectResponse))
          as DeviceConfigurationSelectResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceConfigurationSelectResponse create() =>
      DeviceConfigurationSelectResponse._();
  @$core.override
  DeviceConfigurationSelectResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceConfigurationSelectResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceConfigurationSelectResponse>(
          create);
  static DeviceConfigurationSelectResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<DeviceConfigurationSelect> get result => $_getList(0);
}

class DeviceConfigurationSelect extends $pb.GeneratedMessage {
  factory DeviceConfigurationSelect({
    $core.String? id,
    $core.String? name,
    $2.DeviceSelect? device,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (device != null) result.device = device;
    return result;
  }

  DeviceConfigurationSelect._();

  factory DeviceConfigurationSelect.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceConfigurationSelect.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceConfigurationSelect',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.device_configuration'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOM<$2.DeviceSelect>(3, _omitFieldNames ? '' : 'device',
        subBuilder: $2.DeviceSelect.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceConfigurationSelect clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceConfigurationSelect copyWith(
          void Function(DeviceConfigurationSelect) updates) =>
      super.copyWith((message) => updates(message as DeviceConfigurationSelect))
          as DeviceConfigurationSelect;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceConfigurationSelect create() => DeviceConfigurationSelect._();
  @$core.override
  DeviceConfigurationSelect createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceConfigurationSelect getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceConfigurationSelect>(create);
  static DeviceConfigurationSelect? _defaultInstance;

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
  $2.DeviceSelect get device => $_getN(2);
  @$pb.TagNumber(3)
  set device($2.DeviceSelect value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDevice() => $_has(2);
  @$pb.TagNumber(3)
  void clearDevice() => $_clearField(3);
  @$pb.TagNumber(3)
  $2.DeviceSelect ensureDevice() => $_ensure(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
