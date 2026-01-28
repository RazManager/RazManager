// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/user_services/heat_indicator.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../../public/event_user_type_id.v1.pbenum.dart' as $3;
import '../crud_services/event.pb.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class HeatIndicatorRead extends $pb.GeneratedMessage {
  factory HeatIndicatorRead({
    $core.String? id,
    $3.EventUserTypeId? eventUserTypeId,
    $core.Iterable<$2.EventUserSelect>? eventUsers,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (eventUserTypeId != null) result.eventUserTypeId = eventUserTypeId;
    if (eventUsers != null) result.eventUsers.addAll(eventUsers);
    return result;
  }

  HeatIndicatorRead._();

  factory HeatIndicatorRead.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HeatIndicatorRead.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HeatIndicatorRead',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.user_services.heat_indicator'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aE<$3.EventUserTypeId>(2, _omitFieldNames ? '' : 'eventUserTypeId',
        enumValues: $3.EventUserTypeId.values)
    ..pPM<$2.EventUserSelect>(3, _omitFieldNames ? '' : 'eventUsers',
        subBuilder: $2.EventUserSelect.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatIndicatorRead clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatIndicatorRead copyWith(void Function(HeatIndicatorRead) updates) =>
      super.copyWith((message) => updates(message as HeatIndicatorRead))
          as HeatIndicatorRead;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HeatIndicatorRead create() => HeatIndicatorRead._();
  @$core.override
  HeatIndicatorRead createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HeatIndicatorRead getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HeatIndicatorRead>(create);
  static HeatIndicatorRead? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $3.EventUserTypeId get eventUserTypeId => $_getN(1);
  @$pb.TagNumber(2)
  set eventUserTypeId($3.EventUserTypeId value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEventUserTypeId() => $_has(1);
  @$pb.TagNumber(2)
  void clearEventUserTypeId() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$2.EventUserSelect> get eventUsers => $_getList(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
