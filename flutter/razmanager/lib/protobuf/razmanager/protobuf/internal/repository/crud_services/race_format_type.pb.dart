// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/race_format_type.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'race_format_type.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'race_format_type.pbenum.dart';

class RaceFormatTypeSelect extends $pb.GeneratedMessage {
  factory RaceFormatTypeSelect({
    RaceFormatTypeId? id,
    $core.String? name,
    $core.bool? indicatorEventUserCombined,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (indicatorEventUserCombined != null)
      result.indicatorEventUserCombined = indicatorEventUserCombined;
    return result;
  }

  RaceFormatTypeSelect._();

  factory RaceFormatTypeSelect.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RaceFormatTypeSelect.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RaceFormatTypeSelect',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.race_format_type'),
      createEmptyInstance: create)
    ..aE<RaceFormatTypeId>(1, _omitFieldNames ? '' : 'id',
        enumValues: RaceFormatTypeId.values)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOB(3, _omitFieldNames ? '' : 'indicatorEventUserCombined')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceFormatTypeSelect clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceFormatTypeSelect copyWith(void Function(RaceFormatTypeSelect) updates) =>
      super.copyWith((message) => updates(message as RaceFormatTypeSelect))
          as RaceFormatTypeSelect;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RaceFormatTypeSelect create() => RaceFormatTypeSelect._();
  @$core.override
  RaceFormatTypeSelect createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RaceFormatTypeSelect getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RaceFormatTypeSelect>(create);
  static RaceFormatTypeSelect? _defaultInstance;

  @$pb.TagNumber(1)
  RaceFormatTypeId get id => $_getN(0);
  @$pb.TagNumber(1)
  set id(RaceFormatTypeId value) => $_setField(1, value);
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
  $core.bool get indicatorEventUserCombined => $_getBF(2);
  @$pb.TagNumber(3)
  set indicatorEventUserCombined($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIndicatorEventUserCombined() => $_has(2);
  @$pb.TagNumber(3)
  void clearIndicatorEventUserCombined() => $_clearField(3);
}

class RaceFormatTypeSelectResponse extends $pb.GeneratedMessage {
  factory RaceFormatTypeSelectResponse({
    $core.Iterable<RaceFormatTypeSelect>? result,
  }) {
    final result$ = create();
    if (result != null) result$.result.addAll(result);
    return result$;
  }

  RaceFormatTypeSelectResponse._();

  factory RaceFormatTypeSelectResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RaceFormatTypeSelectResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RaceFormatTypeSelectResponse',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.crud_services.race_format_type'),
      createEmptyInstance: create)
    ..pPM<RaceFormatTypeSelect>(1, _omitFieldNames ? '' : 'result',
        subBuilder: RaceFormatTypeSelect.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceFormatTypeSelectResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceFormatTypeSelectResponse copyWith(
          void Function(RaceFormatTypeSelectResponse) updates) =>
      super.copyWith(
              (message) => updates(message as RaceFormatTypeSelectResponse))
          as RaceFormatTypeSelectResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RaceFormatTypeSelectResponse create() =>
      RaceFormatTypeSelectResponse._();
  @$core.override
  RaceFormatTypeSelectResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RaceFormatTypeSelectResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RaceFormatTypeSelectResponse>(create);
  static RaceFormatTypeSelectResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<RaceFormatTypeSelect> get result => $_getList(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
