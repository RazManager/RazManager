// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/event_user_type_id.v1.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class EventUserTypeId extends $pb.ProtobufEnum {
  static const EventUserTypeId EVENT_USER_TYPE_ID_UNDEFINED = EventUserTypeId._(
      0, _omitEnumNames ? '' : 'EVENT_USER_TYPE_ID_UNDEFINED');
  static const EventUserTypeId EVENT_USER_TYPE_ID_TEAM =
      EventUserTypeId._(1, _omitEnumNames ? '' : 'EVENT_USER_TYPE_ID_TEAM');
  static const EventUserTypeId EVENT_USER_TYPE_ID_DRIVER =
      EventUserTypeId._(2, _omitEnumNames ? '' : 'EVENT_USER_TYPE_ID_DRIVER');
  static const EventUserTypeId EVENT_USER_TYPE_ID_VIEWER =
      EventUserTypeId._(3, _omitEnumNames ? '' : 'EVENT_USER_TYPE_ID_VIEWER');

  static const $core.List<EventUserTypeId> values = <EventUserTypeId>[
    EVENT_USER_TYPE_ID_UNDEFINED,
    EVENT_USER_TYPE_ID_TEAM,
    EVENT_USER_TYPE_ID_DRIVER,
    EVENT_USER_TYPE_ID_VIEWER,
  ];

  static final $core.List<EventUserTypeId?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static EventUserTypeId? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const EventUserTypeId._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
