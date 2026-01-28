// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/session_type_id.v1.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class SessionTypeId extends $pb.ProtobufEnum {
  static const SessionTypeId SESSION_TYPE_ID_RACE =
      SessionTypeId._(0, _omitEnumNames ? '' : 'SESSION_TYPE_ID_RACE');
  static const SessionTypeId SESSION_TYPE_ID_QUALIFYING =
      SessionTypeId._(1, _omitEnumNames ? '' : 'SESSION_TYPE_ID_QUALIFYING');
  static const SessionTypeId SESSION_TYPE_ID_PRACTICE =
      SessionTypeId._(2, _omitEnumNames ? '' : 'SESSION_TYPE_ID_PRACTICE');

  static const $core.List<SessionTypeId> values = <SessionTypeId>[
    SESSION_TYPE_ID_RACE,
    SESSION_TYPE_ID_QUALIFYING,
    SESSION_TYPE_ID_PRACTICE,
  ];

  static final $core.List<SessionTypeId?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static SessionTypeId? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SessionTypeId._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
