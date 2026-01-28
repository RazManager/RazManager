// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/heat_car_type.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class HeatCarTypeId extends $pb.ProtobufEnum {
  static const HeatCarTypeId HEAT_CAR_TYPE_ID_UNDEFINED =
      HeatCarTypeId._(0, _omitEnumNames ? '' : 'HEAT_CAR_TYPE_ID_UNDEFINED');
  static const HeatCarTypeId HEAT_CAR_TYPE_ID_NONE =
      HeatCarTypeId._(1, _omitEnumNames ? '' : 'HEAT_CAR_TYPE_ID_NONE');
  static const HeatCarTypeId HEAT_CAR_TYPE_ID_INDICATOR =
      HeatCarTypeId._(2, _omitEnumNames ? '' : 'HEAT_CAR_TYPE_ID_INDICATOR');
  static const HeatCarTypeId HEAT_CAR_TYPE_ID_DRIVER =
      HeatCarTypeId._(3, _omitEnumNames ? '' : 'HEAT_CAR_TYPE_ID_DRIVER');

  static const $core.List<HeatCarTypeId> values = <HeatCarTypeId>[
    HEAT_CAR_TYPE_ID_UNDEFINED,
    HEAT_CAR_TYPE_ID_NONE,
    HEAT_CAR_TYPE_ID_INDICATOR,
    HEAT_CAR_TYPE_ID_DRIVER,
  ];

  static final $core.List<HeatCarTypeId?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static HeatCarTypeId? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const HeatCarTypeId._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
