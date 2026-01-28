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
    $core.bool? practiceSession,
    $core.bool? qualifyingSession,
    $core.bool? raceSession,
    $3.HeatEndTypeId? raceHeatEndTypeId,
    $0.UInt32Value? raceHeatEndLapLaps,
    $2.Duration? raceHeatEndDurationDuration,
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
    if (practiceSession != null) result.practiceSession = practiceSession;
    if (qualifyingSession != null) result.qualifyingSession = qualifyingSession;
    if (raceSession != null) result.raceSession = raceSession;
    if (raceHeatEndTypeId != null) result.raceHeatEndTypeId = raceHeatEndTypeId;
    if (raceHeatEndLapLaps != null)
      result.raceHeatEndLapLaps = raceHeatEndLapLaps;
    if (raceHeatEndDurationDuration != null)
      result.raceHeatEndDurationDuration = raceHeatEndDurationDuration;
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
    ..aOM<$1.TrackConfiguration>(5, _omitFieldNames ? '' : 'trackConfiguration',
        subBuilder: $1.TrackConfiguration.create)
    ..aOM<$0.StringValue>(6, _omitFieldNames ? '' : 'pointsSchemeId',
        subBuilder: $0.StringValue.create)
    ..aOB(7, _omitFieldNames ? '' : 'practiceSession')
    ..aOB(8, _omitFieldNames ? '' : 'qualifyingSession')
    ..aOB(9, _omitFieldNames ? '' : 'raceSession')
    ..aE<$3.HeatEndTypeId>(10, _omitFieldNames ? '' : 'raceHeatEndTypeId',
        enumValues: $3.HeatEndTypeId.values)
    ..aOM<$0.UInt32Value>(11, _omitFieldNames ? '' : 'raceHeatEndLapLaps',
        subBuilder: $0.UInt32Value.create)
    ..aOM<$2.Duration>(12, _omitFieldNames ? '' : 'raceHeatEndDurationDuration',
        subBuilder: $2.Duration.create)
    ..aOM<RaceStateType>(13, _omitFieldNames ? '' : 'raceStateType',
        subBuilder: RaceStateType.create)
    ..pc<$4.RaceFeatureTypeId>(
        14, _omitFieldNames ? '' : 'raceFeatures', $pb.PbFieldType.KE,
        valueOf: $4.RaceFeatureTypeId.valueOf,
        enumValues: $4.RaceFeatureTypeId.values,
        defaultEnumValue: $4.RaceFeatureTypeId.RACE_FEATURE_TYPE_ID_UNDEFINED)
    ..pPM<$3.Heat>(15, _omitFieldNames ? '' : 'heats',
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

  @$pb.TagNumber(5)
  $1.TrackConfiguration get trackConfiguration => $_getN(4);
  @$pb.TagNumber(5)
  set trackConfiguration($1.TrackConfiguration value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasTrackConfiguration() => $_has(4);
  @$pb.TagNumber(5)
  void clearTrackConfiguration() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.TrackConfiguration ensureTrackConfiguration() => $_ensure(4);

  @$pb.TagNumber(6)
  $0.StringValue get pointsSchemeId => $_getN(5);
  @$pb.TagNumber(6)
  set pointsSchemeId($0.StringValue value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasPointsSchemeId() => $_has(5);
  @$pb.TagNumber(6)
  void clearPointsSchemeId() => $_clearField(6);
  @$pb.TagNumber(6)
  $0.StringValue ensurePointsSchemeId() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.bool get practiceSession => $_getBF(6);
  @$pb.TagNumber(7)
  set practiceSession($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPracticeSession() => $_has(6);
  @$pb.TagNumber(7)
  void clearPracticeSession() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get qualifyingSession => $_getBF(7);
  @$pb.TagNumber(8)
  set qualifyingSession($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasQualifyingSession() => $_has(7);
  @$pb.TagNumber(8)
  void clearQualifyingSession() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get raceSession => $_getBF(8);
  @$pb.TagNumber(9)
  set raceSession($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasRaceSession() => $_has(8);
  @$pb.TagNumber(9)
  void clearRaceSession() => $_clearField(9);

  @$pb.TagNumber(10)
  $3.HeatEndTypeId get raceHeatEndTypeId => $_getN(9);
  @$pb.TagNumber(10)
  set raceHeatEndTypeId($3.HeatEndTypeId value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasRaceHeatEndTypeId() => $_has(9);
  @$pb.TagNumber(10)
  void clearRaceHeatEndTypeId() => $_clearField(10);

  @$pb.TagNumber(11)
  $0.UInt32Value get raceHeatEndLapLaps => $_getN(10);
  @$pb.TagNumber(11)
  set raceHeatEndLapLaps($0.UInt32Value value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasRaceHeatEndLapLaps() => $_has(10);
  @$pb.TagNumber(11)
  void clearRaceHeatEndLapLaps() => $_clearField(11);
  @$pb.TagNumber(11)
  $0.UInt32Value ensureRaceHeatEndLapLaps() => $_ensure(10);

  @$pb.TagNumber(12)
  $2.Duration get raceHeatEndDurationDuration => $_getN(11);
  @$pb.TagNumber(12)
  set raceHeatEndDurationDuration($2.Duration value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasRaceHeatEndDurationDuration() => $_has(11);
  @$pb.TagNumber(12)
  void clearRaceHeatEndDurationDuration() => $_clearField(12);
  @$pb.TagNumber(12)
  $2.Duration ensureRaceHeatEndDurationDuration() => $_ensure(11);

  @$pb.TagNumber(13)
  RaceStateType get raceStateType => $_getN(12);
  @$pb.TagNumber(13)
  set raceStateType(RaceStateType value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasRaceStateType() => $_has(12);
  @$pb.TagNumber(13)
  void clearRaceStateType() => $_clearField(13);
  @$pb.TagNumber(13)
  RaceStateType ensureRaceStateType() => $_ensure(12);

  @$pb.TagNumber(14)
  $pb.PbList<$4.RaceFeatureTypeId> get raceFeatures => $_getList(13);

  @$pb.TagNumber(15)
  $pb.PbList<$3.Heat> get heats => $_getList(14);
}

class RaceLeaderboard extends $pb.GeneratedMessage {
  factory RaceLeaderboard({
    $core.Iterable<RaceLeaderboardEventUser>? eventUsers,
  }) {
    final result = create();
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
    ..pPM<RaceLeaderboardEventUser>(1, _omitFieldNames ? '' : 'eventUsers',
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
  $pb.PbList<RaceLeaderboardEventUser> get eventUsers => $_getList(0);
}

class RaceLeaderboardEventUser extends $pb.GeneratedMessage {
  factory RaceLeaderboardEventUser({
    $core.String? eventUserId,
    $core.int? position,
    $0.UInt32Value? laps,
    $0.UInt32Value? points,
    $core.Iterable<RaceLeaderboardHeatIndicator>? indicators,
    $core.Iterable<RaceIndicatorFlag>? flags,
  }) {
    final result = create();
    if (eventUserId != null) result.eventUserId = eventUserId;
    if (position != null) result.position = position;
    if (laps != null) result.laps = laps;
    if (points != null) result.points = points;
    if (indicators != null) result.indicators.addAll(indicators);
    if (flags != null) result.flags.addAll(flags);
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
    ..aOM<$0.UInt32Value>(3, _omitFieldNames ? '' : 'laps',
        subBuilder: $0.UInt32Value.create)
    ..aOM<$0.UInt32Value>(4, _omitFieldNames ? '' : 'points',
        subBuilder: $0.UInt32Value.create)
    ..pPM<RaceLeaderboardHeatIndicator>(5, _omitFieldNames ? '' : 'indicators',
        subBuilder: RaceLeaderboardHeatIndicator.create)
    ..pc<RaceIndicatorFlag>(
        6, _omitFieldNames ? '' : 'flags', $pb.PbFieldType.KE,
        valueOf: RaceIndicatorFlag.valueOf,
        enumValues: RaceIndicatorFlag.values,
        defaultEnumValue: RaceIndicatorFlag.RACE_INDICATOR_FLAG_RUNNING)
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

  @$pb.TagNumber(3)
  $0.UInt32Value get laps => $_getN(2);
  @$pb.TagNumber(3)
  set laps($0.UInt32Value value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasLaps() => $_has(2);
  @$pb.TagNumber(3)
  void clearLaps() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.UInt32Value ensureLaps() => $_ensure(2);

  @$pb.TagNumber(4)
  $0.UInt32Value get points => $_getN(3);
  @$pb.TagNumber(4)
  set points($0.UInt32Value value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasPoints() => $_has(3);
  @$pb.TagNumber(4)
  void clearPoints() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.UInt32Value ensurePoints() => $_ensure(3);

  /// google.protobuf.StringValue gap_leader = 5;
  /// google.protobuf.StringValue gap_interval = 6;
  @$pb.TagNumber(5)
  $pb.PbList<RaceLeaderboardHeatIndicator> get indicators => $_getList(4);

  @$pb.TagNumber(6)
  $pb.PbList<RaceIndicatorFlag> get flags => $_getList(5);
}

class RaceLeaderboardHeatIndicator extends $pb.GeneratedMessage {
  factory RaceLeaderboardHeatIndicator({
    $core.int? indicatorId,
    $0.UInt32Value? color,
  }) {
    final result = create();
    if (indicatorId != null) result.indicatorId = indicatorId;
    if (color != null) result.color = color;
    return result;
  }

  RaceLeaderboardHeatIndicator._();

  factory RaceLeaderboardHeatIndicator.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RaceLeaderboardHeatIndicator.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RaceLeaderboardHeatIndicator',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'indicatorId',
        fieldType: $pb.PbFieldType.OU3)
    ..aOM<$0.UInt32Value>(2, _omitFieldNames ? '' : 'color',
        subBuilder: $0.UInt32Value.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceLeaderboardHeatIndicator clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceLeaderboardHeatIndicator copyWith(
          void Function(RaceLeaderboardHeatIndicator) updates) =>
      super.copyWith(
              (message) => updates(message as RaceLeaderboardHeatIndicator))
          as RaceLeaderboardHeatIndicator;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RaceLeaderboardHeatIndicator create() =>
      RaceLeaderboardHeatIndicator._();
  @$core.override
  RaceLeaderboardHeatIndicator createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RaceLeaderboardHeatIndicator getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RaceLeaderboardHeatIndicator>(create);
  static RaceLeaderboardHeatIndicator? _defaultInstance;

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

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
