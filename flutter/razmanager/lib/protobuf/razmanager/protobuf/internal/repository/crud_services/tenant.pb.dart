// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/tenant.proto.

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

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class TenantReadResponse extends $pb.GeneratedMessage {
  factory TenantReadResponse({
    TenantRead? entity,
    $core.String? etag,
  }) {
    final result = create();
    if (entity != null) result.entity = entity;
    if (etag != null) result.etag = etag;
    return result;
  }

  TenantReadResponse._();

  factory TenantReadResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TenantReadResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TenantReadResponse',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.tenant'),
      createEmptyInstance: create)
    ..aOM<TenantRead>(1, _omitFieldNames ? '' : 'entity',
        subBuilder: TenantRead.create)
    ..aOS(2, _omitFieldNames ? '' : 'etag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TenantReadResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TenantReadResponse copyWith(void Function(TenantReadResponse) updates) =>
      super.copyWith((message) => updates(message as TenantReadResponse))
          as TenantReadResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TenantReadResponse create() => TenantReadResponse._();
  @$core.override
  TenantReadResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TenantReadResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TenantReadResponse>(create);
  static TenantReadResponse? _defaultInstance;

  @$pb.TagNumber(1)
  TenantRead get entity => $_getN(0);
  @$pb.TagNumber(1)
  set entity(TenantRead value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasEntity() => $_has(0);
  @$pb.TagNumber(1)
  void clearEntity() => $_clearField(1);
  @$pb.TagNumber(1)
  TenantRead ensureEntity() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get etag => $_getSZ(1);
  @$pb.TagNumber(2)
  set etag($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEtag() => $_has(1);
  @$pb.TagNumber(2)
  void clearEtag() => $_clearField(2);
}

class TenantRead extends $pb.GeneratedMessage {
  factory TenantRead({
    $3.StringValue? id,
    $3.StringValue? name,
    $3.StringValue? description,
    $3.BytesValue? image,
    $core.Iterable<TenantInviteReadCreateUpdate>? tenantInvites,
    $core.Iterable<TenantUserReadCreateUpdate>? tenantUsers,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (image != null) result.image = image;
    if (tenantInvites != null) result.tenantInvites.addAll(tenantInvites);
    if (tenantUsers != null) result.tenantUsers.addAll(tenantUsers);
    return result;
  }

  TenantRead._();

  factory TenantRead.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TenantRead.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TenantRead',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.tenant'),
      createEmptyInstance: create)
    ..aOM<$3.StringValue>(1, _omitFieldNames ? '' : 'id',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(2, _omitFieldNames ? '' : 'name',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(3, _omitFieldNames ? '' : 'description',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.BytesValue>(4, _omitFieldNames ? '' : 'image',
        subBuilder: $3.BytesValue.create)
    ..pPM<TenantInviteReadCreateUpdate>(
        6, _omitFieldNames ? '' : 'tenantInvites',
        subBuilder: TenantInviteReadCreateUpdate.create)
    ..pPM<TenantUserReadCreateUpdate>(7, _omitFieldNames ? '' : 'tenantUsers',
        subBuilder: TenantUserReadCreateUpdate.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TenantRead clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TenantRead copyWith(void Function(TenantRead) updates) =>
      super.copyWith((message) => updates(message as TenantRead)) as TenantRead;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TenantRead create() => TenantRead._();
  @$core.override
  TenantRead createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TenantRead getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TenantRead>(create);
  static TenantRead? _defaultInstance;

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

  @$pb.TagNumber(6)
  $pb.PbList<TenantInviteReadCreateUpdate> get tenantInvites => $_getList(4);

  @$pb.TagNumber(7)
  $pb.PbList<TenantUserReadCreateUpdate> get tenantUsers => $_getList(5);
}

class TenantCreateUpdate extends $pb.GeneratedMessage {
  factory TenantCreateUpdate({
    $core.String? name,
    $3.StringValue? description,
    $core.List<$core.int>? image,
    $core.bool? imageDeleted,
    $core.Iterable<TenantInviteReadCreateUpdate>? tenantInvites,
    $core.Iterable<$core.String>? tenantInvitesDeleted,
    $core.Iterable<TenantUserReadCreateUpdate>? tenantUsers,
    $core.Iterable<$core.String>? tenantUsersDeleted,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (image != null) result.image = image;
    if (imageDeleted != null) result.imageDeleted = imageDeleted;
    if (tenantInvites != null) result.tenantInvites.addAll(tenantInvites);
    if (tenantInvitesDeleted != null)
      result.tenantInvitesDeleted.addAll(tenantInvitesDeleted);
    if (tenantUsers != null) result.tenantUsers.addAll(tenantUsers);
    if (tenantUsersDeleted != null)
      result.tenantUsersDeleted.addAll(tenantUsersDeleted);
    return result;
  }

  TenantCreateUpdate._();

  factory TenantCreateUpdate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TenantCreateUpdate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TenantCreateUpdate',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.tenant'),
      createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOM<$3.StringValue>(3, _omitFieldNames ? '' : 'description',
        subBuilder: $3.StringValue.create)
    ..a<$core.List<$core.int>>(
        4, _omitFieldNames ? '' : 'image', $pb.PbFieldType.OY)
    ..aOB(5, _omitFieldNames ? '' : 'imageDeleted')
    ..pPM<TenantInviteReadCreateUpdate>(
        6, _omitFieldNames ? '' : 'tenantInvites',
        subBuilder: TenantInviteReadCreateUpdate.create)
    ..pPS(7, _omitFieldNames ? '' : 'tenantInvitesDeleted')
    ..pPM<TenantUserReadCreateUpdate>(8, _omitFieldNames ? '' : 'tenantUsers',
        subBuilder: TenantUserReadCreateUpdate.create)
    ..pPS(9, _omitFieldNames ? '' : 'tenantUsersDeleted')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TenantCreateUpdate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TenantCreateUpdate copyWith(void Function(TenantCreateUpdate) updates) =>
      super.copyWith((message) => updates(message as TenantCreateUpdate))
          as TenantCreateUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TenantCreateUpdate create() => TenantCreateUpdate._();
  @$core.override
  TenantCreateUpdate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TenantCreateUpdate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TenantCreateUpdate>(create);
  static TenantCreateUpdate? _defaultInstance;

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
  $pb.PbList<TenantInviteReadCreateUpdate> get tenantInvites => $_getList(4);

  @$pb.TagNumber(7)
  $pb.PbList<$core.String> get tenantInvitesDeleted => $_getList(5);

  @$pb.TagNumber(8)
  $pb.PbList<TenantUserReadCreateUpdate> get tenantUsers => $_getList(6);

  @$pb.TagNumber(9)
  $pb.PbList<$core.String> get tenantUsersDeleted => $_getList(7);
}

class TenantUpdateRequest extends $pb.GeneratedMessage {
  factory TenantUpdateRequest({
    $core.String? id,
    TenantCreateUpdate? entity,
    $core.String? etag,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (entity != null) result.entity = entity;
    if (etag != null) result.etag = etag;
    return result;
  }

  TenantUpdateRequest._();

  factory TenantUpdateRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TenantUpdateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TenantUpdateRequest',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.tenant'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<TenantCreateUpdate>(2, _omitFieldNames ? '' : 'entity',
        subBuilder: TenantCreateUpdate.create)
    ..aOS(3, _omitFieldNames ? '' : 'etag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TenantUpdateRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TenantUpdateRequest copyWith(void Function(TenantUpdateRequest) updates) =>
      super.copyWith((message) => updates(message as TenantUpdateRequest))
          as TenantUpdateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TenantUpdateRequest create() => TenantUpdateRequest._();
  @$core.override
  TenantUpdateRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TenantUpdateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TenantUpdateRequest>(create);
  static TenantUpdateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  TenantCreateUpdate get entity => $_getN(1);
  @$pb.TagNumber(2)
  set entity(TenantCreateUpdate value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEntity() => $_has(1);
  @$pb.TagNumber(2)
  void clearEntity() => $_clearField(2);
  @$pb.TagNumber(2)
  TenantCreateUpdate ensureEntity() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get etag => $_getSZ(2);
  @$pb.TagNumber(3)
  set etag($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEtag() => $_has(2);
  @$pb.TagNumber(3)
  void clearEtag() => $_clearField(3);
}

class TenantInviteReadCreateUpdate extends $pb.GeneratedMessage {
  factory TenantInviteReadCreateUpdate({
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

  TenantInviteReadCreateUpdate._();

  factory TenantInviteReadCreateUpdate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TenantInviteReadCreateUpdate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TenantInviteReadCreateUpdate',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.tenant'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aI(2, _omitFieldNames ? '' : 'code')
    ..aOB(3, _omitFieldNames ? '' : 'multiple')
    ..aOM<$4.Timestamp>(4, _omitFieldNames ? '' : 'timeToLiveAt',
        subBuilder: $4.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TenantInviteReadCreateUpdate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TenantInviteReadCreateUpdate copyWith(
          void Function(TenantInviteReadCreateUpdate) updates) =>
      super.copyWith(
              (message) => updates(message as TenantInviteReadCreateUpdate))
          as TenantInviteReadCreateUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TenantInviteReadCreateUpdate create() =>
      TenantInviteReadCreateUpdate._();
  @$core.override
  TenantInviteReadCreateUpdate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TenantInviteReadCreateUpdate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TenantInviteReadCreateUpdate>(create);
  static TenantInviteReadCreateUpdate? _defaultInstance;

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

class TenantUserReadCreateUpdate extends $pb.GeneratedMessage {
  factory TenantUserReadCreateUpdate({
    $core.String? id,
    $3.StringValue? userId,
    $3.StringValue? name,
    $3.StringValue? shortName,
    $core.bool? administrator,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (name != null) result.name = name;
    if (shortName != null) result.shortName = shortName;
    if (administrator != null) result.administrator = administrator;
    return result;
  }

  TenantUserReadCreateUpdate._();

  factory TenantUserReadCreateUpdate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TenantUserReadCreateUpdate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TenantUserReadCreateUpdate',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.tenant'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<$3.StringValue>(2, _omitFieldNames ? '' : 'userId',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(3, _omitFieldNames ? '' : 'name',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(4, _omitFieldNames ? '' : 'shortName',
        subBuilder: $3.StringValue.create)
    ..aOB(5, _omitFieldNames ? '' : 'administrator')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TenantUserReadCreateUpdate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TenantUserReadCreateUpdate copyWith(
          void Function(TenantUserReadCreateUpdate) updates) =>
      super.copyWith(
              (message) => updates(message as TenantUserReadCreateUpdate))
          as TenantUserReadCreateUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TenantUserReadCreateUpdate create() => TenantUserReadCreateUpdate._();
  @$core.override
  TenantUserReadCreateUpdate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TenantUserReadCreateUpdate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TenantUserReadCreateUpdate>(create);
  static TenantUserReadCreateUpdate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $3.StringValue get userId => $_getN(1);
  @$pb.TagNumber(2)
  set userId($3.StringValue value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);
  @$pb.TagNumber(2)
  $3.StringValue ensureUserId() => $_ensure(1);

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

  @$pb.TagNumber(4)
  $3.StringValue get shortName => $_getN(3);
  @$pb.TagNumber(4)
  set shortName($3.StringValue value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasShortName() => $_has(3);
  @$pb.TagNumber(4)
  void clearShortName() => $_clearField(4);
  @$pb.TagNumber(4)
  $3.StringValue ensureShortName() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.bool get administrator => $_getBF(4);
  @$pb.TagNumber(5)
  set administrator($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAdministrator() => $_has(4);
  @$pb.TagNumber(5)
  void clearAdministrator() => $_clearField(5);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
