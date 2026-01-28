// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/heat_indicator_stint.proto.

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

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class HeatIndicatorStintReadResponse extends $pb.GeneratedMessage {
  factory HeatIndicatorStintReadResponse({
    HeatIndicatorStintRead? entity,
    $core.String? etag,
  }) {
    final result = create();
    if (entity != null) result.entity = entity;
    if (etag != null) result.etag = etag;
    return result;
  }

  HeatIndicatorStintReadResponse._();

  factory HeatIndicatorStintReadResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HeatIndicatorStintReadResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HeatIndicatorStintReadResponse',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.heat_indicator_stint'),
      createEmptyInstance: create)
    ..aOM<HeatIndicatorStintRead>(1, _omitFieldNames ? '' : 'entity',
        subBuilder: HeatIndicatorStintRead.create)
    ..aOS(2, _omitFieldNames ? '' : 'etag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatIndicatorStintReadResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatIndicatorStintReadResponse copyWith(
          void Function(HeatIndicatorStintReadResponse) updates) =>
      super.copyWith(
              (message) => updates(message as HeatIndicatorStintReadResponse))
          as HeatIndicatorStintReadResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HeatIndicatorStintReadResponse create() =>
      HeatIndicatorStintReadResponse._();
  @$core.override
  HeatIndicatorStintReadResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HeatIndicatorStintReadResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HeatIndicatorStintReadResponse>(create);
  static HeatIndicatorStintReadResponse? _defaultInstance;

  @$pb.TagNumber(1)
  HeatIndicatorStintRead get entity => $_getN(0);
  @$pb.TagNumber(1)
  set entity(HeatIndicatorStintRead value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasEntity() => $_has(0);
  @$pb.TagNumber(1)
  void clearEntity() => $_clearField(1);
  @$pb.TagNumber(1)
  HeatIndicatorStintRead ensureEntity() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get etag => $_getSZ(1);
  @$pb.TagNumber(2)
  set etag($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEtag() => $_has(1);
  @$pb.TagNumber(2)
  void clearEtag() => $_clearField(2);
}

class HeatIndicatorStintRead extends $pb.GeneratedMessage {
  factory HeatIndicatorStintRead({
    $3.StringValue? id,
    $core.int? lap,
    $3.StringValue? eventUserId,
    $3.StringValue? comments,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (lap != null) result.lap = lap;
    if (eventUserId != null) result.eventUserId = eventUserId;
    if (comments != null) result.comments = comments;
    return result;
  }

  HeatIndicatorStintRead._();

  factory HeatIndicatorStintRead.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HeatIndicatorStintRead.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HeatIndicatorStintRead',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.heat_indicator_stint'),
      createEmptyInstance: create)
    ..aOM<$3.StringValue>(1, _omitFieldNames ? '' : 'id',
        subBuilder: $3.StringValue.create)
    ..aI(3, _omitFieldNames ? '' : 'lap', fieldType: $pb.PbFieldType.OU3)
    ..aOM<$3.StringValue>(4, _omitFieldNames ? '' : 'eventUserId',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(5, _omitFieldNames ? '' : 'comments',
        subBuilder: $3.StringValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatIndicatorStintRead clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatIndicatorStintRead copyWith(
          void Function(HeatIndicatorStintRead) updates) =>
      super.copyWith((message) => updates(message as HeatIndicatorStintRead))
          as HeatIndicatorStintRead;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HeatIndicatorStintRead create() => HeatIndicatorStintRead._();
  @$core.override
  HeatIndicatorStintRead createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HeatIndicatorStintRead getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HeatIndicatorStintRead>(create);
  static HeatIndicatorStintRead? _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.int get lap => $_getIZ(1);
  @$pb.TagNumber(3)
  set lap($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(3)
  $core.bool hasLap() => $_has(1);
  @$pb.TagNumber(3)
  void clearLap() => $_clearField(3);

  @$pb.TagNumber(4)
  $3.StringValue get eventUserId => $_getN(2);
  @$pb.TagNumber(4)
  set eventUserId($3.StringValue value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasEventUserId() => $_has(2);
  @$pb.TagNumber(4)
  void clearEventUserId() => $_clearField(4);
  @$pb.TagNumber(4)
  $3.StringValue ensureEventUserId() => $_ensure(2);

  @$pb.TagNumber(5)
  $3.StringValue get comments => $_getN(3);
  @$pb.TagNumber(5)
  set comments($3.StringValue value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasComments() => $_has(3);
  @$pb.TagNumber(5)
  void clearComments() => $_clearField(5);
  @$pb.TagNumber(5)
  $3.StringValue ensureComments() => $_ensure(3);
}

class HeatIndicatorStintCreate extends $pb.GeneratedMessage {
  factory HeatIndicatorStintCreate({
    $core.String? heatIndicatorId,
    $core.int? lap,
    $3.StringValue? eventUserId,
    $3.StringValue? comments,
  }) {
    final result = create();
    if (heatIndicatorId != null) result.heatIndicatorId = heatIndicatorId;
    if (lap != null) result.lap = lap;
    if (eventUserId != null) result.eventUserId = eventUserId;
    if (comments != null) result.comments = comments;
    return result;
  }

  HeatIndicatorStintCreate._();

  factory HeatIndicatorStintCreate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HeatIndicatorStintCreate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HeatIndicatorStintCreate',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.heat_indicator_stint'),
      createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'heatIndicatorId')
    ..aI(3, _omitFieldNames ? '' : 'lap', fieldType: $pb.PbFieldType.OU3)
    ..aOM<$3.StringValue>(4, _omitFieldNames ? '' : 'eventUserId',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(5, _omitFieldNames ? '' : 'comments',
        subBuilder: $3.StringValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatIndicatorStintCreate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatIndicatorStintCreate copyWith(
          void Function(HeatIndicatorStintCreate) updates) =>
      super.copyWith((message) => updates(message as HeatIndicatorStintCreate))
          as HeatIndicatorStintCreate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HeatIndicatorStintCreate create() => HeatIndicatorStintCreate._();
  @$core.override
  HeatIndicatorStintCreate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HeatIndicatorStintCreate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HeatIndicatorStintCreate>(create);
  static HeatIndicatorStintCreate? _defaultInstance;

  @$pb.TagNumber(2)
  $core.String get heatIndicatorId => $_getSZ(0);
  @$pb.TagNumber(2)
  set heatIndicatorId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(2)
  $core.bool hasHeatIndicatorId() => $_has(0);
  @$pb.TagNumber(2)
  void clearHeatIndicatorId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get lap => $_getIZ(1);
  @$pb.TagNumber(3)
  set lap($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(3)
  $core.bool hasLap() => $_has(1);
  @$pb.TagNumber(3)
  void clearLap() => $_clearField(3);

  @$pb.TagNumber(4)
  $3.StringValue get eventUserId => $_getN(2);
  @$pb.TagNumber(4)
  set eventUserId($3.StringValue value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasEventUserId() => $_has(2);
  @$pb.TagNumber(4)
  void clearEventUserId() => $_clearField(4);
  @$pb.TagNumber(4)
  $3.StringValue ensureEventUserId() => $_ensure(2);

  @$pb.TagNumber(5)
  $3.StringValue get comments => $_getN(3);
  @$pb.TagNumber(5)
  set comments($3.StringValue value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasComments() => $_has(3);
  @$pb.TagNumber(5)
  void clearComments() => $_clearField(5);
  @$pb.TagNumber(5)
  $3.StringValue ensureComments() => $_ensure(3);
}

class HeatIndicatorStintUpdate extends $pb.GeneratedMessage {
  factory HeatIndicatorStintUpdate({
    $core.int? lap,
    $3.StringValue? eventUserId,
    $3.StringValue? comments,
  }) {
    final result = create();
    if (lap != null) result.lap = lap;
    if (eventUserId != null) result.eventUserId = eventUserId;
    if (comments != null) result.comments = comments;
    return result;
  }

  HeatIndicatorStintUpdate._();

  factory HeatIndicatorStintUpdate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HeatIndicatorStintUpdate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HeatIndicatorStintUpdate',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.heat_indicator_stint'),
      createEmptyInstance: create)
    ..aI(3, _omitFieldNames ? '' : 'lap', fieldType: $pb.PbFieldType.OU3)
    ..aOM<$3.StringValue>(4, _omitFieldNames ? '' : 'eventUserId',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(5, _omitFieldNames ? '' : 'comments',
        subBuilder: $3.StringValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatIndicatorStintUpdate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatIndicatorStintUpdate copyWith(
          void Function(HeatIndicatorStintUpdate) updates) =>
      super.copyWith((message) => updates(message as HeatIndicatorStintUpdate))
          as HeatIndicatorStintUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HeatIndicatorStintUpdate create() => HeatIndicatorStintUpdate._();
  @$core.override
  HeatIndicatorStintUpdate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HeatIndicatorStintUpdate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HeatIndicatorStintUpdate>(create);
  static HeatIndicatorStintUpdate? _defaultInstance;

  @$pb.TagNumber(3)
  $core.int get lap => $_getIZ(0);
  @$pb.TagNumber(3)
  set lap($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(3)
  $core.bool hasLap() => $_has(0);
  @$pb.TagNumber(3)
  void clearLap() => $_clearField(3);

  @$pb.TagNumber(4)
  $3.StringValue get eventUserId => $_getN(1);
  @$pb.TagNumber(4)
  set eventUserId($3.StringValue value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasEventUserId() => $_has(1);
  @$pb.TagNumber(4)
  void clearEventUserId() => $_clearField(4);
  @$pb.TagNumber(4)
  $3.StringValue ensureEventUserId() => $_ensure(1);

  @$pb.TagNumber(5)
  $3.StringValue get comments => $_getN(2);
  @$pb.TagNumber(5)
  set comments($3.StringValue value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasComments() => $_has(2);
  @$pb.TagNumber(5)
  void clearComments() => $_clearField(5);
  @$pb.TagNumber(5)
  $3.StringValue ensureComments() => $_ensure(2);
}

class HeatIndicatorStintUpdateRequest extends $pb.GeneratedMessage {
  factory HeatIndicatorStintUpdateRequest({
    $core.String? id,
    HeatIndicatorStintUpdate? entity,
    $core.String? etag,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (entity != null) result.entity = entity;
    if (etag != null) result.etag = etag;
    return result;
  }

  HeatIndicatorStintUpdateRequest._();

  factory HeatIndicatorStintUpdateRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HeatIndicatorStintUpdateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HeatIndicatorStintUpdateRequest',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.heat_indicator_stint'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<HeatIndicatorStintUpdate>(2, _omitFieldNames ? '' : 'entity',
        subBuilder: HeatIndicatorStintUpdate.create)
    ..aOS(3, _omitFieldNames ? '' : 'etag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatIndicatorStintUpdateRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatIndicatorStintUpdateRequest copyWith(
          void Function(HeatIndicatorStintUpdateRequest) updates) =>
      super.copyWith(
              (message) => updates(message as HeatIndicatorStintUpdateRequest))
          as HeatIndicatorStintUpdateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HeatIndicatorStintUpdateRequest create() =>
      HeatIndicatorStintUpdateRequest._();
  @$core.override
  HeatIndicatorStintUpdateRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HeatIndicatorStintUpdateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HeatIndicatorStintUpdateRequest>(
          create);
  static HeatIndicatorStintUpdateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  HeatIndicatorStintUpdate get entity => $_getN(1);
  @$pb.TagNumber(2)
  set entity(HeatIndicatorStintUpdate value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEntity() => $_has(1);
  @$pb.TagNumber(2)
  void clearEntity() => $_clearField(2);
  @$pb.TagNumber(2)
  HeatIndicatorStintUpdate ensureEntity() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get etag => $_getSZ(2);
  @$pb.TagNumber(3)
  set etag($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEtag() => $_has(2);
  @$pb.TagNumber(3)
  void clearEtag() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
