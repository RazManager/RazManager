// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/event.v1.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $0;
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart'
    as $1;

import 'event_user_type_id.v1.pbenum.dart' as $3;
import 'race.v1.pb.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Event extends $pb.GeneratedMessage {
  factory Event({
    $core.String? id,
    $core.String? name,
    $0.Timestamp? startsAt,
    $1.BytesValue? image,
    $core.Iterable<EventUser>? eventUsers,
    $core.Iterable<$2.Race>? races,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (startsAt != null) result.startsAt = startsAt;
    if (image != null) result.image = image;
    if (eventUsers != null) result.eventUsers.addAll(eventUsers);
    if (races != null) result.races.addAll(races);
    return result;
  }

  Event._();

  factory Event.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Event.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Event',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOM<$0.Timestamp>(3, _omitFieldNames ? '' : 'startsAt',
        subBuilder: $0.Timestamp.create)
    ..aOM<$1.BytesValue>(4, _omitFieldNames ? '' : 'image',
        subBuilder: $1.BytesValue.create)
    ..pPM<EventUser>(7, _omitFieldNames ? '' : 'eventUsers',
        subBuilder: EventUser.create)
    ..pPM<$2.Race>(8, _omitFieldNames ? '' : 'races',
        subBuilder: $2.Race.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Event clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Event copyWith(void Function(Event) updates) =>
      super.copyWith((message) => updates(message as Event)) as Event;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Event create() => Event._();
  @$core.override
  Event createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Event getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Event>(create);
  static Event? _defaultInstance;

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
  $0.Timestamp get startsAt => $_getN(2);
  @$pb.TagNumber(3)
  set startsAt($0.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasStartsAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearStartsAt() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.Timestamp ensureStartsAt() => $_ensure(2);

  @$pb.TagNumber(4)
  $1.BytesValue get image => $_getN(3);
  @$pb.TagNumber(4)
  set image($1.BytesValue value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasImage() => $_has(3);
  @$pb.TagNumber(4)
  void clearImage() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.BytesValue ensureImage() => $_ensure(3);

  @$pb.TagNumber(7)
  $pb.PbList<EventUser> get eventUsers => $_getList(4);

  @$pb.TagNumber(8)
  $pb.PbList<$2.Race> get races => $_getList(5);
}

class EventUser extends $pb.GeneratedMessage {
  factory EventUser({
    $core.String? id,
    $1.StringValue? name,
    $1.StringValue? shortName,
    $1.BytesValue? image,
    $3.EventUserTypeId? eventUserTypeId,
    $core.Iterable<TeamUser>? teamUsers,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (shortName != null) result.shortName = shortName;
    if (image != null) result.image = image;
    if (eventUserTypeId != null) result.eventUserTypeId = eventUserTypeId;
    if (teamUsers != null) result.teamUsers.addAll(teamUsers);
    return result;
  }

  EventUser._();

  factory EventUser.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventUser.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventUser',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<$1.StringValue>(2, _omitFieldNames ? '' : 'name',
        subBuilder: $1.StringValue.create)
    ..aOM<$1.StringValue>(3, _omitFieldNames ? '' : 'shortName',
        subBuilder: $1.StringValue.create)
    ..aOM<$1.BytesValue>(4, _omitFieldNames ? '' : 'image',
        subBuilder: $1.BytesValue.create)
    ..aE<$3.EventUserTypeId>(5, _omitFieldNames ? '' : 'eventUserTypeId',
        enumValues: $3.EventUserTypeId.values)
    ..pPM<TeamUser>(6, _omitFieldNames ? '' : 'teamUsers',
        subBuilder: TeamUser.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventUser clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventUser copyWith(void Function(EventUser) updates) =>
      super.copyWith((message) => updates(message as EventUser)) as EventUser;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventUser create() => EventUser._();
  @$core.override
  EventUser createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EventUser getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EventUser>(create);
  static EventUser? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.StringValue get name => $_getN(1);
  @$pb.TagNumber(2)
  set name($1.StringValue value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.StringValue ensureName() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.StringValue get shortName => $_getN(2);
  @$pb.TagNumber(3)
  set shortName($1.StringValue value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasShortName() => $_has(2);
  @$pb.TagNumber(3)
  void clearShortName() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.StringValue ensureShortName() => $_ensure(2);

  @$pb.TagNumber(4)
  $1.BytesValue get image => $_getN(3);
  @$pb.TagNumber(4)
  set image($1.BytesValue value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasImage() => $_has(3);
  @$pb.TagNumber(4)
  void clearImage() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.BytesValue ensureImage() => $_ensure(3);

  @$pb.TagNumber(5)
  $3.EventUserTypeId get eventUserTypeId => $_getN(4);
  @$pb.TagNumber(5)
  set eventUserTypeId($3.EventUserTypeId value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasEventUserTypeId() => $_has(4);
  @$pb.TagNumber(5)
  void clearEventUserTypeId() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<TeamUser> get teamUsers => $_getList(5);
}

class TeamUser extends $pb.GeneratedMessage {
  factory TeamUser({
    $core.String? id,
    $1.StringValue? name,
    $1.StringValue? shortName,
    $1.BytesValue? image,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (shortName != null) result.shortName = shortName;
    if (image != null) result.image = image;
    return result;
  }

  TeamUser._();

  factory TeamUser.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TeamUser.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TeamUser',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<$1.StringValue>(2, _omitFieldNames ? '' : 'name',
        subBuilder: $1.StringValue.create)
    ..aOM<$1.StringValue>(3, _omitFieldNames ? '' : 'shortName',
        subBuilder: $1.StringValue.create)
    ..aOM<$1.BytesValue>(4, _omitFieldNames ? '' : 'image',
        subBuilder: $1.BytesValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TeamUser clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TeamUser copyWith(void Function(TeamUser) updates) =>
      super.copyWith((message) => updates(message as TeamUser)) as TeamUser;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TeamUser create() => TeamUser._();
  @$core.override
  TeamUser createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TeamUser getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TeamUser>(create);
  static TeamUser? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.StringValue get name => $_getN(1);
  @$pb.TagNumber(2)
  set name($1.StringValue value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.StringValue ensureName() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.StringValue get shortName => $_getN(2);
  @$pb.TagNumber(3)
  set shortName($1.StringValue value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasShortName() => $_has(2);
  @$pb.TagNumber(3)
  void clearShortName() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.StringValue ensureShortName() => $_ensure(2);

  @$pb.TagNumber(4)
  $1.BytesValue get image => $_getN(3);
  @$pb.TagNumber(4)
  set image($1.BytesValue value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasImage() => $_has(3);
  @$pb.TagNumber(4)
  void clearImage() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.BytesValue ensureImage() => $_ensure(3);
}

class EventState extends $pb.GeneratedMessage {
  factory EventState({
    $core.String? id,
    $1.StringValue? raceId,
    $1.StringValue? heatId,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (raceId != null) result.raceId = raceId;
    if (heatId != null) result.heatId = heatId;
    return result;
  }

  EventState._();

  factory EventState.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventState.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventState',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<$1.StringValue>(2, _omitFieldNames ? '' : 'raceId',
        subBuilder: $1.StringValue.create)
    ..aOM<$1.StringValue>(3, _omitFieldNames ? '' : 'heatId',
        subBuilder: $1.StringValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventState clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventState copyWith(void Function(EventState) updates) =>
      super.copyWith((message) => updates(message as EventState)) as EventState;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventState create() => EventState._();
  @$core.override
  EventState createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EventState getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EventState>(create);
  static EventState? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.StringValue get raceId => $_getN(1);
  @$pb.TagNumber(2)
  set raceId($1.StringValue value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasRaceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRaceId() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.StringValue ensureRaceId() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.StringValue get heatId => $_getN(2);
  @$pb.TagNumber(3)
  set heatId($1.StringValue value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasHeatId() => $_has(2);
  @$pb.TagNumber(3)
  void clearHeatId() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.StringValue ensureHeatId() => $_ensure(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
