// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/race.v1.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/duration.pb.dart'
    as $2;
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart'
    as $0;

import 'heat.v1.pb.dart' as $3;
import 'race.v1.pbenum.dart';
import 'race_feature_type_id.v1.pbenum.dart' as $4;
import 'session_type_id.v1.pbenum.dart' as $5;
import 'track_configuration.v1.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'race.v1.pbenum.dart';

class RaceCommandPermissions extends $pb.GeneratedMessage {
  factory RaceCommandPermissions({
    $core.Iterable<RaceCommandTypeId>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  RaceCommandPermissions._();

  factory RaceCommandPermissions.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RaceCommandPermissions.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RaceCommandPermissions',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..pc<RaceCommandTypeId>(
        1, _omitFieldNames ? '' : 'items', $pb.PbFieldType.KE,
        valueOf: RaceCommandTypeId.valueOf,
        enumValues: RaceCommandTypeId.values,
        defaultEnumValue: RaceCommandTypeId.RACE_COMMAND_TYPE_ID_START)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceCommandPermissions clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceCommandPermissions copyWith(
          void Function(RaceCommandPermissions) updates) =>
      super.copyWith((message) => updates(message as RaceCommandPermissions))
          as RaceCommandPermissions;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RaceCommandPermissions create() => RaceCommandPermissions._();
  @$core.override
  RaceCommandPermissions createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RaceCommandPermissions getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RaceCommandPermissions>(create);
  static RaceCommandPermissions? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<RaceCommandTypeId> get items => $_getList(0);
}

class RaceStateType extends $pb.GeneratedMessage {
  factory RaceStateType({
    RaceStateTypeId? id,
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
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aE<RaceStateTypeId>(1, _omitFieldNames ? '' : 'id',
        enumValues: RaceStateTypeId.values)
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
  RaceStateTypeId get id => $_getN(0);
  @$pb.TagNumber(1)
  set id(RaceStateTypeId value) => $_setField(1, value);
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

class Race extends $pb.GeneratedMessage {
  factory Race({
    $core.String? id,
    $core.int? number,
    $0.StringValue? name,
    $core.String? eventId,
    $1.TrackConfiguration? trackConfiguration,
    $0.StringValue? pointsSchemeId,
    $3.HeatEndTypeId? raceHeatEndTypeId,
    $0.UInt32Value? raceHeatEndLapLaps,
    $2.Duration? raceHeatEndDurationDuration,
    $core.Iterable<RaceIndicator>? raceIndicators,
    $core.Iterable<$core.String>? raceEventUsers,
    RaceStateType? raceStateType,
    $core.Iterable<$4.RaceFeatureTypeId>? raceFeatures,
    $core.Iterable<$3.Heat>? heats,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (number != null) result.number = number;
    if (name != null) result.name = name;
    if (eventId != null) result.eventId = eventId;
    if (trackConfiguration != null)
      result.trackConfiguration = trackConfiguration;
    if (pointsSchemeId != null) result.pointsSchemeId = pointsSchemeId;
    if (raceHeatEndTypeId != null) result.raceHeatEndTypeId = raceHeatEndTypeId;
    if (raceHeatEndLapLaps != null)
      result.raceHeatEndLapLaps = raceHeatEndLapLaps;
    if (raceHeatEndDurationDuration != null)
      result.raceHeatEndDurationDuration = raceHeatEndDurationDuration;
    if (raceIndicators != null) result.raceIndicators.addAll(raceIndicators);
    if (raceEventUsers != null) result.raceEventUsers.addAll(raceEventUsers);
    if (raceStateType != null) result.raceStateType = raceStateType;
    if (raceFeatures != null) result.raceFeatures.addAll(raceFeatures);
    if (heats != null) result.heats.addAll(heats);
    return result;
  }

  Race._();

  factory Race.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Race.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Race',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aI(2, _omitFieldNames ? '' : 'number', fieldType: $pb.PbFieldType.OU3)
    ..aOM<$0.StringValue>(3, _omitFieldNames ? '' : 'name',
        subBuilder: $0.StringValue.create)
    ..aOS(4, _omitFieldNames ? '' : 'eventId')
    ..aOM<$1.TrackConfiguration>(7, _omitFieldNames ? '' : 'trackConfiguration',
        subBuilder: $1.TrackConfiguration.create)
    ..aOM<$0.StringValue>(8, _omitFieldNames ? '' : 'pointsSchemeId',
        subBuilder: $0.StringValue.create)
    ..aE<$3.HeatEndTypeId>(14, _omitFieldNames ? '' : 'raceHeatEndTypeId',
        enumValues: $3.HeatEndTypeId.values)
    ..aOM<$0.UInt32Value>(15, _omitFieldNames ? '' : 'raceHeatEndLapLaps',
        subBuilder: $0.UInt32Value.create)
    ..aOM<$2.Duration>(16, _omitFieldNames ? '' : 'raceHeatEndDurationDuration',
        subBuilder: $2.Duration.create)
    ..pPM<RaceIndicator>(19, _omitFieldNames ? '' : 'raceIndicators',
        subBuilder: RaceIndicator.create)
    ..pPS(20, _omitFieldNames ? '' : 'raceEventUsers')
    ..aOM<RaceStateType>(21, _omitFieldNames ? '' : 'raceStateType',
        subBuilder: RaceStateType.create)
    ..pc<$4.RaceFeatureTypeId>(
        22, _omitFieldNames ? '' : 'raceFeatures', $pb.PbFieldType.KE,
        valueOf: $4.RaceFeatureTypeId.valueOf,
        enumValues: $4.RaceFeatureTypeId.values,
        defaultEnumValue: $4.RaceFeatureTypeId.RACE_FEATURE_TYPE_ID_UNDEFINED)
    ..pPM<$3.Heat>(23, _omitFieldNames ? '' : 'heats',
        subBuilder: $3.Heat.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Race clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Race copyWith(void Function(Race) updates) =>
      super.copyWith((message) => updates(message as Race)) as Race;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Race create() => Race._();
  @$core.override
  Race createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Race getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Race>(create);
  static Race? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get number => $_getIZ(1);
  @$pb.TagNumber(2)
  set number($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearNumber() => $_clearField(2);

  @$pb.TagNumber(3)
  $0.StringValue get name => $_getN(2);
  @$pb.TagNumber(3)
  set name($0.StringValue value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.StringValue ensureName() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get eventId => $_getSZ(3);
  @$pb.TagNumber(4)
  set eventId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasEventId() => $_has(3);
  @$pb.TagNumber(4)
  void clearEventId() => $_clearField(4);

  @$pb.TagNumber(7)
  $1.TrackConfiguration get trackConfiguration => $_getN(4);
  @$pb.TagNumber(7)
  set trackConfiguration($1.TrackConfiguration value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasTrackConfiguration() => $_has(4);
  @$pb.TagNumber(7)
  void clearTrackConfiguration() => $_clearField(7);
  @$pb.TagNumber(7)
  $1.TrackConfiguration ensureTrackConfiguration() => $_ensure(4);

  @$pb.TagNumber(8)
  $0.StringValue get pointsSchemeId => $_getN(5);
  @$pb.TagNumber(8)
  set pointsSchemeId($0.StringValue value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasPointsSchemeId() => $_has(5);
  @$pb.TagNumber(8)
  void clearPointsSchemeId() => $_clearField(8);
  @$pb.TagNumber(8)
  $0.StringValue ensurePointsSchemeId() => $_ensure(5);

  /// bool practice_session = 7;
  /// bool qualifying_session = 8;
  /// bool race_session = 9;
  /// race_format_type.RaceFormatTypeId race_format_type_id = 13;
  @$pb.TagNumber(14)
  $3.HeatEndTypeId get raceHeatEndTypeId => $_getN(6);
  @$pb.TagNumber(14)
  set raceHeatEndTypeId($3.HeatEndTypeId value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasRaceHeatEndTypeId() => $_has(6);
  @$pb.TagNumber(14)
  void clearRaceHeatEndTypeId() => $_clearField(14);

  @$pb.TagNumber(15)
  $0.UInt32Value get raceHeatEndLapLaps => $_getN(7);
  @$pb.TagNumber(15)
  set raceHeatEndLapLaps($0.UInt32Value value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasRaceHeatEndLapLaps() => $_has(7);
  @$pb.TagNumber(15)
  void clearRaceHeatEndLapLaps() => $_clearField(15);
  @$pb.TagNumber(15)
  $0.UInt32Value ensureRaceHeatEndLapLaps() => $_ensure(7);

  @$pb.TagNumber(16)
  $2.Duration get raceHeatEndDurationDuration => $_getN(8);
  @$pb.TagNumber(16)
  set raceHeatEndDurationDuration($2.Duration value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasRaceHeatEndDurationDuration() => $_has(8);
  @$pb.TagNumber(16)
  void clearRaceHeatEndDurationDuration() => $_clearField(16);
  @$pb.TagNumber(16)
  $2.Duration ensureRaceHeatEndDurationDuration() => $_ensure(8);

  @$pb.TagNumber(19)
  $pb.PbList<RaceIndicator> get raceIndicators => $_getList(9);

  @$pb.TagNumber(20)
  $pb.PbList<$core.String> get raceEventUsers => $_getList(10);

  @$pb.TagNumber(21)
  RaceStateType get raceStateType => $_getN(11);
  @$pb.TagNumber(21)
  set raceStateType(RaceStateType value) => $_setField(21, value);
  @$pb.TagNumber(21)
  $core.bool hasRaceStateType() => $_has(11);
  @$pb.TagNumber(21)
  void clearRaceStateType() => $_clearField(21);
  @$pb.TagNumber(21)
  RaceStateType ensureRaceStateType() => $_ensure(11);

  @$pb.TagNumber(22)
  $pb.PbList<$4.RaceFeatureTypeId> get raceFeatures => $_getList(12);

  @$pb.TagNumber(23)
  $pb.PbList<$3.Heat> get heats => $_getList(13);
}

class RaceIndicator extends $pb.GeneratedMessage {
  factory RaceIndicator({
    $core.int? indicatorId,
    $0.UInt32Value? color,
  }) {
    final result = create();
    if (indicatorId != null) result.indicatorId = indicatorId;
    if (color != null) result.color = color;
    return result;
  }

  RaceIndicator._();

  factory RaceIndicator.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RaceIndicator.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RaceIndicator',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'indicatorId',
        fieldType: $pb.PbFieldType.OU3)
    ..aOM<$0.UInt32Value>(2, _omitFieldNames ? '' : 'color',
        subBuilder: $0.UInt32Value.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceIndicator clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceIndicator copyWith(void Function(RaceIndicator) updates) =>
      super.copyWith((message) => updates(message as RaceIndicator))
          as RaceIndicator;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RaceIndicator create() => RaceIndicator._();
  @$core.override
  RaceIndicator createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RaceIndicator getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RaceIndicator>(create);
  static RaceIndicator? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get indicatorId => $_getIZ(0);
  @$pb.TagNumber(1)
  set indicatorId($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIndicatorId() => $_has(0);
  @$pb.TagNumber(1)
  void clearIndicatorId() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.UInt32Value get color => $_getN(1);
  @$pb.TagNumber(2)
  set color($0.UInt32Value value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasColor() => $_has(1);
  @$pb.TagNumber(2)
  void clearColor() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.UInt32Value ensureColor() => $_ensure(1);
}

class RaceState extends $pb.GeneratedMessage {
  factory RaceState({
    $5.SessionTypeId? sessionTypeId,
    RaceStateType? raceStateType,
    $core.Iterable<RaceEventUserState>? raceEventUserStates,
    $0.StringValue? heatId,
    $0.UInt32Value? heatNumber,
    $3.HeatState? heatState,
  }) {
    final result = create();
    if (sessionTypeId != null) result.sessionTypeId = sessionTypeId;
    if (raceStateType != null) result.raceStateType = raceStateType;
    if (raceEventUserStates != null)
      result.raceEventUserStates.addAll(raceEventUserStates);
    if (heatId != null) result.heatId = heatId;
    if (heatNumber != null) result.heatNumber = heatNumber;
    if (heatState != null) result.heatState = heatState;
    return result;
  }

  RaceState._();

  factory RaceState.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RaceState.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RaceState',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aE<$5.SessionTypeId>(1, _omitFieldNames ? '' : 'sessionTypeId',
        enumValues: $5.SessionTypeId.values)
    ..aOM<RaceStateType>(2, _omitFieldNames ? '' : 'raceStateType',
        subBuilder: RaceStateType.create)
    ..pPM<RaceEventUserState>(3, _omitFieldNames ? '' : 'raceEventUserStates',
        subBuilder: RaceEventUserState.create)
    ..aOM<$0.StringValue>(4, _omitFieldNames ? '' : 'heatId',
        subBuilder: $0.StringValue.create)
    ..aOM<$0.UInt32Value>(5, _omitFieldNames ? '' : 'heatNumber',
        subBuilder: $0.UInt32Value.create)
    ..aOM<$3.HeatState>(6, _omitFieldNames ? '' : 'heatState',
        subBuilder: $3.HeatState.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceState clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceState copyWith(void Function(RaceState) updates) =>
      super.copyWith((message) => updates(message as RaceState)) as RaceState;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RaceState create() => RaceState._();
  @$core.override
  RaceState createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RaceState getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RaceState>(create);
  static RaceState? _defaultInstance;

  @$pb.TagNumber(1)
  $5.SessionTypeId get sessionTypeId => $_getN(0);
  @$pb.TagNumber(1)
  set sessionTypeId($5.SessionTypeId value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSessionTypeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionTypeId() => $_clearField(1);

  @$pb.TagNumber(2)
  RaceStateType get raceStateType => $_getN(1);
  @$pb.TagNumber(2)
  set raceStateType(RaceStateType value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasRaceStateType() => $_has(1);
  @$pb.TagNumber(2)
  void clearRaceStateType() => $_clearField(2);
  @$pb.TagNumber(2)
  RaceStateType ensureRaceStateType() => $_ensure(1);

  @$pb.TagNumber(3)
  $pb.PbList<RaceEventUserState> get raceEventUserStates => $_getList(2);

  @$pb.TagNumber(4)
  $0.StringValue get heatId => $_getN(3);
  @$pb.TagNumber(4)
  set heatId($0.StringValue value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasHeatId() => $_has(3);
  @$pb.TagNumber(4)
  void clearHeatId() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.StringValue ensureHeatId() => $_ensure(3);

  @$pb.TagNumber(5)
  $0.UInt32Value get heatNumber => $_getN(4);
  @$pb.TagNumber(5)
  set heatNumber($0.UInt32Value value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasHeatNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearHeatNumber() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.UInt32Value ensureHeatNumber() => $_ensure(4);

  @$pb.TagNumber(6)
  $3.HeatState get heatState => $_getN(5);
  @$pb.TagNumber(6)
  set heatState($3.HeatState value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasHeatState() => $_has(5);
  @$pb.TagNumber(6)
  void clearHeatState() => $_clearField(6);
  @$pb.TagNumber(6)
  $3.HeatState ensureHeatState() => $_ensure(5);
}

class RaceEventUserState extends $pb.GeneratedMessage {
  factory RaceEventUserState({
    $core.String? eventUserId,
    $0.UInt32Value? indicatorIdCurrent,
    $core.Iterable<$core.int>? indicatorIdsFinished,
  }) {
    final result = create();
    if (eventUserId != null) result.eventUserId = eventUserId;
    if (indicatorIdCurrent != null)
      result.indicatorIdCurrent = indicatorIdCurrent;
    if (indicatorIdsFinished != null)
      result.indicatorIdsFinished.addAll(indicatorIdsFinished);
    return result;
  }

  RaceEventUserState._();

  factory RaceEventUserState.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RaceEventUserState.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RaceEventUserState',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'eventUserId')
    ..aOM<$0.UInt32Value>(2, _omitFieldNames ? '' : 'indicatorIdCurrent',
        subBuilder: $0.UInt32Value.create)
    ..p<$core.int>(
        3, _omitFieldNames ? '' : 'indicatorIdsFinished', $pb.PbFieldType.KU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceEventUserState clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceEventUserState copyWith(void Function(RaceEventUserState) updates) =>
      super.copyWith((message) => updates(message as RaceEventUserState))
          as RaceEventUserState;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RaceEventUserState create() => RaceEventUserState._();
  @$core.override
  RaceEventUserState createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RaceEventUserState getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RaceEventUserState>(create);
  static RaceEventUserState? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get eventUserId => $_getSZ(0);
  @$pb.TagNumber(1)
  set eventUserId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEventUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEventUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.UInt32Value get indicatorIdCurrent => $_getN(1);
  @$pb.TagNumber(2)
  set indicatorIdCurrent($0.UInt32Value value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasIndicatorIdCurrent() => $_has(1);
  @$pb.TagNumber(2)
  void clearIndicatorIdCurrent() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.UInt32Value ensureIndicatorIdCurrent() => $_ensure(1);

  @$pb.TagNumber(3)
  $pb.PbList<$core.int> get indicatorIdsFinished => $_getList(2);
}

class RaceLeaderboard extends $pb.GeneratedMessage {
  factory RaceLeaderboard({
    $5.SessionTypeId? sessionTypeId,
    $core.Iterable<RaceLeaderboardEventUser>? eventUsers,
  }) {
    final result = create();
    if (sessionTypeId != null) result.sessionTypeId = sessionTypeId;
    if (eventUsers != null) result.eventUsers.addAll(eventUsers);
    return result;
  }

  RaceLeaderboard._();

  factory RaceLeaderboard.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RaceLeaderboard.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RaceLeaderboard',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aE<$5.SessionTypeId>(1, _omitFieldNames ? '' : 'sessionTypeId',
        enumValues: $5.SessionTypeId.values)
    ..pPM<RaceLeaderboardEventUser>(2, _omitFieldNames ? '' : 'eventUsers',
        subBuilder: RaceLeaderboardEventUser.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceLeaderboard clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceLeaderboard copyWith(void Function(RaceLeaderboard) updates) =>
      super.copyWith((message) => updates(message as RaceLeaderboard))
          as RaceLeaderboard;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RaceLeaderboard create() => RaceLeaderboard._();
  @$core.override
  RaceLeaderboard createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RaceLeaderboard getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RaceLeaderboard>(create);
  static RaceLeaderboard? _defaultInstance;

  @$pb.TagNumber(1)
  $5.SessionTypeId get sessionTypeId => $_getN(0);
  @$pb.TagNumber(1)
  set sessionTypeId($5.SessionTypeId value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSessionTypeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionTypeId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<RaceLeaderboardEventUser> get eventUsers => $_getList(1);
}

class RaceLeaderboardEventUser extends $pb.GeneratedMessage {
  factory RaceLeaderboardEventUser({
    $core.String? eventUserId,
    $core.int? position,
    $0.StringValue? lapsCompleted,
    $0.StringValue? lapsPredicted,
    $0.StringValue? gapLapsPredictedLeader,
    $0.StringValue? gapLapsPredictedInterval,
    $0.DoubleValue? gapLapsPredictedIntervalFraction,
    $core.Iterable<$3.HeatIndicatorFlag>? flags,
    $0.StringValue? teamEventUserId,
  }) {
    final result = create();
    if (eventUserId != null) result.eventUserId = eventUserId;
    if (position != null) result.position = position;
    if (lapsCompleted != null) result.lapsCompleted = lapsCompleted;
    if (lapsPredicted != null) result.lapsPredicted = lapsPredicted;
    if (gapLapsPredictedLeader != null)
      result.gapLapsPredictedLeader = gapLapsPredictedLeader;
    if (gapLapsPredictedInterval != null)
      result.gapLapsPredictedInterval = gapLapsPredictedInterval;
    if (gapLapsPredictedIntervalFraction != null)
      result.gapLapsPredictedIntervalFraction =
          gapLapsPredictedIntervalFraction;
    if (flags != null) result.flags.addAll(flags);
    if (teamEventUserId != null) result.teamEventUserId = teamEventUserId;
    return result;
  }

  RaceLeaderboardEventUser._();

  factory RaceLeaderboardEventUser.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RaceLeaderboardEventUser.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RaceLeaderboardEventUser',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'eventUserId')
    ..aI(2, _omitFieldNames ? '' : 'position', fieldType: $pb.PbFieldType.OU3)
    ..aOM<$0.StringValue>(4, _omitFieldNames ? '' : 'lapsCompleted',
        subBuilder: $0.StringValue.create)
    ..aOM<$0.StringValue>(5, _omitFieldNames ? '' : 'lapsPredicted',
        subBuilder: $0.StringValue.create)
    ..aOM<$0.StringValue>(8, _omitFieldNames ? '' : 'gapLapsPredictedLeader',
        subBuilder: $0.StringValue.create)
    ..aOM<$0.StringValue>(9, _omitFieldNames ? '' : 'gapLapsPredictedInterval',
        subBuilder: $0.StringValue.create)
    ..aOM<$0.DoubleValue>(
        10, _omitFieldNames ? '' : 'gapLapsPredictedIntervalFraction',
        subBuilder: $0.DoubleValue.create)
    ..pc<$3.HeatIndicatorFlag>(
        11, _omitFieldNames ? '' : 'flags', $pb.PbFieldType.KE,
        valueOf: $3.HeatIndicatorFlag.valueOf,
        enumValues: $3.HeatIndicatorFlag.values,
        defaultEnumValue: $3.HeatIndicatorFlag.HEAT_INDICATOR_FLAG_FINISHED)
    ..aOM<$0.StringValue>(12, _omitFieldNames ? '' : 'teamEventUserId',
        subBuilder: $0.StringValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceLeaderboardEventUser clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceLeaderboardEventUser copyWith(
          void Function(RaceLeaderboardEventUser) updates) =>
      super.copyWith((message) => updates(message as RaceLeaderboardEventUser))
          as RaceLeaderboardEventUser;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RaceLeaderboardEventUser create() => RaceLeaderboardEventUser._();
  @$core.override
  RaceLeaderboardEventUser createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RaceLeaderboardEventUser getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RaceLeaderboardEventUser>(create);
  static RaceLeaderboardEventUser? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get eventUserId => $_getSZ(0);
  @$pb.TagNumber(1)
  set eventUserId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEventUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEventUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get position => $_getIZ(1);
  @$pb.TagNumber(2)
  set position($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearPosition() => $_clearField(2);

  /// uint32 position_estimate = 3;
  @$pb.TagNumber(4)
  $0.StringValue get lapsCompleted => $_getN(2);
  @$pb.TagNumber(4)
  set lapsCompleted($0.StringValue value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasLapsCompleted() => $_has(2);
  @$pb.TagNumber(4)
  void clearLapsCompleted() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.StringValue ensureLapsCompleted() => $_ensure(2);

  @$pb.TagNumber(5)
  $0.StringValue get lapsPredicted => $_getN(3);
  @$pb.TagNumber(5)
  set lapsPredicted($0.StringValue value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasLapsPredicted() => $_has(3);
  @$pb.TagNumber(5)
  void clearLapsPredicted() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.StringValue ensureLapsPredicted() => $_ensure(3);

  /// google.protobuf.UInt32Value points = 6;
  /// google.protobuf.UInt32Value points_predicted = 7;
  @$pb.TagNumber(8)
  $0.StringValue get gapLapsPredictedLeader => $_getN(4);
  @$pb.TagNumber(8)
  set gapLapsPredictedLeader($0.StringValue value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasGapLapsPredictedLeader() => $_has(4);
  @$pb.TagNumber(8)
  void clearGapLapsPredictedLeader() => $_clearField(8);
  @$pb.TagNumber(8)
  $0.StringValue ensureGapLapsPredictedLeader() => $_ensure(4);

  @$pb.TagNumber(9)
  $0.StringValue get gapLapsPredictedInterval => $_getN(5);
  @$pb.TagNumber(9)
  set gapLapsPredictedInterval($0.StringValue value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasGapLapsPredictedInterval() => $_has(5);
  @$pb.TagNumber(9)
  void clearGapLapsPredictedInterval() => $_clearField(9);
  @$pb.TagNumber(9)
  $0.StringValue ensureGapLapsPredictedInterval() => $_ensure(5);

  @$pb.TagNumber(10)
  $0.DoubleValue get gapLapsPredictedIntervalFraction => $_getN(6);
  @$pb.TagNumber(10)
  set gapLapsPredictedIntervalFraction($0.DoubleValue value) =>
      $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasGapLapsPredictedIntervalFraction() => $_has(6);
  @$pb.TagNumber(10)
  void clearGapLapsPredictedIntervalFraction() => $_clearField(10);
  @$pb.TagNumber(10)
  $0.DoubleValue ensureGapLapsPredictedIntervalFraction() => $_ensure(6);

  @$pb.TagNumber(11)
  $pb.PbList<$3.HeatIndicatorFlag> get flags => $_getList(7);

  /// uint32 pit_lanes = 10;
  /// uint32 car_off_tracks = 11;
  @$pb.TagNumber(12)
  $0.StringValue get teamEventUserId => $_getN(8);
  @$pb.TagNumber(12)
  set teamEventUserId($0.StringValue value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasTeamEventUserId() => $_has(8);
  @$pb.TagNumber(12)
  void clearTeamEventUserId() => $_clearField(12);
  @$pb.TagNumber(12)
  $0.StringValue ensureTeamEventUserId() => $_ensure(8);
}

enum RaceLeaderboardHeatEventUserUpdate_Value { laps, finished, flags, notSet }

class RaceLeaderboardHeatEventUserUpdate extends $pb.GeneratedMessage {
  factory RaceLeaderboardHeatEventUserUpdate({
    $core.String? heatId,
    $core.String? eventUserId,
    $2.Duration? timerElapsed,
    $0.DoubleValue? laps,
    $core.bool? finished,
    $3.HeatIndicatorFlag? flags,
  }) {
    final result = create();
    if (heatId != null) result.heatId = heatId;
    if (eventUserId != null) result.eventUserId = eventUserId;
    if (timerElapsed != null) result.timerElapsed = timerElapsed;
    if (laps != null) result.laps = laps;
    if (finished != null) result.finished = finished;
    if (flags != null) result.flags = flags;
    return result;
  }

  RaceLeaderboardHeatEventUserUpdate._();

  factory RaceLeaderboardHeatEventUserUpdate.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RaceLeaderboardHeatEventUserUpdate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, RaceLeaderboardHeatEventUserUpdate_Value>
      _RaceLeaderboardHeatEventUserUpdate_ValueByTag = {
    4: RaceLeaderboardHeatEventUserUpdate_Value.laps,
    9: RaceLeaderboardHeatEventUserUpdate_Value.finished,
    10: RaceLeaderboardHeatEventUserUpdate_Value.flags,
    0: RaceLeaderboardHeatEventUserUpdate_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RaceLeaderboardHeatEventUserUpdate',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..oo(0, [4, 9, 10])
    ..aOS(1, _omitFieldNames ? '' : 'heatId')
    ..aOS(2, _omitFieldNames ? '' : 'eventUserId')
    ..aOM<$2.Duration>(3, _omitFieldNames ? '' : 'timerElapsed',
        subBuilder: $2.Duration.create)
    ..aOM<$0.DoubleValue>(4, _omitFieldNames ? '' : 'laps',
        subBuilder: $0.DoubleValue.create)
    ..aOB(9, _omitFieldNames ? '' : 'finished')
    ..aE<$3.HeatIndicatorFlag>(10, _omitFieldNames ? '' : 'flags',
        enumValues: $3.HeatIndicatorFlag.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceLeaderboardHeatEventUserUpdate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceLeaderboardHeatEventUserUpdate copyWith(
          void Function(RaceLeaderboardHeatEventUserUpdate) updates) =>
      super.copyWith((message) =>
              updates(message as RaceLeaderboardHeatEventUserUpdate))
          as RaceLeaderboardHeatEventUserUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RaceLeaderboardHeatEventUserUpdate create() =>
      RaceLeaderboardHeatEventUserUpdate._();
  @$core.override
  RaceLeaderboardHeatEventUserUpdate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RaceLeaderboardHeatEventUserUpdate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RaceLeaderboardHeatEventUserUpdate>(
          create);
  static RaceLeaderboardHeatEventUserUpdate? _defaultInstance;

  @$pb.TagNumber(4)
  @$pb.TagNumber(9)
  @$pb.TagNumber(10)
  RaceLeaderboardHeatEventUserUpdate_Value whichValue() =>
      _RaceLeaderboardHeatEventUserUpdate_ValueByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(4)
  @$pb.TagNumber(9)
  @$pb.TagNumber(10)
  void clearValue() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get heatId => $_getSZ(0);
  @$pb.TagNumber(1)
  set heatId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasHeatId() => $_has(0);
  @$pb.TagNumber(1)
  void clearHeatId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get eventUserId => $_getSZ(1);
  @$pb.TagNumber(2)
  set eventUserId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEventUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearEventUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $2.Duration get timerElapsed => $_getN(2);
  @$pb.TagNumber(3)
  set timerElapsed($2.Duration value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTimerElapsed() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimerElapsed() => $_clearField(3);
  @$pb.TagNumber(3)
  $2.Duration ensureTimerElapsed() => $_ensure(2);

  @$pb.TagNumber(4)
  $0.DoubleValue get laps => $_getN(3);
  @$pb.TagNumber(4)
  set laps($0.DoubleValue value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasLaps() => $_has(3);
  @$pb.TagNumber(4)
  void clearLaps() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.DoubleValue ensureLaps() => $_ensure(3);

  @$pb.TagNumber(9)
  $core.bool get finished => $_getBF(4);
  @$pb.TagNumber(9)
  set finished($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(9)
  $core.bool hasFinished() => $_has(4);
  @$pb.TagNumber(9)
  void clearFinished() => $_clearField(9);

  @$pb.TagNumber(10)
  $3.HeatIndicatorFlag get flags => $_getN(5);
  @$pb.TagNumber(10)
  set flags($3.HeatIndicatorFlag value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasFlags() => $_has(5);
  @$pb.TagNumber(10)
  void clearFlags() => $_clearField(10);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
