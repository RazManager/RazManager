// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/tenant_user.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart'
    as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class TenantUserSelectRequest extends $pb.GeneratedMessage {
  factory TenantUserSelectRequest({
    $core.Iterable<$core.String>? userIdsExclude,
    $core.Iterable<$core.String>? shortNamesExclude,
  }) {
    final result = create();
    if (userIdsExclude != null) result.userIdsExclude.addAll(userIdsExclude);
    if (shortNamesExclude != null)
      result.shortNamesExclude.addAll(shortNamesExclude);
    return result;
  }

  TenantUserSelectRequest._();

  factory TenantUserSelectRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TenantUserSelectRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TenantUserSelectRequest',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.tenant_user'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'userIdsExclude')
    ..pPS(2, _omitFieldNames ? '' : 'shortNamesExclude')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TenantUserSelectRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TenantUserSelectRequest copyWith(
          void Function(TenantUserSelectRequest) updates) =>
      super.copyWith((message) => updates(message as TenantUserSelectRequest))
          as TenantUserSelectRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TenantUserSelectRequest create() => TenantUserSelectRequest._();
  @$core.override
  TenantUserSelectRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TenantUserSelectRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TenantUserSelectRequest>(create);
  static TenantUserSelectRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get userIdsExclude => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get shortNamesExclude => $_getList(1);
}

class TenantUserSelectResponse extends $pb.GeneratedMessage {
  factory TenantUserSelectResponse({
    $core.Iterable<TenantUserSelect>? result,
  }) {
    final result$ = create();
    if (result != null) result$.result.addAll(result);
    return result$;
  }

  TenantUserSelectResponse._();

  factory TenantUserSelectResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TenantUserSelectResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TenantUserSelectResponse',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.tenant_user'),
      createEmptyInstance: create)
    ..pPM<TenantUserSelect>(1, _omitFieldNames ? '' : 'result',
        subBuilder: TenantUserSelect.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TenantUserSelectResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TenantUserSelectResponse copyWith(
          void Function(TenantUserSelectResponse) updates) =>
      super.copyWith((message) => updates(message as TenantUserSelectResponse))
          as TenantUserSelectResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TenantUserSelectResponse create() => TenantUserSelectResponse._();
  @$core.override
  TenantUserSelectResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TenantUserSelectResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TenantUserSelectResponse>(create);
  static TenantUserSelectResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TenantUserSelect> get result => $_getList(0);
}

class TenantUserSelect extends $pb.GeneratedMessage {
  factory TenantUserSelect({
    $core.String? id,
    $1.StringValue? userId,
    $core.String? name,
    $1.StringValue? shortName,
    $1.BytesValue? image,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (name != null) result.name = name;
    if (shortName != null) result.shortName = shortName;
    if (image != null) result.image = image;
    return result;
  }

  TenantUserSelect._();

  factory TenantUserSelect.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TenantUserSelect.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TenantUserSelect',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.tenant_user'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<$1.StringValue>(2, _omitFieldNames ? '' : 'userId',
        subBuilder: $1.StringValue.create)
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aOM<$1.StringValue>(4, _omitFieldNames ? '' : 'shortName',
        subBuilder: $1.StringValue.create)
    ..aOM<$1.BytesValue>(5, _omitFieldNames ? '' : 'image',
        subBuilder: $1.BytesValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TenantUserSelect clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TenantUserSelect copyWith(void Function(TenantUserSelect) updates) =>
      super.copyWith((message) => updates(message as TenantUserSelect))
          as TenantUserSelect;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TenantUserSelect create() => TenantUserSelect._();
  @$core.override
  TenantUserSelect createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TenantUserSelect getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TenantUserSelect>(create);
  static TenantUserSelect? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.StringValue get userId => $_getN(1);
  @$pb.TagNumber(2)
  set userId($1.StringValue value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.StringValue ensureUserId() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  $1.StringValue get shortName => $_getN(3);
  @$pb.TagNumber(4)
  set shortName($1.StringValue value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasShortName() => $_has(3);
  @$pb.TagNumber(4)
  void clearShortName() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.StringValue ensureShortName() => $_ensure(3);

  @$pb.TagNumber(5)
  $1.BytesValue get image => $_getN(4);
  @$pb.TagNumber(5)
  set image($1.BytesValue value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasImage() => $_has(4);
  @$pb.TagNumber(5)
  void clearImage() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.BytesValue ensureImage() => $_ensure(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
