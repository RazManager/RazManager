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

class RaceFormatTypeId extends $pb.ProtobufEnum {
  static const RaceFormatTypeId RACE_FORMAT_TYPE_ID_UNDEFINED =
      RaceFormatTypeId._(
          0, _omitEnumNames ? '' : 'RACE_FORMAT_TYPE_ID_UNDEFINED');
  static const RaceFormatTypeId RACE_FORMAT_TYPE_ID_ALL_DRIVERS_ALL_LANES_NEXT =
      RaceFormatTypeId._(
          1,
          _omitEnumNames
              ? ''
              : 'RACE_FORMAT_TYPE_ID_ALL_DRIVERS_ALL_LANES_NEXT');
  static const RaceFormatTypeId
      RACE_FORMAT_TYPE_ID_ALL_DRIVERS_ALL_LANES_SPREAD = RaceFormatTypeId._(
          2,
          _omitEnumNames
              ? ''
              : 'RACE_FORMAT_TYPE_ID_ALL_DRIVERS_ALL_LANES_SPREAD');
  static const RaceFormatTypeId
      RACE_FORMAT_TYPE_ID_ALL_DRIVERS_ALL_LANES_ALL_DRIVERS =
      RaceFormatTypeId._(
          3,
          _omitEnumNames
              ? ''
              : 'RACE_FORMAT_TYPE_ID_ALL_DRIVERS_ALL_LANES_ALL_DRIVERS');
  static const RaceFormatTypeId
      RACE_FORMAT_TYPE_ID_ALL_DRIVERS_UNIQUE_CONTROLLER = RaceFormatTypeId._(
          4,
          _omitEnumNames
              ? ''
              : 'RACE_FORMAT_TYPE_ID_ALL_DRIVERS_UNIQUE_CONTROLLER');
  static const RaceFormatTypeId RACE_FORMAT_TYPE_ID_STEP_UP =
      RaceFormatTypeId._(
          5, _omitEnumNames ? '' : 'RACE_FORMAT_TYPE_ID_STEP_UP');
  static const RaceFormatTypeId RACE_FORMAT_TYPE_ID_CUSTOM =
      RaceFormatTypeId._(6, _omitEnumNames ? '' : 'RACE_FORMAT_TYPE_ID_CUSTOM');

  static const $core.List<RaceFormatTypeId> values = <RaceFormatTypeId>[
    RACE_FORMAT_TYPE_ID_UNDEFINED,
    RACE_FORMAT_TYPE_ID_ALL_DRIVERS_ALL_LANES_NEXT,
    RACE_FORMAT_TYPE_ID_ALL_DRIVERS_ALL_LANES_SPREAD,
    RACE_FORMAT_TYPE_ID_ALL_DRIVERS_ALL_LANES_ALL_DRIVERS,
    RACE_FORMAT_TYPE_ID_ALL_DRIVERS_UNIQUE_CONTROLLER,
    RACE_FORMAT_TYPE_ID_STEP_UP,
    RACE_FORMAT_TYPE_ID_CUSTOM,
  ];

  static final $core.List<RaceFormatTypeId?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 6);
  static RaceFormatTypeId? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RaceFormatTypeId._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
