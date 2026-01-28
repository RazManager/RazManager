// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/heat.v1.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class HeatCommandTypeId extends $pb.ProtobufEnum {
  static const HeatCommandTypeId HEAT_COMMAND_TYPE_ID_OPEN =
      HeatCommandTypeId._(0, _omitEnumNames ? '' : 'HEAT_COMMAND_TYPE_ID_OPEN');
  static const HeatCommandTypeId HEAT_COMMAND_TYPE_ID_START =
      HeatCommandTypeId._(
          1, _omitEnumNames ? '' : 'HEAT_COMMAND_TYPE_ID_START');
  static const HeatCommandTypeId HEAT_COMMAND_TYPE_ID_YELLOW =
      HeatCommandTypeId._(
          2, _omitEnumNames ? '' : 'HEAT_COMMAND_TYPE_ID_YELLOW');
  static const HeatCommandTypeId HEAT_COMMAND_TYPE_ID_RED =
      HeatCommandTypeId._(3, _omitEnumNames ? '' : 'HEAT_COMMAND_TYPE_ID_RED');
  static const HeatCommandTypeId HEAT_COMMAND_TYPE_ID_END =
      HeatCommandTypeId._(4, _omitEnumNames ? '' : 'HEAT_COMMAND_TYPE_ID_END');
  static const HeatCommandTypeId HEAT_COMMAND_TYPE_ID_REOPEN =
      HeatCommandTypeId._(
          5, _omitEnumNames ? '' : 'HEAT_COMMAND_TYPE_ID_REOPEN');
  static const HeatCommandTypeId HEAT_COMMAND_TYPE_ID_CLOSE =
      HeatCommandTypeId._(
          6, _omitEnumNames ? '' : 'HEAT_COMMAND_TYPE_ID_CLOSE');
  static const HeatCommandTypeId HEAT_COMMAND_TYPE_ID_RESET =
      HeatCommandTypeId._(
          7, _omitEnumNames ? '' : 'HEAT_COMMAND_TYPE_ID_RESET');

  static const $core.List<HeatCommandTypeId> values = <HeatCommandTypeId>[
    HEAT_COMMAND_TYPE_ID_OPEN,
    HEAT_COMMAND_TYPE_ID_START,
    HEAT_COMMAND_TYPE_ID_YELLOW,
    HEAT_COMMAND_TYPE_ID_RED,
    HEAT_COMMAND_TYPE_ID_END,
    HEAT_COMMAND_TYPE_ID_REOPEN,
    HEAT_COMMAND_TYPE_ID_CLOSE,
    HEAT_COMMAND_TYPE_ID_RESET,
  ];

  static final $core.List<HeatCommandTypeId?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 7);
  static HeatCommandTypeId? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const HeatCommandTypeId._(super.value, super.name);
}

class HeatStateTypeId extends $pb.ProtobufEnum {
  static const HeatStateTypeId HEAT_STATE_TYPE_ID_PENDING =
      HeatStateTypeId._(0, _omitEnumNames ? '' : 'HEAT_STATE_TYPE_ID_PENDING');
  static const HeatStateTypeId HEAT_STATE_TYPE_ID_OPENED =
      HeatStateTypeId._(1, _omitEnumNames ? '' : 'HEAT_STATE_TYPE_ID_OPENED');
  static const HeatStateTypeId HEAT_STATE_TYPE_ID_COUNTDOWN = HeatStateTypeId._(
      2, _omitEnumNames ? '' : 'HEAT_STATE_TYPE_ID_COUNTDOWN');
  static const HeatStateTypeId HEAT_STATE_TYPE_ID_RUNNING =
      HeatStateTypeId._(3, _omitEnumNames ? '' : 'HEAT_STATE_TYPE_ID_RUNNING');
  static const HeatStateTypeId HEAT_STATE_TYPE_ID_YELLOW =
      HeatStateTypeId._(4, _omitEnumNames ? '' : 'HEAT_STATE_TYPE_ID_YELLOW');
  static const HeatStateTypeId HEAT_STATE_TYPE_ID_COUNTDOWN_YELLOW =
      HeatStateTypeId._(
          5, _omitEnumNames ? '' : 'HEAT_STATE_TYPE_ID_COUNTDOWN_YELLOW');
  static const HeatStateTypeId HEAT_STATE_TYPE_ID_RED =
      HeatStateTypeId._(6, _omitEnumNames ? '' : 'HEAT_STATE_TYPE_ID_RED');
  static const HeatStateTypeId HEAT_STATE_TYPE_ID_COUNTDOWN_RED =
      HeatStateTypeId._(
          7, _omitEnumNames ? '' : 'HEAT_STATE_TYPE_ID_COUNTDOWN_RED');
  static const HeatStateTypeId HEAT_STATE_TYPE_ID_ENDED =
      HeatStateTypeId._(8, _omitEnumNames ? '' : 'HEAT_STATE_TYPE_ID_ENDED');
  static const HeatStateTypeId HEAT_STATE_TYPE_ID_OFF =
      HeatStateTypeId._(9, _omitEnumNames ? '' : 'HEAT_STATE_TYPE_ID_OFF');
  static const HeatStateTypeId HEAT_STATE_TYPE_ID_CLOSED =
      HeatStateTypeId._(10, _omitEnumNames ? '' : 'HEAT_STATE_TYPE_ID_CLOSED');

  static const $core.List<HeatStateTypeId> values = <HeatStateTypeId>[
    HEAT_STATE_TYPE_ID_PENDING,
    HEAT_STATE_TYPE_ID_OPENED,
    HEAT_STATE_TYPE_ID_COUNTDOWN,
    HEAT_STATE_TYPE_ID_RUNNING,
    HEAT_STATE_TYPE_ID_YELLOW,
    HEAT_STATE_TYPE_ID_COUNTDOWN_YELLOW,
    HEAT_STATE_TYPE_ID_RED,
    HEAT_STATE_TYPE_ID_COUNTDOWN_RED,
    HEAT_STATE_TYPE_ID_ENDED,
    HEAT_STATE_TYPE_ID_OFF,
    HEAT_STATE_TYPE_ID_CLOSED,
  ];

  static final $core.List<HeatStateTypeId?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 10);
  static HeatStateTypeId? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const HeatStateTypeId._(super.value, super.name);
}

class HeatEndTypeId extends $pb.ProtobufEnum {
  static const HeatEndTypeId HEAT_END_TYPE_ID_UNDEFINED =
      HeatEndTypeId._(0, _omitEnumNames ? '' : 'HEAT_END_TYPE_ID_UNDEFINED');
  static const HeatEndTypeId HEAT_END_TYPE_ID_LAP =
      HeatEndTypeId._(1, _omitEnumNames ? '' : 'HEAT_END_TYPE_ID_LAP');
  static const HeatEndTypeId HEAT_END_TYPE_ID_DURATION =
      HeatEndTypeId._(2, _omitEnumNames ? '' : 'HEAT_END_TYPE_ID_DURATION');
  static const HeatEndTypeId HEAT_END_TYPE_ID_MANUAL =
      HeatEndTypeId._(3, _omitEnumNames ? '' : 'HEAT_END_TYPE_ID_MANUAL');

  static const $core.List<HeatEndTypeId> values = <HeatEndTypeId>[
    HEAT_END_TYPE_ID_UNDEFINED,
    HEAT_END_TYPE_ID_LAP,
    HEAT_END_TYPE_ID_DURATION,
    HEAT_END_TYPE_ID_MANUAL,
  ];

  static final $core.List<HeatEndTypeId?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static HeatEndTypeId? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const HeatEndTypeId._(super.value, super.name);
}

class HeatIndicatorFlag extends $pb.ProtobufEnum {
  static const HeatIndicatorFlag HEAT_INDICATOR_FLAG_FINISHED =
      HeatIndicatorFlag._(
          0, _omitEnumNames ? '' : 'HEAT_INDICATOR_FLAG_FINISHED');
  static const HeatIndicatorFlag HEAT_INDICATOR_FLAG_FASTEST_LAP =
      HeatIndicatorFlag._(
          1, _omitEnumNames ? '' : 'HEAT_INDICATOR_FLAG_FASTEST_LAP');
  static const HeatIndicatorFlag HEAT_INDICATOR_FLAG_PITLANE =
      HeatIndicatorFlag._(
          2, _omitEnumNames ? '' : 'HEAT_INDICATOR_FLAG_PITLANE');
  static const HeatIndicatorFlag HEAT_INDICATOR_FLAG_CAR_OFF_TRACK =
      HeatIndicatorFlag._(
          3, _omitEnumNames ? '' : 'HEAT_INDICATOR_FLAG_CAR_OFF_TRACK');
  static const HeatIndicatorFlag
      HEAT_INDICATOR_FLAG_CONTROLLER_BATTERY_WARNING = HeatIndicatorFlag._(
          4,
          _omitEnumNames
              ? ''
              : 'HEAT_INDICATOR_FLAG_CONTROLLER_BATTERY_WARNING');
  static const HeatIndicatorFlag HEAT_INDICATOR_FLAG_CHARGING =
      HeatIndicatorFlag._(
          5, _omitEnumNames ? '' : 'HEAT_INDICATOR_FLAG_CHARGING');
  static const HeatIndicatorFlag HEAT_INDICATOR_FLAG_WARNING =
      HeatIndicatorFlag._(
          10, _omitEnumNames ? '' : 'HEAT_INDICATOR_FLAG_WARNING');

  static const $core.List<HeatIndicatorFlag> values = <HeatIndicatorFlag>[
    HEAT_INDICATOR_FLAG_FINISHED,
    HEAT_INDICATOR_FLAG_FASTEST_LAP,
    HEAT_INDICATOR_FLAG_PITLANE,
    HEAT_INDICATOR_FLAG_CAR_OFF_TRACK,
    HEAT_INDICATOR_FLAG_CONTROLLER_BATTERY_WARNING,
    HEAT_INDICATOR_FLAG_CHARGING,
    HEAT_INDICATOR_FLAG_WARNING,
  ];

  static final $core.Map<$core.int, HeatIndicatorFlag> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static HeatIndicatorFlag? valueOf($core.int value) => _byValue[value];

  const HeatIndicatorFlag._(super.value, super.name);
}

class HeatIndicatorTimeTypeId extends $pb.ProtobufEnum {
  static const HeatIndicatorTimeTypeId HEAT_INDICATOR_TIME_TYPE_ID_LAP =
      HeatIndicatorTimeTypeId._(
          0, _omitEnumNames ? '' : 'HEAT_INDICATOR_TIME_TYPE_ID_LAP');
  static const HeatIndicatorTimeTypeId HEAT_INDICATOR_TIME_TYPE_ID_SECTOR1 =
      HeatIndicatorTimeTypeId._(
          1, _omitEnumNames ? '' : 'HEAT_INDICATOR_TIME_TYPE_ID_SECTOR1');
  static const HeatIndicatorTimeTypeId HEAT_INDICATOR_TIME_TYPE_ID_SECTOR2 =
      HeatIndicatorTimeTypeId._(
          2, _omitEnumNames ? '' : 'HEAT_INDICATOR_TIME_TYPE_ID_SECTOR2');
  static const HeatIndicatorTimeTypeId HEAT_INDICATOR_TIME_TYPE_ID_SECTOR3 =
      HeatIndicatorTimeTypeId._(
          3, _omitEnumNames ? '' : 'HEAT_INDICATOR_TIME_TYPE_ID_SECTOR3');
  static const HeatIndicatorTimeTypeId HEAT_INDICATOR_TIME_TYPE_ID_SPEED_TRAP =
      HeatIndicatorTimeTypeId._(
          4, _omitEnumNames ? '' : 'HEAT_INDICATOR_TIME_TYPE_ID_SPEED_TRAP');

  static const $core.List<HeatIndicatorTimeTypeId> values =
      <HeatIndicatorTimeTypeId>[
    HEAT_INDICATOR_TIME_TYPE_ID_LAP,
    HEAT_INDICATOR_TIME_TYPE_ID_SECTOR1,
    HEAT_INDICATOR_TIME_TYPE_ID_SECTOR2,
    HEAT_INDICATOR_TIME_TYPE_ID_SECTOR3,
    HEAT_INDICATOR_TIME_TYPE_ID_SPEED_TRAP,
  ];

  static final $core.List<HeatIndicatorTimeTypeId?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static HeatIndicatorTimeTypeId? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const HeatIndicatorTimeTypeId._(super.value, super.name);
}

class HeatIndicatorFastestTimeTypeId extends $pb.ProtobufEnum {
  static const HeatIndicatorFastestTimeTypeId
      HEAT_INDICATOR_FASTEST_TIME_TYPE_ID_NONE =
      HeatIndicatorFastestTimeTypeId._(
          0, _omitEnumNames ? '' : 'HEAT_INDICATOR_FASTEST_TIME_TYPE_ID_NONE');
  static const HeatIndicatorFastestTimeTypeId
      HEAT_INDICATOR_FASTEST_TIME_TYPE_ID_INDICATOR =
      HeatIndicatorFastestTimeTypeId._(
          1,
          _omitEnumNames
              ? ''
              : 'HEAT_INDICATOR_FASTEST_TIME_TYPE_ID_INDICATOR');
  static const HeatIndicatorFastestTimeTypeId
      HEAT_INDICATOR_FASTEST_TIME_TYPE_ID_ALL_INDICATORS =
      HeatIndicatorFastestTimeTypeId._(
          2,
          _omitEnumNames
              ? ''
              : 'HEAT_INDICATOR_FASTEST_TIME_TYPE_ID_ALL_INDICATORS');

  static const $core.List<HeatIndicatorFastestTimeTypeId> values =
      <HeatIndicatorFastestTimeTypeId>[
    HEAT_INDICATOR_FASTEST_TIME_TYPE_ID_NONE,
    HEAT_INDICATOR_FASTEST_TIME_TYPE_ID_INDICATOR,
    HEAT_INDICATOR_FASTEST_TIME_TYPE_ID_ALL_INDICATORS,
  ];

  static final $core.List<HeatIndicatorFastestTimeTypeId?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static HeatIndicatorFastestTimeTypeId? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const HeatIndicatorFastestTimeTypeId._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
