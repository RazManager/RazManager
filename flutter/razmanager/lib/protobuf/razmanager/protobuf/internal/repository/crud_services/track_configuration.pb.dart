// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/track_configuration.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart'
    as $4;

import 'race_format_type.pb.dart' as $3;
import 'track.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class TrackConfigurationList extends $pb.GeneratedMessage {
  factory TrackConfigurationList({
    $core.String? id,
    $core.String? name,
    $1.TrackSelect? track,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (track != null) result.track = track;
    return result;
  }

  TrackConfigurationList._();

  factory TrackConfigurationList.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TrackConfigurationList.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TrackConfigurationList',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.track_configuration'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOM<$1.TrackSelect>(3, _omitFieldNames ? '' : 'track',
        subBuilder: $1.TrackSelect.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackConfigurationList clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackConfigurationList copyWith(
          void Function(TrackConfigurationList) updates) =>
      super.copyWith((message) => updates(message as TrackConfigurationList))
          as TrackConfigurationList;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TrackConfigurationList create() => TrackConfigurationList._();
  @$core.override
  TrackConfigurationList createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TrackConfigurationList getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TrackConfigurationList>(create);
  static TrackConfigurationList? _defaultInstance;

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
  $1.TrackSelect get track => $_getN(2);
  @$pb.TagNumber(3)
  set track($1.TrackSelect value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTrack() => $_has(2);
  @$pb.TagNumber(3)
  void clearTrack() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.TrackSelect ensureTrack() => $_ensure(2);
}

class TrackConfigurationSelectResponse extends $pb.GeneratedMessage {
  factory TrackConfigurationSelectResponse({
    $core.Iterable<TrackConfigurationSelect>? result,
  }) {
    final result$ = create();
    if (result != null) result$.result.addAll(result);
    return result$;
  }

  TrackConfigurationSelectResponse._();

  factory TrackConfigurationSelectResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TrackConfigurationSelectResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TrackConfigurationSelectResponse',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.track_configuration'),
      createEmptyInstance: create)
    ..pPM<TrackConfigurationSelect>(1, _omitFieldNames ? '' : 'result',
        subBuilder: TrackConfigurationSelect.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackConfigurationSelectResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackConfigurationSelectResponse copyWith(
          void Function(TrackConfigurationSelectResponse) updates) =>
      super.copyWith(
              (message) => updates(message as TrackConfigurationSelectResponse))
          as TrackConfigurationSelectResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TrackConfigurationSelectResponse create() =>
      TrackConfigurationSelectResponse._();
  @$core.override
  TrackConfigurationSelectResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TrackConfigurationSelectResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TrackConfigurationSelectResponse>(
          create);
  static TrackConfigurationSelectResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TrackConfigurationSelect> get result => $_getList(0);
}

class TrackConfigurationSelect extends $pb.GeneratedMessage {
  factory TrackConfigurationSelect({
    $core.String? id,
    $core.String? name,
    $1.TrackSelect? track,
    $core.Iterable<$3.RaceFormatTypeSelect>? trackConfigurationRaceFormats,
    $core.Iterable<TrackConfigurationIndicatorSelect>?
        trackConfigurationIndicators,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (track != null) result.track = track;
    if (trackConfigurationRaceFormats != null)
      result.trackConfigurationRaceFormats
          .addAll(trackConfigurationRaceFormats);
    if (trackConfigurationIndicators != null)
      result.trackConfigurationIndicators.addAll(trackConfigurationIndicators);
    return result;
  }

  TrackConfigurationSelect._();

  factory TrackConfigurationSelect.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TrackConfigurationSelect.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TrackConfigurationSelect',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.track_configuration'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOM<$1.TrackSelect>(3, _omitFieldNames ? '' : 'track',
        subBuilder: $1.TrackSelect.create)
    ..pPM<$3.RaceFormatTypeSelect>(
        4, _omitFieldNames ? '' : 'trackConfigurationRaceFormats',
        subBuilder: $3.RaceFormatTypeSelect.create)
    ..pPM<TrackConfigurationIndicatorSelect>(
        5, _omitFieldNames ? '' : 'trackConfigurationIndicators',
        subBuilder: TrackConfigurationIndicatorSelect.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackConfigurationSelect clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackConfigurationSelect copyWith(
          void Function(TrackConfigurationSelect) updates) =>
      super.copyWith((message) => updates(message as TrackConfigurationSelect))
          as TrackConfigurationSelect;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TrackConfigurationSelect create() => TrackConfigurationSelect._();
  @$core.override
  TrackConfigurationSelect createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TrackConfigurationSelect getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TrackConfigurationSelect>(create);
  static TrackConfigurationSelect? _defaultInstance;

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
  $1.TrackSelect get track => $_getN(2);
  @$pb.TagNumber(3)
  set track($1.TrackSelect value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTrack() => $_has(2);
  @$pb.TagNumber(3)
  void clearTrack() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.TrackSelect ensureTrack() => $_ensure(2);

  @$pb.TagNumber(4)
  $pb.PbList<$3.RaceFormatTypeSelect> get trackConfigurationRaceFormats =>
      $_getList(3);

  @$pb.TagNumber(5)
  $pb.PbList<TrackConfigurationIndicatorSelect>
      get trackConfigurationIndicators => $_getList(4);
}

class TrackConfigurationIndicatorSelect extends $pb.GeneratedMessage {
  factory TrackConfigurationIndicatorSelect({
    $core.int? indicatorId,
    $4.UInt32Value? color,
  }) {
    final result = create();
    if (indicatorId != null) result.indicatorId = indicatorId;
    if (color != null) result.color = color;
    return result;
  }

  TrackConfigurationIndicatorSelect._();

  factory TrackConfigurationIndicatorSelect.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TrackConfigurationIndicatorSelect.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TrackConfigurationIndicatorSelect',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.track_configuration'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'indicatorId',
        fieldType: $pb.PbFieldType.OU3)
    ..aOM<$4.UInt32Value>(2, _omitFieldNames ? '' : 'color',
        subBuilder: $4.UInt32Value.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackConfigurationIndicatorSelect clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackConfigurationIndicatorSelect copyWith(
          void Function(TrackConfigurationIndicatorSelect) updates) =>
      super.copyWith((message) =>
              updates(message as TrackConfigurationIndicatorSelect))
          as TrackConfigurationIndicatorSelect;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TrackConfigurationIndicatorSelect create() =>
      TrackConfigurationIndicatorSelect._();
  @$core.override
  TrackConfigurationIndicatorSelect createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TrackConfigurationIndicatorSelect getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TrackConfigurationIndicatorSelect>(
          create);
  static TrackConfigurationIndicatorSelect? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get indicatorId => $_getIZ(0);
  @$pb.TagNumber(1)
  set indicatorId($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIndicatorId() => $_has(0);
  @$pb.TagNumber(1)
  void clearIndicatorId() => $_clearField(1);

  @$pb.TagNumber(2)
  $4.UInt32Value get color => $_getN(1);
  @$pb.TagNumber(2)
  set color($4.UInt32Value value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasColor() => $_has(1);
  @$pb.TagNumber(2)
  void clearColor() => $_clearField(2);
  @$pb.TagNumber(2)
  $4.UInt32Value ensureColor() => $_ensure(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
