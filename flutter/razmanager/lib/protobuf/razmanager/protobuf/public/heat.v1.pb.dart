// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/heat.v1.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/duration.pb.dart'
    as $1;
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart'
    as $0;

import 'heat.v1.pbenum.dart';
import 'session_type_id.v1.pbenum.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'heat.v1.pbenum.dart';

class HeatCommandPermissions extends $pb.GeneratedMessage {
  factory HeatCommandPermissions({
    $core.Iterable<HeatCommandTypeId>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  HeatCommandPermissions._();

  factory HeatCommandPermissions.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HeatCommandPermissions.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HeatCommandPermissions',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..pc<HeatCommandTypeId>(
        1, _omitFieldNames ? '' : 'items', $pb.PbFieldType.KE,
        valueOf: HeatCommandTypeId.valueOf,
        enumValues: HeatCommandTypeId.values,
        defaultEnumValue: HeatCommandTypeId.HEAT_COMMAND_TYPE_ID_OPEN)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatCommandPermissions clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatCommandPermissions copyWith(
          void Function(HeatCommandPermissions) updates) =>
      super.copyWith((message) => updates(message as HeatCommandPermissions))
          as HeatCommandPermissions;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HeatCommandPermissions create() => HeatCommandPermissions._();
  @$core.override
  HeatCommandPermissions createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HeatCommandPermissions getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HeatCommandPermissions>(create);
  static HeatCommandPermissions? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<HeatCommandTypeId> get items => $_getList(0);
}

class SessionType extends $pb.GeneratedMessage {
  factory SessionType({
    $2.SessionTypeId? id,
    $core.String? name,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    return result;
  }

  SessionType._();

  factory SessionType.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SessionType.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SessionType',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aE<$2.SessionTypeId>(1, _omitFieldNames ? '' : 'id',
        enumValues: $2.SessionTypeId.values)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SessionType clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SessionType copyWith(void Function(SessionType) updates) =>
      super.copyWith((message) => updates(message as SessionType))
          as SessionType;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SessionType create() => SessionType._();
  @$core.override
  SessionType createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SessionType getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SessionType>(create);
  static SessionType? _defaultInstance;

  @$pb.TagNumber(1)
  $2.SessionTypeId get id => $_getN(0);
  @$pb.TagNumber(1)
  set id($2.SessionTypeId value) => $_setField(1, value);
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

class HeatStateType extends $pb.GeneratedMessage {
  factory HeatStateType({
    HeatStateTypeId? id,
    $core.String? name,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    return result;
  }

  HeatStateType._();

  factory HeatStateType.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HeatStateType.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HeatStateType',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aE<HeatStateTypeId>(1, _omitFieldNames ? '' : 'id',
        enumValues: HeatStateTypeId.values)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatStateType clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatStateType copyWith(void Function(HeatStateType) updates) =>
      super.copyWith((message) => updates(message as HeatStateType))
          as HeatStateType;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HeatStateType create() => HeatStateType._();
  @$core.override
  HeatStateType createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HeatStateType getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HeatStateType>(create);
  static HeatStateType? _defaultInstance;

  @$pb.TagNumber(1)
  HeatStateTypeId get id => $_getN(0);
  @$pb.TagNumber(1)
  set id(HeatStateTypeId value) => $_setField(1, value);
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

class Heat extends $pb.GeneratedMessage {
  factory Heat({
    $core.String? id,
    $core.int? number,
    $core.String? raceId,
    SessionType? sessionType,
    HeatStateType? heatStateType,
    $core.Iterable<HeatIndicator>? heatIndicators,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (number != null) result.number = number;
    if (raceId != null) result.raceId = raceId;
    if (sessionType != null) result.sessionType = sessionType;
    if (heatStateType != null) result.heatStateType = heatStateType;
    if (heatIndicators != null) result.heatIndicators.addAll(heatIndicators);
    return result;
  }

  Heat._();

  factory Heat.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Heat.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Heat',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aI(2, _omitFieldNames ? '' : 'number', fieldType: $pb.PbFieldType.OU3)
    ..aOS(3, _omitFieldNames ? '' : 'raceId')
    ..aOM<SessionType>(4, _omitFieldNames ? '' : 'sessionType',
        subBuilder: SessionType.create)
    ..aOM<HeatStateType>(5, _omitFieldNames ? '' : 'heatStateType',
        subBuilder: HeatStateType.create)
    ..pPM<HeatIndicator>(6, _omitFieldNames ? '' : 'heatIndicators',
        subBuilder: HeatIndicator.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Heat clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Heat copyWith(void Function(Heat) updates) =>
      super.copyWith((message) => updates(message as Heat)) as Heat;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Heat create() => Heat._();
  @$core.override
  Heat createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Heat getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Heat>(create);
  static Heat? _defaultInstance;

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
  $core.String get raceId => $_getSZ(2);
  @$pb.TagNumber(3)
  set raceId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRaceId() => $_has(2);
  @$pb.TagNumber(3)
  void clearRaceId() => $_clearField(3);

  @$pb.TagNumber(4)
  SessionType get sessionType => $_getN(3);
  @$pb.TagNumber(4)
  set sessionType(SessionType value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasSessionType() => $_has(3);
  @$pb.TagNumber(4)
  void clearSessionType() => $_clearField(4);
  @$pb.TagNumber(4)
  SessionType ensureSessionType() => $_ensure(3);

  @$pb.TagNumber(5)
  HeatStateType get heatStateType => $_getN(4);
  @$pb.TagNumber(5)
  set heatStateType(HeatStateType value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasHeatStateType() => $_has(4);
  @$pb.TagNumber(5)
  void clearHeatStateType() => $_clearField(5);
  @$pb.TagNumber(5)
  HeatStateType ensureHeatStateType() => $_ensure(4);

  @$pb.TagNumber(6)
  $pb.PbList<HeatIndicator> get heatIndicators => $_getList(5);
}

class HeatIndicator extends $pb.GeneratedMessage {
  factory HeatIndicator({
    $core.String? id,
    $core.int? indicatorId,
    $0.UInt32Value? color,
    $core.String? eventUserId,
    $0.UInt32Value? carClassColor,
    $0.BytesValue? carImage,
    $core.Iterable<HeatIndicatorStint>? heatIndicatorStints,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (indicatorId != null) result.indicatorId = indicatorId;
    if (color != null) result.color = color;
    if (eventUserId != null) result.eventUserId = eventUserId;
    if (carClassColor != null) result.carClassColor = carClassColor;
    if (carImage != null) result.carImage = carImage;
    if (heatIndicatorStints != null)
      result.heatIndicatorStints.addAll(heatIndicatorStints);
    return result;
  }

  HeatIndicator._();

  factory HeatIndicator.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HeatIndicator.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HeatIndicator',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aI(2, _omitFieldNames ? '' : 'indicatorId',
        fieldType: $pb.PbFieldType.OU3)
    ..aOM<$0.UInt32Value>(3, _omitFieldNames ? '' : 'color',
        subBuilder: $0.UInt32Value.create)
    ..aOS(4, _omitFieldNames ? '' : 'eventUserId')
    ..aOM<$0.UInt32Value>(5, _omitFieldNames ? '' : 'carClassColor',
        subBuilder: $0.UInt32Value.create)
    ..aOM<$0.BytesValue>(6, _omitFieldNames ? '' : 'carImage',
        subBuilder: $0.BytesValue.create)
    ..pPM<HeatIndicatorStint>(7, _omitFieldNames ? '' : 'heatIndicatorStints',
        subBuilder: HeatIndicatorStint.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatIndicator clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatIndicator copyWith(void Function(HeatIndicator) updates) =>
      super.copyWith((message) => updates(message as HeatIndicator))
          as HeatIndicator;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HeatIndicator create() => HeatIndicator._();
  @$core.override
  HeatIndicator createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HeatIndicator getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HeatIndicator>(create);
  static HeatIndicator? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get indicatorId => $_getIZ(1);
  @$pb.TagNumber(2)
  set indicatorId($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIndicatorId() => $_has(1);
  @$pb.TagNumber(2)
  void clearIndicatorId() => $_clearField(2);

  @$pb.TagNumber(3)
  $0.UInt32Value get color => $_getN(2);
  @$pb.TagNumber(3)
  set color($0.UInt32Value value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasColor() => $_has(2);
  @$pb.TagNumber(3)
  void clearColor() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.UInt32Value ensureColor() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get eventUserId => $_getSZ(3);
  @$pb.TagNumber(4)
  set eventUserId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasEventUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearEventUserId() => $_clearField(4);

  @$pb.TagNumber(5)
  $0.UInt32Value get carClassColor => $_getN(4);
  @$pb.TagNumber(5)
  set carClassColor($0.UInt32Value value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasCarClassColor() => $_has(4);
  @$pb.TagNumber(5)
  void clearCarClassColor() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.UInt32Value ensureCarClassColor() => $_ensure(4);

  @$pb.TagNumber(6)
  $0.BytesValue get carImage => $_getN(5);
  @$pb.TagNumber(6)
  set carImage($0.BytesValue value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasCarImage() => $_has(5);
  @$pb.TagNumber(6)
  void clearCarImage() => $_clearField(6);
  @$pb.TagNumber(6)
  $0.BytesValue ensureCarImage() => $_ensure(5);

  @$pb.TagNumber(7)
  $pb.PbList<HeatIndicatorStint> get heatIndicatorStints => $_getList(6);
}

class HeatIndicatorStint extends $pb.GeneratedMessage {
  factory HeatIndicatorStint({
    $core.String? id,
    $core.int? lap,
    $0.StringValue? eventUserId,
    $0.StringValue? comments,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (lap != null) result.lap = lap;
    if (eventUserId != null) result.eventUserId = eventUserId;
    if (comments != null) result.comments = comments;
    return result;
  }

  HeatIndicatorStint._();

  factory HeatIndicatorStint.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HeatIndicatorStint.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HeatIndicatorStint',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aI(3, _omitFieldNames ? '' : 'lap', fieldType: $pb.PbFieldType.OU3)
    ..aOM<$0.StringValue>(4, _omitFieldNames ? '' : 'eventUserId',
        subBuilder: $0.StringValue.create)
    ..aOM<$0.StringValue>(5, _omitFieldNames ? '' : 'comments',
        subBuilder: $0.StringValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatIndicatorStint clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatIndicatorStint copyWith(void Function(HeatIndicatorStint) updates) =>
      super.copyWith((message) => updates(message as HeatIndicatorStint))
          as HeatIndicatorStint;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HeatIndicatorStint create() => HeatIndicatorStint._();
  @$core.override
  HeatIndicatorStint createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HeatIndicatorStint getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HeatIndicatorStint>(create);
  static HeatIndicatorStint? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(3)
  $core.int get lap => $_getIZ(1);
  @$pb.TagNumber(3)
  set lap($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(3)
  $core.bool hasLap() => $_has(1);
  @$pb.TagNumber(3)
  void clearLap() => $_clearField(3);

  @$pb.TagNumber(4)
  $0.StringValue get eventUserId => $_getN(2);
  @$pb.TagNumber(4)
  set eventUserId($0.StringValue value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasEventUserId() => $_has(2);
  @$pb.TagNumber(4)
  void clearEventUserId() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.StringValue ensureEventUserId() => $_ensure(2);

  @$pb.TagNumber(5)
  $0.StringValue get comments => $_getN(3);
  @$pb.TagNumber(5)
  set comments($0.StringValue value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasComments() => $_has(3);
  @$pb.TagNumber(5)
  void clearComments() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.StringValue ensureComments() => $_ensure(3);
}

class HeatState extends $pb.GeneratedMessage {
  factory HeatState({
    HeatStateType? heatStateType,
    $0.UInt32Value? lapsCurrent,
    $core.bool? timerIsRunning,
    $1.Duration? timerElapsed,
    $core.int? startLightId,
  }) {
    final result = create();
    if (heatStateType != null) result.heatStateType = heatStateType;
    if (lapsCurrent != null) result.lapsCurrent = lapsCurrent;
    if (timerIsRunning != null) result.timerIsRunning = timerIsRunning;
    if (timerElapsed != null) result.timerElapsed = timerElapsed;
    if (startLightId != null) result.startLightId = startLightId;
    return result;
  }

  HeatState._();

  factory HeatState.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HeatState.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HeatState',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOM<HeatStateType>(1, _omitFieldNames ? '' : 'heatStateType',
        subBuilder: HeatStateType.create)
    ..aOM<$0.UInt32Value>(2, _omitFieldNames ? '' : 'lapsCurrent',
        subBuilder: $0.UInt32Value.create)
    ..aOB(3, _omitFieldNames ? '' : 'timerIsRunning')
    ..aOM<$1.Duration>(4, _omitFieldNames ? '' : 'timerElapsed',
        subBuilder: $1.Duration.create)
    ..aI(5, _omitFieldNames ? '' : 'startLightId',
        fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatState clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatState copyWith(void Function(HeatState) updates) =>
      super.copyWith((message) => updates(message as HeatState)) as HeatState;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HeatState create() => HeatState._();
  @$core.override
  HeatState createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HeatState getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HeatState>(create);
  static HeatState? _defaultInstance;

  @$pb.TagNumber(1)
  HeatStateType get heatStateType => $_getN(0);
  @$pb.TagNumber(1)
  set heatStateType(HeatStateType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasHeatStateType() => $_has(0);
  @$pb.TagNumber(1)
  void clearHeatStateType() => $_clearField(1);
  @$pb.TagNumber(1)
  HeatStateType ensureHeatStateType() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UInt32Value get lapsCurrent => $_getN(1);
  @$pb.TagNumber(2)
  set lapsCurrent($0.UInt32Value value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasLapsCurrent() => $_has(1);
  @$pb.TagNumber(2)
  void clearLapsCurrent() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.UInt32Value ensureLapsCurrent() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.bool get timerIsRunning => $_getBF(2);
  @$pb.TagNumber(3)
  set timerIsRunning($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTimerIsRunning() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimerIsRunning() => $_clearField(3);

  @$pb.TagNumber(4)
  $1.Duration get timerElapsed => $_getN(3);
  @$pb.TagNumber(4)
  set timerElapsed($1.Duration value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasTimerElapsed() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimerElapsed() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Duration ensureTimerElapsed() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.int get startLightId => $_getIZ(4);
  @$pb.TagNumber(5)
  set startLightId($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasStartLightId() => $_has(4);
  @$pb.TagNumber(5)
  void clearStartLightId() => $_clearField(5);
}

class HeatLeaderboard extends $pb.GeneratedMessage {
  factory HeatLeaderboard({
    $0.StringValue? correlationId,
    $core.Iterable<HeatLeaderboardIndicator>? indicators,
  }) {
    final result = create();
    if (correlationId != null) result.correlationId = correlationId;
    if (indicators != null) result.indicators.addAll(indicators);
    return result;
  }

  HeatLeaderboard._();

  factory HeatLeaderboard.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HeatLeaderboard.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HeatLeaderboard',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOM<$0.StringValue>(1, _omitFieldNames ? '' : 'correlationId',
        subBuilder: $0.StringValue.create)
    ..pPM<HeatLeaderboardIndicator>(2, _omitFieldNames ? '' : 'indicators',
        subBuilder: HeatLeaderboardIndicator.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatLeaderboard clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatLeaderboard copyWith(void Function(HeatLeaderboard) updates) =>
      super.copyWith((message) => updates(message as HeatLeaderboard))
          as HeatLeaderboard;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HeatLeaderboard create() => HeatLeaderboard._();
  @$core.override
  HeatLeaderboard createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HeatLeaderboard getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HeatLeaderboard>(create);
  static HeatLeaderboard? _defaultInstance;

  @$pb.TagNumber(1)
  $0.StringValue get correlationId => $_getN(0);
  @$pb.TagNumber(1)
  set correlationId($0.StringValue value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCorrelationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCorrelationId() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.StringValue ensureCorrelationId() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<HeatLeaderboardIndicator> get indicators => $_getList(1);
}

class HeatLeaderboardIndicator extends $pb.GeneratedMessage {
  factory HeatLeaderboardIndicator({
    $core.int? indicatorId,
    $core.int? position,
    $0.UInt32Value? laps,
    $core.Iterable<HeatIndicatorTimeTypeTime>? timeTypeTimes,
    $0.StringValue? gapLeader,
    $0.StringValue? gapInterval,
    $core.int? energyPercent,
    $0.UInt32Value? energyLapsLeft,
    $core.Iterable<HeatIndicatorFlag>? flags,
    $core.int? pitLanes,
    $core.int? carOffTracks,
    $0.StringValue? teamEventUserId,
  }) {
    final result = create();
    if (indicatorId != null) result.indicatorId = indicatorId;
    if (position != null) result.position = position;
    if (laps != null) result.laps = laps;
    if (timeTypeTimes != null) result.timeTypeTimes.addAll(timeTypeTimes);
    if (gapLeader != null) result.gapLeader = gapLeader;
    if (gapInterval != null) result.gapInterval = gapInterval;
    if (energyPercent != null) result.energyPercent = energyPercent;
    if (energyLapsLeft != null) result.energyLapsLeft = energyLapsLeft;
    if (flags != null) result.flags.addAll(flags);
    if (pitLanes != null) result.pitLanes = pitLanes;
    if (carOffTracks != null) result.carOffTracks = carOffTracks;
    if (teamEventUserId != null) result.teamEventUserId = teamEventUserId;
    return result;
  }

  HeatLeaderboardIndicator._();

  factory HeatLeaderboardIndicator.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HeatLeaderboardIndicator.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HeatLeaderboardIndicator',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'indicatorId',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'position', fieldType: $pb.PbFieldType.OU3)
    ..aOM<$0.UInt32Value>(3, _omitFieldNames ? '' : 'laps',
        subBuilder: $0.UInt32Value.create)
    ..pPM<HeatIndicatorTimeTypeTime>(4, _omitFieldNames ? '' : 'timeTypeTimes',
        subBuilder: HeatIndicatorTimeTypeTime.create)
    ..aOM<$0.StringValue>(5, _omitFieldNames ? '' : 'gapLeader',
        subBuilder: $0.StringValue.create)
    ..aOM<$0.StringValue>(6, _omitFieldNames ? '' : 'gapInterval',
        subBuilder: $0.StringValue.create)
    ..aI(7, _omitFieldNames ? '' : 'energyPercent',
        fieldType: $pb.PbFieldType.OU3)
    ..aOM<$0.UInt32Value>(8, _omitFieldNames ? '' : 'energyLapsLeft',
        subBuilder: $0.UInt32Value.create)
    ..pc<HeatIndicatorFlag>(
        9, _omitFieldNames ? '' : 'flags', $pb.PbFieldType.KE,
        valueOf: HeatIndicatorFlag.valueOf,
        enumValues: HeatIndicatorFlag.values,
        defaultEnumValue: HeatIndicatorFlag.HEAT_INDICATOR_FLAG_FINISHED)
    ..aI(10, _omitFieldNames ? '' : 'pitLanes', fieldType: $pb.PbFieldType.OU3)
    ..aI(11, _omitFieldNames ? '' : 'carOffTracks',
        fieldType: $pb.PbFieldType.OU3)
    ..aOM<$0.StringValue>(12, _omitFieldNames ? '' : 'teamEventUserId',
        subBuilder: $0.StringValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatLeaderboardIndicator clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatLeaderboardIndicator copyWith(
          void Function(HeatLeaderboardIndicator) updates) =>
      super.copyWith((message) => updates(message as HeatLeaderboardIndicator))
          as HeatLeaderboardIndicator;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HeatLeaderboardIndicator create() => HeatLeaderboardIndicator._();
  @$core.override
  HeatLeaderboardIndicator createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HeatLeaderboardIndicator getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HeatLeaderboardIndicator>(create);
  static HeatLeaderboardIndicator? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get indicatorId => $_getIZ(0);
  @$pb.TagNumber(1)
  set indicatorId($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIndicatorId() => $_has(0);
  @$pb.TagNumber(1)
  void clearIndicatorId() => $_clearField(1);

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
  $pb.PbList<HeatIndicatorTimeTypeTime> get timeTypeTimes => $_getList(3);

  @$pb.TagNumber(5)
  $0.StringValue get gapLeader => $_getN(4);
  @$pb.TagNumber(5)
  set gapLeader($0.StringValue value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasGapLeader() => $_has(4);
  @$pb.TagNumber(5)
  void clearGapLeader() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.StringValue ensureGapLeader() => $_ensure(4);

  @$pb.TagNumber(6)
  $0.StringValue get gapInterval => $_getN(5);
  @$pb.TagNumber(6)
  set gapInterval($0.StringValue value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasGapInterval() => $_has(5);
  @$pb.TagNumber(6)
  void clearGapInterval() => $_clearField(6);
  @$pb.TagNumber(6)
  $0.StringValue ensureGapInterval() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.int get energyPercent => $_getIZ(6);
  @$pb.TagNumber(7)
  set energyPercent($core.int value) => $_setUnsignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasEnergyPercent() => $_has(6);
  @$pb.TagNumber(7)
  void clearEnergyPercent() => $_clearField(7);

  @$pb.TagNumber(8)
  $0.UInt32Value get energyLapsLeft => $_getN(7);
  @$pb.TagNumber(8)
  set energyLapsLeft($0.UInt32Value value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasEnergyLapsLeft() => $_has(7);
  @$pb.TagNumber(8)
  void clearEnergyLapsLeft() => $_clearField(8);
  @$pb.TagNumber(8)
  $0.UInt32Value ensureEnergyLapsLeft() => $_ensure(7);

  @$pb.TagNumber(9)
  $pb.PbList<HeatIndicatorFlag> get flags => $_getList(8);

  @$pb.TagNumber(10)
  $core.int get pitLanes => $_getIZ(9);
  @$pb.TagNumber(10)
  set pitLanes($core.int value) => $_setUnsignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasPitLanes() => $_has(9);
  @$pb.TagNumber(10)
  void clearPitLanes() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get carOffTracks => $_getIZ(10);
  @$pb.TagNumber(11)
  set carOffTracks($core.int value) => $_setUnsignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCarOffTracks() => $_has(10);
  @$pb.TagNumber(11)
  void clearCarOffTracks() => $_clearField(11);

  @$pb.TagNumber(12)
  $0.StringValue get teamEventUserId => $_getN(11);
  @$pb.TagNumber(12)
  set teamEventUserId($0.StringValue value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasTeamEventUserId() => $_has(11);
  @$pb.TagNumber(12)
  void clearTeamEventUserId() => $_clearField(12);
  @$pb.TagNumber(12)
  $0.StringValue ensureTeamEventUserId() => $_ensure(11);
}

class HeatIndicatorTimeTypeTime extends $pb.GeneratedMessage {
  factory HeatIndicatorTimeTypeTime({
    HeatIndicatorTimeTypeId? timeTypeId,
    $0.DoubleValue? time,
    HeatIndicatorFastestTimeTypeId? fastestTimeTypeId,
    $0.DoubleValue? fastestTime,
  }) {
    final result = create();
    if (timeTypeId != null) result.timeTypeId = timeTypeId;
    if (time != null) result.time = time;
    if (fastestTimeTypeId != null) result.fastestTimeTypeId = fastestTimeTypeId;
    if (fastestTime != null) result.fastestTime = fastestTime;
    return result;
  }

  HeatIndicatorTimeTypeTime._();

  factory HeatIndicatorTimeTypeTime.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HeatIndicatorTimeTypeTime.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HeatIndicatorTimeTypeTime',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aE<HeatIndicatorTimeTypeId>(1, _omitFieldNames ? '' : 'timeTypeId',
        enumValues: HeatIndicatorTimeTypeId.values)
    ..aOM<$0.DoubleValue>(2, _omitFieldNames ? '' : 'time',
        subBuilder: $0.DoubleValue.create)
    ..aE<HeatIndicatorFastestTimeTypeId>(
        3, _omitFieldNames ? '' : 'fastestTimeTypeId',
        enumValues: HeatIndicatorFastestTimeTypeId.values)
    ..aOM<$0.DoubleValue>(4, _omitFieldNames ? '' : 'fastestTime',
        subBuilder: $0.DoubleValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatIndicatorTimeTypeTime clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatIndicatorTimeTypeTime copyWith(
          void Function(HeatIndicatorTimeTypeTime) updates) =>
      super.copyWith((message) => updates(message as HeatIndicatorTimeTypeTime))
          as HeatIndicatorTimeTypeTime;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HeatIndicatorTimeTypeTime create() => HeatIndicatorTimeTypeTime._();
  @$core.override
  HeatIndicatorTimeTypeTime createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HeatIndicatorTimeTypeTime getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HeatIndicatorTimeTypeTime>(create);
  static HeatIndicatorTimeTypeTime? _defaultInstance;

  @$pb.TagNumber(1)
  HeatIndicatorTimeTypeId get timeTypeId => $_getN(0);
  @$pb.TagNumber(1)
  set timeTypeId(HeatIndicatorTimeTypeId value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTimeTypeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimeTypeId() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.DoubleValue get time => $_getN(1);
  @$pb.TagNumber(2)
  set time($0.DoubleValue value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearTime() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.DoubleValue ensureTime() => $_ensure(1);

  @$pb.TagNumber(3)
  HeatIndicatorFastestTimeTypeId get fastestTimeTypeId => $_getN(2);
  @$pb.TagNumber(3)
  set fastestTimeTypeId(HeatIndicatorFastestTimeTypeId value) =>
      $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasFastestTimeTypeId() => $_has(2);
  @$pb.TagNumber(3)
  void clearFastestTimeTypeId() => $_clearField(3);

  @$pb.TagNumber(4)
  $0.DoubleValue get fastestTime => $_getN(3);
  @$pb.TagNumber(4)
  set fastestTime($0.DoubleValue value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasFastestTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearFastestTime() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.DoubleValue ensureFastestTime() => $_ensure(3);
}

class HeatAnalyses extends $pb.GeneratedMessage {
  factory HeatAnalyses({
    $core.Iterable<HeatAnalysis>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  HeatAnalyses._();

  factory HeatAnalyses.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HeatAnalyses.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HeatAnalyses',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..pPM<HeatAnalysis>(1, _omitFieldNames ? '' : 'items',
        subBuilder: HeatAnalysis.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatAnalyses clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatAnalyses copyWith(void Function(HeatAnalyses) updates) =>
      super.copyWith((message) => updates(message as HeatAnalyses))
          as HeatAnalyses;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HeatAnalyses create() => HeatAnalyses._();
  @$core.override
  HeatAnalyses createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HeatAnalyses getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HeatAnalyses>(create);
  static HeatAnalyses? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<HeatAnalysis> get items => $_getList(0);
}

enum HeatAnalysis_Value { heatStateTypeId, lap, gap, notSet }

class HeatAnalysis extends $pb.GeneratedMessage {
  factory HeatAnalysis({
    $1.Duration? timerElapsed,
    $0.UInt32Value? indicatorId,
    HeatStateTypeId? heatStateTypeId,
    HeatAnalysisLap? lap,
    HeatAnalysisGap? gap,
  }) {
    final result = create();
    if (timerElapsed != null) result.timerElapsed = timerElapsed;
    if (indicatorId != null) result.indicatorId = indicatorId;
    if (heatStateTypeId != null) result.heatStateTypeId = heatStateTypeId;
    if (lap != null) result.lap = lap;
    if (gap != null) result.gap = gap;
    return result;
  }

  HeatAnalysis._();

  factory HeatAnalysis.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HeatAnalysis.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, HeatAnalysis_Value>
      _HeatAnalysis_ValueByTag = {
    3: HeatAnalysis_Value.heatStateTypeId,
    4: HeatAnalysis_Value.lap,
    5: HeatAnalysis_Value.gap,
    0: HeatAnalysis_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HeatAnalysis',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..oo(0, [3, 4, 5])
    ..aOM<$1.Duration>(1, _omitFieldNames ? '' : 'timerElapsed',
        subBuilder: $1.Duration.create)
    ..aOM<$0.UInt32Value>(2, _omitFieldNames ? '' : 'indicatorId',
        subBuilder: $0.UInt32Value.create)
    ..aE<HeatStateTypeId>(3, _omitFieldNames ? '' : 'heatStateTypeId',
        enumValues: HeatStateTypeId.values)
    ..aOM<HeatAnalysisLap>(4, _omitFieldNames ? '' : 'lap',
        subBuilder: HeatAnalysisLap.create)
    ..aOM<HeatAnalysisGap>(5, _omitFieldNames ? '' : 'gap',
        subBuilder: HeatAnalysisGap.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatAnalysis clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatAnalysis copyWith(void Function(HeatAnalysis) updates) =>
      super.copyWith((message) => updates(message as HeatAnalysis))
          as HeatAnalysis;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HeatAnalysis create() => HeatAnalysis._();
  @$core.override
  HeatAnalysis createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HeatAnalysis getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HeatAnalysis>(create);
  static HeatAnalysis? _defaultInstance;

  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  HeatAnalysis_Value whichValue() => _HeatAnalysis_ValueByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  void clearValue() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $1.Duration get timerElapsed => $_getN(0);
  @$pb.TagNumber(1)
  set timerElapsed($1.Duration value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTimerElapsed() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimerElapsed() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Duration ensureTimerElapsed() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.UInt32Value get indicatorId => $_getN(1);
  @$pb.TagNumber(2)
  set indicatorId($0.UInt32Value value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasIndicatorId() => $_has(1);
  @$pb.TagNumber(2)
  void clearIndicatorId() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.UInt32Value ensureIndicatorId() => $_ensure(1);

  @$pb.TagNumber(3)
  HeatStateTypeId get heatStateTypeId => $_getN(2);
  @$pb.TagNumber(3)
  set heatStateTypeId(HeatStateTypeId value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasHeatStateTypeId() => $_has(2);
  @$pb.TagNumber(3)
  void clearHeatStateTypeId() => $_clearField(3);

  @$pb.TagNumber(4)
  HeatAnalysisLap get lap => $_getN(3);
  @$pb.TagNumber(4)
  set lap(HeatAnalysisLap value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasLap() => $_has(3);
  @$pb.TagNumber(4)
  void clearLap() => $_clearField(4);
  @$pb.TagNumber(4)
  HeatAnalysisLap ensureLap() => $_ensure(3);

  @$pb.TagNumber(5)
  HeatAnalysisGap get gap => $_getN(4);
  @$pb.TagNumber(5)
  set gap(HeatAnalysisGap value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasGap() => $_has(4);
  @$pb.TagNumber(5)
  void clearGap() => $_clearField(5);
  @$pb.TagNumber(5)
  HeatAnalysisGap ensureGap() => $_ensure(4);
}

class HeatAnalysisLap extends $pb.GeneratedMessage {
  factory HeatAnalysisLap({
    $core.int? position,
    $core.int? lap,
    $0.DoubleValue? time,
    $core.int? pitlanes,
    $core.int? carOffTracks,
  }) {
    final result = create();
    if (position != null) result.position = position;
    if (lap != null) result.lap = lap;
    if (time != null) result.time = time;
    if (pitlanes != null) result.pitlanes = pitlanes;
    if (carOffTracks != null) result.carOffTracks = carOffTracks;
    return result;
  }

  HeatAnalysisLap._();

  factory HeatAnalysisLap.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HeatAnalysisLap.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HeatAnalysisLap',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'position', fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'lap', fieldType: $pb.PbFieldType.OU3)
    ..aOM<$0.DoubleValue>(3, _omitFieldNames ? '' : 'time',
        subBuilder: $0.DoubleValue.create)
    ..aI(4, _omitFieldNames ? '' : 'pitlanes', fieldType: $pb.PbFieldType.OU3)
    ..aI(5, _omitFieldNames ? '' : 'carOffTracks',
        fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatAnalysisLap clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatAnalysisLap copyWith(void Function(HeatAnalysisLap) updates) =>
      super.copyWith((message) => updates(message as HeatAnalysisLap))
          as HeatAnalysisLap;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HeatAnalysisLap create() => HeatAnalysisLap._();
  @$core.override
  HeatAnalysisLap createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HeatAnalysisLap getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HeatAnalysisLap>(create);
  static HeatAnalysisLap? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get position => $_getIZ(0);
  @$pb.TagNumber(1)
  set position($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPosition() => $_has(0);
  @$pb.TagNumber(1)
  void clearPosition() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get lap => $_getIZ(1);
  @$pb.TagNumber(2)
  set lap($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLap() => $_has(1);
  @$pb.TagNumber(2)
  void clearLap() => $_clearField(2);

  @$pb.TagNumber(3)
  $0.DoubleValue get time => $_getN(2);
  @$pb.TagNumber(3)
  set time($0.DoubleValue value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearTime() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.DoubleValue ensureTime() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.int get pitlanes => $_getIZ(3);
  @$pb.TagNumber(4)
  set pitlanes($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPitlanes() => $_has(3);
  @$pb.TagNumber(4)
  void clearPitlanes() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get carOffTracks => $_getIZ(4);
  @$pb.TagNumber(5)
  set carOffTracks($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCarOffTracks() => $_has(4);
  @$pb.TagNumber(5)
  void clearCarOffTracks() => $_clearField(5);
}

class HeatAnalysisGap extends $pb.GeneratedMessage {
  factory HeatAnalysisGap({
    $core.int? indicatorId,
    $core.double? value,
    $core.String? displayValue,
    $0.DoubleValue? deltaValue,
    $0.DoubleValue? deltaFraction,
    $core.Iterable<HeatIndicatorFlag>? flags,
  }) {
    final result = create();
    if (indicatorId != null) result.indicatorId = indicatorId;
    if (value != null) result.value = value;
    if (displayValue != null) result.displayValue = displayValue;
    if (deltaValue != null) result.deltaValue = deltaValue;
    if (deltaFraction != null) result.deltaFraction = deltaFraction;
    if (flags != null) result.flags.addAll(flags);
    return result;
  }

  HeatAnalysisGap._();

  factory HeatAnalysisGap.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HeatAnalysisGap.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HeatAnalysisGap',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'indicatorId',
        fieldType: $pb.PbFieldType.OU3)
    ..aD(2, _omitFieldNames ? '' : 'value')
    ..aOS(3, _omitFieldNames ? '' : 'displayValue')
    ..aOM<$0.DoubleValue>(4, _omitFieldNames ? '' : 'deltaValue',
        subBuilder: $0.DoubleValue.create)
    ..aOM<$0.DoubleValue>(5, _omitFieldNames ? '' : 'deltaFraction',
        subBuilder: $0.DoubleValue.create)
    ..pc<HeatIndicatorFlag>(
        6, _omitFieldNames ? '' : 'flags', $pb.PbFieldType.KE,
        valueOf: HeatIndicatorFlag.valueOf,
        enumValues: HeatIndicatorFlag.values,
        defaultEnumValue: HeatIndicatorFlag.HEAT_INDICATOR_FLAG_FINISHED)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatAnalysisGap clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatAnalysisGap copyWith(void Function(HeatAnalysisGap) updates) =>
      super.copyWith((message) => updates(message as HeatAnalysisGap))
          as HeatAnalysisGap;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HeatAnalysisGap create() => HeatAnalysisGap._();
  @$core.override
  HeatAnalysisGap createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HeatAnalysisGap getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HeatAnalysisGap>(create);
  static HeatAnalysisGap? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get indicatorId => $_getIZ(0);
  @$pb.TagNumber(1)
  set indicatorId($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIndicatorId() => $_has(0);
  @$pb.TagNumber(1)
  void clearIndicatorId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get displayValue => $_getSZ(2);
  @$pb.TagNumber(3)
  set displayValue($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDisplayValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisplayValue() => $_clearField(3);

  @$pb.TagNumber(4)
  $0.DoubleValue get deltaValue => $_getN(3);
  @$pb.TagNumber(4)
  set deltaValue($0.DoubleValue value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasDeltaValue() => $_has(3);
  @$pb.TagNumber(4)
  void clearDeltaValue() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.DoubleValue ensureDeltaValue() => $_ensure(3);

  @$pb.TagNumber(5)
  $0.DoubleValue get deltaFraction => $_getN(4);
  @$pb.TagNumber(5)
  set deltaFraction($0.DoubleValue value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasDeltaFraction() => $_has(4);
  @$pb.TagNumber(5)
  void clearDeltaFraction() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.DoubleValue ensureDeltaFraction() => $_ensure(4);

  @$pb.TagNumber(6)
  $pb.PbList<HeatIndicatorFlag> get flags => $_getList(5);
}

class HeatStintAnalysis extends $pb.GeneratedMessage {
  factory HeatStintAnalysis({
    $core.bool? refresh,
    HeatStintAnalysisIndicatorStints? heatStintAnalysisIndicatorStints,
  }) {
    final result = create();
    if (refresh != null) result.refresh = refresh;
    if (heatStintAnalysisIndicatorStints != null)
      result.heatStintAnalysisIndicatorStints =
          heatStintAnalysisIndicatorStints;
    return result;
  }

  HeatStintAnalysis._();

  factory HeatStintAnalysis.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HeatStintAnalysis.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HeatStintAnalysis',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'refresh')
    ..aOM<HeatStintAnalysisIndicatorStints>(
        2, _omitFieldNames ? '' : 'heatStintAnalysisIndicatorStints',
        subBuilder: HeatStintAnalysisIndicatorStints.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatStintAnalysis clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatStintAnalysis copyWith(void Function(HeatStintAnalysis) updates) =>
      super.copyWith((message) => updates(message as HeatStintAnalysis))
          as HeatStintAnalysis;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HeatStintAnalysis create() => HeatStintAnalysis._();
  @$core.override
  HeatStintAnalysis createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HeatStintAnalysis getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HeatStintAnalysis>(create);
  static HeatStintAnalysis? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get refresh => $_getBF(0);
  @$pb.TagNumber(1)
  set refresh($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefresh() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefresh() => $_clearField(1);

  @$pb.TagNumber(2)
  HeatStintAnalysisIndicatorStints get heatStintAnalysisIndicatorStints =>
      $_getN(1);
  @$pb.TagNumber(2)
  set heatStintAnalysisIndicatorStints(
          HeatStintAnalysisIndicatorStints value) =>
      $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasHeatStintAnalysisIndicatorStints() => $_has(1);
  @$pb.TagNumber(2)
  void clearHeatStintAnalysisIndicatorStints() => $_clearField(2);
  @$pb.TagNumber(2)
  HeatStintAnalysisIndicatorStints ensureHeatStintAnalysisIndicatorStints() =>
      $_ensure(1);
}

class HeatStintAnalysisIndicatorStints extends $pb.GeneratedMessage {
  factory HeatStintAnalysisIndicatorStints({
    $core.Iterable<HeatStintAnalysisIndicatorStint>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  HeatStintAnalysisIndicatorStints._();

  factory HeatStintAnalysisIndicatorStints.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HeatStintAnalysisIndicatorStints.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HeatStintAnalysisIndicatorStints',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..pPM<HeatStintAnalysisIndicatorStint>(1, _omitFieldNames ? '' : 'items',
        subBuilder: HeatStintAnalysisIndicatorStint.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatStintAnalysisIndicatorStints clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatStintAnalysisIndicatorStints copyWith(
          void Function(HeatStintAnalysisIndicatorStints) updates) =>
      super.copyWith(
              (message) => updates(message as HeatStintAnalysisIndicatorStints))
          as HeatStintAnalysisIndicatorStints;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HeatStintAnalysisIndicatorStints create() =>
      HeatStintAnalysisIndicatorStints._();
  @$core.override
  HeatStintAnalysisIndicatorStints createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HeatStintAnalysisIndicatorStints getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HeatStintAnalysisIndicatorStints>(
          create);
  static HeatStintAnalysisIndicatorStints? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<HeatStintAnalysisIndicatorStint> get items => $_getList(0);
}

class HeatStintAnalysisIndicatorStint extends $pb.GeneratedMessage {
  factory HeatStintAnalysisIndicatorStint({
    $core.String? id,
    $core.int? indicatorId,
    $core.int? lap,
    $0.StringValue? eventUserId,
    $0.StringValue? comments,
    $core.Iterable<HeatStintAnalysisIndicatorStintLap>? laps,
    $1.Duration? duration,
    $0.DoubleValue? averageTime,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (indicatorId != null) result.indicatorId = indicatorId;
    if (lap != null) result.lap = lap;
    if (eventUserId != null) result.eventUserId = eventUserId;
    if (comments != null) result.comments = comments;
    if (laps != null) result.laps.addAll(laps);
    if (duration != null) result.duration = duration;
    if (averageTime != null) result.averageTime = averageTime;
    return result;
  }

  HeatStintAnalysisIndicatorStint._();

  factory HeatStintAnalysisIndicatorStint.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HeatStintAnalysisIndicatorStint.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HeatStintAnalysisIndicatorStint',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aI(2, _omitFieldNames ? '' : 'indicatorId',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'lap', fieldType: $pb.PbFieldType.OU3)
    ..aOM<$0.StringValue>(4, _omitFieldNames ? '' : 'eventUserId',
        subBuilder: $0.StringValue.create)
    ..aOM<$0.StringValue>(5, _omitFieldNames ? '' : 'comments',
        subBuilder: $0.StringValue.create)
    ..pPM<HeatStintAnalysisIndicatorStintLap>(10, _omitFieldNames ? '' : 'laps',
        subBuilder: HeatStintAnalysisIndicatorStintLap.create)
    ..aOM<$1.Duration>(11, _omitFieldNames ? '' : 'duration',
        subBuilder: $1.Duration.create)
    ..aOM<$0.DoubleValue>(12, _omitFieldNames ? '' : 'averageTime',
        subBuilder: $0.DoubleValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatStintAnalysisIndicatorStint clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatStintAnalysisIndicatorStint copyWith(
          void Function(HeatStintAnalysisIndicatorStint) updates) =>
      super.copyWith(
              (message) => updates(message as HeatStintAnalysisIndicatorStint))
          as HeatStintAnalysisIndicatorStint;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HeatStintAnalysisIndicatorStint create() =>
      HeatStintAnalysisIndicatorStint._();
  @$core.override
  HeatStintAnalysisIndicatorStint createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HeatStintAnalysisIndicatorStint getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HeatStintAnalysisIndicatorStint>(
          create);
  static HeatStintAnalysisIndicatorStint? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get indicatorId => $_getIZ(1);
  @$pb.TagNumber(2)
  set indicatorId($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIndicatorId() => $_has(1);
  @$pb.TagNumber(2)
  void clearIndicatorId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get lap => $_getIZ(2);
  @$pb.TagNumber(3)
  set lap($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLap() => $_has(2);
  @$pb.TagNumber(3)
  void clearLap() => $_clearField(3);

  @$pb.TagNumber(4)
  $0.StringValue get eventUserId => $_getN(3);
  @$pb.TagNumber(4)
  set eventUserId($0.StringValue value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasEventUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearEventUserId() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.StringValue ensureEventUserId() => $_ensure(3);

  @$pb.TagNumber(5)
  $0.StringValue get comments => $_getN(4);
  @$pb.TagNumber(5)
  set comments($0.StringValue value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasComments() => $_has(4);
  @$pb.TagNumber(5)
  void clearComments() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.StringValue ensureComments() => $_ensure(4);

  @$pb.TagNumber(10)
  $pb.PbList<HeatStintAnalysisIndicatorStintLap> get laps => $_getList(5);

  @$pb.TagNumber(11)
  $1.Duration get duration => $_getN(6);
  @$pb.TagNumber(11)
  set duration($1.Duration value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasDuration() => $_has(6);
  @$pb.TagNumber(11)
  void clearDuration() => $_clearField(11);
  @$pb.TagNumber(11)
  $1.Duration ensureDuration() => $_ensure(6);

  @$pb.TagNumber(12)
  $0.DoubleValue get averageTime => $_getN(7);
  @$pb.TagNumber(12)
  set averageTime($0.DoubleValue value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasAverageTime() => $_has(7);
  @$pb.TagNumber(12)
  void clearAverageTime() => $_clearField(12);
  @$pb.TagNumber(12)
  $0.DoubleValue ensureAverageTime() => $_ensure(7);
}

class HeatStintAnalysisIndicatorStintLap extends $pb.GeneratedMessage {
  factory HeatStintAnalysisIndicatorStintLap({
    $core.int? indicatorId,
    $core.int? lap,
    $1.Duration? timerElapsed,
    $0.DoubleValue? time,
    $core.int? pitlanes,
    $core.int? carOffTracks,
  }) {
    final result = create();
    if (indicatorId != null) result.indicatorId = indicatorId;
    if (lap != null) result.lap = lap;
    if (timerElapsed != null) result.timerElapsed = timerElapsed;
    if (time != null) result.time = time;
    if (pitlanes != null) result.pitlanes = pitlanes;
    if (carOffTracks != null) result.carOffTracks = carOffTracks;
    return result;
  }

  HeatStintAnalysisIndicatorStintLap._();

  factory HeatStintAnalysisIndicatorStintLap.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HeatStintAnalysisIndicatorStintLap.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HeatStintAnalysisIndicatorStintLap',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'indicatorId',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'lap', fieldType: $pb.PbFieldType.OU3)
    ..aOM<$1.Duration>(3, _omitFieldNames ? '' : 'timerElapsed',
        subBuilder: $1.Duration.create)
    ..aOM<$0.DoubleValue>(4, _omitFieldNames ? '' : 'time',
        subBuilder: $0.DoubleValue.create)
    ..aI(5, _omitFieldNames ? '' : 'pitlanes', fieldType: $pb.PbFieldType.OU3)
    ..aI(6, _omitFieldNames ? '' : 'carOffTracks',
        fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatStintAnalysisIndicatorStintLap clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatStintAnalysisIndicatorStintLap copyWith(
          void Function(HeatStintAnalysisIndicatorStintLap) updates) =>
      super.copyWith((message) =>
              updates(message as HeatStintAnalysisIndicatorStintLap))
          as HeatStintAnalysisIndicatorStintLap;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HeatStintAnalysisIndicatorStintLap create() =>
      HeatStintAnalysisIndicatorStintLap._();
  @$core.override
  HeatStintAnalysisIndicatorStintLap createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HeatStintAnalysisIndicatorStintLap getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HeatStintAnalysisIndicatorStintLap>(
          create);
  static HeatStintAnalysisIndicatorStintLap? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get indicatorId => $_getIZ(0);
  @$pb.TagNumber(1)
  set indicatorId($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIndicatorId() => $_has(0);
  @$pb.TagNumber(1)
  void clearIndicatorId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get lap => $_getIZ(1);
  @$pb.TagNumber(2)
  set lap($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLap() => $_has(1);
  @$pb.TagNumber(2)
  void clearLap() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.Duration get timerElapsed => $_getN(2);
  @$pb.TagNumber(3)
  set timerElapsed($1.Duration value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTimerElapsed() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimerElapsed() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Duration ensureTimerElapsed() => $_ensure(2);

  @$pb.TagNumber(4)
  $0.DoubleValue get time => $_getN(3);
  @$pb.TagNumber(4)
  set time($0.DoubleValue value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearTime() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.DoubleValue ensureTime() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.int get pitlanes => $_getIZ(4);
  @$pb.TagNumber(5)
  set pitlanes($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPitlanes() => $_has(4);
  @$pb.TagNumber(5)
  void clearPitlanes() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get carOffTracks => $_getIZ(5);
  @$pb.TagNumber(6)
  set carOffTracks($core.int value) => $_setUnsignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCarOffTracks() => $_has(5);
  @$pb.TagNumber(6)
  void clearCarOffTracks() => $_clearField(6);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
