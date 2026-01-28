// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/user.proto.

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

import '../user_services/event.pb.dart' as $4;
import '../user_services/tenant.pb.dart' as $5;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class UserReadResponse extends $pb.GeneratedMessage {
  factory UserReadResponse({
    UserRead? entity,
    $core.String? etag,
  }) {
    final result = create();
    if (entity != null) result.entity = entity;
    if (etag != null) result.etag = etag;
    return result;
  }

  UserReadResponse._();

  factory UserReadResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserReadResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserReadResponse',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.user'),
      createEmptyInstance: create)
    ..aOM<UserRead>(1, _omitFieldNames ? '' : 'entity',
        subBuilder: UserRead.create)
    ..aOS(2, _omitFieldNames ? '' : 'etag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserReadResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserReadResponse copyWith(void Function(UserReadResponse) updates) =>
      super.copyWith((message) => updates(message as UserReadResponse))
          as UserReadResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserReadResponse create() => UserReadResponse._();
  @$core.override
  UserReadResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UserReadResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserReadResponse>(create);
  static UserReadResponse? _defaultInstance;

  @$pb.TagNumber(1)
  UserRead get entity => $_getN(0);
  @$pb.TagNumber(1)
  set entity(UserRead value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasEntity() => $_has(0);
  @$pb.TagNumber(1)
  void clearEntity() => $_clearField(1);
  @$pb.TagNumber(1)
  UserRead ensureEntity() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get etag => $_getSZ(1);
  @$pb.TagNumber(2)
  set etag($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEtag() => $_has(1);
  @$pb.TagNumber(2)
  void clearEtag() => $_clearField(2);
}

class UserRead extends $pb.GeneratedMessage {
  factory UserRead({
    $core.String? id,
    $3.StringValue? userName,
    $3.StringValue? email,
    $3.StringValue? name,
    $3.StringValue? shortName,
    $3.BytesValue? image,
    $core.Iterable<$4.EventSelect>? events,
    $core.Iterable<$5.TenantSelect>? tenants,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userName != null) result.userName = userName;
    if (email != null) result.email = email;
    if (name != null) result.name = name;
    if (shortName != null) result.shortName = shortName;
    if (image != null) result.image = image;
    if (events != null) result.events.addAll(events);
    if (tenants != null) result.tenants.addAll(tenants);
    return result;
  }

  UserRead._();

  factory UserRead.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserRead.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserRead',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.user'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<$3.StringValue>(2, _omitFieldNames ? '' : 'userName',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(3, _omitFieldNames ? '' : 'email',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(4, _omitFieldNames ? '' : 'name',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(5, _omitFieldNames ? '' : 'shortName',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.BytesValue>(6, _omitFieldNames ? '' : 'image',
        subBuilder: $3.BytesValue.create)
    ..pPM<$4.EventSelect>(7, _omitFieldNames ? '' : 'events',
        subBuilder: $4.EventSelect.create)
    ..pPM<$5.TenantSelect>(8, _omitFieldNames ? '' : 'tenants',
        subBuilder: $5.TenantSelect.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserRead clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserRead copyWith(void Function(UserRead) updates) =>
      super.copyWith((message) => updates(message as UserRead)) as UserRead;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserRead create() => UserRead._();
  @$core.override
  UserRead createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UserRead getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserRead>(create);
  static UserRead? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $3.StringValue get userName => $_getN(1);
  @$pb.TagNumber(2)
  set userName($3.StringValue value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasUserName() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserName() => $_clearField(2);
  @$pb.TagNumber(2)
  $3.StringValue ensureUserName() => $_ensure(1);

  @$pb.TagNumber(3)
  $3.StringValue get email => $_getN(2);
  @$pb.TagNumber(3)
  set email($3.StringValue value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => $_clearField(3);
  @$pb.TagNumber(3)
  $3.StringValue ensureEmail() => $_ensure(2);

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
  $3.StringValue get shortName => $_getN(4);
  @$pb.TagNumber(5)
  set shortName($3.StringValue value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasShortName() => $_has(4);
  @$pb.TagNumber(5)
  void clearShortName() => $_clearField(5);
  @$pb.TagNumber(5)
  $3.StringValue ensureShortName() => $_ensure(4);

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
  $pb.PbList<$4.EventSelect> get events => $_getList(6);

  @$pb.TagNumber(8)
  $pb.PbList<$5.TenantSelect> get tenants => $_getList(7);
}

class UserCreate extends $pb.GeneratedMessage {
  factory UserCreate({
    $core.String? userName,
    $3.StringValue? email,
    $core.String? name,
    $core.String? shortName,
    $core.List<$core.int>? image,
    $core.String? password,
  }) {
    final result = create();
    if (userName != null) result.userName = userName;
    if (email != null) result.email = email;
    if (name != null) result.name = name;
    if (shortName != null) result.shortName = shortName;
    if (image != null) result.image = image;
    if (password != null) result.password = password;
    return result;
  }

  UserCreate._();

  factory UserCreate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserCreate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserCreate',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.user'),
      createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'userName')
    ..aOM<$3.StringValue>(3, _omitFieldNames ? '' : 'email',
        subBuilder: $3.StringValue.create)
    ..aOS(4, _omitFieldNames ? '' : 'name')
    ..aOS(5, _omitFieldNames ? '' : 'shortName')
    ..a<$core.List<$core.int>>(
        6, _omitFieldNames ? '' : 'image', $pb.PbFieldType.OY)
    ..aOS(7, _omitFieldNames ? '' : 'password')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserCreate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserCreate copyWith(void Function(UserCreate) updates) =>
      super.copyWith((message) => updates(message as UserCreate)) as UserCreate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserCreate create() => UserCreate._();
  @$core.override
  UserCreate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UserCreate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserCreate>(create);
  static UserCreate? _defaultInstance;

  @$pb.TagNumber(2)
  $core.String get userName => $_getSZ(0);
  @$pb.TagNumber(2)
  set userName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(2)
  $core.bool hasUserName() => $_has(0);
  @$pb.TagNumber(2)
  void clearUserName() => $_clearField(2);

  @$pb.TagNumber(3)
  $3.StringValue get email => $_getN(1);
  @$pb.TagNumber(3)
  set email($3.StringValue value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(3)
  void clearEmail() => $_clearField(3);
  @$pb.TagNumber(3)
  $3.StringValue ensureEmail() => $_ensure(1);

  @$pb.TagNumber(4)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(4)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(4)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(4)
  void clearName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get shortName => $_getSZ(3);
  @$pb.TagNumber(5)
  set shortName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(5)
  $core.bool hasShortName() => $_has(3);
  @$pb.TagNumber(5)
  void clearShortName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.int> get image => $_getN(4);
  @$pb.TagNumber(6)
  set image($core.List<$core.int> value) => $_setBytes(4, value);
  @$pb.TagNumber(6)
  $core.bool hasImage() => $_has(4);
  @$pb.TagNumber(6)
  void clearImage() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get password => $_getSZ(5);
  @$pb.TagNumber(7)
  set password($core.String value) => $_setString(5, value);
  @$pb.TagNumber(7)
  $core.bool hasPassword() => $_has(5);
  @$pb.TagNumber(7)
  void clearPassword() => $_clearField(7);
}

class UserUpdate extends $pb.GeneratedMessage {
  factory UserUpdate({
    $3.StringValue? email,
    $core.String? name,
    $core.String? shortName,
    $core.List<$core.int>? image,
    $core.bool? imageDeleted,
    $core.Iterable<$core.String>? eventsDeleted,
    $core.Iterable<$core.String>? tenantsDeleted,
  }) {
    final result = create();
    if (email != null) result.email = email;
    if (name != null) result.name = name;
    if (shortName != null) result.shortName = shortName;
    if (image != null) result.image = image;
    if (imageDeleted != null) result.imageDeleted = imageDeleted;
    if (eventsDeleted != null) result.eventsDeleted.addAll(eventsDeleted);
    if (tenantsDeleted != null) result.tenantsDeleted.addAll(tenantsDeleted);
    return result;
  }

  UserUpdate._();

  factory UserUpdate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserUpdate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserUpdate',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.user'),
      createEmptyInstance: create)
    ..aOM<$3.StringValue>(3, _omitFieldNames ? '' : 'email',
        subBuilder: $3.StringValue.create)
    ..aOS(4, _omitFieldNames ? '' : 'name')
    ..aOS(5, _omitFieldNames ? '' : 'shortName')
    ..a<$core.List<$core.int>>(
        6, _omitFieldNames ? '' : 'image', $pb.PbFieldType.OY)
    ..aOB(7, _omitFieldNames ? '' : 'imageDeleted')
    ..pPS(8, _omitFieldNames ? '' : 'eventsDeleted')
    ..pPS(9, _omitFieldNames ? '' : 'tenantsDeleted')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserUpdate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserUpdate copyWith(void Function(UserUpdate) updates) =>
      super.copyWith((message) => updates(message as UserUpdate)) as UserUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserUpdate create() => UserUpdate._();
  @$core.override
  UserUpdate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UserUpdate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserUpdate>(create);
  static UserUpdate? _defaultInstance;

  @$pb.TagNumber(3)
  $3.StringValue get email => $_getN(0);
  @$pb.TagNumber(3)
  set email($3.StringValue value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(3)
  void clearEmail() => $_clearField(3);
  @$pb.TagNumber(3)
  $3.StringValue ensureEmail() => $_ensure(0);

  @$pb.TagNumber(4)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(4)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(4)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(4)
  void clearName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get shortName => $_getSZ(2);
  @$pb.TagNumber(5)
  set shortName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(5)
  $core.bool hasShortName() => $_has(2);
  @$pb.TagNumber(5)
  void clearShortName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.int> get image => $_getN(3);
  @$pb.TagNumber(6)
  set image($core.List<$core.int> value) => $_setBytes(3, value);
  @$pb.TagNumber(6)
  $core.bool hasImage() => $_has(3);
  @$pb.TagNumber(6)
  void clearImage() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get imageDeleted => $_getBF(4);
  @$pb.TagNumber(7)
  set imageDeleted($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(7)
  $core.bool hasImageDeleted() => $_has(4);
  @$pb.TagNumber(7)
  void clearImageDeleted() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<$core.String> get eventsDeleted => $_getList(5);

  @$pb.TagNumber(9)
  $pb.PbList<$core.String> get tenantsDeleted => $_getList(6);
}

class UserUpdateRequest extends $pb.GeneratedMessage {
  factory UserUpdateRequest({
    UserUpdate? entity,
    $core.String? etag,
  }) {
    final result = create();
    if (entity != null) result.entity = entity;
    if (etag != null) result.etag = etag;
    return result;
  }

  UserUpdateRequest._();

  factory UserUpdateRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserUpdateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserUpdateRequest',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.user'),
      createEmptyInstance: create)
    ..aOM<UserUpdate>(2, _omitFieldNames ? '' : 'entity',
        subBuilder: UserUpdate.create)
    ..aOS(3, _omitFieldNames ? '' : 'etag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserUpdateRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserUpdateRequest copyWith(void Function(UserUpdateRequest) updates) =>
      super.copyWith((message) => updates(message as UserUpdateRequest))
          as UserUpdateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserUpdateRequest create() => UserUpdateRequest._();
  @$core.override
  UserUpdateRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UserUpdateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserUpdateRequest>(create);
  static UserUpdateRequest? _defaultInstance;

  @$pb.TagNumber(2)
  UserUpdate get entity => $_getN(0);
  @$pb.TagNumber(2)
  set entity(UserUpdate value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEntity() => $_has(0);
  @$pb.TagNumber(2)
  void clearEntity() => $_clearField(2);
  @$pb.TagNumber(2)
  UserUpdate ensureEntity() => $_ensure(0);

  @$pb.TagNumber(3)
  $core.String get etag => $_getSZ(1);
  @$pb.TagNumber(3)
  set etag($core.String value) => $_setString(1, value);
  @$pb.TagNumber(3)
  $core.bool hasEtag() => $_has(1);
  @$pb.TagNumber(3)
  void clearEtag() => $_clearField(3);
}

class UserSelect extends $pb.GeneratedMessage {
  factory UserSelect({
    $core.String? id,
    $core.String? name,
    $core.String? shortName,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (shortName != null) result.shortName = shortName;
    return result;
  }

  UserSelect._();

  factory UserSelect.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserSelect.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserSelect',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.user'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'shortName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserSelect clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserSelect copyWith(void Function(UserSelect) updates) =>
      super.copyWith((message) => updates(message as UserSelect)) as UserSelect;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserSelect create() => UserSelect._();
  @$core.override
  UserSelect createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UserSelect getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserSelect>(create);
  static UserSelect? _defaultInstance;

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
  $core.String get shortName => $_getSZ(2);
  @$pb.TagNumber(3)
  set shortName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasShortName() => $_has(2);
  @$pb.TagNumber(3)
  void clearShortName() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
