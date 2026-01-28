// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/car.proto.

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

class CarReadResponse extends $pb.GeneratedMessage {
  factory CarReadResponse({
    CarRead? entity,
    $core.String? etag,
  }) {
    final result = create();
    if (entity != null) result.entity = entity;
    if (etag != null) result.etag = etag;
    return result;
  }

  CarReadResponse._();

  factory CarReadResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CarReadResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CarReadResponse',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.car'),
      createEmptyInstance: create)
    ..aOM<CarRead>(1, _omitFieldNames ? '' : 'entity',
        subBuilder: CarRead.create)
    ..aOS(2, _omitFieldNames ? '' : 'etag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarReadResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarReadResponse copyWith(void Function(CarReadResponse) updates) =>
      super.copyWith((message) => updates(message as CarReadResponse))
          as CarReadResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CarReadResponse create() => CarReadResponse._();
  @$core.override
  CarReadResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CarReadResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CarReadResponse>(create);
  static CarReadResponse? _defaultInstance;

  @$pb.TagNumber(1)
  CarRead get entity => $_getN(0);
  @$pb.TagNumber(1)
  set entity(CarRead value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasEntity() => $_has(0);
  @$pb.TagNumber(1)
  void clearEntity() => $_clearField(1);
  @$pb.TagNumber(1)
  CarRead ensureEntity() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get etag => $_getSZ(1);
  @$pb.TagNumber(2)
  set etag($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEtag() => $_has(1);
  @$pb.TagNumber(2)
  void clearEtag() => $_clearField(2);
}

class CarRead extends $pb.GeneratedMessage {
  factory CarRead({
    $3.StringValue? id,
    $3.StringValue? name,
    $3.UInt32Value? number,
    $3.StringValue? description,
    $core.Iterable<$core.String>? carTagIds,
    $core.Iterable<$core.String>? trackConfigurationIds,
    $3.BytesValue? image,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (number != null) result.number = number;
    if (description != null) result.description = description;
    if (carTagIds != null) result.carTagIds.addAll(carTagIds);
    if (trackConfigurationIds != null)
      result.trackConfigurationIds.addAll(trackConfigurationIds);
    if (image != null) result.image = image;
    return result;
  }

  CarRead._();

  factory CarRead.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CarRead.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CarRead',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.car'),
      createEmptyInstance: create)
    ..aOM<$3.StringValue>(1, _omitFieldNames ? '' : 'id',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(2, _omitFieldNames ? '' : 'name',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.UInt32Value>(3, _omitFieldNames ? '' : 'number',
        subBuilder: $3.UInt32Value.create)
    ..aOM<$3.StringValue>(4, _omitFieldNames ? '' : 'description',
        subBuilder: $3.StringValue.create)
    ..pPS(5, _omitFieldNames ? '' : 'carTagIds')
    ..pPS(6, _omitFieldNames ? '' : 'trackConfigurationIds')
    ..aOM<$3.BytesValue>(7, _omitFieldNames ? '' : 'image',
        subBuilder: $3.BytesValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarRead clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarRead copyWith(void Function(CarRead) updates) =>
      super.copyWith((message) => updates(message as CarRead)) as CarRead;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CarRead create() => CarRead._();
  @$core.override
  CarRead createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CarRead getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CarRead>(create);
  static CarRead? _defaultInstance;

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
  $3.UInt32Value get number => $_getN(2);
  @$pb.TagNumber(3)
  set number($3.UInt32Value value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearNumber() => $_clearField(3);
  @$pb.TagNumber(3)
  $3.UInt32Value ensureNumber() => $_ensure(2);

  @$pb.TagNumber(4)
  $3.StringValue get description => $_getN(3);
  @$pb.TagNumber(4)
  set description($3.StringValue value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);
  @$pb.TagNumber(4)
  $3.StringValue ensureDescription() => $_ensure(3);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get carTagIds => $_getList(4);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get trackConfigurationIds => $_getList(5);

  @$pb.TagNumber(7)
  $3.BytesValue get image => $_getN(6);
  @$pb.TagNumber(7)
  set image($3.BytesValue value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasImage() => $_has(6);
  @$pb.TagNumber(7)
  void clearImage() => $_clearField(7);
  @$pb.TagNumber(7)
  $3.BytesValue ensureImage() => $_ensure(6);
}

class CarCreateUpdate extends $pb.GeneratedMessage {
  factory CarCreateUpdate({
    $core.String? name,
    $3.UInt32Value? number,
    $3.StringValue? description,
    $core.Iterable<$core.String>? carTagIds,
    $core.Iterable<$core.String>? trackConfigurationIds,
    $core.List<$core.int>? image,
    $core.bool? imageDeleted,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (number != null) result.number = number;
    if (description != null) result.description = description;
    if (carTagIds != null) result.carTagIds.addAll(carTagIds);
    if (trackConfigurationIds != null)
      result.trackConfigurationIds.addAll(trackConfigurationIds);
    if (image != null) result.image = image;
    if (imageDeleted != null) result.imageDeleted = imageDeleted;
    return result;
  }

  CarCreateUpdate._();

  factory CarCreateUpdate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CarCreateUpdate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CarCreateUpdate',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.car'),
      createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOM<$3.UInt32Value>(3, _omitFieldNames ? '' : 'number',
        subBuilder: $3.UInt32Value.create)
    ..aOM<$3.StringValue>(4, _omitFieldNames ? '' : 'description',
        subBuilder: $3.StringValue.create)
    ..pPS(5, _omitFieldNames ? '' : 'carTagIds')
    ..pPS(6, _omitFieldNames ? '' : 'trackConfigurationIds')
    ..a<$core.List<$core.int>>(
        7, _omitFieldNames ? '' : 'image', $pb.PbFieldType.OY)
    ..aOB(8, _omitFieldNames ? '' : 'imageDeleted')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarCreateUpdate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarCreateUpdate copyWith(void Function(CarCreateUpdate) updates) =>
      super.copyWith((message) => updates(message as CarCreateUpdate))
          as CarCreateUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CarCreateUpdate create() => CarCreateUpdate._();
  @$core.override
  CarCreateUpdate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CarCreateUpdate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CarCreateUpdate>(create);
  static CarCreateUpdate? _defaultInstance;

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $3.UInt32Value get number => $_getN(1);
  @$pb.TagNumber(3)
  set number($3.UInt32Value value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasNumber() => $_has(1);
  @$pb.TagNumber(3)
  void clearNumber() => $_clearField(3);
  @$pb.TagNumber(3)
  $3.UInt32Value ensureNumber() => $_ensure(1);

  @$pb.TagNumber(4)
  $3.StringValue get description => $_getN(2);
  @$pb.TagNumber(4)
  set description($3.StringValue value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);
  @$pb.TagNumber(4)
  $3.StringValue ensureDescription() => $_ensure(2);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get carTagIds => $_getList(3);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get trackConfigurationIds => $_getList(4);

  @$pb.TagNumber(7)
  $core.List<$core.int> get image => $_getN(5);
  @$pb.TagNumber(7)
  set image($core.List<$core.int> value) => $_setBytes(5, value);
  @$pb.TagNumber(7)
  $core.bool hasImage() => $_has(5);
  @$pb.TagNumber(7)
  void clearImage() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get imageDeleted => $_getBF(6);
  @$pb.TagNumber(8)
  set imageDeleted($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(8)
  $core.bool hasImageDeleted() => $_has(6);
  @$pb.TagNumber(8)
  void clearImageDeleted() => $_clearField(8);
}

class CarUpdateRequest extends $pb.GeneratedMessage {
  factory CarUpdateRequest({
    $core.String? id,
    CarCreateUpdate? entity,
    $core.String? etag,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (entity != null) result.entity = entity;
    if (etag != null) result.etag = etag;
    return result;
  }

  CarUpdateRequest._();

  factory CarUpdateRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CarUpdateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CarUpdateRequest',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.car'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<CarCreateUpdate>(2, _omitFieldNames ? '' : 'entity',
        subBuilder: CarCreateUpdate.create)
    ..aOS(3, _omitFieldNames ? '' : 'etag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarUpdateRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarUpdateRequest copyWith(void Function(CarUpdateRequest) updates) =>
      super.copyWith((message) => updates(message as CarUpdateRequest))
          as CarUpdateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CarUpdateRequest create() => CarUpdateRequest._();
  @$core.override
  CarUpdateRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CarUpdateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CarUpdateRequest>(create);
  static CarUpdateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  CarCreateUpdate get entity => $_getN(1);
  @$pb.TagNumber(2)
  set entity(CarCreateUpdate value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEntity() => $_has(1);
  @$pb.TagNumber(2)
  void clearEntity() => $_clearField(2);
  @$pb.TagNumber(2)
  CarCreateUpdate ensureEntity() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get etag => $_getSZ(2);
  @$pb.TagNumber(3)
  set etag($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEtag() => $_has(2);
  @$pb.TagNumber(3)
  void clearEtag() => $_clearField(3);
}

class CarListRequest extends $pb.GeneratedMessage {
  factory CarListRequest({
    $core.int? limit,
    $core.int? offset,
    $core.Iterable<$core.String>? carTagIds,
  }) {
    final result = create();
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    if (carTagIds != null) result.carTagIds.addAll(carTagIds);
    return result;
  }

  CarListRequest._();

  factory CarListRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CarListRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CarListRequest',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.car'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'limit')
    ..aI(2, _omitFieldNames ? '' : 'offset')
    ..pPS(3, _omitFieldNames ? '' : 'carTagIds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarListRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarListRequest copyWith(void Function(CarListRequest) updates) =>
      super.copyWith((message) => updates(message as CarListRequest))
          as CarListRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CarListRequest create() => CarListRequest._();
  @$core.override
  CarListRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CarListRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CarListRequest>(create);
  static CarListRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(2)
  set offset($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffset() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get carTagIds => $_getList(2);
}

class CarListResponse extends $pb.GeneratedMessage {
  factory CarListResponse({
    $core.Iterable<CarList>? result,
  }) {
    final result$ = create();
    if (result != null) result$.result.addAll(result);
    return result$;
  }

  CarListResponse._();

  factory CarListResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CarListResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CarListResponse',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.car'),
      createEmptyInstance: create)
    ..pPM<CarList>(1, _omitFieldNames ? '' : 'result',
        subBuilder: CarList.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarListResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarListResponse copyWith(void Function(CarListResponse) updates) =>
      super.copyWith((message) => updates(message as CarListResponse))
          as CarListResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CarListResponse create() => CarListResponse._();
  @$core.override
  CarListResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CarListResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CarListResponse>(create);
  static CarListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<CarList> get result => $_getList(0);
}

class CarList extends $pb.GeneratedMessage {
  factory CarList({
    $core.String? id,
    $core.String? name,
    $3.UInt32Value? number,
    $3.StringValue? description,
    $core.String? carTagNames,
    $3.BytesValue? image,
    $core.String? etag,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (number != null) result.number = number;
    if (description != null) result.description = description;
    if (carTagNames != null) result.carTagNames = carTagNames;
    if (image != null) result.image = image;
    if (etag != null) result.etag = etag;
    return result;
  }

  CarList._();

  factory CarList.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CarList.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CarList',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.car'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOM<$3.UInt32Value>(3, _omitFieldNames ? '' : 'number',
        subBuilder: $3.UInt32Value.create)
    ..aOM<$3.StringValue>(4, _omitFieldNames ? '' : 'description',
        subBuilder: $3.StringValue.create)
    ..aOS(5, _omitFieldNames ? '' : 'carTagNames')
    ..aOM<$3.BytesValue>(6, _omitFieldNames ? '' : 'image',
        subBuilder: $3.BytesValue.create)
    ..aOS(7, _omitFieldNames ? '' : 'etag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarList clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarList copyWith(void Function(CarList) updates) =>
      super.copyWith((message) => updates(message as CarList)) as CarList;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CarList create() => CarList._();
  @$core.override
  CarList createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CarList getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CarList>(create);
  static CarList? _defaultInstance;

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
  $3.UInt32Value get number => $_getN(2);
  @$pb.TagNumber(3)
  set number($3.UInt32Value value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearNumber() => $_clearField(3);
  @$pb.TagNumber(3)
  $3.UInt32Value ensureNumber() => $_ensure(2);

  @$pb.TagNumber(4)
  $3.StringValue get description => $_getN(3);
  @$pb.TagNumber(4)
  set description($3.StringValue value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);
  @$pb.TagNumber(4)
  $3.StringValue ensureDescription() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get carTagNames => $_getSZ(4);
  @$pb.TagNumber(5)
  set carTagNames($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCarTagNames() => $_has(4);
  @$pb.TagNumber(5)
  void clearCarTagNames() => $_clearField(5);

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

class CarSelectResponse extends $pb.GeneratedMessage {
  factory CarSelectResponse({
    $core.Iterable<CarSelect>? result,
  }) {
    final result$ = create();
    if (result != null) result$.result.addAll(result);
    return result$;
  }

  CarSelectResponse._();

  factory CarSelectResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CarSelectResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CarSelectResponse',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.car'),
      createEmptyInstance: create)
    ..pPM<CarSelect>(1, _omitFieldNames ? '' : 'result',
        subBuilder: CarSelect.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarSelectResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarSelectResponse copyWith(void Function(CarSelectResponse) updates) =>
      super.copyWith((message) => updates(message as CarSelectResponse))
          as CarSelectResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CarSelectResponse create() => CarSelectResponse._();
  @$core.override
  CarSelectResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CarSelectResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CarSelectResponse>(create);
  static CarSelectResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<CarSelect> get result => $_getList(0);
}

class CarSelect extends $pb.GeneratedMessage {
  factory CarSelect({
    $core.String? id,
    $core.String? name,
    $3.BytesValue? image,
    $core.Iterable<$core.String>? carTagIds,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (image != null) result.image = image;
    if (carTagIds != null) result.carTagIds.addAll(carTagIds);
    return result;
  }

  CarSelect._();

  factory CarSelect.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CarSelect.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CarSelect',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.car'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOM<$3.BytesValue>(3, _omitFieldNames ? '' : 'image',
        subBuilder: $3.BytesValue.create)
    ..pPS(4, _omitFieldNames ? '' : 'carTagIds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarSelect clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CarSelect copyWith(void Function(CarSelect) updates) =>
      super.copyWith((message) => updates(message as CarSelect)) as CarSelect;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CarSelect create() => CarSelect._();
  @$core.override
  CarSelect createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CarSelect getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CarSelect>(create);
  static CarSelect? _defaultInstance;

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
  $3.BytesValue get image => $_getN(2);
  @$pb.TagNumber(3)
  set image($3.BytesValue value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasImage() => $_has(2);
  @$pb.TagNumber(3)
  void clearImage() => $_clearField(3);
  @$pb.TagNumber(3)
  $3.BytesValue ensureImage() => $_ensure(2);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get carTagIds => $_getList(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
