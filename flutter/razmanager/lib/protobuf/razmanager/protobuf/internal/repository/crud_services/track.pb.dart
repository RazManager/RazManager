// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/track.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart'
    as $3;

import 'race_format_type.pbenum.dart' as $4;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class TrackReadResponse extends $pb.GeneratedMessage {
  factory TrackReadResponse({
    TrackRead? entity,
    $core.String? etag,
  }) {
    final result = create();
    if (entity != null) result.entity = entity;
    if (etag != null) result.etag = etag;
    return result;
  }

  TrackReadResponse._();

  factory TrackReadResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TrackReadResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TrackReadResponse',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.track'),
      createEmptyInstance: create)
    ..aOM<TrackRead>(1, _omitFieldNames ? '' : 'entity',
        subBuilder: TrackRead.create)
    ..aOS(2, _omitFieldNames ? '' : 'etag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackReadResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackReadResponse copyWith(void Function(TrackReadResponse) updates) =>
      super.copyWith((message) => updates(message as TrackReadResponse))
          as TrackReadResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TrackReadResponse create() => TrackReadResponse._();
  @$core.override
  TrackReadResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TrackReadResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TrackReadResponse>(create);
  static TrackReadResponse? _defaultInstance;

  @$pb.TagNumber(1)
  TrackRead get entity => $_getN(0);
  @$pb.TagNumber(1)
  set entity(TrackRead value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasEntity() => $_has(0);
  @$pb.TagNumber(1)
  void clearEntity() => $_clearField(1);
  @$pb.TagNumber(1)
  TrackRead ensureEntity() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get etag => $_getSZ(1);
  @$pb.TagNumber(2)
  set etag($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEtag() => $_has(1);
  @$pb.TagNumber(2)
  void clearEtag() => $_clearField(2);
}

class TrackRead extends $pb.GeneratedMessage {
  factory TrackRead({
    $3.StringValue? id,
    $3.StringValue? name,
    $3.StringValue? description,
    $3.BytesValue? image,
    $core.Iterable<TrackConfigurationReadCreateUpdate>? trackConfigurations,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (image != null) result.image = image;
    if (trackConfigurations != null)
      result.trackConfigurations.addAll(trackConfigurations);
    return result;
  }

  TrackRead._();

  factory TrackRead.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TrackRead.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TrackRead',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.track'),
      createEmptyInstance: create)
    ..aOM<$3.StringValue>(1, _omitFieldNames ? '' : 'id',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(2, _omitFieldNames ? '' : 'name',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(3, _omitFieldNames ? '' : 'description',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.BytesValue>(4, _omitFieldNames ? '' : 'image',
        subBuilder: $3.BytesValue.create)
    ..pPM<TrackConfigurationReadCreateUpdate>(
        5, _omitFieldNames ? '' : 'trackConfigurations',
        subBuilder: TrackConfigurationReadCreateUpdate.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackRead clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackRead copyWith(void Function(TrackRead) updates) =>
      super.copyWith((message) => updates(message as TrackRead)) as TrackRead;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TrackRead create() => TrackRead._();
  @$core.override
  TrackRead createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TrackRead getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TrackRead>(create);
  static TrackRead? _defaultInstance;

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
  $3.BytesValue get image => $_getN(3);
  @$pb.TagNumber(4)
  set image($3.BytesValue value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasImage() => $_has(3);
  @$pb.TagNumber(4)
  void clearImage() => $_clearField(4);
  @$pb.TagNumber(4)
  $3.BytesValue ensureImage() => $_ensure(3);

  @$pb.TagNumber(5)
  $pb.PbList<TrackConfigurationReadCreateUpdate> get trackConfigurations =>
      $_getList(4);
}

class TrackCreateUpdate extends $pb.GeneratedMessage {
  factory TrackCreateUpdate({
    $core.String? name,
    $3.StringValue? description,
    $core.List<$core.int>? image,
    $core.bool? imageDeleted,
    $core.Iterable<TrackConfigurationReadCreateUpdate>? trackConfigurations,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (image != null) result.image = image;
    if (imageDeleted != null) result.imageDeleted = imageDeleted;
    if (trackConfigurations != null)
      result.trackConfigurations.addAll(trackConfigurations);
    return result;
  }

  TrackCreateUpdate._();

  factory TrackCreateUpdate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TrackCreateUpdate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TrackCreateUpdate',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.track'),
      createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOM<$3.StringValue>(3, _omitFieldNames ? '' : 'description',
        subBuilder: $3.StringValue.create)
    ..a<$core.List<$core.int>>(
        4, _omitFieldNames ? '' : 'image', $pb.PbFieldType.OY)
    ..aOB(5, _omitFieldNames ? '' : 'imageDeleted')
    ..pPM<TrackConfigurationReadCreateUpdate>(
        6, _omitFieldNames ? '' : 'trackConfigurations',
        subBuilder: TrackConfigurationReadCreateUpdate.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackCreateUpdate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackCreateUpdate copyWith(void Function(TrackCreateUpdate) updates) =>
      super.copyWith((message) => updates(message as TrackCreateUpdate))
          as TrackCreateUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TrackCreateUpdate create() => TrackCreateUpdate._();
  @$core.override
  TrackCreateUpdate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TrackCreateUpdate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TrackCreateUpdate>(create);
  static TrackCreateUpdate? _defaultInstance;

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

  @$pb.TagNumber(4)
  $core.List<$core.int> get image => $_getN(2);
  @$pb.TagNumber(4)
  set image($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(4)
  $core.bool hasImage() => $_has(2);
  @$pb.TagNumber(4)
  void clearImage() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get imageDeleted => $_getBF(3);
  @$pb.TagNumber(5)
  set imageDeleted($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(5)
  $core.bool hasImageDeleted() => $_has(3);
  @$pb.TagNumber(5)
  void clearImageDeleted() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<TrackConfigurationReadCreateUpdate> get trackConfigurations =>
      $_getList(4);
}

class TrackUpdateRequest extends $pb.GeneratedMessage {
  factory TrackUpdateRequest({
    $core.String? id,
    TrackCreateUpdate? entity,
    $core.String? etag,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (entity != null) result.entity = entity;
    if (etag != null) result.etag = etag;
    return result;
  }

  TrackUpdateRequest._();

  factory TrackUpdateRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TrackUpdateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TrackUpdateRequest',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.track'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<TrackCreateUpdate>(2, _omitFieldNames ? '' : 'entity',
        subBuilder: TrackCreateUpdate.create)
    ..aOS(3, _omitFieldNames ? '' : 'etag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackUpdateRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackUpdateRequest copyWith(void Function(TrackUpdateRequest) updates) =>
      super.copyWith((message) => updates(message as TrackUpdateRequest))
          as TrackUpdateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TrackUpdateRequest create() => TrackUpdateRequest._();
  @$core.override
  TrackUpdateRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TrackUpdateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TrackUpdateRequest>(create);
  static TrackUpdateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  TrackCreateUpdate get entity => $_getN(1);
  @$pb.TagNumber(2)
  set entity(TrackCreateUpdate value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEntity() => $_has(1);
  @$pb.TagNumber(2)
  void clearEntity() => $_clearField(2);
  @$pb.TagNumber(2)
  TrackCreateUpdate ensureEntity() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get etag => $_getSZ(2);
  @$pb.TagNumber(3)
  set etag($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEtag() => $_has(2);
  @$pb.TagNumber(3)
  void clearEtag() => $_clearField(3);
}

class TrackConfigurationReadCreateUpdate extends $pb.GeneratedMessage {
  factory TrackConfigurationReadCreateUpdate({
    $3.StringValue? id,
    $3.StringValue? name,
    $core.int? laptimeMinSeconds,
    $core.int? laptimeMaxSeconds,
    $core.Iterable<$core.String>? deviceConfigurationIds,
    $core.Iterable<$4.RaceFormatTypeId>? raceFormatTypeIds,
    $core.Iterable<TrackConfigurationIndicatorReadCreateUpdate>?
        trackConfigurationIndicators,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (laptimeMinSeconds != null) result.laptimeMinSeconds = laptimeMinSeconds;
    if (laptimeMaxSeconds != null) result.laptimeMaxSeconds = laptimeMaxSeconds;
    if (deviceConfigurationIds != null)
      result.deviceConfigurationIds.addAll(deviceConfigurationIds);
    if (raceFormatTypeIds != null)
      result.raceFormatTypeIds.addAll(raceFormatTypeIds);
    if (trackConfigurationIndicators != null)
      result.trackConfigurationIndicators.addAll(trackConfigurationIndicators);
    return result;
  }

  TrackConfigurationReadCreateUpdate._();

  factory TrackConfigurationReadCreateUpdate.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TrackConfigurationReadCreateUpdate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TrackConfigurationReadCreateUpdate',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.track'),
      createEmptyInstance: create)
    ..aOM<$3.StringValue>(1, _omitFieldNames ? '' : 'id',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(2, _omitFieldNames ? '' : 'name',
        subBuilder: $3.StringValue.create)
    ..aI(3, _omitFieldNames ? '' : 'laptimeMinSeconds',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(4, _omitFieldNames ? '' : 'laptimeMaxSeconds',
        fieldType: $pb.PbFieldType.OU3)
    ..pPS(5, _omitFieldNames ? '' : 'deviceConfigurationIds')
    ..pc<$4.RaceFormatTypeId>(
        6, _omitFieldNames ? '' : 'raceFormatTypeIds', $pb.PbFieldType.KE,
        valueOf: $4.RaceFormatTypeId.valueOf,
        enumValues: $4.RaceFormatTypeId.values,
        defaultEnumValue: $4.RaceFormatTypeId.RACE_FORMAT_TYPE_ID_UNDEFINED)
    ..pPM<TrackConfigurationIndicatorReadCreateUpdate>(
        7, _omitFieldNames ? '' : 'trackConfigurationIndicators',
        subBuilder: TrackConfigurationIndicatorReadCreateUpdate.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackConfigurationReadCreateUpdate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackConfigurationReadCreateUpdate copyWith(
          void Function(TrackConfigurationReadCreateUpdate) updates) =>
      super.copyWith((message) =>
              updates(message as TrackConfigurationReadCreateUpdate))
          as TrackConfigurationReadCreateUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TrackConfigurationReadCreateUpdate create() =>
      TrackConfigurationReadCreateUpdate._();
  @$core.override
  TrackConfigurationReadCreateUpdate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TrackConfigurationReadCreateUpdate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TrackConfigurationReadCreateUpdate>(
          create);
  static TrackConfigurationReadCreateUpdate? _defaultInstance;

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
  $core.int get laptimeMinSeconds => $_getIZ(2);
  @$pb.TagNumber(3)
  set laptimeMinSeconds($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLaptimeMinSeconds() => $_has(2);
  @$pb.TagNumber(3)
  void clearLaptimeMinSeconds() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get laptimeMaxSeconds => $_getIZ(3);
  @$pb.TagNumber(4)
  set laptimeMaxSeconds($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLaptimeMaxSeconds() => $_has(3);
  @$pb.TagNumber(4)
  void clearLaptimeMaxSeconds() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get deviceConfigurationIds => $_getList(4);

  @$pb.TagNumber(6)
  $pb.PbList<$4.RaceFormatTypeId> get raceFormatTypeIds => $_getList(5);

  @$pb.TagNumber(7)
  $pb.PbList<TrackConfigurationIndicatorReadCreateUpdate>
      get trackConfigurationIndicators => $_getList(6);
}

class TrackConfigurationIndicatorReadCreateUpdate extends $pb.GeneratedMessage {
  factory TrackConfigurationIndicatorReadCreateUpdate({
    $core.int? indicatorId,
    $core.int? color,
  }) {
    final result = create();
    if (indicatorId != null) result.indicatorId = indicatorId;
    if (color != null) result.color = color;
    return result;
  }

  TrackConfigurationIndicatorReadCreateUpdate._();

  factory TrackConfigurationIndicatorReadCreateUpdate.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TrackConfigurationIndicatorReadCreateUpdate.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TrackConfigurationIndicatorReadCreateUpdate',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.track'),
      createEmptyInstance: create)
    ..aI(2, _omitFieldNames ? '' : 'indicatorId',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'color', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackConfigurationIndicatorReadCreateUpdate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackConfigurationIndicatorReadCreateUpdate copyWith(
          void Function(TrackConfigurationIndicatorReadCreateUpdate) updates) =>
      super.copyWith((message) =>
              updates(message as TrackConfigurationIndicatorReadCreateUpdate))
          as TrackConfigurationIndicatorReadCreateUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TrackConfigurationIndicatorReadCreateUpdate create() =>
      TrackConfigurationIndicatorReadCreateUpdate._();
  @$core.override
  TrackConfigurationIndicatorReadCreateUpdate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TrackConfigurationIndicatorReadCreateUpdate getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          TrackConfigurationIndicatorReadCreateUpdate>(create);
  static TrackConfigurationIndicatorReadCreateUpdate? _defaultInstance;

  @$pb.TagNumber(2)
  $core.int get indicatorId => $_getIZ(0);
  @$pb.TagNumber(2)
  set indicatorId($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(2)
  $core.bool hasIndicatorId() => $_has(0);
  @$pb.TagNumber(2)
  void clearIndicatorId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get color => $_getIZ(1);
  @$pb.TagNumber(3)
  set color($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(3)
  $core.bool hasColor() => $_has(1);
  @$pb.TagNumber(3)
  void clearColor() => $_clearField(3);
}

class TrackListResponse extends $pb.GeneratedMessage {
  factory TrackListResponse({
    $core.Iterable<TrackList>? result,
  }) {
    final result$ = create();
    if (result != null) result$.result.addAll(result);
    return result$;
  }

  TrackListResponse._();

  factory TrackListResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TrackListResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TrackListResponse',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.track'),
      createEmptyInstance: create)
    ..pPM<TrackList>(1, _omitFieldNames ? '' : 'result',
        subBuilder: TrackList.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackListResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackListResponse copyWith(void Function(TrackListResponse) updates) =>
      super.copyWith((message) => updates(message as TrackListResponse))
          as TrackListResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TrackListResponse create() => TrackListResponse._();
  @$core.override
  TrackListResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TrackListResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TrackListResponse>(create);
  static TrackListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TrackList> get result => $_getList(0);
}

class TrackList extends $pb.GeneratedMessage {
  factory TrackList({
    $core.String? id,
    $core.String? name,
    $3.StringValue? description,
    $3.BytesValue? image,
    $core.String? etag,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (image != null) result.image = image;
    if (etag != null) result.etag = etag;
    return result;
  }

  TrackList._();

  factory TrackList.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TrackList.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TrackList',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.track'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOM<$3.StringValue>(3, _omitFieldNames ? '' : 'description',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.BytesValue>(4, _omitFieldNames ? '' : 'image',
        subBuilder: $3.BytesValue.create)
    ..aOS(5, _omitFieldNames ? '' : 'etag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackList clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackList copyWith(void Function(TrackList) updates) =>
      super.copyWith((message) => updates(message as TrackList)) as TrackList;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TrackList create() => TrackList._();
  @$core.override
  TrackList createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TrackList getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TrackList>(create);
  static TrackList? _defaultInstance;

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
  $3.BytesValue get image => $_getN(3);
  @$pb.TagNumber(4)
  set image($3.BytesValue value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasImage() => $_has(3);
  @$pb.TagNumber(4)
  void clearImage() => $_clearField(4);
  @$pb.TagNumber(4)
  $3.BytesValue ensureImage() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get etag => $_getSZ(4);
  @$pb.TagNumber(5)
  set etag($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasEtag() => $_has(4);
  @$pb.TagNumber(5)
  void clearEtag() => $_clearField(5);
}

class TrackSelect extends $pb.GeneratedMessage {
  factory TrackSelect({
    $core.String? id,
    $core.String? name,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    return result;
  }

  TrackSelect._();

  factory TrackSelect.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TrackSelect.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TrackSelect',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.track'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackSelect clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackSelect copyWith(void Function(TrackSelect) updates) =>
      super.copyWith((message) => updates(message as TrackSelect))
          as TrackSelect;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TrackSelect create() => TrackSelect._();
  @$core.override
  TrackSelect createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TrackSelect getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TrackSelect>(create);
  static TrackSelect? _defaultInstance;

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

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
