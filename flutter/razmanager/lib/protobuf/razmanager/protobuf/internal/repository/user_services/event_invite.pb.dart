// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/user_services/event_invite.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../../public/event_user_type_id.v1.pbenum.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class EventInviteCreate extends $pb.GeneratedMessage {
  factory EventInviteCreate({
    $core.int? code,
    $2.EventUserTypeId? eventUserTypeId,
  }) {
    final result = create();
    if (code != null) result.code = code;
    if (eventUserTypeId != null) result.eventUserTypeId = eventUserTypeId;
    return result;
  }

  EventInviteCreate._();

  factory EventInviteCreate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventInviteCreate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventInviteCreate',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.user_services.event_invite'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'code')
    ..aE<$2.EventUserTypeId>(2, _omitFieldNames ? '' : 'eventUserTypeId',
        enumValues: $2.EventUserTypeId.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventInviteCreate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventInviteCreate copyWith(void Function(EventInviteCreate) updates) =>
      super.copyWith((message) => updates(message as EventInviteCreate))
          as EventInviteCreate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventInviteCreate create() => EventInviteCreate._();
  @$core.override
  EventInviteCreate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EventInviteCreate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EventInviteCreate>(create);
  static EventInviteCreate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get code => $_getIZ(0);
  @$pb.TagNumber(1)
  set code($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $2.EventUserTypeId get eventUserTypeId => $_getN(1);
  @$pb.TagNumber(2)
  set eventUserTypeId($2.EventUserTypeId value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEventUserTypeId() => $_has(1);
  @$pb.TagNumber(2)
  void clearEventUserTypeId() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
