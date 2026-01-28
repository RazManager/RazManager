// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/race.service.v1.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'race.v1.pbenum.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class RaceCommandRequest extends $pb.GeneratedMessage {
  factory RaceCommandRequest({
    $core.String? id,
    $1.RaceCommandTypeId? raceCommandTypeId,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (raceCommandTypeId != null) result.raceCommandTypeId = raceCommandTypeId;
    return result;
  }

  RaceCommandRequest._();

  factory RaceCommandRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RaceCommandRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RaceCommandRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aE<$1.RaceCommandTypeId>(2, _omitFieldNames ? '' : 'raceCommandTypeId',
        enumValues: $1.RaceCommandTypeId.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceCommandRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RaceCommandRequest copyWith(void Function(RaceCommandRequest) updates) =>
      super.copyWith((message) => updates(message as RaceCommandRequest))
          as RaceCommandRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RaceCommandRequest create() => RaceCommandRequest._();
  @$core.override
  RaceCommandRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RaceCommandRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RaceCommandRequest>(create);
  static RaceCommandRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.RaceCommandTypeId get raceCommandTypeId => $_getN(1);
  @$pb.TagNumber(2)
  set raceCommandTypeId($1.RaceCommandTypeId value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasRaceCommandTypeId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRaceCommandTypeId() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
