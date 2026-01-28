// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/track_configuration.v1.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'device_configuration_feature_type_id.v1.pbenum.dart' as $1;
import 'track.v1.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class TrackConfiguration extends $pb.GeneratedMessage {
  factory TrackConfiguration({
    $core.String? id,
    $core.String? name,
    $0.Track? track,
    $core.Iterable<$1.DeviceConfigurationFeatureTypeId>?
        deviceConfigurationFeatures,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (track != null) result.track = track;
    if (deviceConfigurationFeatures != null)
      result.deviceConfigurationFeatures.addAll(deviceConfigurationFeatures);
    return result;
  }

  TrackConfiguration._();

  factory TrackConfiguration.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TrackConfiguration.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TrackConfiguration',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOM<$0.Track>(3, _omitFieldNames ? '' : 'track',
        subBuilder: $0.Track.create)
    ..pc<$1.DeviceConfigurationFeatureTypeId>(
        4,
        _omitFieldNames ? '' : 'deviceConfigurationFeatures',
        $pb.PbFieldType.KE,
        valueOf: $1.DeviceConfigurationFeatureTypeId.valueOf,
        enumValues: $1.DeviceConfigurationFeatureTypeId.values,
        defaultEnumValue: $1.DeviceConfigurationFeatureTypeId
            .DEVICE_CONFIGURATION_FEATURE_TYPE_ID_UNDEFINED)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackConfiguration clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackConfiguration copyWith(void Function(TrackConfiguration) updates) =>
      super.copyWith((message) => updates(message as TrackConfiguration))
          as TrackConfiguration;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TrackConfiguration create() => TrackConfiguration._();
  @$core.override
  TrackConfiguration createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TrackConfiguration getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TrackConfiguration>(create);
  static TrackConfiguration? _defaultInstance;

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
  $0.Track get track => $_getN(2);
  @$pb.TagNumber(3)
  set track($0.Track value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTrack() => $_has(2);
  @$pb.TagNumber(3)
  void clearTrack() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.Track ensureTrack() => $_ensure(2);

  @$pb.TagNumber(4)
  $pb.PbList<$1.DeviceConfigurationFeatureTypeId>
      get deviceConfigurationFeatures => $_getList(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
