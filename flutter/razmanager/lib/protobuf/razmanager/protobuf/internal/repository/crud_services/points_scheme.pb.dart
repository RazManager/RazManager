// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/points_scheme.proto.

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

class PointsSchemeReadResponse extends $pb.GeneratedMessage {
  factory PointsSchemeReadResponse({
    PointsSchemeRead? entity,
    $core.String? etag,
  }) {
    final result = create();
    if (entity != null) result.entity = entity;
    if (etag != null) result.etag = etag;
    return result;
  }

  PointsSchemeReadResponse._();

  factory PointsSchemeReadResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PointsSchemeReadResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PointsSchemeReadResponse',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.points_scheme'),
      createEmptyInstance: create)
    ..aOM<PointsSchemeRead>(1, _omitFieldNames ? '' : 'entity',
        subBuilder: PointsSchemeRead.create)
    ..aOS(2, _omitFieldNames ? '' : 'etag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PointsSchemeReadResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PointsSchemeReadResponse copyWith(
          void Function(PointsSchemeReadResponse) updates) =>
      super.copyWith((message) => updates(message as PointsSchemeReadResponse))
          as PointsSchemeReadResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PointsSchemeReadResponse create() => PointsSchemeReadResponse._();
  @$core.override
  PointsSchemeReadResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PointsSchemeReadResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PointsSchemeReadResponse>(create);
  static PointsSchemeReadResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PointsSchemeRead get entity => $_getN(0);
  @$pb.TagNumber(1)
  set entity(PointsSchemeRead value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasEntity() => $_has(0);
  @$pb.TagNumber(1)
  void clearEntity() => $_clearField(1);
  @$pb.TagNumber(1)
  PointsSchemeRead ensureEntity() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get etag => $_getSZ(1);
  @$pb.TagNumber(2)
  set etag($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEtag() => $_has(1);
  @$pb.TagNumber(2)
  void clearEtag() => $_clearField(2);
}

class PointsSchemeRead extends $pb.GeneratedMessage {
  factory PointsSchemeRead({
    $3.StringValue? id,
    $3.StringValue? name,
    $3.StringValue? description,
    $core.int? position,
    $3.UInt32Value? pointsRaceSessionHeatFastestLap,
    $3.UInt32Value? pointsRaceSessionHeatMostLedLaps,
    $3.UInt32Value? pointsRaceSessionHeatLedAtLeastOneLap,
    $3.UInt32Value? pointsRaceSessionOverallFastestLap,
    $3.UInt32Value? pointsRaceSessionOverallMostLedLaps,
    $core.int? minDrivers,
    $core.int? maxDrivers,
    $core.Iterable<PointsSchemePositionReadCreateUpdate>? pointsSchemePositions,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (position != null) result.position = position;
    if (pointsRaceSessionHeatFastestLap != null)
      result.pointsRaceSessionHeatFastestLap = pointsRaceSessionHeatFastestLap;
    if (pointsRaceSessionHeatMostLedLaps != null)
      result.pointsRaceSessionHeatMostLedLaps =
          pointsRaceSessionHeatMostLedLaps;
    if (pointsRaceSessionHeatLedAtLeastOneLap != null)
      result.pointsRaceSessionHeatLedAtLeastOneLap =
          pointsRaceSessionHeatLedAtLeastOneLap;
    if (pointsRaceSessionOverallFastestLap != null)
      result.pointsRaceSessionOverallFastestLap =
          pointsRaceSessionOverallFastestLap;
    if (pointsRaceSessionOverallMostLedLaps != null)
      result.pointsRaceSessionOverallMostLedLaps =
          pointsRaceSessionOverallMostLedLaps;
    if (minDrivers != null) result.minDrivers = minDrivers;
    if (maxDrivers != null) result.maxDrivers = maxDrivers;
    if (pointsSchemePositions != null)
      result.pointsSchemePositions.addAll(pointsSchemePositions);
    return result;
  }

  PointsSchemeRead._();

  factory PointsSchemeRead.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PointsSchemeRead.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PointsSchemeRead',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.points_scheme'),
      createEmptyInstance: create)
    ..aOM<$3.StringValue>(1, _omitFieldNames ? '' : 'id',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(2, _omitFieldNames ? '' : 'name',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(3, _omitFieldNames ? '' : 'description',
        subBuilder: $3.StringValue.create)
    ..aI(4, _omitFieldNames ? '' : 'position', fieldType: $pb.PbFieldType.OU3)
    ..aOM<$3.UInt32Value>(
        5, _omitFieldNames ? '' : 'pointsRaceSessionHeatFastestLap',
        subBuilder: $3.UInt32Value.create)
    ..aOM<$3.UInt32Value>(
        6, _omitFieldNames ? '' : 'pointsRaceSessionHeatMostLedLaps',
        subBuilder: $3.UInt32Value.create)
    ..aOM<$3.UInt32Value>(
        7, _omitFieldNames ? '' : 'pointsRaceSessionHeatLedAtLeastOneLap',
        subBuilder: $3.UInt32Value.create)
    ..aOM<$3.UInt32Value>(
        8, _omitFieldNames ? '' : 'pointsRaceSessionOverallFastestLap',
        subBuilder: $3.UInt32Value.create)
    ..aOM<$3.UInt32Value>(
        9, _omitFieldNames ? '' : 'pointsRaceSessionOverallMostLedLaps',
        subBuilder: $3.UInt32Value.create)
    ..aI(11, _omitFieldNames ? '' : 'minDrivers',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(12, _omitFieldNames ? '' : 'maxDrivers',
        fieldType: $pb.PbFieldType.OU3)
    ..pPM<PointsSchemePositionReadCreateUpdate>(
        14, _omitFieldNames ? '' : 'pointsSchemePositions',
        subBuilder: PointsSchemePositionReadCreateUpdate.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PointsSchemeRead clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PointsSchemeRead copyWith(void Function(PointsSchemeRead) updates) =>
      super.copyWith((message) => updates(message as PointsSchemeRead))
          as PointsSchemeRead;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PointsSchemeRead create() => PointsSchemeRead._();
  @$core.override
  PointsSchemeRead createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PointsSchemeRead getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PointsSchemeRead>(create);
  static PointsSchemeRead? _defaultInstance;

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
  $core.int get position => $_getIZ(3);
  @$pb.TagNumber(4)
  set position($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPosition() => $_has(3);
  @$pb.TagNumber(4)
  void clearPosition() => $_clearField(4);

  @$pb.TagNumber(5)
  $3.UInt32Value get pointsRaceSessionHeatFastestLap => $_getN(4);
  @$pb.TagNumber(5)
  set pointsRaceSessionHeatFastestLap($3.UInt32Value value) =>
      $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasPointsRaceSessionHeatFastestLap() => $_has(4);
  @$pb.TagNumber(5)
  void clearPointsRaceSessionHeatFastestLap() => $_clearField(5);
  @$pb.TagNumber(5)
  $3.UInt32Value ensurePointsRaceSessionHeatFastestLap() => $_ensure(4);

  @$pb.TagNumber(6)
  $3.UInt32Value get pointsRaceSessionHeatMostLedLaps => $_getN(5);
  @$pb.TagNumber(6)
  set pointsRaceSessionHeatMostLedLaps($3.UInt32Value value) =>
      $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasPointsRaceSessionHeatMostLedLaps() => $_has(5);
  @$pb.TagNumber(6)
  void clearPointsRaceSessionHeatMostLedLaps() => $_clearField(6);
  @$pb.TagNumber(6)
  $3.UInt32Value ensurePointsRaceSessionHeatMostLedLaps() => $_ensure(5);

  @$pb.TagNumber(7)
  $3.UInt32Value get pointsRaceSessionHeatLedAtLeastOneLap => $_getN(6);
  @$pb.TagNumber(7)
  set pointsRaceSessionHeatLedAtLeastOneLap($3.UInt32Value value) =>
      $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasPointsRaceSessionHeatLedAtLeastOneLap() => $_has(6);
  @$pb.TagNumber(7)
  void clearPointsRaceSessionHeatLedAtLeastOneLap() => $_clearField(7);
  @$pb.TagNumber(7)
  $3.UInt32Value ensurePointsRaceSessionHeatLedAtLeastOneLap() => $_ensure(6);

  @$pb.TagNumber(8)
  $3.UInt32Value get pointsRaceSessionOverallFastestLap => $_getN(7);
  @$pb.TagNumber(8)
  set pointsRaceSessionOverallFastestLap($3.UInt32Value value) =>
      $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasPointsRaceSessionOverallFastestLap() => $_has(7);
  @$pb.TagNumber(8)
  void clearPointsRaceSessionOverallFastestLap() => $_clearField(8);
  @$pb.TagNumber(8)
  $3.UInt32Value ensurePointsRaceSessionOverallFastestLap() => $_ensure(7);

  @$pb.TagNumber(9)
  $3.UInt32Value get pointsRaceSessionOverallMostLedLaps => $_getN(8);
  @$pb.TagNumber(9)
  set pointsRaceSessionOverallMostLedLaps($3.UInt32Value value) =>
      $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasPointsRaceSessionOverallMostLedLaps() => $_has(8);
  @$pb.TagNumber(9)
  void clearPointsRaceSessionOverallMostLedLaps() => $_clearField(9);
  @$pb.TagNumber(9)
  $3.UInt32Value ensurePointsRaceSessionOverallMostLedLaps() => $_ensure(8);

  @$pb.TagNumber(11)
  $core.int get minDrivers => $_getIZ(9);
  @$pb.TagNumber(11)
  set minDrivers($core.int value) => $_setUnsignedInt32(9, value);
  @$pb.TagNumber(11)
  $core.bool hasMinDrivers() => $_has(9);
  @$pb.TagNumber(11)
  void clearMinDrivers() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.int get maxDrivers => $_getIZ(10);
  @$pb.TagNumber(12)
  set maxDrivers($core.int value) => $_setUnsignedInt32(10, value);
  @$pb.TagNumber(12)
  $core.bool hasMaxDrivers() => $_has(10);
  @$pb.TagNumber(12)
  void clearMaxDrivers() => $_clearField(12);

  @$pb.TagNumber(14)
  $pb.PbList<PointsSchemePositionReadCreateUpdate> get pointsSchemePositions =>
      $_getList(11);
}

class PointsSchemeCreateUpdate extends $pb.GeneratedMessage {
  factory PointsSchemeCreateUpdate({
    $core.String? name,
    $3.StringValue? description,
    $core.int? position,
    $3.UInt32Value? pointsRaceSessionHeatFastestLap,
    $3.UInt32Value? pointsRaceSessionHeatMostLedLaps,
    $3.UInt32Value? pointsRaceSessionHeatLedAtLeastOneLap,
    $3.UInt32Value? pointsRaceSessionOverallFastestLap,
    $3.UInt32Value? pointsRaceSessionOverallMostLedLaps,
    $core.int? minDrivers,
    $core.int? maxDrivers,
    $core.Iterable<PointsSchemePositionReadCreateUpdate>? pointsSchemePositions,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (position != null) result.position = position;
    if (pointsRaceSessionHeatFastestLap != null)
      result.pointsRaceSessionHeatFastestLap = pointsRaceSessionHeatFastestLap;
    if (pointsRaceSessionHeatMostLedLaps != null)
      result.pointsRaceSessionHeatMostLedLaps =
          pointsRaceSessionHeatMostLedLaps;
    if (pointsRaceSessionHeatLedAtLeastOneLap != null)
      result.pointsRaceSessionHeatLedAtLeastOneLap =
          pointsRaceSessionHeatLedAtLeastOneLap;
    if (pointsRaceSessionOverallFastestLap != null)
      result.pointsRaceSessionOverallFastestLap =
          pointsRaceSessionOverallFastestLap;
    if (pointsRaceSessionOverallMostLedLaps != null)
      result.pointsRaceSessionOverallMostLedLaps =
          pointsRaceSessionOverallMostLedLaps;
    if (minDrivers != null) result.minDrivers = minDrivers;
    if (maxDrivers != null) result.maxDrivers = maxDrivers;
    if (pointsSchemePositions != null)
      result.pointsSchemePositions.addAll(pointsSchemePositions);
    return result;
  }

  PointsSchemeCreateUpdate._();

  factory PointsSchemeCreateUpdate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PointsSchemeCreateUpdate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PointsSchemeCreateUpdate',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.points_scheme'),
      createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOM<$3.StringValue>(3, _omitFieldNames ? '' : 'description',
        subBuilder: $3.StringValue.create)
    ..aI(4, _omitFieldNames ? '' : 'position', fieldType: $pb.PbFieldType.OU3)
    ..aOM<$3.UInt32Value>(
        5, _omitFieldNames ? '' : 'pointsRaceSessionHeatFastestLap',
        subBuilder: $3.UInt32Value.create)
    ..aOM<$3.UInt32Value>(
        6, _omitFieldNames ? '' : 'pointsRaceSessionHeatMostLedLaps',
        subBuilder: $3.UInt32Value.create)
    ..aOM<$3.UInt32Value>(
        7, _omitFieldNames ? '' : 'pointsRaceSessionHeatLedAtLeastOneLap',
        subBuilder: $3.UInt32Value.create)
    ..aOM<$3.UInt32Value>(
        8, _omitFieldNames ? '' : 'pointsRaceSessionOverallFastestLap',
        subBuilder: $3.UInt32Value.create)
    ..aOM<$3.UInt32Value>(
        9, _omitFieldNames ? '' : 'pointsRaceSessionOverallMostLedLaps',
        subBuilder: $3.UInt32Value.create)
    ..aI(11, _omitFieldNames ? '' : 'minDrivers',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(12, _omitFieldNames ? '' : 'maxDrivers',
        fieldType: $pb.PbFieldType.OU3)
    ..pPM<PointsSchemePositionReadCreateUpdate>(
        14, _omitFieldNames ? '' : 'pointsSchemePositions',
        subBuilder: PointsSchemePositionReadCreateUpdate.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PointsSchemeCreateUpdate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PointsSchemeCreateUpdate copyWith(
          void Function(PointsSchemeCreateUpdate) updates) =>
      super.copyWith((message) => updates(message as PointsSchemeCreateUpdate))
          as PointsSchemeCreateUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PointsSchemeCreateUpdate create() => PointsSchemeCreateUpdate._();
  @$core.override
  PointsSchemeCreateUpdate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PointsSchemeCreateUpdate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PointsSchemeCreateUpdate>(create);
  static PointsSchemeCreateUpdate? _defaultInstance;

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
  $core.int get position => $_getIZ(2);
  @$pb.TagNumber(4)
  set position($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(4)
  $core.bool hasPosition() => $_has(2);
  @$pb.TagNumber(4)
  void clearPosition() => $_clearField(4);

  @$pb.TagNumber(5)
  $3.UInt32Value get pointsRaceSessionHeatFastestLap => $_getN(3);
  @$pb.TagNumber(5)
  set pointsRaceSessionHeatFastestLap($3.UInt32Value value) =>
      $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasPointsRaceSessionHeatFastestLap() => $_has(3);
  @$pb.TagNumber(5)
  void clearPointsRaceSessionHeatFastestLap() => $_clearField(5);
  @$pb.TagNumber(5)
  $3.UInt32Value ensurePointsRaceSessionHeatFastestLap() => $_ensure(3);

  @$pb.TagNumber(6)
  $3.UInt32Value get pointsRaceSessionHeatMostLedLaps => $_getN(4);
  @$pb.TagNumber(6)
  set pointsRaceSessionHeatMostLedLaps($3.UInt32Value value) =>
      $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasPointsRaceSessionHeatMostLedLaps() => $_has(4);
  @$pb.TagNumber(6)
  void clearPointsRaceSessionHeatMostLedLaps() => $_clearField(6);
  @$pb.TagNumber(6)
  $3.UInt32Value ensurePointsRaceSessionHeatMostLedLaps() => $_ensure(4);

  @$pb.TagNumber(7)
  $3.UInt32Value get pointsRaceSessionHeatLedAtLeastOneLap => $_getN(5);
  @$pb.TagNumber(7)
  set pointsRaceSessionHeatLedAtLeastOneLap($3.UInt32Value value) =>
      $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasPointsRaceSessionHeatLedAtLeastOneLap() => $_has(5);
  @$pb.TagNumber(7)
  void clearPointsRaceSessionHeatLedAtLeastOneLap() => $_clearField(7);
  @$pb.TagNumber(7)
  $3.UInt32Value ensurePointsRaceSessionHeatLedAtLeastOneLap() => $_ensure(5);

  @$pb.TagNumber(8)
  $3.UInt32Value get pointsRaceSessionOverallFastestLap => $_getN(6);
  @$pb.TagNumber(8)
  set pointsRaceSessionOverallFastestLap($3.UInt32Value value) =>
      $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasPointsRaceSessionOverallFastestLap() => $_has(6);
  @$pb.TagNumber(8)
  void clearPointsRaceSessionOverallFastestLap() => $_clearField(8);
  @$pb.TagNumber(8)
  $3.UInt32Value ensurePointsRaceSessionOverallFastestLap() => $_ensure(6);

  @$pb.TagNumber(9)
  $3.UInt32Value get pointsRaceSessionOverallMostLedLaps => $_getN(7);
  @$pb.TagNumber(9)
  set pointsRaceSessionOverallMostLedLaps($3.UInt32Value value) =>
      $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasPointsRaceSessionOverallMostLedLaps() => $_has(7);
  @$pb.TagNumber(9)
  void clearPointsRaceSessionOverallMostLedLaps() => $_clearField(9);
  @$pb.TagNumber(9)
  $3.UInt32Value ensurePointsRaceSessionOverallMostLedLaps() => $_ensure(7);

  @$pb.TagNumber(11)
  $core.int get minDrivers => $_getIZ(8);
  @$pb.TagNumber(11)
  set minDrivers($core.int value) => $_setUnsignedInt32(8, value);
  @$pb.TagNumber(11)
  $core.bool hasMinDrivers() => $_has(8);
  @$pb.TagNumber(11)
  void clearMinDrivers() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.int get maxDrivers => $_getIZ(9);
  @$pb.TagNumber(12)
  set maxDrivers($core.int value) => $_setUnsignedInt32(9, value);
  @$pb.TagNumber(12)
  $core.bool hasMaxDrivers() => $_has(9);
  @$pb.TagNumber(12)
  void clearMaxDrivers() => $_clearField(12);

  @$pb.TagNumber(14)
  $pb.PbList<PointsSchemePositionReadCreateUpdate> get pointsSchemePositions =>
      $_getList(10);
}

class PointsSchemeUpdateRequest extends $pb.GeneratedMessage {
  factory PointsSchemeUpdateRequest({
    $core.String? id,
    PointsSchemeCreateUpdate? entity,
    $core.String? etag,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (entity != null) result.entity = entity;
    if (etag != null) result.etag = etag;
    return result;
  }

  PointsSchemeUpdateRequest._();

  factory PointsSchemeUpdateRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PointsSchemeUpdateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PointsSchemeUpdateRequest',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.points_scheme'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<PointsSchemeCreateUpdate>(2, _omitFieldNames ? '' : 'entity',
        subBuilder: PointsSchemeCreateUpdate.create)
    ..aOS(3, _omitFieldNames ? '' : 'etag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PointsSchemeUpdateRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PointsSchemeUpdateRequest copyWith(
          void Function(PointsSchemeUpdateRequest) updates) =>
      super.copyWith((message) => updates(message as PointsSchemeUpdateRequest))
          as PointsSchemeUpdateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PointsSchemeUpdateRequest create() => PointsSchemeUpdateRequest._();
  @$core.override
  PointsSchemeUpdateRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PointsSchemeUpdateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PointsSchemeUpdateRequest>(create);
  static PointsSchemeUpdateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  PointsSchemeCreateUpdate get entity => $_getN(1);
  @$pb.TagNumber(2)
  set entity(PointsSchemeCreateUpdate value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEntity() => $_has(1);
  @$pb.TagNumber(2)
  void clearEntity() => $_clearField(2);
  @$pb.TagNumber(2)
  PointsSchemeCreateUpdate ensureEntity() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get etag => $_getSZ(2);
  @$pb.TagNumber(3)
  set etag($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEtag() => $_has(2);
  @$pb.TagNumber(3)
  void clearEtag() => $_clearField(3);
}

class PointsSchemePositionReadCreateUpdate extends $pb.GeneratedMessage {
  factory PointsSchemePositionReadCreateUpdate({
    $core.int? position,
    $core.int? points,
  }) {
    final result = create();
    if (position != null) result.position = position;
    if (points != null) result.points = points;
    return result;
  }

  PointsSchemePositionReadCreateUpdate._();

  factory PointsSchemePositionReadCreateUpdate.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PointsSchemePositionReadCreateUpdate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PointsSchemePositionReadCreateUpdate',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.points_scheme'),
      createEmptyInstance: create)
    ..aI(2, _omitFieldNames ? '' : 'position', fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'points', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PointsSchemePositionReadCreateUpdate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PointsSchemePositionReadCreateUpdate copyWith(
          void Function(PointsSchemePositionReadCreateUpdate) updates) =>
      super.copyWith((message) =>
              updates(message as PointsSchemePositionReadCreateUpdate))
          as PointsSchemePositionReadCreateUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PointsSchemePositionReadCreateUpdate create() =>
      PointsSchemePositionReadCreateUpdate._();
  @$core.override
  PointsSchemePositionReadCreateUpdate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PointsSchemePositionReadCreateUpdate getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          PointsSchemePositionReadCreateUpdate>(create);
  static PointsSchemePositionReadCreateUpdate? _defaultInstance;

  @$pb.TagNumber(2)
  $core.int get position => $_getIZ(0);
  @$pb.TagNumber(2)
  set position($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(2)
  $core.bool hasPosition() => $_has(0);
  @$pb.TagNumber(2)
  void clearPosition() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get points => $_getIZ(1);
  @$pb.TagNumber(3)
  set points($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(3)
  $core.bool hasPoints() => $_has(1);
  @$pb.TagNumber(3)
  void clearPoints() => $_clearField(3);
}

class PointsSchemeListResponse extends $pb.GeneratedMessage {
  factory PointsSchemeListResponse({
    $core.Iterable<PointsSchemeList>? result,
  }) {
    final result$ = create();
    if (result != null) result$.result.addAll(result);
    return result$;
  }

  PointsSchemeListResponse._();

  factory PointsSchemeListResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PointsSchemeListResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PointsSchemeListResponse',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.points_scheme'),
      createEmptyInstance: create)
    ..pPM<PointsSchemeList>(1, _omitFieldNames ? '' : 'result',
        subBuilder: PointsSchemeList.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PointsSchemeListResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PointsSchemeListResponse copyWith(
          void Function(PointsSchemeListResponse) updates) =>
      super.copyWith((message) => updates(message as PointsSchemeListResponse))
          as PointsSchemeListResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PointsSchemeListResponse create() => PointsSchemeListResponse._();
  @$core.override
  PointsSchemeListResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PointsSchemeListResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PointsSchemeListResponse>(create);
  static PointsSchemeListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<PointsSchemeList> get result => $_getList(0);
}

class PointsSchemeList extends $pb.GeneratedMessage {
  factory PointsSchemeList({
    $core.String? id,
    $core.String? name,
    $3.StringValue? description,
    $core.String? etag,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (etag != null) result.etag = etag;
    return result;
  }

  PointsSchemeList._();

  factory PointsSchemeList.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PointsSchemeList.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PointsSchemeList',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.points_scheme'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOM<$3.StringValue>(3, _omitFieldNames ? '' : 'description',
        subBuilder: $3.StringValue.create)
    ..aOS(4, _omitFieldNames ? '' : 'etag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PointsSchemeList clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PointsSchemeList copyWith(void Function(PointsSchemeList) updates) =>
      super.copyWith((message) => updates(message as PointsSchemeList))
          as PointsSchemeList;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PointsSchemeList create() => PointsSchemeList._();
  @$core.override
  PointsSchemeList createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PointsSchemeList getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PointsSchemeList>(create);
  static PointsSchemeList? _defaultInstance;

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
  $core.String get etag => $_getSZ(3);
  @$pb.TagNumber(4)
  set etag($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasEtag() => $_has(3);
  @$pb.TagNumber(4)
  void clearEtag() => $_clearField(4);
}

class PointsSchemeSelectResponse extends $pb.GeneratedMessage {
  factory PointsSchemeSelectResponse({
    $core.Iterable<PointsSchemeSelect>? result,
  }) {
    final result$ = create();
    if (result != null) result$.result.addAll(result);
    return result$;
  }

  PointsSchemeSelectResponse._();

  factory PointsSchemeSelectResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PointsSchemeSelectResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PointsSchemeSelectResponse',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.points_scheme'),
      createEmptyInstance: create)
    ..pPM<PointsSchemeSelect>(1, _omitFieldNames ? '' : 'result',
        subBuilder: PointsSchemeSelect.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PointsSchemeSelectResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PointsSchemeSelectResponse copyWith(
          void Function(PointsSchemeSelectResponse) updates) =>
      super.copyWith(
              (message) => updates(message as PointsSchemeSelectResponse))
          as PointsSchemeSelectResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PointsSchemeSelectResponse create() => PointsSchemeSelectResponse._();
  @$core.override
  PointsSchemeSelectResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PointsSchemeSelectResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PointsSchemeSelectResponse>(create);
  static PointsSchemeSelectResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<PointsSchemeSelect> get result => $_getList(0);
}

class PointsSchemeSelect extends $pb.GeneratedMessage {
  factory PointsSchemeSelect({
    $core.String? id,
    $core.String? name,
    $core.int? minDrivers,
    $core.int? maxDrivers,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (minDrivers != null) result.minDrivers = minDrivers;
    if (maxDrivers != null) result.maxDrivers = maxDrivers;
    return result;
  }

  PointsSchemeSelect._();

  factory PointsSchemeSelect.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PointsSchemeSelect.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PointsSchemeSelect',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.points_scheme'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aI(3, _omitFieldNames ? '' : 'minDrivers', fieldType: $pb.PbFieldType.OU3)
    ..aI(4, _omitFieldNames ? '' : 'maxDrivers', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PointsSchemeSelect clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PointsSchemeSelect copyWith(void Function(PointsSchemeSelect) updates) =>
      super.copyWith((message) => updates(message as PointsSchemeSelect))
          as PointsSchemeSelect;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PointsSchemeSelect create() => PointsSchemeSelect._();
  @$core.override
  PointsSchemeSelect createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PointsSchemeSelect getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PointsSchemeSelect>(create);
  static PointsSchemeSelect? _defaultInstance;

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
  $core.int get minDrivers => $_getIZ(2);
  @$pb.TagNumber(3)
  set minDrivers($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMinDrivers() => $_has(2);
  @$pb.TagNumber(3)
  void clearMinDrivers() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get maxDrivers => $_getIZ(3);
  @$pb.TagNumber(4)
  set maxDrivers($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMaxDrivers() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaxDrivers() => $_clearField(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
