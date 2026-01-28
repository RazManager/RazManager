// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/event.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class EventVisibilityTypeId extends $pb.ProtobufEnum {
  static const EventVisibilityTypeId EVENT_VISIBILITY_TYPE_ID_UNDEFINED =
      EventVisibilityTypeId._(
          0, _omitEnumNames ? '' : 'EVENT_VISIBILITY_TYPE_ID_UNDEFINED');
  static const EventVisibilityTypeId EVENT_VISIBILITY_TYPE_ID_PUBLIC =
      EventVisibilityTypeId._(
          1, _omitEnumNames ? '' : 'EVENT_VISIBILITY_TYPE_ID_PUBLIC');
  static const EventVisibilityTypeId
      EVENT_VISIBILITY_TYPE_ID_MEMBERS_AND_GUESTS = EventVisibilityTypeId._(2,
          _omitEnumNames ? '' : 'EVENT_VISIBILITY_TYPE_ID_MEMBERS_AND_GUESTS');

  static const $core.List<EventVisibilityTypeId> values =
      <EventVisibilityTypeId>[
    EVENT_VISIBILITY_TYPE_ID_UNDEFINED,
    EVENT_VISIBILITY_TYPE_ID_PUBLIC,
    EVENT_VISIBILITY_TYPE_ID_MEMBERS_AND_GUESTS,
  ];

  static final $core.List<EventVisibilityTypeId?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static EventVisibilityTypeId? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const EventVisibilityTypeId._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
