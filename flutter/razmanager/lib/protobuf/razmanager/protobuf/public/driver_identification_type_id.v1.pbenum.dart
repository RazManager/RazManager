// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/driver_identification_type_id.v1.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class DriverIdentificationTypeId extends $pb.ProtobufEnum {
  static const DriverIdentificationTypeId
      DRIVER_IDENTIFICATION_TYPE_ID_INDICATOR = DriverIdentificationTypeId._(
          0, _omitEnumNames ? '' : 'DRIVER_IDENTIFICATION_TYPE_ID_INDICATOR');
  static const DriverIdentificationTypeId DRIVER_IDENTIFICATION_TYPE_ID_COLOR =
      DriverIdentificationTypeId._(
          1, _omitEnumNames ? '' : 'DRIVER_IDENTIFICATION_TYPE_ID_COLOR');
  static const DriverIdentificationTypeId
      DRIVER_IDENTIFICATION_TYPE_ID_INDICATOR_COLOR =
      DriverIdentificationTypeId._(
          2,
          _omitEnumNames
              ? ''
              : 'DRIVER_IDENTIFICATION_TYPE_ID_INDICATOR_COLOR');

  static const $core.List<DriverIdentificationTypeId> values =
      <DriverIdentificationTypeId>[
    DRIVER_IDENTIFICATION_TYPE_ID_INDICATOR,
    DRIVER_IDENTIFICATION_TYPE_ID_COLOR,
    DRIVER_IDENTIFICATION_TYPE_ID_INDICATOR_COLOR,
  ];

  static final $core.List<DriverIdentificationTypeId?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static DriverIdentificationTypeId? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const DriverIdentificationTypeId._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
