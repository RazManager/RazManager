// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/heat.service.v1.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'heat.v1.pbenum.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class HeatCommandRequest extends $pb.GeneratedMessage {
  factory HeatCommandRequest({
    $core.String? id,
    $1.HeatCommandTypeId? heatCommandTypeId,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (heatCommandTypeId != null) result.heatCommandTypeId = heatCommandTypeId;
    return result;
  }

  HeatCommandRequest._();

  factory HeatCommandRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HeatCommandRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HeatCommandRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aE<$1.HeatCommandTypeId>(2, _omitFieldNames ? '' : 'heatCommandTypeId',
        enumValues: $1.HeatCommandTypeId.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatCommandRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatCommandRequest copyWith(void Function(HeatCommandRequest) updates) =>
      super.copyWith((message) => updates(message as HeatCommandRequest))
          as HeatCommandRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HeatCommandRequest create() => HeatCommandRequest._();
  @$core.override
  HeatCommandRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HeatCommandRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HeatCommandRequest>(create);
  static HeatCommandRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.HeatCommandTypeId get heatCommandTypeId => $_getN(1);
  @$pb.TagNumber(2)
  set heatCommandTypeId($1.HeatCommandTypeId value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasHeatCommandTypeId() => $_has(1);
  @$pb.TagNumber(2)
  void clearHeatCommandTypeId() => $_clearField(2);
}

class HeatStintAnalysesRequest extends $pb.GeneratedMessage {
  factory HeatStintAnalysesRequest({
    $core.String? heatId,
    $core.int? indicatorId,
  }) {
    final result = create();
    if (heatId != null) result.heatId = heatId;
    if (indicatorId != null) result.indicatorId = indicatorId;
    return result;
  }

  HeatStintAnalysesRequest._();

  factory HeatStintAnalysesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HeatStintAnalysesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HeatStintAnalysesRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'heatId')
    ..aI(2, _omitFieldNames ? '' : 'indicatorId',
        fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatStintAnalysesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatStintAnalysesRequest copyWith(
          void Function(HeatStintAnalysesRequest) updates) =>
      super.copyWith((message) => updates(message as HeatStintAnalysesRequest))
          as HeatStintAnalysesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HeatStintAnalysesRequest create() => HeatStintAnalysesRequest._();
  @$core.override
  HeatStintAnalysesRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HeatStintAnalysesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HeatStintAnalysesRequest>(create);
  static HeatStintAnalysesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get heatId => $_getSZ(0);
  @$pb.TagNumber(1)
  set heatId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasHeatId() => $_has(0);
  @$pb.TagNumber(1)
  void clearHeatId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get indicatorId => $_getIZ(1);
  @$pb.TagNumber(2)
  set indicatorId($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIndicatorId() => $_has(1);
  @$pb.TagNumber(2)
  void clearIndicatorId() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
