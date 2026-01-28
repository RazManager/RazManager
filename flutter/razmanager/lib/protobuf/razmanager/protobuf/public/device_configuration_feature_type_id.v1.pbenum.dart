// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/device_configuration_feature_type_id.v1.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class DeviceConfigurationFeatureTypeId extends $pb.ProtobufEnum {
  static const DeviceConfigurationFeatureTypeId
      DEVICE_CONFIGURATION_FEATURE_TYPE_ID_UNDEFINED =
      DeviceConfigurationFeatureTypeId._(
          0,
          _omitEnumNames
              ? ''
              : 'DEVICE_CONFIGURATION_FEATURE_TYPE_ID_UNDEFINED');
  static const DeviceConfigurationFeatureTypeId
      DEVICE_CONFIGURATION_FEATURE_TYPE_ID_SECTOR_1 =
      DeviceConfigurationFeatureTypeId._(
          1,
          _omitEnumNames
              ? ''
              : 'DEVICE_CONFIGURATION_FEATURE_TYPE_ID_SECTOR_1');
  static const DeviceConfigurationFeatureTypeId
      DEVICE_CONFIGURATION_FEATURE_TYPE_ID_SECTOR_2 =
      DeviceConfigurationFeatureTypeId._(
          2,
          _omitEnumNames
              ? ''
              : 'DEVICE_CONFIGURATION_FEATURE_TYPE_ID_SECTOR_2');
  static const DeviceConfigurationFeatureTypeId
      DEVICE_CONFIGURATION_FEATURE_TYPE_ID_SECTOR_3 =
      DeviceConfigurationFeatureTypeId._(
          3,
          _omitEnumNames
              ? ''
              : 'DEVICE_CONFIGURATION_FEATURE_TYPE_ID_SECTOR_3');
  static const DeviceConfigurationFeatureTypeId
      DEVICE_CONFIGURATION_FEATURE_TYPE_ID_SPEED_TRAP =
      DeviceConfigurationFeatureTypeId._(
          4,
          _omitEnumNames
              ? ''
              : 'DEVICE_CONFIGURATION_FEATURE_TYPE_ID_SPEED_TRAP');
  static const DeviceConfigurationFeatureTypeId
      DEVICE_CONFIGURATION_FEATURE_TYPE_ID_PITLANE =
      DeviceConfigurationFeatureTypeId._(5,
          _omitEnumNames ? '' : 'DEVICE_CONFIGURATION_FEATURE_TYPE_ID_PITLANE');
  static const DeviceConfigurationFeatureTypeId
      DEVICE_CONFIGURATION_FEATURE_TYPE_ID_PITSTOP =
      DeviceConfigurationFeatureTypeId._(6,
          _omitEnumNames ? '' : 'DEVICE_CONFIGURATION_FEATURE_TYPE_ID_PITSTOP');
  static const DeviceConfigurationFeatureTypeId
      DEVICE_CONFIGURATION_FEATURE_TYPE_ID_ENERGY =
      DeviceConfigurationFeatureTypeId._(7,
          _omitEnumNames ? '' : 'DEVICE_CONFIGURATION_FEATURE_TYPE_ID_ENERGY');
  static const DeviceConfigurationFeatureTypeId
      DEVICE_CONFIGURATION_FEATURE_TYPE_ID_CAR_ON_TRACK =
      DeviceConfigurationFeatureTypeId._(
          8,
          _omitEnumNames
              ? ''
              : 'DEVICE_CONFIGURATION_FEATURE_TYPE_ID_CAR_ON_TRACK');
  static const DeviceConfigurationFeatureTypeId
      DEVICE_CONFIGURATION_FEATURE_TYPE_ID_LANE_BASED_ID =
      DeviceConfigurationFeatureTypeId._(
          9,
          _omitEnumNames
              ? ''
              : 'DEVICE_CONFIGURATION_FEATURE_TYPE_ID_LANE_BASED_ID');
  static const DeviceConfigurationFeatureTypeId
      DEVICE_CONFIGURATION_FEATURE_TYPE_ID_CONTROLLER_BASED_ID =
      DeviceConfigurationFeatureTypeId._(
          10,
          _omitEnumNames
              ? ''
              : 'DEVICE_CONFIGURATION_FEATURE_TYPE_ID_CONTROLLER_BASED_ID');
  static const DeviceConfigurationFeatureTypeId
      DEVICE_CONFIGURATION_FEATURE_TYPE_ID_THROTTLE_PROFILES =
      DeviceConfigurationFeatureTypeId._(
          11,
          _omitEnumNames
              ? ''
              : 'DEVICE_CONFIGURATION_FEATURE_TYPE_ID_THROTTLE_PROFILES');

  static const $core.List<DeviceConfigurationFeatureTypeId> values =
      <DeviceConfigurationFeatureTypeId>[
    DEVICE_CONFIGURATION_FEATURE_TYPE_ID_UNDEFINED,
    DEVICE_CONFIGURATION_FEATURE_TYPE_ID_SECTOR_1,
    DEVICE_CONFIGURATION_FEATURE_TYPE_ID_SECTOR_2,
    DEVICE_CONFIGURATION_FEATURE_TYPE_ID_SECTOR_3,
    DEVICE_CONFIGURATION_FEATURE_TYPE_ID_SPEED_TRAP,
    DEVICE_CONFIGURATION_FEATURE_TYPE_ID_PITLANE,
    DEVICE_CONFIGURATION_FEATURE_TYPE_ID_PITSTOP,
    DEVICE_CONFIGURATION_FEATURE_TYPE_ID_ENERGY,
    DEVICE_CONFIGURATION_FEATURE_TYPE_ID_CAR_ON_TRACK,
    DEVICE_CONFIGURATION_FEATURE_TYPE_ID_LANE_BASED_ID,
    DEVICE_CONFIGURATION_FEATURE_TYPE_ID_CONTROLLER_BASED_ID,
    DEVICE_CONFIGURATION_FEATURE_TYPE_ID_THROTTLE_PROFILES,
  ];

  static final $core.List<DeviceConfigurationFeatureTypeId?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 11);
  static DeviceConfigurationFeatureTypeId? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const DeviceConfigurationFeatureTypeId._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
