// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/device_configuration_output_type_id.v1.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class DeviceConfigurationOutputTypeId extends $pb.ProtobufEnum {
  static const DeviceConfigurationOutputTypeId
      DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_START_FINISH_INDICATOR =
      DeviceConfigurationOutputTypeId._(
          0,
          _omitEnumNames
              ? ''
              : 'DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_START_FINISH_INDICATOR');
  static const DeviceConfigurationOutputTypeId
      DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_POWER_ON =
      DeviceConfigurationOutputTypeId._(1,
          _omitEnumNames ? '' : 'DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_POWER_ON');
  static const DeviceConfigurationOutputTypeId
      DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_POWER_YELLOW =
      DeviceConfigurationOutputTypeId._(
          2,
          _omitEnumNames
              ? ''
              : 'DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_POWER_YELLOW');
  static const DeviceConfigurationOutputTypeId
      DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_POWER_OFF =
      DeviceConfigurationOutputTypeId._(
          3,
          _omitEnumNames
              ? ''
              : 'DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_POWER_OFF');
  static const DeviceConfigurationOutputTypeId
      DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_COUNTDOWN_ON =
      DeviceConfigurationOutputTypeId._(
          4,
          _omitEnumNames
              ? ''
              : 'DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_COUNTDOWN_ON');
  static const DeviceConfigurationOutputTypeId
      DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_COUNTDOWN_OFF =
      DeviceConfigurationOutputTypeId._(
          5,
          _omitEnumNames
              ? ''
              : 'DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_COUNTDOWN_OFF');
  static const DeviceConfigurationOutputTypeId
      DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_HEAT_GREEN =
      DeviceConfigurationOutputTypeId._(
          6,
          _omitEnumNames
              ? ''
              : 'DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_HEAT_GREEN');
  static const DeviceConfigurationOutputTypeId
      DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_HEAT_YELLOW =
      DeviceConfigurationOutputTypeId._(
          7,
          _omitEnumNames
              ? ''
              : 'DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_HEAT_YELLOW');
  static const DeviceConfigurationOutputTypeId
      DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_HEAT_RED =
      DeviceConfigurationOutputTypeId._(8,
          _omitEnumNames ? '' : 'DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_HEAT_RED');
  static const DeviceConfigurationOutputTypeId
      DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_HEAT_OFF =
      DeviceConfigurationOutputTypeId._(9,
          _omitEnumNames ? '' : 'DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_HEAT_OFF');
  static const DeviceConfigurationOutputTypeId
      DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_PITSTOP =
      DeviceConfigurationOutputTypeId._(10,
          _omitEnumNames ? '' : 'DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_PITSTOP');
  static const DeviceConfigurationOutputTypeId
      DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_ENERGY_LEVEL =
      DeviceConfigurationOutputTypeId._(
          11,
          _omitEnumNames
              ? ''
              : 'DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_ENERGY_LEVEL');
  static const DeviceConfigurationOutputTypeId
      DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_ENERGY_LAPS_LEFT =
      DeviceConfigurationOutputTypeId._(
          12,
          _omitEnumNames
              ? ''
              : 'DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_ENERGY_LAPS_LEFT');

  static const $core.List<DeviceConfigurationOutputTypeId> values =
      <DeviceConfigurationOutputTypeId>[
    DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_START_FINISH_INDICATOR,
    DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_POWER_ON,
    DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_POWER_YELLOW,
    DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_POWER_OFF,
    DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_COUNTDOWN_ON,
    DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_COUNTDOWN_OFF,
    DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_HEAT_GREEN,
    DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_HEAT_YELLOW,
    DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_HEAT_RED,
    DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_HEAT_OFF,
    DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_PITSTOP,
    DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_ENERGY_LEVEL,
    DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_ENERGY_LAPS_LEFT,
  ];

  static final $core.List<DeviceConfigurationOutputTypeId?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 12);
  static DeviceConfigurationOutputTypeId? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const DeviceConfigurationOutputTypeId._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
