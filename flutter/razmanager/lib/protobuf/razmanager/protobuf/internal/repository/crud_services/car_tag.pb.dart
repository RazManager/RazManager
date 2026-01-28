// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/car_tag.proto.

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

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class CarTagReadResponse extends $pb.GeneratedMessage {
  factory CarTagReadResponse({
    CarTagRead? entity,
    $core.String? etag,
  }) {
    final result = create();
    if (entity != null) result.entity = entity;
    if (etag != null) result.etag = etag;
    return result;
  }

  CarTagReadResponse._();

  factory CarTagReadResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CarTagReadResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CarTagReadResponse',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.car_tag'),
      createEmptyInstance: create)
    ..aOM<CarTagRead>(1, _omitFieldNames ? '' : 'entity',
        subBuilder: CarTagRead.create)
    ..aOS(2, _omitFieldNames ? '' : 'etag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarTagReadResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarTagReadResponse copyWith(void Function(CarTagReadResponse) updates) =>
      super.copyWith((message) => updates(message as CarTagReadResponse))
          as CarTagReadResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CarTagReadResponse create() => CarTagReadResponse._();
  @$core.override
  CarTagReadResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CarTagReadResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CarTagReadResponse>(create);
  static CarTagReadResponse? _defaultInstance;

  @$pb.TagNumber(1)
  CarTagRead get entity => $_getN(0);
  @$pb.TagNumber(1)
  set entity(CarTagRead value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasEntity() => $_has(0);
  @$pb.TagNumber(1)
  void clearEntity() => $_clearField(1);
  @$pb.TagNumber(1)
  CarTagRead ensureEntity() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get etag => $_getSZ(1);
  @$pb.TagNumber(2)
  set etag($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEtag() => $_has(1);
  @$pb.TagNumber(2)
  void clearEtag() => $_clearField(2);
}

class CarTagRead extends $pb.GeneratedMessage {
  factory CarTagRead({
    $3.StringValue? id,
    $3.StringValue? name,
    $3.StringValue? description,
    $core.int? position,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (position != null) result.position = position;
    return result;
  }

  CarTagRead._();

  factory CarTagRead.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CarTagRead.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CarTagRead',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.car_tag'),
      createEmptyInstance: create)
    ..aOM<$3.StringValue>(1, _omitFieldNames ? '' : 'id',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(2, _omitFieldNames ? '' : 'name',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(3, _omitFieldNames ? '' : 'description',
        subBuilder: $3.StringValue.create)
    ..aI(4, _omitFieldNames ? '' : 'position', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarTagRead clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarTagRead copyWith(void Function(CarTagRead) updates) =>
      super.copyWith((message) => updates(message as CarTagRead)) as CarTagRead;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CarTagRead create() => CarTagRead._();
  @$core.override
  CarTagRead createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CarTagRead getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CarTagRead>(create);
  static CarTagRead? _defaultInstance;

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
  $core.int get position => $_getIZ(3);
  @$pb.TagNumber(4)
  set position($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPosition() => $_has(3);
  @$pb.TagNumber(4)
  void clearPosition() => $_clearField(4);
}

class CarTagCreateUpdate extends $pb.GeneratedMessage {
  factory CarTagCreateUpdate({
    $core.String? name,
    $3.StringValue? description,
    $core.int? position,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (position != null) result.position = position;
    return result;
  }

  CarTagCreateUpdate._();

  factory CarTagCreateUpdate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CarTagCreateUpdate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CarTagCreateUpdate',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.car_tag'),
      createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOM<$3.StringValue>(3, _omitFieldNames ? '' : 'description',
        subBuilder: $3.StringValue.create)
    ..aI(4, _omitFieldNames ? '' : 'position', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarTagCreateUpdate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarTagCreateUpdate copyWith(void Function(CarTagCreateUpdate) updates) =>
      super.copyWith((message) => updates(message as CarTagCreateUpdate))
          as CarTagCreateUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CarTagCreateUpdate create() => CarTagCreateUpdate._();
  @$core.override
  CarTagCreateUpdate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CarTagCreateUpdate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CarTagCreateUpdate>(create);
  static CarTagCreateUpdate? _defaultInstance;

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
  $core.int get position => $_getIZ(2);
  @$pb.TagNumber(4)
  set position($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(4)
  $core.bool hasPosition() => $_has(2);
  @$pb.TagNumber(4)
  void clearPosition() => $_clearField(4);
}

class CarTagUpdateRequest extends $pb.GeneratedMessage {
  factory CarTagUpdateRequest({
    $core.String? id,
    CarTagCreateUpdate? entity,
    $core.String? etag,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (entity != null) result.entity = entity;
    if (etag != null) result.etag = etag;
    return result;
  }

  CarTagUpdateRequest._();

  factory CarTagUpdateRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CarTagUpdateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CarTagUpdateRequest',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.car_tag'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<CarTagCreateUpdate>(2, _omitFieldNames ? '' : 'entity',
        subBuilder: CarTagCreateUpdate.create)
    ..aOS(3, _omitFieldNames ? '' : 'etag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarTagUpdateRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarTagUpdateRequest copyWith(void Function(CarTagUpdateRequest) updates) =>
      super.copyWith((message) => updates(message as CarTagUpdateRequest))
          as CarTagUpdateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CarTagUpdateRequest create() => CarTagUpdateRequest._();
  @$core.override
  CarTagUpdateRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CarTagUpdateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CarTagUpdateRequest>(create);
  static CarTagUpdateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  CarTagCreateUpdate get entity => $_getN(1);
  @$pb.TagNumber(2)
  set entity(CarTagCreateUpdate value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEntity() => $_has(1);
  @$pb.TagNumber(2)
  void clearEntity() => $_clearField(2);
  @$pb.TagNumber(2)
  CarTagCreateUpdate ensureEntity() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get etag => $_getSZ(2);
  @$pb.TagNumber(3)
  set etag($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEtag() => $_has(2);
  @$pb.TagNumber(3)
  void clearEtag() => $_clearField(3);
}

class CarTagList extends $pb.GeneratedMessage {
  factory CarTagList({
    $core.String? id,
    $core.String? name,
    $3.StringValue? description,
    $core.String? etag,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (etag != null) result.etag = etag;
    return result;
  }

  CarTagList._();

  factory CarTagList.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CarTagList.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CarTagList',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.car_tag'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOM<$3.StringValue>(3, _omitFieldNames ? '' : 'description',
        subBuilder: $3.StringValue.create)
    ..aOS(4, _omitFieldNames ? '' : 'etag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarTagList clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarTagList copyWith(void Function(CarTagList) updates) =>
      super.copyWith((message) => updates(message as CarTagList)) as CarTagList;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CarTagList create() => CarTagList._();
  @$core.override
  CarTagList createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CarTagList getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CarTagList>(create);
  static CarTagList? _defaultInstance;

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
  $core.String get etag => $_getSZ(3);
  @$pb.TagNumber(4)
  set etag($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasEtag() => $_has(3);
  @$pb.TagNumber(4)
  void clearEtag() => $_clearField(4);
}

class CarTagListResponse extends $pb.GeneratedMessage {
  factory CarTagListResponse({
    $core.Iterable<CarTagList>? result,
  }) {
    final result$ = create();
    if (result != null) result$.result.addAll(result);
    return result$;
  }

  CarTagListResponse._();

  factory CarTagListResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CarTagListResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CarTagListResponse',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.car_tag'),
      createEmptyInstance: create)
    ..pPM<CarTagList>(1, _omitFieldNames ? '' : 'result',
        subBuilder: CarTagList.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarTagListResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarTagListResponse copyWith(void Function(CarTagListResponse) updates) =>
      super.copyWith((message) => updates(message as CarTagListResponse))
          as CarTagListResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CarTagListResponse create() => CarTagListResponse._();
  @$core.override
  CarTagListResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CarTagListResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CarTagListResponse>(create);
  static CarTagListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<CarTagList> get result => $_getList(0);
}

class CarTagSelect extends $pb.GeneratedMessage {
  factory CarTagSelect({
    $core.String? id,
    $core.String? name,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    return result;
  }

  CarTagSelect._();

  factory CarTagSelect.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CarTagSelect.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CarTagSelect',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.car_tag'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarTagSelect clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarTagSelect copyWith(void Function(CarTagSelect) updates) =>
      super.copyWith((message) => updates(message as CarTagSelect))
          as CarTagSelect;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CarTagSelect create() => CarTagSelect._();
  @$core.override
  CarTagSelect createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CarTagSelect getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CarTagSelect>(create);
  static CarTagSelect? _defaultInstance;

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

class CarTagSelectResponse extends $pb.GeneratedMessage {
  factory CarTagSelectResponse({
    $core.Iterable<CarTagSelect>? result,
  }) {
    final result$ = create();
    if (result != null) result$.result.addAll(result);
    return result$;
  }

  CarTagSelectResponse._();

  factory CarTagSelectResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CarTagSelectResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CarTagSelectResponse',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.car_tag'),
      createEmptyInstance: create)
    ..pPM<CarTagSelect>(1, _omitFieldNames ? '' : 'result',
        subBuilder: CarTagSelect.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarTagSelectResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarTagSelectResponse copyWith(void Function(CarTagSelectResponse) updates) =>
      super.copyWith((message) => updates(message as CarTagSelectResponse))
          as CarTagSelectResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CarTagSelectResponse create() => CarTagSelectResponse._();
  @$core.override
  CarTagSelectResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CarTagSelectResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CarTagSelectResponse>(create);
  static CarTagSelectResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<CarTagSelect> get result => $_getList(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
