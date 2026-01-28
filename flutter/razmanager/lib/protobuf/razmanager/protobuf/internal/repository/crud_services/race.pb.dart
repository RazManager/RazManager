// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/race.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/duration.pb.dart'
    as $7;
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart'
    as $3;

import '../../../public/heat.v1.pbenum.dart' as $9;
import '../../../public/race.v1.pbenum.dart' as $11;
import 'event.pb.dart' as $4;
import 'heat_car_type.pbenum.dart' as $10;
import 'points_scheme.pb.dart' as $6;
import 'race_format_type.pbenum.dart' as $8;
import 'track_configuration.pb.dart' as $5;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class RaceReadResponse extends $pb.GeneratedMessage {
  factory RaceReadResponse({
    RaceRead? entity,
    $core.String? etag,
  }) {
    final result = create();
    if (entity != null) result.entity = entity;
    if (etag != null) result.etag = etag;
    return result;
  }

  RaceReadResponse._();

  factory RaceReadResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RaceReadResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RaceReadResponse',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.race'),
      createEmptyInstance: create)
    ..aOM<RaceRead>(1, _omitFieldNames ? '' : 'entity',
        subBuilder: RaceRead.create)
    ..aOS(2, _omitFieldNames ? '' : 'etag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceReadResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceReadResponse copyWith(void Function(RaceReadResponse) updates) =>
      super.copyWith((message) => updates(message as RaceReadResponse))
          as RaceReadResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RaceReadResponse create() => RaceReadResponse._();
  @$core.override
  RaceReadResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RaceReadResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RaceReadResponse>(create);
  static RaceReadResponse? _defaultInstance;

  @$pb.TagNumber(1)
  RaceRead get entity => $_getN(0);
  @$pb.TagNumber(1)
  set entity(RaceRead value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasEntity() => $_has(0);
  @$pb.TagNumber(1)
  void clearEntity() => $_clearField(1);
  @$pb.TagNumber(1)
  RaceRead ensureEntity() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get etag => $_getSZ(1);
  @$pb.TagNumber(2)
  set etag($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEtag() => $_has(1);
  @$pb.TagNumber(2)
  void clearEtag() => $_clearField(2);
}

class RaceRead extends $pb.GeneratedMessage {
  factory RaceRead({
    $3.StringValue? id,
    $3.StringValue? eventId,
    $4.EventSelect? event,
    $3.UInt32Value? number,
    $3.StringValue? name,
    $3.StringValue? trackConfigurationId,
    $5.TrackConfigurationSelect? trackConfiguration,
    $3.StringValue? pointsSchemeId,
    $6.PointsSchemeSelect? pointsScheme,
    $core.bool? practiceSession,
    $core.bool? qualifyingSession,
    $core.bool? raceSession,
    $8.RaceFormatTypeId? raceFormatTypeId,
    $9.HeatEndTypeId? raceHeatEndTypeId,
    $3.UInt32Value? raceHeatEndLapLaps,
    $7.Duration? raceHeatEndDurationDuration,
    $core.Iterable<$core.String>? carTagIds,
    $10.HeatCarTypeId? heatCarTypeId,
    $core.Iterable<RaceIndicatorReadCreateUpdate>? raceIndicators,
    $core.Iterable<RaceEventUserReadCreateUpdate>? raceEventUsers,
    $core.Iterable<RaceIndicatorEventUserReadCreateUpdate>?
        raceIndicatorEventUsers,
    $core.bool? energySimulation,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (eventId != null) result.eventId = eventId;
    if (event != null) result.event = event;
    if (number != null) result.number = number;
    if (name != null) result.name = name;
    if (trackConfigurationId != null)
      result.trackConfigurationId = trackConfigurationId;
    if (trackConfiguration != null)
      result.trackConfiguration = trackConfiguration;
    if (pointsSchemeId != null) result.pointsSchemeId = pointsSchemeId;
    if (pointsScheme != null) result.pointsScheme = pointsScheme;
    if (practiceSession != null) result.practiceSession = practiceSession;
    if (qualifyingSession != null) result.qualifyingSession = qualifyingSession;
    if (raceSession != null) result.raceSession = raceSession;
    if (raceFormatTypeId != null) result.raceFormatTypeId = raceFormatTypeId;
    if (raceHeatEndTypeId != null) result.raceHeatEndTypeId = raceHeatEndTypeId;
    if (raceHeatEndLapLaps != null)
      result.raceHeatEndLapLaps = raceHeatEndLapLaps;
    if (raceHeatEndDurationDuration != null)
      result.raceHeatEndDurationDuration = raceHeatEndDurationDuration;
    if (carTagIds != null) result.carTagIds.addAll(carTagIds);
    if (heatCarTypeId != null) result.heatCarTypeId = heatCarTypeId;
    if (raceIndicators != null) result.raceIndicators.addAll(raceIndicators);
    if (raceEventUsers != null) result.raceEventUsers.addAll(raceEventUsers);
    if (raceIndicatorEventUsers != null)
      result.raceIndicatorEventUsers.addAll(raceIndicatorEventUsers);
    if (energySimulation != null) result.energySimulation = energySimulation;
    return result;
  }

  RaceRead._();

  factory RaceRead.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RaceRead.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RaceRead',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.race'),
      createEmptyInstance: create)
    ..aOM<$3.StringValue>(1, _omitFieldNames ? '' : 'id',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(2, _omitFieldNames ? '' : 'eventId',
        subBuilder: $3.StringValue.create)
    ..aOM<$4.EventSelect>(3, _omitFieldNames ? '' : 'event',
        subBuilder: $4.EventSelect.create)
    ..aOM<$3.UInt32Value>(4, _omitFieldNames ? '' : 'number',
        subBuilder: $3.UInt32Value.create)
    ..aOM<$3.StringValue>(5, _omitFieldNames ? '' : 'name',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(6, _omitFieldNames ? '' : 'trackConfigurationId',
        subBuilder: $3.StringValue.create)
    ..aOM<$5.TrackConfigurationSelect>(
        7, _omitFieldNames ? '' : 'trackConfiguration',
        subBuilder: $5.TrackConfigurationSelect.create)
    ..aOM<$3.StringValue>(8, _omitFieldNames ? '' : 'pointsSchemeId',
        subBuilder: $3.StringValue.create)
    ..aOM<$6.PointsSchemeSelect>(9, _omitFieldNames ? '' : 'pointsScheme',
        subBuilder: $6.PointsSchemeSelect.create)
    ..aOB(10, _omitFieldNames ? '' : 'practiceSession')
    ..aOB(11, _omitFieldNames ? '' : 'qualifyingSession')
    ..aOB(12, _omitFieldNames ? '' : 'raceSession')
    ..aE<$8.RaceFormatTypeId>(13, _omitFieldNames ? '' : 'raceFormatTypeId',
        enumValues: $8.RaceFormatTypeId.values)
    ..aE<$9.HeatEndTypeId>(14, _omitFieldNames ? '' : 'raceHeatEndTypeId',
        enumValues: $9.HeatEndTypeId.values)
    ..aOM<$3.UInt32Value>(15, _omitFieldNames ? '' : 'raceHeatEndLapLaps',
        subBuilder: $3.UInt32Value.create)
    ..aOM<$7.Duration>(16, _omitFieldNames ? '' : 'raceHeatEndDurationDuration',
        subBuilder: $7.Duration.create)
    ..pPS(17, _omitFieldNames ? '' : 'carTagIds')
    ..aE<$10.HeatCarTypeId>(18, _omitFieldNames ? '' : 'heatCarTypeId',
        enumValues: $10.HeatCarTypeId.values)
    ..pPM<RaceIndicatorReadCreateUpdate>(
        19, _omitFieldNames ? '' : 'raceIndicators',
        subBuilder: RaceIndicatorReadCreateUpdate.create)
    ..pPM<RaceEventUserReadCreateUpdate>(
        20, _omitFieldNames ? '' : 'raceEventUsers',
        subBuilder: RaceEventUserReadCreateUpdate.create)
    ..pPM<RaceIndicatorEventUserReadCreateUpdate>(
        21, _omitFieldNames ? '' : 'raceIndicatorEventUsers',
        subBuilder: RaceIndicatorEventUserReadCreateUpdate.create)
    ..aOB(22, _omitFieldNames ? '' : 'energySimulation')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceRead clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceRead copyWith(void Function(RaceRead) updates) =>
      super.copyWith((message) => updates(message as RaceRead)) as RaceRead;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RaceRead create() => RaceRead._();
  @$core.override
  RaceRead createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RaceRead getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RaceRead>(create);
  static RaceRead? _defaultInstance;

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
  $3.StringValue get eventId => $_getN(1);
  @$pb.TagNumber(2)
  set eventId($3.StringValue value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEventId() => $_has(1);
  @$pb.TagNumber(2)
  void clearEventId() => $_clearField(2);
  @$pb.TagNumber(2)
  $3.StringValue ensureEventId() => $_ensure(1);

  @$pb.TagNumber(3)
  $4.EventSelect get event => $_getN(2);
  @$pb.TagNumber(3)
  set event($4.EventSelect value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasEvent() => $_has(2);
  @$pb.TagNumber(3)
  void clearEvent() => $_clearField(3);
  @$pb.TagNumber(3)
  $4.EventSelect ensureEvent() => $_ensure(2);

  @$pb.TagNumber(4)
  $3.UInt32Value get number => $_getN(3);
  @$pb.TagNumber(4)
  set number($3.UInt32Value value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearNumber() => $_clearField(4);
  @$pb.TagNumber(4)
  $3.UInt32Value ensureNumber() => $_ensure(3);

  @$pb.TagNumber(5)
  $3.StringValue get name => $_getN(4);
  @$pb.TagNumber(5)
  set name($3.StringValue value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasName() => $_has(4);
  @$pb.TagNumber(5)
  void clearName() => $_clearField(5);
  @$pb.TagNumber(5)
  $3.StringValue ensureName() => $_ensure(4);

  @$pb.TagNumber(6)
  $3.StringValue get trackConfigurationId => $_getN(5);
  @$pb.TagNumber(6)
  set trackConfigurationId($3.StringValue value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasTrackConfigurationId() => $_has(5);
  @$pb.TagNumber(6)
  void clearTrackConfigurationId() => $_clearField(6);
  @$pb.TagNumber(6)
  $3.StringValue ensureTrackConfigurationId() => $_ensure(5);

  @$pb.TagNumber(7)
  $5.TrackConfigurationSelect get trackConfiguration => $_getN(6);
  @$pb.TagNumber(7)
  set trackConfiguration($5.TrackConfigurationSelect value) =>
      $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasTrackConfiguration() => $_has(6);
  @$pb.TagNumber(7)
  void clearTrackConfiguration() => $_clearField(7);
  @$pb.TagNumber(7)
  $5.TrackConfigurationSelect ensureTrackConfiguration() => $_ensure(6);

  @$pb.TagNumber(8)
  $3.StringValue get pointsSchemeId => $_getN(7);
  @$pb.TagNumber(8)
  set pointsSchemeId($3.StringValue value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasPointsSchemeId() => $_has(7);
  @$pb.TagNumber(8)
  void clearPointsSchemeId() => $_clearField(8);
  @$pb.TagNumber(8)
  $3.StringValue ensurePointsSchemeId() => $_ensure(7);

  @$pb.TagNumber(9)
  $6.PointsSchemeSelect get pointsScheme => $_getN(8);
  @$pb.TagNumber(9)
  set pointsScheme($6.PointsSchemeSelect value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasPointsScheme() => $_has(8);
  @$pb.TagNumber(9)
  void clearPointsScheme() => $_clearField(9);
  @$pb.TagNumber(9)
  $6.PointsSchemeSelect ensurePointsScheme() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.bool get practiceSession => $_getBF(9);
  @$pb.TagNumber(10)
  set practiceSession($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasPracticeSession() => $_has(9);
  @$pb.TagNumber(10)
  void clearPracticeSession() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.bool get qualifyingSession => $_getBF(10);
  @$pb.TagNumber(11)
  set qualifyingSession($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasQualifyingSession() => $_has(10);
  @$pb.TagNumber(11)
  void clearQualifyingSession() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.bool get raceSession => $_getBF(11);
  @$pb.TagNumber(12)
  set raceSession($core.bool value) => $_setBool(11, value);
  @$pb.TagNumber(12)
  $core.bool hasRaceSession() => $_has(11);
  @$pb.TagNumber(12)
  void clearRaceSession() => $_clearField(12);

  @$pb.TagNumber(13)
  $8.RaceFormatTypeId get raceFormatTypeId => $_getN(12);
  @$pb.TagNumber(13)
  set raceFormatTypeId($8.RaceFormatTypeId value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasRaceFormatTypeId() => $_has(12);
  @$pb.TagNumber(13)
  void clearRaceFormatTypeId() => $_clearField(13);

  @$pb.TagNumber(14)
  $9.HeatEndTypeId get raceHeatEndTypeId => $_getN(13);
  @$pb.TagNumber(14)
  set raceHeatEndTypeId($9.HeatEndTypeId value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasRaceHeatEndTypeId() => $_has(13);
  @$pb.TagNumber(14)
  void clearRaceHeatEndTypeId() => $_clearField(14);

  @$pb.TagNumber(15)
  $3.UInt32Value get raceHeatEndLapLaps => $_getN(14);
  @$pb.TagNumber(15)
  set raceHeatEndLapLaps($3.UInt32Value value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasRaceHeatEndLapLaps() => $_has(14);
  @$pb.TagNumber(15)
  void clearRaceHeatEndLapLaps() => $_clearField(15);
  @$pb.TagNumber(15)
  $3.UInt32Value ensureRaceHeatEndLapLaps() => $_ensure(14);

  @$pb.TagNumber(16)
  $7.Duration get raceHeatEndDurationDuration => $_getN(15);
  @$pb.TagNumber(16)
  set raceHeatEndDurationDuration($7.Duration value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasRaceHeatEndDurationDuration() => $_has(15);
  @$pb.TagNumber(16)
  void clearRaceHeatEndDurationDuration() => $_clearField(16);
  @$pb.TagNumber(16)
  $7.Duration ensureRaceHeatEndDurationDuration() => $_ensure(15);

  @$pb.TagNumber(17)
  $pb.PbList<$core.String> get carTagIds => $_getList(16);

  @$pb.TagNumber(18)
  $10.HeatCarTypeId get heatCarTypeId => $_getN(17);
  @$pb.TagNumber(18)
  set heatCarTypeId($10.HeatCarTypeId value) => $_setField(18, value);
  @$pb.TagNumber(18)
  $core.bool hasHeatCarTypeId() => $_has(17);
  @$pb.TagNumber(18)
  void clearHeatCarTypeId() => $_clearField(18);

  @$pb.TagNumber(19)
  $pb.PbList<RaceIndicatorReadCreateUpdate> get raceIndicators => $_getList(18);

  @$pb.TagNumber(20)
  $pb.PbList<RaceEventUserReadCreateUpdate> get raceEventUsers => $_getList(19);

  @$pb.TagNumber(21)
  $pb.PbList<RaceIndicatorEventUserReadCreateUpdate>
      get raceIndicatorEventUsers => $_getList(20);

  @$pb.TagNumber(22)
  $core.bool get energySimulation => $_getBF(21);
  @$pb.TagNumber(22)
  set energySimulation($core.bool value) => $_setBool(21, value);
  @$pb.TagNumber(22)
  $core.bool hasEnergySimulation() => $_has(21);
  @$pb.TagNumber(22)
  void clearEnergySimulation() => $_clearField(22);
}

class RaceCreate extends $pb.GeneratedMessage {
  factory RaceCreate({
    $core.String? eventId,
    $3.StringValue? name,
    $core.String? trackConfigurationId,
    $3.StringValue? pointsSchemeId,
    $core.bool? practiceSession,
    $core.bool? qualifyingSession,
    $core.bool? raceSession,
    $8.RaceFormatTypeId? raceFormatTypeId,
    $9.HeatEndTypeId? raceHeatEndTypeId,
    $3.UInt32Value? raceHeatEndLapLaps,
    $7.Duration? raceHeatEndDurationDuration,
    $core.Iterable<$core.String>? carTagIds,
    $10.HeatCarTypeId? heatCarTypeId,
    $core.Iterable<RaceIndicatorReadCreateUpdate>? raceIndicators,
    $core.Iterable<RaceEventUserReadCreateUpdate>? raceEventUsers,
    $core.Iterable<RaceIndicatorEventUserReadCreateUpdate>?
        raceIndicatorEventUsers,
    $core.bool? energySimulation,
  }) {
    final result = create();
    if (eventId != null) result.eventId = eventId;
    if (name != null) result.name = name;
    if (trackConfigurationId != null)
      result.trackConfigurationId = trackConfigurationId;
    if (pointsSchemeId != null) result.pointsSchemeId = pointsSchemeId;
    if (practiceSession != null) result.practiceSession = practiceSession;
    if (qualifyingSession != null) result.qualifyingSession = qualifyingSession;
    if (raceSession != null) result.raceSession = raceSession;
    if (raceFormatTypeId != null) result.raceFormatTypeId = raceFormatTypeId;
    if (raceHeatEndTypeId != null) result.raceHeatEndTypeId = raceHeatEndTypeId;
    if (raceHeatEndLapLaps != null)
      result.raceHeatEndLapLaps = raceHeatEndLapLaps;
    if (raceHeatEndDurationDuration != null)
      result.raceHeatEndDurationDuration = raceHeatEndDurationDuration;
    if (carTagIds != null) result.carTagIds.addAll(carTagIds);
    if (heatCarTypeId != null) result.heatCarTypeId = heatCarTypeId;
    if (raceIndicators != null) result.raceIndicators.addAll(raceIndicators);
    if (raceEventUsers != null) result.raceEventUsers.addAll(raceEventUsers);
    if (raceIndicatorEventUsers != null)
      result.raceIndicatorEventUsers.addAll(raceIndicatorEventUsers);
    if (energySimulation != null) result.energySimulation = energySimulation;
    return result;
  }

  RaceCreate._();

  factory RaceCreate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RaceCreate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RaceCreate',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.race'),
      createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'eventId')
    ..aOM<$3.StringValue>(5, _omitFieldNames ? '' : 'name',
        subBuilder: $3.StringValue.create)
    ..aOS(6, _omitFieldNames ? '' : 'trackConfigurationId')
    ..aOM<$3.StringValue>(8, _omitFieldNames ? '' : 'pointsSchemeId',
        subBuilder: $3.StringValue.create)
    ..aOB(10, _omitFieldNames ? '' : 'practiceSession')
    ..aOB(11, _omitFieldNames ? '' : 'qualifyingSession')
    ..aOB(12, _omitFieldNames ? '' : 'raceSession')
    ..aE<$8.RaceFormatTypeId>(13, _omitFieldNames ? '' : 'raceFormatTypeId',
        enumValues: $8.RaceFormatTypeId.values)
    ..aE<$9.HeatEndTypeId>(14, _omitFieldNames ? '' : 'raceHeatEndTypeId',
        enumValues: $9.HeatEndTypeId.values)
    ..aOM<$3.UInt32Value>(15, _omitFieldNames ? '' : 'raceHeatEndLapLaps',
        subBuilder: $3.UInt32Value.create)
    ..aOM<$7.Duration>(16, _omitFieldNames ? '' : 'raceHeatEndDurationDuration',
        subBuilder: $7.Duration.create)
    ..pPS(17, _omitFieldNames ? '' : 'carTagIds')
    ..aE<$10.HeatCarTypeId>(18, _omitFieldNames ? '' : 'heatCarTypeId',
        enumValues: $10.HeatCarTypeId.values)
    ..pPM<RaceIndicatorReadCreateUpdate>(
        19, _omitFieldNames ? '' : 'raceIndicators',
        subBuilder: RaceIndicatorReadCreateUpdate.create)
    ..pPM<RaceEventUserReadCreateUpdate>(
        20, _omitFieldNames ? '' : 'raceEventUsers',
        subBuilder: RaceEventUserReadCreateUpdate.create)
    ..pPM<RaceIndicatorEventUserReadCreateUpdate>(
        21, _omitFieldNames ? '' : 'raceIndicatorEventUsers',
        subBuilder: RaceIndicatorEventUserReadCreateUpdate.create)
    ..aOB(22, _omitFieldNames ? '' : 'energySimulation')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceCreate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceCreate copyWith(void Function(RaceCreate) updates) =>
      super.copyWith((message) => updates(message as RaceCreate)) as RaceCreate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RaceCreate create() => RaceCreate._();
  @$core.override
  RaceCreate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RaceCreate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RaceCreate>(create);
  static RaceCreate? _defaultInstance;

  @$pb.TagNumber(2)
  $core.String get eventId => $_getSZ(0);
  @$pb.TagNumber(2)
  set eventId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(2)
  $core.bool hasEventId() => $_has(0);
  @$pb.TagNumber(2)
  void clearEventId() => $_clearField(2);

  @$pb.TagNumber(5)
  $3.StringValue get name => $_getN(1);
  @$pb.TagNumber(5)
  set name($3.StringValue value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(5)
  void clearName() => $_clearField(5);
  @$pb.TagNumber(5)
  $3.StringValue ensureName() => $_ensure(1);

  @$pb.TagNumber(6)
  $core.String get trackConfigurationId => $_getSZ(2);
  @$pb.TagNumber(6)
  set trackConfigurationId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(6)
  $core.bool hasTrackConfigurationId() => $_has(2);
  @$pb.TagNumber(6)
  void clearTrackConfigurationId() => $_clearField(6);

  @$pb.TagNumber(8)
  $3.StringValue get pointsSchemeId => $_getN(3);
  @$pb.TagNumber(8)
  set pointsSchemeId($3.StringValue value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasPointsSchemeId() => $_has(3);
  @$pb.TagNumber(8)
  void clearPointsSchemeId() => $_clearField(8);
  @$pb.TagNumber(8)
  $3.StringValue ensurePointsSchemeId() => $_ensure(3);

  @$pb.TagNumber(10)
  $core.bool get practiceSession => $_getBF(4);
  @$pb.TagNumber(10)
  set practiceSession($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(10)
  $core.bool hasPracticeSession() => $_has(4);
  @$pb.TagNumber(10)
  void clearPracticeSession() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.bool get qualifyingSession => $_getBF(5);
  @$pb.TagNumber(11)
  set qualifyingSession($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(11)
  $core.bool hasQualifyingSession() => $_has(5);
  @$pb.TagNumber(11)
  void clearQualifyingSession() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.bool get raceSession => $_getBF(6);
  @$pb.TagNumber(12)
  set raceSession($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(12)
  $core.bool hasRaceSession() => $_has(6);
  @$pb.TagNumber(12)
  void clearRaceSession() => $_clearField(12);

  @$pb.TagNumber(13)
  $8.RaceFormatTypeId get raceFormatTypeId => $_getN(7);
  @$pb.TagNumber(13)
  set raceFormatTypeId($8.RaceFormatTypeId value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasRaceFormatTypeId() => $_has(7);
  @$pb.TagNumber(13)
  void clearRaceFormatTypeId() => $_clearField(13);

  @$pb.TagNumber(14)
  $9.HeatEndTypeId get raceHeatEndTypeId => $_getN(8);
  @$pb.TagNumber(14)
  set raceHeatEndTypeId($9.HeatEndTypeId value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasRaceHeatEndTypeId() => $_has(8);
  @$pb.TagNumber(14)
  void clearRaceHeatEndTypeId() => $_clearField(14);

  @$pb.TagNumber(15)
  $3.UInt32Value get raceHeatEndLapLaps => $_getN(9);
  @$pb.TagNumber(15)
  set raceHeatEndLapLaps($3.UInt32Value value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasRaceHeatEndLapLaps() => $_has(9);
  @$pb.TagNumber(15)
  void clearRaceHeatEndLapLaps() => $_clearField(15);
  @$pb.TagNumber(15)
  $3.UInt32Value ensureRaceHeatEndLapLaps() => $_ensure(9);

  @$pb.TagNumber(16)
  $7.Duration get raceHeatEndDurationDuration => $_getN(10);
  @$pb.TagNumber(16)
  set raceHeatEndDurationDuration($7.Duration value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasRaceHeatEndDurationDuration() => $_has(10);
  @$pb.TagNumber(16)
  void clearRaceHeatEndDurationDuration() => $_clearField(16);
  @$pb.TagNumber(16)
  $7.Duration ensureRaceHeatEndDurationDuration() => $_ensure(10);

  @$pb.TagNumber(17)
  $pb.PbList<$core.String> get carTagIds => $_getList(11);

  @$pb.TagNumber(18)
  $10.HeatCarTypeId get heatCarTypeId => $_getN(12);
  @$pb.TagNumber(18)
  set heatCarTypeId($10.HeatCarTypeId value) => $_setField(18, value);
  @$pb.TagNumber(18)
  $core.bool hasHeatCarTypeId() => $_has(12);
  @$pb.TagNumber(18)
  void clearHeatCarTypeId() => $_clearField(18);

  @$pb.TagNumber(19)
  $pb.PbList<RaceIndicatorReadCreateUpdate> get raceIndicators => $_getList(13);

  @$pb.TagNumber(20)
  $pb.PbList<RaceEventUserReadCreateUpdate> get raceEventUsers => $_getList(14);

  @$pb.TagNumber(21)
  $pb.PbList<RaceIndicatorEventUserReadCreateUpdate>
      get raceIndicatorEventUsers => $_getList(15);

  @$pb.TagNumber(22)
  $core.bool get energySimulation => $_getBF(16);
  @$pb.TagNumber(22)
  set energySimulation($core.bool value) => $_setBool(16, value);
  @$pb.TagNumber(22)
  $core.bool hasEnergySimulation() => $_has(16);
  @$pb.TagNumber(22)
  void clearEnergySimulation() => $_clearField(22);
}

class RaceUpdateRequest extends $pb.GeneratedMessage {
  factory RaceUpdateRequest({
    $core.String? id,
    RaceUpdate? entity,
    $core.String? etag,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (entity != null) result.entity = entity;
    if (etag != null) result.etag = etag;
    return result;
  }

  RaceUpdateRequest._();

  factory RaceUpdateRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RaceUpdateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RaceUpdateRequest',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.race'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<RaceUpdate>(2, _omitFieldNames ? '' : 'entity',
        subBuilder: RaceUpdate.create)
    ..aOS(3, _omitFieldNames ? '' : 'etag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceUpdateRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceUpdateRequest copyWith(void Function(RaceUpdateRequest) updates) =>
      super.copyWith((message) => updates(message as RaceUpdateRequest))
          as RaceUpdateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RaceUpdateRequest create() => RaceUpdateRequest._();
  @$core.override
  RaceUpdateRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RaceUpdateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RaceUpdateRequest>(create);
  static RaceUpdateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  RaceUpdate get entity => $_getN(1);
  @$pb.TagNumber(2)
  set entity(RaceUpdate value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEntity() => $_has(1);
  @$pb.TagNumber(2)
  void clearEntity() => $_clearField(2);
  @$pb.TagNumber(2)
  RaceUpdate ensureEntity() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get etag => $_getSZ(2);
  @$pb.TagNumber(3)
  set etag($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEtag() => $_has(2);
  @$pb.TagNumber(3)
  void clearEtag() => $_clearField(3);
}

class RaceUpdate extends $pb.GeneratedMessage {
  factory RaceUpdate({
    $3.StringValue? name,
    $3.StringValue? pointsSchemeId,
    $core.bool? practiceSession,
    $core.bool? qualifyingSession,
    $core.bool? raceSession,
    $8.RaceFormatTypeId? raceFormatTypeId,
    $9.HeatEndTypeId? raceHeatEndTypeId,
    $3.UInt32Value? raceHeatEndLapLaps,
    $7.Duration? raceHeatEndDurationDuration,
    $core.Iterable<$core.String>? carTagIds,
    $10.HeatCarTypeId? heatCarTypeId,
    $core.Iterable<RaceIndicatorReadCreateUpdate>? raceIndicators,
    $core.Iterable<RaceEventUserReadCreateUpdate>? raceEventUsers,
    $core.Iterable<RaceIndicatorEventUserReadCreateUpdate>?
        raceIndicatorEventUsers,
    $core.bool? energySimulation,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (pointsSchemeId != null) result.pointsSchemeId = pointsSchemeId;
    if (practiceSession != null) result.practiceSession = practiceSession;
    if (qualifyingSession != null) result.qualifyingSession = qualifyingSession;
    if (raceSession != null) result.raceSession = raceSession;
    if (raceFormatTypeId != null) result.raceFormatTypeId = raceFormatTypeId;
    if (raceHeatEndTypeId != null) result.raceHeatEndTypeId = raceHeatEndTypeId;
    if (raceHeatEndLapLaps != null)
      result.raceHeatEndLapLaps = raceHeatEndLapLaps;
    if (raceHeatEndDurationDuration != null)
      result.raceHeatEndDurationDuration = raceHeatEndDurationDuration;
    if (carTagIds != null) result.carTagIds.addAll(carTagIds);
    if (heatCarTypeId != null) result.heatCarTypeId = heatCarTypeId;
    if (raceIndicators != null) result.raceIndicators.addAll(raceIndicators);
    if (raceEventUsers != null) result.raceEventUsers.addAll(raceEventUsers);
    if (raceIndicatorEventUsers != null)
      result.raceIndicatorEventUsers.addAll(raceIndicatorEventUsers);
    if (energySimulation != null) result.energySimulation = energySimulation;
    return result;
  }

  RaceUpdate._();

  factory RaceUpdate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RaceUpdate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RaceUpdate',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.race'),
      createEmptyInstance: create)
    ..aOM<$3.StringValue>(5, _omitFieldNames ? '' : 'name',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(8, _omitFieldNames ? '' : 'pointsSchemeId',
        subBuilder: $3.StringValue.create)
    ..aOB(10, _omitFieldNames ? '' : 'practiceSession')
    ..aOB(11, _omitFieldNames ? '' : 'qualifyingSession')
    ..aOB(12, _omitFieldNames ? '' : 'raceSession')
    ..aE<$8.RaceFormatTypeId>(13, _omitFieldNames ? '' : 'raceFormatTypeId',
        enumValues: $8.RaceFormatTypeId.values)
    ..aE<$9.HeatEndTypeId>(14, _omitFieldNames ? '' : 'raceHeatEndTypeId',
        enumValues: $9.HeatEndTypeId.values)
    ..aOM<$3.UInt32Value>(15, _omitFieldNames ? '' : 'raceHeatEndLapLaps',
        subBuilder: $3.UInt32Value.create)
    ..aOM<$7.Duration>(16, _omitFieldNames ? '' : 'raceHeatEndDurationDuration',
        subBuilder: $7.Duration.create)
    ..pPS(17, _omitFieldNames ? '' : 'carTagIds')
    ..aE<$10.HeatCarTypeId>(18, _omitFieldNames ? '' : 'heatCarTypeId',
        enumValues: $10.HeatCarTypeId.values)
    ..pPM<RaceIndicatorReadCreateUpdate>(
        19, _omitFieldNames ? '' : 'raceIndicators',
        subBuilder: RaceIndicatorReadCreateUpdate.create)
    ..pPM<RaceEventUserReadCreateUpdate>(
        20, _omitFieldNames ? '' : 'raceEventUsers',
        subBuilder: RaceEventUserReadCreateUpdate.create)
    ..pPM<RaceIndicatorEventUserReadCreateUpdate>(
        21, _omitFieldNames ? '' : 'raceIndicatorEventUsers',
        subBuilder: RaceIndicatorEventUserReadCreateUpdate.create)
    ..aOB(22, _omitFieldNames ? '' : 'energySimulation')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceUpdate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceUpdate copyWith(void Function(RaceUpdate) updates) =>
      super.copyWith((message) => updates(message as RaceUpdate)) as RaceUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RaceUpdate create() => RaceUpdate._();
  @$core.override
  RaceUpdate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RaceUpdate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RaceUpdate>(create);
  static RaceUpdate? _defaultInstance;

  @$pb.TagNumber(5)
  $3.StringValue get name => $_getN(0);
  @$pb.TagNumber(5)
  set name($3.StringValue value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(5)
  void clearName() => $_clearField(5);
  @$pb.TagNumber(5)
  $3.StringValue ensureName() => $_ensure(0);

  @$pb.TagNumber(8)
  $3.StringValue get pointsSchemeId => $_getN(1);
  @$pb.TagNumber(8)
  set pointsSchemeId($3.StringValue value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasPointsSchemeId() => $_has(1);
  @$pb.TagNumber(8)
  void clearPointsSchemeId() => $_clearField(8);
  @$pb.TagNumber(8)
  $3.StringValue ensurePointsSchemeId() => $_ensure(1);

  @$pb.TagNumber(10)
  $core.bool get practiceSession => $_getBF(2);
  @$pb.TagNumber(10)
  set practiceSession($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(10)
  $core.bool hasPracticeSession() => $_has(2);
  @$pb.TagNumber(10)
  void clearPracticeSession() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.bool get qualifyingSession => $_getBF(3);
  @$pb.TagNumber(11)
  set qualifyingSession($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(11)
  $core.bool hasQualifyingSession() => $_has(3);
  @$pb.TagNumber(11)
  void clearQualifyingSession() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.bool get raceSession => $_getBF(4);
  @$pb.TagNumber(12)
  set raceSession($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(12)
  $core.bool hasRaceSession() => $_has(4);
  @$pb.TagNumber(12)
  void clearRaceSession() => $_clearField(12);

  @$pb.TagNumber(13)
  $8.RaceFormatTypeId get raceFormatTypeId => $_getN(5);
  @$pb.TagNumber(13)
  set raceFormatTypeId($8.RaceFormatTypeId value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasRaceFormatTypeId() => $_has(5);
  @$pb.TagNumber(13)
  void clearRaceFormatTypeId() => $_clearField(13);

  @$pb.TagNumber(14)
  $9.HeatEndTypeId get raceHeatEndTypeId => $_getN(6);
  @$pb.TagNumber(14)
  set raceHeatEndTypeId($9.HeatEndTypeId value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasRaceHeatEndTypeId() => $_has(6);
  @$pb.TagNumber(14)
  void clearRaceHeatEndTypeId() => $_clearField(14);

  @$pb.TagNumber(15)
  $3.UInt32Value get raceHeatEndLapLaps => $_getN(7);
  @$pb.TagNumber(15)
  set raceHeatEndLapLaps($3.UInt32Value value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasRaceHeatEndLapLaps() => $_has(7);
  @$pb.TagNumber(15)
  void clearRaceHeatEndLapLaps() => $_clearField(15);
  @$pb.TagNumber(15)
  $3.UInt32Value ensureRaceHeatEndLapLaps() => $_ensure(7);

  @$pb.TagNumber(16)
  $7.Duration get raceHeatEndDurationDuration => $_getN(8);
  @$pb.TagNumber(16)
  set raceHeatEndDurationDuration($7.Duration value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasRaceHeatEndDurationDuration() => $_has(8);
  @$pb.TagNumber(16)
  void clearRaceHeatEndDurationDuration() => $_clearField(16);
  @$pb.TagNumber(16)
  $7.Duration ensureRaceHeatEndDurationDuration() => $_ensure(8);

  @$pb.TagNumber(17)
  $pb.PbList<$core.String> get carTagIds => $_getList(9);

  @$pb.TagNumber(18)
  $10.HeatCarTypeId get heatCarTypeId => $_getN(10);
  @$pb.TagNumber(18)
  set heatCarTypeId($10.HeatCarTypeId value) => $_setField(18, value);
  @$pb.TagNumber(18)
  $core.bool hasHeatCarTypeId() => $_has(10);
  @$pb.TagNumber(18)
  void clearHeatCarTypeId() => $_clearField(18);

  @$pb.TagNumber(19)
  $pb.PbList<RaceIndicatorReadCreateUpdate> get raceIndicators => $_getList(11);

  @$pb.TagNumber(20)
  $pb.PbList<RaceEventUserReadCreateUpdate> get raceEventUsers => $_getList(12);

  @$pb.TagNumber(21)
  $pb.PbList<RaceIndicatorEventUserReadCreateUpdate>
      get raceIndicatorEventUsers => $_getList(13);

  @$pb.TagNumber(22)
  $core.bool get energySimulation => $_getBF(14);
  @$pb.TagNumber(22)
  set energySimulation($core.bool value) => $_setBool(14, value);
  @$pb.TagNumber(22)
  $core.bool hasEnergySimulation() => $_has(14);
  @$pb.TagNumber(22)
  void clearEnergySimulation() => $_clearField(22);
}

class RaceIndicatorReadCreateUpdate extends $pb.GeneratedMessage {
  factory RaceIndicatorReadCreateUpdate({
    $core.int? indicatorId,
    $3.StringValue? carId,
  }) {
    final result = create();
    if (indicatorId != null) result.indicatorId = indicatorId;
    if (carId != null) result.carId = carId;
    return result;
  }

  RaceIndicatorReadCreateUpdate._();

  factory RaceIndicatorReadCreateUpdate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RaceIndicatorReadCreateUpdate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RaceIndicatorReadCreateUpdate',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.race'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'indicatorId',
        fieldType: $pb.PbFieldType.OU3)
    ..aOM<$3.StringValue>(2, _omitFieldNames ? '' : 'carId',
        subBuilder: $3.StringValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceIndicatorReadCreateUpdate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceIndicatorReadCreateUpdate copyWith(
          void Function(RaceIndicatorReadCreateUpdate) updates) =>
      super.copyWith(
              (message) => updates(message as RaceIndicatorReadCreateUpdate))
          as RaceIndicatorReadCreateUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RaceIndicatorReadCreateUpdate create() =>
      RaceIndicatorReadCreateUpdate._();
  @$core.override
  RaceIndicatorReadCreateUpdate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RaceIndicatorReadCreateUpdate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RaceIndicatorReadCreateUpdate>(create);
  static RaceIndicatorReadCreateUpdate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get indicatorId => $_getIZ(0);
  @$pb.TagNumber(1)
  set indicatorId($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIndicatorId() => $_has(0);
  @$pb.TagNumber(1)
  void clearIndicatorId() => $_clearField(1);

  @$pb.TagNumber(2)
  $3.StringValue get carId => $_getN(1);
  @$pb.TagNumber(2)
  set carId($3.StringValue value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCarId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCarId() => $_clearField(2);
  @$pb.TagNumber(2)
  $3.StringValue ensureCarId() => $_ensure(1);
}

class RaceEventUserReadCreateUpdate extends $pb.GeneratedMessage {
  factory RaceEventUserReadCreateUpdate({
    $core.String? eventUserId,
    $3.StringValue? carId,
  }) {
    final result = create();
    if (eventUserId != null) result.eventUserId = eventUserId;
    if (carId != null) result.carId = carId;
    return result;
  }

  RaceEventUserReadCreateUpdate._();

  factory RaceEventUserReadCreateUpdate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RaceEventUserReadCreateUpdate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RaceEventUserReadCreateUpdate',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.race'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'eventUserId')
    ..aOM<$3.StringValue>(2, _omitFieldNames ? '' : 'carId',
        subBuilder: $3.StringValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceEventUserReadCreateUpdate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceEventUserReadCreateUpdate copyWith(
          void Function(RaceEventUserReadCreateUpdate) updates) =>
      super.copyWith(
              (message) => updates(message as RaceEventUserReadCreateUpdate))
          as RaceEventUserReadCreateUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RaceEventUserReadCreateUpdate create() =>
      RaceEventUserReadCreateUpdate._();
  @$core.override
  RaceEventUserReadCreateUpdate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RaceEventUserReadCreateUpdate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RaceEventUserReadCreateUpdate>(create);
  static RaceEventUserReadCreateUpdate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get eventUserId => $_getSZ(0);
  @$pb.TagNumber(1)
  set eventUserId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEventUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEventUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $3.StringValue get carId => $_getN(1);
  @$pb.TagNumber(2)
  set carId($3.StringValue value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCarId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCarId() => $_clearField(2);
  @$pb.TagNumber(2)
  $3.StringValue ensureCarId() => $_ensure(1);
}

class RaceIndicatorEventUserReadCreateUpdate extends $pb.GeneratedMessage {
  factory RaceIndicatorEventUserReadCreateUpdate({
    $core.int? indicatorId,
    $core.String? eventUserId,
    $3.UInt32Value? carClassColor,
    $3.StringValue? carId,
  }) {
    final result = create();
    if (indicatorId != null) result.indicatorId = indicatorId;
    if (eventUserId != null) result.eventUserId = eventUserId;
    if (carClassColor != null) result.carClassColor = carClassColor;
    if (carId != null) result.carId = carId;
    return result;
  }

  RaceIndicatorEventUserReadCreateUpdate._();

  factory RaceIndicatorEventUserReadCreateUpdate.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RaceIndicatorEventUserReadCreateUpdate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RaceIndicatorEventUserReadCreateUpdate',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.race'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'indicatorId',
        fieldType: $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'eventUserId')
    ..aOM<$3.UInt32Value>(3, _omitFieldNames ? '' : 'carClassColor',
        subBuilder: $3.UInt32Value.create)
    ..aOM<$3.StringValue>(4, _omitFieldNames ? '' : 'carId',
        subBuilder: $3.StringValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceIndicatorEventUserReadCreateUpdate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceIndicatorEventUserReadCreateUpdate copyWith(
          void Function(RaceIndicatorEventUserReadCreateUpdate) updates) =>
      super.copyWith((message) =>
              updates(message as RaceIndicatorEventUserReadCreateUpdate))
          as RaceIndicatorEventUserReadCreateUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RaceIndicatorEventUserReadCreateUpdate create() =>
      RaceIndicatorEventUserReadCreateUpdate._();
  @$core.override
  RaceIndicatorEventUserReadCreateUpdate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RaceIndicatorEventUserReadCreateUpdate getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          RaceIndicatorEventUserReadCreateUpdate>(create);
  static RaceIndicatorEventUserReadCreateUpdate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get indicatorId => $_getIZ(0);
  @$pb.TagNumber(1)
  set indicatorId($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIndicatorId() => $_has(0);
  @$pb.TagNumber(1)
  void clearIndicatorId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get eventUserId => $_getSZ(1);
  @$pb.TagNumber(2)
  set eventUserId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEventUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearEventUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $3.UInt32Value get carClassColor => $_getN(2);
  @$pb.TagNumber(3)
  set carClassColor($3.UInt32Value value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCarClassColor() => $_has(2);
  @$pb.TagNumber(3)
  void clearCarClassColor() => $_clearField(3);
  @$pb.TagNumber(3)
  $3.UInt32Value ensureCarClassColor() => $_ensure(2);

  @$pb.TagNumber(4)
  $3.StringValue get carId => $_getN(3);
  @$pb.TagNumber(4)
  set carId($3.StringValue value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasCarId() => $_has(3);
  @$pb.TagNumber(4)
  void clearCarId() => $_clearField(4);
  @$pb.TagNumber(4)
  $3.StringValue ensureCarId() => $_ensure(3);
}

class RaceStateType extends $pb.GeneratedMessage {
  factory RaceStateType({
    $11.RaceStateTypeId? id,
    $core.String? name,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    return result;
  }

  RaceStateType._();

  factory RaceStateType.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RaceStateType.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RaceStateType',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.race'),
      createEmptyInstance: create)
    ..aE<$11.RaceStateTypeId>(1, _omitFieldNames ? '' : 'id',
        enumValues: $11.RaceStateTypeId.values)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceStateType clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceStateType copyWith(void Function(RaceStateType) updates) =>
      super.copyWith((message) => updates(message as RaceStateType))
          as RaceStateType;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RaceStateType create() => RaceStateType._();
  @$core.override
  RaceStateType createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RaceStateType getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RaceStateType>(create);
  static RaceStateType? _defaultInstance;

  @$pb.TagNumber(1)
  $11.RaceStateTypeId get id => $_getN(0);
  @$pb.TagNumber(1)
  set id($11.RaceStateTypeId value) => $_setField(1, value);
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

class RaceListResponse extends $pb.GeneratedMessage {
  factory RaceListResponse({
    $core.Iterable<RaceList>? result,
  }) {
    final result$ = create();
    if (result != null) result$.result.addAll(result);
    return result$;
  }

  RaceListResponse._();

  factory RaceListResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RaceListResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RaceListResponse',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.race'),
      createEmptyInstance: create)
    ..pPM<RaceList>(1, _omitFieldNames ? '' : 'result',
        subBuilder: RaceList.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceListResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceListResponse copyWith(void Function(RaceListResponse) updates) =>
      super.copyWith((message) => updates(message as RaceListResponse))
          as RaceListResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RaceListResponse create() => RaceListResponse._();
  @$core.override
  RaceListResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RaceListResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RaceListResponse>(create);
  static RaceListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<RaceList> get result => $_getList(0);
}

class RaceList extends $pb.GeneratedMessage {
  factory RaceList({
    $core.String? id,
    $4.EventSelect? event,
    $core.int? number,
    $3.StringValue? name,
    $5.TrackConfigurationList? trackConfiguration,
    RaceStateType? raceStateType,
    $core.String? etag,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (event != null) result.event = event;
    if (number != null) result.number = number;
    if (name != null) result.name = name;
    if (trackConfiguration != null)
      result.trackConfiguration = trackConfiguration;
    if (raceStateType != null) result.raceStateType = raceStateType;
    if (etag != null) result.etag = etag;
    return result;
  }

  RaceList._();

  factory RaceList.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RaceList.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RaceList',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.race'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<$4.EventSelect>(2, _omitFieldNames ? '' : 'event',
        subBuilder: $4.EventSelect.create)
    ..aI(3, _omitFieldNames ? '' : 'number', fieldType: $pb.PbFieldType.OU3)
    ..aOM<$3.StringValue>(4, _omitFieldNames ? '' : 'name',
        subBuilder: $3.StringValue.create)
    ..aOM<$5.TrackConfigurationList>(
        5, _omitFieldNames ? '' : 'trackConfiguration',
        subBuilder: $5.TrackConfigurationList.create)
    ..aOM<RaceStateType>(6, _omitFieldNames ? '' : 'raceStateType',
        subBuilder: RaceStateType.create)
    ..aOS(7, _omitFieldNames ? '' : 'etag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceList clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceList copyWith(void Function(RaceList) updates) =>
      super.copyWith((message) => updates(message as RaceList)) as RaceList;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RaceList create() => RaceList._();
  @$core.override
  RaceList createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RaceList getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RaceList>(create);
  static RaceList? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $4.EventSelect get event => $_getN(1);
  @$pb.TagNumber(2)
  set event($4.EventSelect value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEvent() => $_has(1);
  @$pb.TagNumber(2)
  void clearEvent() => $_clearField(2);
  @$pb.TagNumber(2)
  $4.EventSelect ensureEvent() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.int get number => $_getIZ(2);
  @$pb.TagNumber(3)
  set number($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearNumber() => $_clearField(3);

  @$pb.TagNumber(4)
  $3.StringValue get name => $_getN(3);
  @$pb.TagNumber(4)
  set name($3.StringValue value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasName() => $_has(3);
  @$pb.TagNumber(4)
  void clearName() => $_clearField(4);
  @$pb.TagNumber(4)
  $3.StringValue ensureName() => $_ensure(3);

  @$pb.TagNumber(5)
  $5.TrackConfigurationList get trackConfiguration => $_getN(4);
  @$pb.TagNumber(5)
  set trackConfiguration($5.TrackConfigurationList value) =>
      $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasTrackConfiguration() => $_has(4);
  @$pb.TagNumber(5)
  void clearTrackConfiguration() => $_clearField(5);
  @$pb.TagNumber(5)
  $5.TrackConfigurationList ensureTrackConfiguration() => $_ensure(4);

  @$pb.TagNumber(6)
  RaceStateType get raceStateType => $_getN(5);
  @$pb.TagNumber(6)
  set raceStateType(RaceStateType value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasRaceStateType() => $_has(5);
  @$pb.TagNumber(6)
  void clearRaceStateType() => $_clearField(6);
  @$pb.TagNumber(6)
  RaceStateType ensureRaceStateType() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get etag => $_getSZ(6);
  @$pb.TagNumber(7)
  set etag($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasEtag() => $_has(6);
  @$pb.TagNumber(7)
  void clearEtag() => $_clearField(7);
}

class RaceSelectRequest extends $pb.GeneratedMessage {
  factory RaceSelectRequest({
    $core.String? eventId,
  }) {
    final result = create();
    if (eventId != null) result.eventId = eventId;
    return result;
  }

  RaceSelectRequest._();

  factory RaceSelectRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RaceSelectRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RaceSelectRequest',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.race'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'eventId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceSelectRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceSelectRequest copyWith(void Function(RaceSelectRequest) updates) =>
      super.copyWith((message) => updates(message as RaceSelectRequest))
          as RaceSelectRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RaceSelectRequest create() => RaceSelectRequest._();
  @$core.override
  RaceSelectRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RaceSelectRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RaceSelectRequest>(create);
  static RaceSelectRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get eventId => $_getSZ(0);
  @$pb.TagNumber(1)
  set eventId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEventId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEventId() => $_clearField(1);
}

class RaceSelectResponse extends $pb.GeneratedMessage {
  factory RaceSelectResponse({
    $core.Iterable<RaceSelect>? result,
  }) {
    final result$ = create();
    if (result != null) result$.result.addAll(result);
    return result$;
  }

  RaceSelectResponse._();

  factory RaceSelectResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RaceSelectResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RaceSelectResponse',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.race'),
      createEmptyInstance: create)
    ..pPM<RaceSelect>(1, _omitFieldNames ? '' : 'result',
        subBuilder: RaceSelect.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceSelectResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceSelectResponse copyWith(void Function(RaceSelectResponse) updates) =>
      super.copyWith((message) => updates(message as RaceSelectResponse))
          as RaceSelectResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RaceSelectResponse create() => RaceSelectResponse._();
  @$core.override
  RaceSelectResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RaceSelectResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RaceSelectResponse>(create);
  static RaceSelectResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<RaceSelect> get result => $_getList(0);
}

class RaceSelect extends $pb.GeneratedMessage {
  factory RaceSelect({
    $core.String? id,
    $core.String? number,
    $3.StringValue? name,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (number != null) result.number = number;
    if (name != null) result.name = name;
    return result;
  }

  RaceSelect._();

  factory RaceSelect.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RaceSelect.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RaceSelect',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.race'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'number')
    ..aOM<$3.StringValue>(3, _omitFieldNames ? '' : 'name',
        subBuilder: $3.StringValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceSelect clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceSelect copyWith(void Function(RaceSelect) updates) =>
      super.copyWith((message) => updates(message as RaceSelect)) as RaceSelect;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RaceSelect create() => RaceSelect._();
  @$core.override
  RaceSelect createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RaceSelect getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RaceSelect>(create);
  static RaceSelect? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get number => $_getSZ(1);
  @$pb.TagNumber(2)
  set number($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearNumber() => $_clearField(2);

  @$pb.TagNumber(3)
  $3.StringValue get name => $_getN(2);
  @$pb.TagNumber(3)
  set name($3.StringValue value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);
  @$pb.TagNumber(3)
  $3.StringValue ensureName() => $_ensure(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
