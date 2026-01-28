// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/user_services/tenant.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart'
    as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class TenantRead extends $pb.GeneratedMessage {
  factory TenantRead({
    $core.String? id,
    $core.String? name,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
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
          : 'razmanager.protobuf.internal.repository.user_services.tenant'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
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
}

class TenantSelectResponse extends $pb.GeneratedMessage {
  factory TenantSelectResponse({
    $core.Iterable<TenantSelect>? result,
  }) {
    final result$ = create();
    if (result != null) result$.result.addAll(result);
    return result$;
  }

  TenantSelectResponse._();

  factory TenantSelectResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TenantSelectResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TenantSelectResponse',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.user_services.tenant'),
      createEmptyInstance: create)
    ..pPM<TenantSelect>(1, _omitFieldNames ? '' : 'result',
        subBuilder: TenantSelect.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TenantSelectResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TenantSelectResponse copyWith(void Function(TenantSelectResponse) updates) =>
      super.copyWith((message) => updates(message as TenantSelectResponse))
          as TenantSelectResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TenantSelectResponse create() => TenantSelectResponse._();
  @$core.override
  TenantSelectResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TenantSelectResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TenantSelectResponse>(create);
  static TenantSelectResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TenantSelect> get result => $_getList(0);
}

class TenantSelect extends $pb.GeneratedMessage {
  factory TenantSelect({
    $core.String? id,
    $core.String? name,
    $2.BytesValue? image,
    $core.bool? administrator,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (image != null) result.image = image;
    if (administrator != null) result.administrator = administrator;
    return result;
  }

  TenantSelect._();

  factory TenantSelect.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TenantSelect.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TenantSelect',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.user_services.tenant'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOM<$2.BytesValue>(3, _omitFieldNames ? '' : 'image',
        subBuilder: $2.BytesValue.create)
    ..aOB(4, _omitFieldNames ? '' : 'administrator')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TenantSelect clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TenantSelect copyWith(void Function(TenantSelect) updates) =>
      super.copyWith((message) => updates(message as TenantSelect))
          as TenantSelect;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TenantSelect create() => TenantSelect._();
  @$core.override
  TenantSelect createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TenantSelect getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TenantSelect>(create);
  static TenantSelect? _defaultInstance;

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
  $2.BytesValue get image => $_getN(2);
  @$pb.TagNumber(3)
  set image($2.BytesValue value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasImage() => $_has(2);
  @$pb.TagNumber(3)
  void clearImage() => $_clearField(3);
  @$pb.TagNumber(3)
  $2.BytesValue ensureImage() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.bool get administrator => $_getBF(3);
  @$pb.TagNumber(4)
  set administrator($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAdministrator() => $_has(3);
  @$pb.TagNumber(4)
  void clearAdministrator() => $_clearField(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
