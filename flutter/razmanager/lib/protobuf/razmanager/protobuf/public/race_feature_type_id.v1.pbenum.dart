// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/race_feature_type_id.v1.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class RaceFeatureTypeId extends $pb.ProtobufEnum {
  static const RaceFeatureTypeId RACE_FEATURE_TYPE_ID_UNDEFINED =
      RaceFeatureTypeId._(
          0, _omitEnumNames ? '' : 'RACE_FEATURE_TYPE_ID_UNDEFINED');
  static const RaceFeatureTypeId RACE_FEATURE_TYPE_ID_SECTOR_1 =
      RaceFeatureTypeId._(
          1, _omitEnumNames ? '' : 'RACE_FEATURE_TYPE_ID_SECTOR_1');
  static const RaceFeatureTypeId RACE_FEATURE_TYPE_ID_SECTOR_2 =
      RaceFeatureTypeId._(
          2, _omitEnumNames ? '' : 'RACE_FEATURE_TYPE_ID_SECTOR_2');
  static const RaceFeatureTypeId RACE_FEATURE_TYPE_ID_SECTOR_3 =
      RaceFeatureTypeId._(
          3, _omitEnumNames ? '' : 'RACE_FEATURE_TYPE_ID_SECTOR_3');
  static const RaceFeatureTypeId RACE_FEATURE_TYPE_ID_SPEED_TRAP =
      RaceFeatureTypeId._(
          4, _omitEnumNames ? '' : 'RACE_FEATURE_TYPE_ID_SPEED_TRAP');
  static const RaceFeatureTypeId RACE_FEATURE_TYPE_ID_PITLANE =
      RaceFeatureTypeId._(
          5, _omitEnumNames ? '' : 'RACE_FEATURE_TYPE_ID_PITLANE');
  static const RaceFeatureTypeId RACE_FEATURE_TYPE_ID_PITSTOP =
      RaceFeatureTypeId._(
          6, _omitEnumNames ? '' : 'RACE_FEATURE_TYPE_ID_PITSTOP');
  static const RaceFeatureTypeId RACE_FEATURE_TYPE_ID_ENERGY =
      RaceFeatureTypeId._(
          7, _omitEnumNames ? '' : 'RACE_FEATURE_TYPE_ID_ENERGY');
  static const RaceFeatureTypeId RACE_FEATURE_TYPE_ID_CAR_ON_TRACK =
      RaceFeatureTypeId._(
          8, _omitEnumNames ? '' : 'RACE_FEATURE_TYPE_ID_CAR_ON_TRACK');
  static const RaceFeatureTypeId RACE_FEATURE_TYPE_ID_LANE_BASED_ID =
      RaceFeatureTypeId._(
          9, _omitEnumNames ? '' : 'RACE_FEATURE_TYPE_ID_LANE_BASED_ID');
  static const RaceFeatureTypeId RACE_FEATURE_TYPE_ID_CONTROLLER_BASED_ID =
      RaceFeatureTypeId._(
          10, _omitEnumNames ? '' : 'RACE_FEATURE_TYPE_ID_CONTROLLER_BASED_ID');
  static const RaceFeatureTypeId RACE_FEATURE_TYPE_ID_THROTTLE_PROFILES =
      RaceFeatureTypeId._(
          11, _omitEnumNames ? '' : 'RACE_FEATURE_TYPE_ID_THROTTLE_PROFILES');

  static const $core.List<RaceFeatureTypeId> values = <RaceFeatureTypeId>[
    RACE_FEATURE_TYPE_ID_UNDEFINED,
    RACE_FEATURE_TYPE_ID_SECTOR_1,
    RACE_FEATURE_TYPE_ID_SECTOR_2,
    RACE_FEATURE_TYPE_ID_SECTOR_3,
    RACE_FEATURE_TYPE_ID_SPEED_TRAP,
    RACE_FEATURE_TYPE_ID_PITLANE,
    RACE_FEATURE_TYPE_ID_PITSTOP,
    RACE_FEATURE_TYPE_ID_ENERGY,
    RACE_FEATURE_TYPE_ID_CAR_ON_TRACK,
    RACE_FEATURE_TYPE_ID_LANE_BASED_ID,
    RACE_FEATURE_TYPE_ID_CONTROLLER_BASED_ID,
    RACE_FEATURE_TYPE_ID_THROTTLE_PROFILES,
  ];

  static final $core.List<RaceFeatureTypeId?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 11);
  static RaceFeatureTypeId? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RaceFeatureTypeId._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
