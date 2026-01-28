// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/user_services/event.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $3;
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart'
    as $2;

import 'tenant.pb.dart' as $4;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class EventAuthorizedRequest extends $pb.GeneratedMessage {
  factory EventAuthorizedRequest({
    $core.String? id,
    $2.StringValue? userId,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    return result;
  }

  EventAuthorizedRequest._();

  factory EventAuthorizedRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventAuthorizedRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventAuthorizedRequest',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.user_services.event'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<$2.StringValue>(4, _omitFieldNames ? '' : 'userId',
        subBuilder: $2.StringValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventAuthorizedRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventAuthorizedRequest copyWith(
          void Function(EventAuthorizedRequest) updates) =>
      super.copyWith((message) => updates(message as EventAuthorizedRequest))
          as EventAuthorizedRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventAuthorizedRequest create() => EventAuthorizedRequest._();
  @$core.override
  EventAuthorizedRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EventAuthorizedRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EventAuthorizedRequest>(create);
  static EventAuthorizedRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(4)
  $2.StringValue get userId => $_getN(1);
  @$pb.TagNumber(4)
  set userId($2.StringValue value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(4)
  void clearUserId() => $_clearField(4);
  @$pb.TagNumber(4)
  $2.StringValue ensureUserId() => $_ensure(1);
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
          : 'razmanager.protobuf.internal.repository.user_services.event'),
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
    $2.StringValue? description,
    $3.Timestamp? startsAt,
    $2.BytesValue? image,
    $4.TenantSelect? tenant,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (startsAt != null) result.startsAt = startsAt;
    if (image != null) result.image = image;
    if (tenant != null) result.tenant = tenant;
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
          : 'razmanager.protobuf.internal.repository.user_services.event'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOM<$2.StringValue>(3, _omitFieldNames ? '' : 'description',
        subBuilder: $2.StringValue.create)
    ..aOM<$3.Timestamp>(4, _omitFieldNames ? '' : 'startsAt',
        subBuilder: $3.Timestamp.create)
    ..aOM<$2.BytesValue>(5, _omitFieldNames ? '' : 'image',
        subBuilder: $2.BytesValue.create)
    ..aOM<$4.TenantSelect>(6, _omitFieldNames ? '' : 'tenant',
        subBuilder: $4.TenantSelect.create)
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

  @$pb.TagNumber(3)
  $2.StringValue get description => $_getN(2);
  @$pb.TagNumber(3)
  set description($2.StringValue value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);
  @$pb.TagNumber(3)
  $2.StringValue ensureDescription() => $_ensure(2);

  @$pb.TagNumber(4)
  $3.Timestamp get startsAt => $_getN(3);
  @$pb.TagNumber(4)
  set startsAt($3.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasStartsAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearStartsAt() => $_clearField(4);
  @$pb.TagNumber(4)
  $3.Timestamp ensureStartsAt() => $_ensure(3);

  @$pb.TagNumber(5)
  $2.BytesValue get image => $_getN(4);
  @$pb.TagNumber(5)
  set image($2.BytesValue value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasImage() => $_has(4);
  @$pb.TagNumber(5)
  void clearImage() => $_clearField(5);
  @$pb.TagNumber(5)
  $2.BytesValue ensureImage() => $_ensure(4);

  @$pb.TagNumber(6)
  $4.TenantSelect get tenant => $_getN(5);
  @$pb.TagNumber(6)
  set tenant($4.TenantSelect value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasTenant() => $_has(5);
  @$pb.TagNumber(6)
  void clearTenant() => $_clearField(6);
  @$pb.TagNumber(6)
  $4.TenantSelect ensureTenant() => $_ensure(5);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
