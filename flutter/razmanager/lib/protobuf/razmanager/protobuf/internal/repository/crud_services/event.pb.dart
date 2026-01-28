// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/event.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $4;
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart'
    as $3;

import '../../../public/event_user_type_id.v1.pbenum.dart' as $5;
import 'event.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'event.pbenum.dart';

class EventReadResponse extends $pb.GeneratedMessage {
  factory EventReadResponse({
    EventRead? entity,
    $core.String? etag,
  }) {
    final result = create();
    if (entity != null) result.entity = entity;
    if (etag != null) result.etag = etag;
    return result;
  }

  EventReadResponse._();

  factory EventReadResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventReadResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventReadResponse',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.event'),
      createEmptyInstance: create)
    ..aOM<EventRead>(1, _omitFieldNames ? '' : 'entity',
        subBuilder: EventRead.create)
    ..aOS(2, _omitFieldNames ? '' : 'etag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventReadResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventReadResponse copyWith(void Function(EventReadResponse) updates) =>
      super.copyWith((message) => updates(message as EventReadResponse))
          as EventReadResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventReadResponse create() => EventReadResponse._();
  @$core.override
  EventReadResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EventReadResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EventReadResponse>(create);
  static EventReadResponse? _defaultInstance;

  @$pb.TagNumber(1)
  EventRead get entity => $_getN(0);
  @$pb.TagNumber(1)
  set entity(EventRead value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasEntity() => $_has(0);
  @$pb.TagNumber(1)
  void clearEntity() => $_clearField(1);
  @$pb.TagNumber(1)
  EventRead ensureEntity() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get etag => $_getSZ(1);
  @$pb.TagNumber(2)
  set etag($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEtag() => $_has(1);
  @$pb.TagNumber(2)
  void clearEtag() => $_clearField(2);
}

class EventRead extends $pb.GeneratedMessage {
  factory EventRead({
    $3.StringValue? id,
    $3.StringValue? name,
    $3.StringValue? description,
    $4.Timestamp? startsAt,
    $4.Timestamp? publishFrom,
    $4.Timestamp? publishUntil,
    EventVisibilityTypeId? eventVisibilityTypeId,
    $3.BytesValue? image,
    $core.Iterable<EventInviteReadCreateUpdate>? eventInvites,
    $core.Iterable<EventUserRead>? eventUsers,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (startsAt != null) result.startsAt = startsAt;
    if (publishFrom != null) result.publishFrom = publishFrom;
    if (publishUntil != null) result.publishUntil = publishUntil;
    if (eventVisibilityTypeId != null)
      result.eventVisibilityTypeId = eventVisibilityTypeId;
    if (image != null) result.image = image;
    if (eventInvites != null) result.eventInvites.addAll(eventInvites);
    if (eventUsers != null) result.eventUsers.addAll(eventUsers);
    return result;
  }

  EventRead._();

  factory EventRead.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventRead.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventRead',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.event'),
      createEmptyInstance: create)
    ..aOM<$3.StringValue>(1, _omitFieldNames ? '' : 'id',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(2, _omitFieldNames ? '' : 'name',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(3, _omitFieldNames ? '' : 'description',
        subBuilder: $3.StringValue.create)
    ..aOM<$4.Timestamp>(4, _omitFieldNames ? '' : 'startsAt',
        subBuilder: $4.Timestamp.create)
    ..aOM<$4.Timestamp>(5, _omitFieldNames ? '' : 'publishFrom',
        subBuilder: $4.Timestamp.create)
    ..aOM<$4.Timestamp>(6, _omitFieldNames ? '' : 'publishUntil',
        subBuilder: $4.Timestamp.create)
    ..aE<EventVisibilityTypeId>(
        7, _omitFieldNames ? '' : 'eventVisibilityTypeId',
        enumValues: EventVisibilityTypeId.values)
    ..aOM<$3.BytesValue>(8, _omitFieldNames ? '' : 'image',
        subBuilder: $3.BytesValue.create)
    ..pPM<EventInviteReadCreateUpdate>(
        10, _omitFieldNames ? '' : 'eventInvites',
        subBuilder: EventInviteReadCreateUpdate.create)
    ..pPM<EventUserRead>(11, _omitFieldNames ? '' : 'eventUsers',
        subBuilder: EventUserRead.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventRead clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventRead copyWith(void Function(EventRead) updates) =>
      super.copyWith((message) => updates(message as EventRead)) as EventRead;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventRead create() => EventRead._();
  @$core.override
  EventRead createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EventRead getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EventRead>(create);
  static EventRead? _defaultInstance;

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
  $4.Timestamp get startsAt => $_getN(3);
  @$pb.TagNumber(4)
  set startsAt($4.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasStartsAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearStartsAt() => $_clearField(4);
  @$pb.TagNumber(4)
  $4.Timestamp ensureStartsAt() => $_ensure(3);

  @$pb.TagNumber(5)
  $4.Timestamp get publishFrom => $_getN(4);
  @$pb.TagNumber(5)
  set publishFrom($4.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasPublishFrom() => $_has(4);
  @$pb.TagNumber(5)
  void clearPublishFrom() => $_clearField(5);
  @$pb.TagNumber(5)
  $4.Timestamp ensurePublishFrom() => $_ensure(4);

  @$pb.TagNumber(6)
  $4.Timestamp get publishUntil => $_getN(5);
  @$pb.TagNumber(6)
  set publishUntil($4.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasPublishUntil() => $_has(5);
  @$pb.TagNumber(6)
  void clearPublishUntil() => $_clearField(6);
  @$pb.TagNumber(6)
  $4.Timestamp ensurePublishUntil() => $_ensure(5);

  @$pb.TagNumber(7)
  EventVisibilityTypeId get eventVisibilityTypeId => $_getN(6);
  @$pb.TagNumber(7)
  set eventVisibilityTypeId(EventVisibilityTypeId value) =>
      $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasEventVisibilityTypeId() => $_has(6);
  @$pb.TagNumber(7)
  void clearEventVisibilityTypeId() => $_clearField(7);

  @$pb.TagNumber(8)
  $3.BytesValue get image => $_getN(7);
  @$pb.TagNumber(8)
  set image($3.BytesValue value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasImage() => $_has(7);
  @$pb.TagNumber(8)
  void clearImage() => $_clearField(8);
  @$pb.TagNumber(8)
  $3.BytesValue ensureImage() => $_ensure(7);

  @$pb.TagNumber(10)
  $pb.PbList<EventInviteReadCreateUpdate> get eventInvites => $_getList(8);

  @$pb.TagNumber(11)
  $pb.PbList<EventUserRead> get eventUsers => $_getList(9);
}

class EventCreateUpdate extends $pb.GeneratedMessage {
  factory EventCreateUpdate({
    $core.String? name,
    $3.StringValue? description,
    $4.Timestamp? startsAt,
    $4.Timestamp? publishFrom,
    $4.Timestamp? publishUntil,
    EventVisibilityTypeId? eventVisibilityTypeId,
    $core.List<$core.int>? image,
    $core.bool? imageDeleted,
    $core.Iterable<EventInviteReadCreateUpdate>? eventInvites,
    $core.Iterable<$core.String>? eventInvitesDeleted,
    $core.Iterable<EventUserCreateUpdate>? eventUsers,
    $core.Iterable<$core.String>? eventUsersDeleted,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (startsAt != null) result.startsAt = startsAt;
    if (publishFrom != null) result.publishFrom = publishFrom;
    if (publishUntil != null) result.publishUntil = publishUntil;
    if (eventVisibilityTypeId != null)
      result.eventVisibilityTypeId = eventVisibilityTypeId;
    if (image != null) result.image = image;
    if (imageDeleted != null) result.imageDeleted = imageDeleted;
    if (eventInvites != null) result.eventInvites.addAll(eventInvites);
    if (eventInvitesDeleted != null)
      result.eventInvitesDeleted.addAll(eventInvitesDeleted);
    if (eventUsers != null) result.eventUsers.addAll(eventUsers);
    if (eventUsersDeleted != null)
      result.eventUsersDeleted.addAll(eventUsersDeleted);
    return result;
  }

  EventCreateUpdate._();

  factory EventCreateUpdate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventCreateUpdate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventCreateUpdate',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.event'),
      createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOM<$3.StringValue>(3, _omitFieldNames ? '' : 'description',
        subBuilder: $3.StringValue.create)
    ..aOM<$4.Timestamp>(4, _omitFieldNames ? '' : 'startsAt',
        subBuilder: $4.Timestamp.create)
    ..aOM<$4.Timestamp>(5, _omitFieldNames ? '' : 'publishFrom',
        subBuilder: $4.Timestamp.create)
    ..aOM<$4.Timestamp>(6, _omitFieldNames ? '' : 'publishUntil',
        subBuilder: $4.Timestamp.create)
    ..aE<EventVisibilityTypeId>(
        7, _omitFieldNames ? '' : 'eventVisibilityTypeId',
        enumValues: EventVisibilityTypeId.values)
    ..a<$core.List<$core.int>>(
        8, _omitFieldNames ? '' : 'image', $pb.PbFieldType.OY)
    ..aOB(9, _omitFieldNames ? '' : 'imageDeleted')
    ..pPM<EventInviteReadCreateUpdate>(
        10, _omitFieldNames ? '' : 'eventInvites',
        subBuilder: EventInviteReadCreateUpdate.create)
    ..pPS(11, _omitFieldNames ? '' : 'eventInvitesDeleted')
    ..pPM<EventUserCreateUpdate>(12, _omitFieldNames ? '' : 'eventUsers',
        subBuilder: EventUserCreateUpdate.create)
    ..pPS(13, _omitFieldNames ? '' : 'eventUsersDeleted')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventCreateUpdate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventCreateUpdate copyWith(void Function(EventCreateUpdate) updates) =>
      super.copyWith((message) => updates(message as EventCreateUpdate))
          as EventCreateUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventCreateUpdate create() => EventCreateUpdate._();
  @$core.override
  EventCreateUpdate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EventCreateUpdate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EventCreateUpdate>(create);
  static EventCreateUpdate? _defaultInstance;

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
  $4.Timestamp get startsAt => $_getN(2);
  @$pb.TagNumber(4)
  set startsAt($4.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasStartsAt() => $_has(2);
  @$pb.TagNumber(4)
  void clearStartsAt() => $_clearField(4);
  @$pb.TagNumber(4)
  $4.Timestamp ensureStartsAt() => $_ensure(2);

  @$pb.TagNumber(5)
  $4.Timestamp get publishFrom => $_getN(3);
  @$pb.TagNumber(5)
  set publishFrom($4.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasPublishFrom() => $_has(3);
  @$pb.TagNumber(5)
  void clearPublishFrom() => $_clearField(5);
  @$pb.TagNumber(5)
  $4.Timestamp ensurePublishFrom() => $_ensure(3);

  @$pb.TagNumber(6)
  $4.Timestamp get publishUntil => $_getN(4);
  @$pb.TagNumber(6)
  set publishUntil($4.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasPublishUntil() => $_has(4);
  @$pb.TagNumber(6)
  void clearPublishUntil() => $_clearField(6);
  @$pb.TagNumber(6)
  $4.Timestamp ensurePublishUntil() => $_ensure(4);

  @$pb.TagNumber(7)
  EventVisibilityTypeId get eventVisibilityTypeId => $_getN(5);
  @$pb.TagNumber(7)
  set eventVisibilityTypeId(EventVisibilityTypeId value) =>
      $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasEventVisibilityTypeId() => $_has(5);
  @$pb.TagNumber(7)
  void clearEventVisibilityTypeId() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.List<$core.int> get image => $_getN(6);
  @$pb.TagNumber(8)
  set image($core.List<$core.int> value) => $_setBytes(6, value);
  @$pb.TagNumber(8)
  $core.bool hasImage() => $_has(6);
  @$pb.TagNumber(8)
  void clearImage() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get imageDeleted => $_getBF(7);
  @$pb.TagNumber(9)
  set imageDeleted($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(9)
  $core.bool hasImageDeleted() => $_has(7);
  @$pb.TagNumber(9)
  void clearImageDeleted() => $_clearField(9);

  @$pb.TagNumber(10)
  $pb.PbList<EventInviteReadCreateUpdate> get eventInvites => $_getList(8);

  @$pb.TagNumber(11)
  $pb.PbList<$core.String> get eventInvitesDeleted => $_getList(9);

  @$pb.TagNumber(12)
  $pb.PbList<EventUserCreateUpdate> get eventUsers => $_getList(10);

  @$pb.TagNumber(13)
  $pb.PbList<$core.String> get eventUsersDeleted => $_getList(11);
}

class EventUpdateRequest extends $pb.GeneratedMessage {
  factory EventUpdateRequest({
    $core.String? id,
    EventCreateUpdate? entity,
    $core.String? etag,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (entity != null) result.entity = entity;
    if (etag != null) result.etag = etag;
    return result;
  }

  EventUpdateRequest._();

  factory EventUpdateRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventUpdateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventUpdateRequest',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.event'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<EventCreateUpdate>(2, _omitFieldNames ? '' : 'entity',
        subBuilder: EventCreateUpdate.create)
    ..aOS(3, _omitFieldNames ? '' : 'etag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventUpdateRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventUpdateRequest copyWith(void Function(EventUpdateRequest) updates) =>
      super.copyWith((message) => updates(message as EventUpdateRequest))
          as EventUpdateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventUpdateRequest create() => EventUpdateRequest._();
  @$core.override
  EventUpdateRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EventUpdateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EventUpdateRequest>(create);
  static EventUpdateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  EventCreateUpdate get entity => $_getN(1);
  @$pb.TagNumber(2)
  set entity(EventCreateUpdate value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEntity() => $_has(1);
  @$pb.TagNumber(2)
  void clearEntity() => $_clearField(2);
  @$pb.TagNumber(2)
  EventCreateUpdate ensureEntity() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get etag => $_getSZ(2);
  @$pb.TagNumber(3)
  set etag($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEtag() => $_has(2);
  @$pb.TagNumber(3)
  void clearEtag() => $_clearField(3);
}

class EventListResponse extends $pb.GeneratedMessage {
  factory EventListResponse({
    $core.Iterable<EventList>? result,
  }) {
    final result$ = create();
    if (result != null) result$.result.addAll(result);
    return result$;
  }

  EventListResponse._();

  factory EventListResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventListResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventListResponse',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.event'),
      createEmptyInstance: create)
    ..pPM<EventList>(1, _omitFieldNames ? '' : 'result',
        subBuilder: EventList.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventListResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventListResponse copyWith(void Function(EventListResponse) updates) =>
      super.copyWith((message) => updates(message as EventListResponse))
          as EventListResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventListResponse create() => EventListResponse._();
  @$core.override
  EventListResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EventListResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EventListResponse>(create);
  static EventListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<EventList> get result => $_getList(0);
}

class EventList extends $pb.GeneratedMessage {
  factory EventList({
    $core.String? id,
    $core.String? name,
    $3.StringValue? description,
    $4.Timestamp? publishFrom,
    $4.Timestamp? publishUntil,
    $3.BytesValue? image,
    $core.String? etag,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (publishFrom != null) result.publishFrom = publishFrom;
    if (publishUntil != null) result.publishUntil = publishUntil;
    if (image != null) result.image = image;
    if (etag != null) result.etag = etag;
    return result;
  }

  EventList._();

  factory EventList.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventList.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventList',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.event'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOM<$3.StringValue>(3, _omitFieldNames ? '' : 'description',
        subBuilder: $3.StringValue.create)
    ..aOM<$4.Timestamp>(4, _omitFieldNames ? '' : 'publishFrom',
        subBuilder: $4.Timestamp.create)
    ..aOM<$4.Timestamp>(5, _omitFieldNames ? '' : 'publishUntil',
        subBuilder: $4.Timestamp.create)
    ..aOM<$3.BytesValue>(6, _omitFieldNames ? '' : 'image',
        subBuilder: $3.BytesValue.create)
    ..aOS(7, _omitFieldNames ? '' : 'etag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventList clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventList copyWith(void Function(EventList) updates) =>
      super.copyWith((message) => updates(message as EventList)) as EventList;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventList create() => EventList._();
  @$core.override
  EventList createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EventList getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EventList>(create);
  static EventList? _defaultInstance;

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
  $4.Timestamp get publishFrom => $_getN(3);
  @$pb.TagNumber(4)
  set publishFrom($4.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasPublishFrom() => $_has(3);
  @$pb.TagNumber(4)
  void clearPublishFrom() => $_clearField(4);
  @$pb.TagNumber(4)
  $4.Timestamp ensurePublishFrom() => $_ensure(3);

  @$pb.TagNumber(5)
  $4.Timestamp get publishUntil => $_getN(4);
  @$pb.TagNumber(5)
  set publishUntil($4.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasPublishUntil() => $_has(4);
  @$pb.TagNumber(5)
  void clearPublishUntil() => $_clearField(5);
  @$pb.TagNumber(5)
  $4.Timestamp ensurePublishUntil() => $_ensure(4);

  @$pb.TagNumber(6)
  $3.BytesValue get image => $_getN(5);
  @$pb.TagNumber(6)
  set image($3.BytesValue value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasImage() => $_has(5);
  @$pb.TagNumber(6)
  void clearImage() => $_clearField(6);
  @$pb.TagNumber(6)
  $3.BytesValue ensureImage() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get etag => $_getSZ(6);
  @$pb.TagNumber(7)
  set etag($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasEtag() => $_has(6);
  @$pb.TagNumber(7)
  void clearEtag() => $_clearField(7);
}

class EventSelectResponse extends $pb.GeneratedMessage {
  factory EventSelectResponse({
    $core.Iterable<EventSelect>? result,
  }) {
    final result$ = create();
    if (result != null) result$.result.addAll(result);
    return result$;
  }

  EventSelectResponse._();

  factory EventSelectResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventSelectResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventSelectResponse',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.event'),
      createEmptyInstance: create)
    ..pPM<EventSelect>(1, _omitFieldNames ? '' : 'result',
        subBuilder: EventSelect.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventSelectResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventSelectResponse copyWith(void Function(EventSelectResponse) updates) =>
      super.copyWith((message) => updates(message as EventSelectResponse))
          as EventSelectResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventSelectResponse create() => EventSelectResponse._();
  @$core.override
  EventSelectResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EventSelectResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EventSelectResponse>(create);
  static EventSelectResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<EventSelect> get result => $_getList(0);
}

class EventSelect extends $pb.GeneratedMessage {
  factory EventSelect({
    $core.String? id,
    $core.String? name,
    $core.Iterable<EventUserSelect>? eventUsers,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (eventUsers != null) result.eventUsers.addAll(eventUsers);
    return result;
  }

  EventSelect._();

  factory EventSelect.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventSelect.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventSelect',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.event'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..pPM<EventUserSelect>(9, _omitFieldNames ? '' : 'eventUsers',
        subBuilder: EventUserSelect.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventSelect clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventSelect copyWith(void Function(EventSelect) updates) =>
      super.copyWith((message) => updates(message as EventSelect))
          as EventSelect;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventSelect create() => EventSelect._();
  @$core.override
  EventSelect createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EventSelect getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EventSelect>(create);
  static EventSelect? _defaultInstance;

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

  @$pb.TagNumber(9)
  $pb.PbList<EventUserSelect> get eventUsers => $_getList(2);
}

class EventInviteReadCreateUpdate extends $pb.GeneratedMessage {
  factory EventInviteReadCreateUpdate({
    $core.String? id,
    $core.int? code,
    $core.bool? multiple,
    $4.Timestamp? timeToLiveAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (code != null) result.code = code;
    if (multiple != null) result.multiple = multiple;
    if (timeToLiveAt != null) result.timeToLiveAt = timeToLiveAt;
    return result;
  }

  EventInviteReadCreateUpdate._();

  factory EventInviteReadCreateUpdate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventInviteReadCreateUpdate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventInviteReadCreateUpdate',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.event'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aI(2, _omitFieldNames ? '' : 'code')
    ..aOB(3, _omitFieldNames ? '' : 'multiple')
    ..aOM<$4.Timestamp>(4, _omitFieldNames ? '' : 'timeToLiveAt',
        subBuilder: $4.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventInviteReadCreateUpdate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventInviteReadCreateUpdate copyWith(
          void Function(EventInviteReadCreateUpdate) updates) =>
      super.copyWith(
              (message) => updates(message as EventInviteReadCreateUpdate))
          as EventInviteReadCreateUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventInviteReadCreateUpdate create() =>
      EventInviteReadCreateUpdate._();
  @$core.override
  EventInviteReadCreateUpdate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EventInviteReadCreateUpdate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EventInviteReadCreateUpdate>(create);
  static EventInviteReadCreateUpdate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get code => $_getIZ(1);
  @$pb.TagNumber(2)
  set code($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get multiple => $_getBF(2);
  @$pb.TagNumber(3)
  set multiple($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMultiple() => $_has(2);
  @$pb.TagNumber(3)
  void clearMultiple() => $_clearField(3);

  @$pb.TagNumber(4)
  $4.Timestamp get timeToLiveAt => $_getN(3);
  @$pb.TagNumber(4)
  set timeToLiveAt($4.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasTimeToLiveAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimeToLiveAt() => $_clearField(4);
  @$pb.TagNumber(4)
  $4.Timestamp ensureTimeToLiveAt() => $_ensure(3);
}

class EventUserRead extends $pb.GeneratedMessage {
  factory EventUserRead({
    $core.String? id,
    $3.StringValue? eventUserId,
    $3.StringValue? userId,
    $3.StringValue? name,
    $3.StringValue? shortName,
    $5.EventUserTypeId? eventUserTypeId,
    $3.BytesValue? image,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (eventUserId != null) result.eventUserId = eventUserId;
    if (userId != null) result.userId = userId;
    if (name != null) result.name = name;
    if (shortName != null) result.shortName = shortName;
    if (eventUserTypeId != null) result.eventUserTypeId = eventUserTypeId;
    if (image != null) result.image = image;
    return result;
  }

  EventUserRead._();

  factory EventUserRead.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventUserRead.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventUserRead',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.event'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<$3.StringValue>(2, _omitFieldNames ? '' : 'eventUserId',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(3, _omitFieldNames ? '' : 'userId',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(5, _omitFieldNames ? '' : 'name',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(6, _omitFieldNames ? '' : 'shortName',
        subBuilder: $3.StringValue.create)
    ..aE<$5.EventUserTypeId>(7, _omitFieldNames ? '' : 'eventUserTypeId',
        enumValues: $5.EventUserTypeId.values)
    ..aOM<$3.BytesValue>(8, _omitFieldNames ? '' : 'image',
        subBuilder: $3.BytesValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventUserRead clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventUserRead copyWith(void Function(EventUserRead) updates) =>
      super.copyWith((message) => updates(message as EventUserRead))
          as EventUserRead;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventUserRead create() => EventUserRead._();
  @$core.override
  EventUserRead createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EventUserRead getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EventUserRead>(create);
  static EventUserRead? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $3.StringValue get eventUserId => $_getN(1);
  @$pb.TagNumber(2)
  set eventUserId($3.StringValue value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEventUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearEventUserId() => $_clearField(2);
  @$pb.TagNumber(2)
  $3.StringValue ensureEventUserId() => $_ensure(1);

  @$pb.TagNumber(3)
  $3.StringValue get userId => $_getN(2);
  @$pb.TagNumber(3)
  set userId($3.StringValue value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);
  @$pb.TagNumber(3)
  $3.StringValue ensureUserId() => $_ensure(2);

  /// google.protobuf.StringValue autopilot_id = 4;
  @$pb.TagNumber(5)
  $3.StringValue get name => $_getN(3);
  @$pb.TagNumber(5)
  set name($3.StringValue value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasName() => $_has(3);
  @$pb.TagNumber(5)
  void clearName() => $_clearField(5);
  @$pb.TagNumber(5)
  $3.StringValue ensureName() => $_ensure(3);

  @$pb.TagNumber(6)
  $3.StringValue get shortName => $_getN(4);
  @$pb.TagNumber(6)
  set shortName($3.StringValue value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasShortName() => $_has(4);
  @$pb.TagNumber(6)
  void clearShortName() => $_clearField(6);
  @$pb.TagNumber(6)
  $3.StringValue ensureShortName() => $_ensure(4);

  @$pb.TagNumber(7)
  $5.EventUserTypeId get eventUserTypeId => $_getN(5);
  @$pb.TagNumber(7)
  set eventUserTypeId($5.EventUserTypeId value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasEventUserTypeId() => $_has(5);
  @$pb.TagNumber(7)
  void clearEventUserTypeId() => $_clearField(7);

  @$pb.TagNumber(8)
  $3.BytesValue get image => $_getN(6);
  @$pb.TagNumber(8)
  set image($3.BytesValue value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasImage() => $_has(6);
  @$pb.TagNumber(8)
  void clearImage() => $_clearField(8);
  @$pb.TagNumber(8)
  $3.BytesValue ensureImage() => $_ensure(6);
}

class EventUserCreateUpdate extends $pb.GeneratedMessage {
  factory EventUserCreateUpdate({
    $core.String? id,
    $3.StringValue? eventUserId,
    $3.StringValue? userId,
    $3.StringValue? name,
    $3.StringValue? shortName,
    $5.EventUserTypeId? eventUserTypeId,
    $core.List<$core.int>? image,
    $core.bool? imageDeleted,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (eventUserId != null) result.eventUserId = eventUserId;
    if (userId != null) result.userId = userId;
    if (name != null) result.name = name;
    if (shortName != null) result.shortName = shortName;
    if (eventUserTypeId != null) result.eventUserTypeId = eventUserTypeId;
    if (image != null) result.image = image;
    if (imageDeleted != null) result.imageDeleted = imageDeleted;
    return result;
  }

  EventUserCreateUpdate._();

  factory EventUserCreateUpdate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventUserCreateUpdate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventUserCreateUpdate',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.event'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<$3.StringValue>(2, _omitFieldNames ? '' : 'eventUserId',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(3, _omitFieldNames ? '' : 'userId',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(5, _omitFieldNames ? '' : 'name',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(6, _omitFieldNames ? '' : 'shortName',
        subBuilder: $3.StringValue.create)
    ..aE<$5.EventUserTypeId>(7, _omitFieldNames ? '' : 'eventUserTypeId',
        enumValues: $5.EventUserTypeId.values)
    ..a<$core.List<$core.int>>(
        8, _omitFieldNames ? '' : 'image', $pb.PbFieldType.OY)
    ..aOB(9, _omitFieldNames ? '' : 'imageDeleted')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventUserCreateUpdate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventUserCreateUpdate copyWith(
          void Function(EventUserCreateUpdate) updates) =>
      super.copyWith((message) => updates(message as EventUserCreateUpdate))
          as EventUserCreateUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventUserCreateUpdate create() => EventUserCreateUpdate._();
  @$core.override
  EventUserCreateUpdate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EventUserCreateUpdate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EventUserCreateUpdate>(create);
  static EventUserCreateUpdate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $3.StringValue get eventUserId => $_getN(1);
  @$pb.TagNumber(2)
  set eventUserId($3.StringValue value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEventUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearEventUserId() => $_clearField(2);
  @$pb.TagNumber(2)
  $3.StringValue ensureEventUserId() => $_ensure(1);

  @$pb.TagNumber(3)
  $3.StringValue get userId => $_getN(2);
  @$pb.TagNumber(3)
  set userId($3.StringValue value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);
  @$pb.TagNumber(3)
  $3.StringValue ensureUserId() => $_ensure(2);

  /// google.protobuf.StringValue autopilot_id = 4;
  @$pb.TagNumber(5)
  $3.StringValue get name => $_getN(3);
  @$pb.TagNumber(5)
  set name($3.StringValue value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasName() => $_has(3);
  @$pb.TagNumber(5)
  void clearName() => $_clearField(5);
  @$pb.TagNumber(5)
  $3.StringValue ensureName() => $_ensure(3);

  @$pb.TagNumber(6)
  $3.StringValue get shortName => $_getN(4);
  @$pb.TagNumber(6)
  set shortName($3.StringValue value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasShortName() => $_has(4);
  @$pb.TagNumber(6)
  void clearShortName() => $_clearField(6);
  @$pb.TagNumber(6)
  $3.StringValue ensureShortName() => $_ensure(4);

  @$pb.TagNumber(7)
  $5.EventUserTypeId get eventUserTypeId => $_getN(5);
  @$pb.TagNumber(7)
  set eventUserTypeId($5.EventUserTypeId value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasEventUserTypeId() => $_has(5);
  @$pb.TagNumber(7)
  void clearEventUserTypeId() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.List<$core.int> get image => $_getN(6);
  @$pb.TagNumber(8)
  set image($core.List<$core.int> value) => $_setBytes(6, value);
  @$pb.TagNumber(8)
  $core.bool hasImage() => $_has(6);
  @$pb.TagNumber(8)
  void clearImage() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get imageDeleted => $_getBF(7);
  @$pb.TagNumber(9)
  set imageDeleted($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(9)
  $core.bool hasImageDeleted() => $_has(7);
  @$pb.TagNumber(9)
  void clearImageDeleted() => $_clearField(9);
}

class EventUserSelect extends $pb.GeneratedMessage {
  factory EventUserSelect({
    $core.String? id,
    $core.String? name,
    $3.StringValue? shortName,
    $3.BytesValue? image,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (shortName != null) result.shortName = shortName;
    if (image != null) result.image = image;
    return result;
  }

  EventUserSelect._();

  factory EventUserSelect.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventUserSelect.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventUserSelect',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.event'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOM<$3.StringValue>(3, _omitFieldNames ? '' : 'shortName',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.BytesValue>(4, _omitFieldNames ? '' : 'image',
        subBuilder: $3.BytesValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventUserSelect clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventUserSelect copyWith(void Function(EventUserSelect) updates) =>
      super.copyWith((message) => updates(message as EventUserSelect))
          as EventUserSelect;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventUserSelect create() => EventUserSelect._();
  @$core.override
  EventUserSelect createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EventUserSelect getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EventUserSelect>(create);
  static EventUserSelect? _defaultInstance;

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
  $3.StringValue get shortName => $_getN(2);
  @$pb.TagNumber(3)
  set shortName($3.StringValue value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasShortName() => $_has(2);
  @$pb.TagNumber(3)
  void clearShortName() => $_clearField(3);
  @$pb.TagNumber(3)
  $3.StringValue ensureShortName() => $_ensure(2);

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
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
