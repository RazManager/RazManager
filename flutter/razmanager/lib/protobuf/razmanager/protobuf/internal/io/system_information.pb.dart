// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/io/system_information.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart'
    as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class SystemInformationRead extends $pb.GeneratedMessage {
  factory SystemInformationRead({
    $2.StringValue? hardwareModel,
    $2.StringValue? hardwareProcessor,
    $2.StringValue? softwareAssemblyVersion,
    $2.StringValue? softwareSnapVersion,
    $2.StringValue? softwareDotNetVersion,
    $2.StringValue? softwareOsVersion,
    $2.StringValue? softwareOsReleaseVersion,
    $core.Iterable<$core.String>? networkIpAddresses,
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
    if (networkIpAddresses != null)
      result.networkIpAddresses.addAll(networkIpAddresses);
    return result;
  }

  SystemInformationRead._();

  factory SystemInformationRead.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SystemInformationRead.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SystemInformationRead',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.io.system_information'),
      createEmptyInstance: create)
    ..aOM<$2.StringValue>(1, _omitFieldNames ? '' : 'hardwareModel',
        subBuilder: $2.StringValue.create)
    ..aOM<$2.StringValue>(2, _omitFieldNames ? '' : 'hardwareProcessor',
        subBuilder: $2.StringValue.create)
    ..aOM<$2.StringValue>(3, _omitFieldNames ? '' : 'softwareAssemblyVersion',
        subBuilder: $2.StringValue.create)
    ..aOM<$2.StringValue>(4, _omitFieldNames ? '' : 'softwareSnapVersion',
        subBuilder: $2.StringValue.create)
    ..aOM<$2.StringValue>(5, _omitFieldNames ? '' : 'softwareDotNetVersion',
        subBuilder: $2.StringValue.create)
    ..aOM<$2.StringValue>(6, _omitFieldNames ? '' : 'softwareOsVersion',
        subBuilder: $2.StringValue.create)
    ..aOM<$2.StringValue>(7, _omitFieldNames ? '' : 'softwareOsReleaseVersion',
        subBuilder: $2.StringValue.create)
    ..pPS(8, _omitFieldNames ? '' : 'networkIpAddresses')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SystemInformationRead clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SystemInformationRead copyWith(
          void Function(SystemInformationRead) updates) =>
      super.copyWith((message) => updates(message as SystemInformationRead))
          as SystemInformationRead;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SystemInformationRead create() => SystemInformationRead._();
  @$core.override
  SystemInformationRead createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SystemInformationRead getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SystemInformationRead>(create);
  static SystemInformationRead? _defaultInstance;

  @$pb.TagNumber(1)
  $2.StringValue get hardwareModel => $_getN(0);
  @$pb.TagNumber(1)
  set hardwareModel($2.StringValue value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasHardwareModel() => $_has(0);
  @$pb.TagNumber(1)
  void clearHardwareModel() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.StringValue ensureHardwareModel() => $_ensure(0);

  @$pb.TagNumber(2)
  $2.StringValue get hardwareProcessor => $_getN(1);
  @$pb.TagNumber(2)
  set hardwareProcessor($2.StringValue value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasHardwareProcessor() => $_has(1);
  @$pb.TagNumber(2)
  void clearHardwareProcessor() => $_clearField(2);
  @$pb.TagNumber(2)
  $2.StringValue ensureHardwareProcessor() => $_ensure(1);

  @$pb.TagNumber(3)
  $2.StringValue get softwareAssemblyVersion => $_getN(2);
  @$pb.TagNumber(3)
  set softwareAssemblyVersion($2.StringValue value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSoftwareAssemblyVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearSoftwareAssemblyVersion() => $_clearField(3);
  @$pb.TagNumber(3)
  $2.StringValue ensureSoftwareAssemblyVersion() => $_ensure(2);

  @$pb.TagNumber(4)
  $2.StringValue get softwareSnapVersion => $_getN(3);
  @$pb.TagNumber(4)
  set softwareSnapVersion($2.StringValue value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasSoftwareSnapVersion() => $_has(3);
  @$pb.TagNumber(4)
  void clearSoftwareSnapVersion() => $_clearField(4);
  @$pb.TagNumber(4)
  $2.StringValue ensureSoftwareSnapVersion() => $_ensure(3);

  @$pb.TagNumber(5)
  $2.StringValue get softwareDotNetVersion => $_getN(4);
  @$pb.TagNumber(5)
  set softwareDotNetVersion($2.StringValue value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasSoftwareDotNetVersion() => $_has(4);
  @$pb.TagNumber(5)
  void clearSoftwareDotNetVersion() => $_clearField(5);
  @$pb.TagNumber(5)
  $2.StringValue ensureSoftwareDotNetVersion() => $_ensure(4);

  @$pb.TagNumber(6)
  $2.StringValue get softwareOsVersion => $_getN(5);
  @$pb.TagNumber(6)
  set softwareOsVersion($2.StringValue value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasSoftwareOsVersion() => $_has(5);
  @$pb.TagNumber(6)
  void clearSoftwareOsVersion() => $_clearField(6);
  @$pb.TagNumber(6)
  $2.StringValue ensureSoftwareOsVersion() => $_ensure(5);

  @$pb.TagNumber(7)
  $2.StringValue get softwareOsReleaseVersion => $_getN(6);
  @$pb.TagNumber(7)
  set softwareOsReleaseVersion($2.StringValue value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasSoftwareOsReleaseVersion() => $_has(6);
  @$pb.TagNumber(7)
  void clearSoftwareOsReleaseVersion() => $_clearField(7);
  @$pb.TagNumber(7)
  $2.StringValue ensureSoftwareOsReleaseVersion() => $_ensure(6);

  @$pb.TagNumber(8)
  $pb.PbList<$core.String> get networkIpAddresses => $_getList(7);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
