// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/race.v1.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class RaceCommandTypeId extends $pb.ProtobufEnum {
  static const RaceCommandTypeId RACE_COMMAND_TYPE_ID_START =
      RaceCommandTypeId._(
          0, _omitEnumNames ? '' : 'RACE_COMMAND_TYPE_ID_START');
  static const RaceCommandTypeId RACE_COMMAND_TYPE_ID_PAUSE =
      RaceCommandTypeId._(
          1, _omitEnumNames ? '' : 'RACE_COMMAND_TYPE_ID_PAUSE');
  static const RaceCommandTypeId RACE_COMMAND_TYPE_ID_END =
      RaceCommandTypeId._(2, _omitEnumNames ? '' : 'RACE_COMMAND_TYPE_ID_END');
  static const RaceCommandTypeId RACE_COMMAND_TYPE_ID_RESET =
      RaceCommandTypeId._(
          3, _omitEnumNames ? '' : 'RACE_COMMAND_TYPE_ID_RESET');

  static const $core.List<RaceCommandTypeId> values = <RaceCommandTypeId>[
    RACE_COMMAND_TYPE_ID_START,
    RACE_COMMAND_TYPE_ID_PAUSE,
    RACE_COMMAND_TYPE_ID_END,
    RACE_COMMAND_TYPE_ID_RESET,
  ];

  static final $core.List<RaceCommandTypeId?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static RaceCommandTypeId? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RaceCommandTypeId._(super.value, super.name);
}

class RaceStateTypeId extends $pb.ProtobufEnum {
  static const RaceStateTypeId RACE_STATE_TYPE_ID_PENDING =
      RaceStateTypeId._(0, _omitEnumNames ? '' : 'RACE_STATE_TYPE_ID_PENDING');
  static const RaceStateTypeId RACE_STATE_TYPE_ID_STARTED =
      RaceStateTypeId._(1, _omitEnumNames ? '' : 'RACE_STATE_TYPE_ID_STARTED');
  static const RaceStateTypeId RACE_STATE_TYPE_ID_PAUSED =
      RaceStateTypeId._(2, _omitEnumNames ? '' : 'RACE_STATE_TYPE_ID_PAUSED');
  static const RaceStateTypeId RACE_STATE_TYPE_ID_ENDED =
      RaceStateTypeId._(3, _omitEnumNames ? '' : 'RACE_STATE_TYPE_ID_ENDED');

  static const $core.List<RaceStateTypeId> values = <RaceStateTypeId>[
    RACE_STATE_TYPE_ID_PENDING,
    RACE_STATE_TYPE_ID_STARTED,
    RACE_STATE_TYPE_ID_PAUSED,
    RACE_STATE_TYPE_ID_ENDED,
  ];

  static final $core.List<RaceStateTypeId?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static RaceStateTypeId? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RaceStateTypeId._(super.value, super.name);
}

class RaceIndicatorFlag extends $pb.ProtobufEnum {
  static const RaceIndicatorFlag RACE_INDICATOR_FLAG_RUNNING =
      RaceIndicatorFlag._(
          0, _omitEnumNames ? '' : 'RACE_INDICATOR_FLAG_RUNNING');
  static const RaceIndicatorFlag RACE_INDICATOR_FLAG_FINISHED =
      RaceIndicatorFlag._(
          1, _omitEnumNames ? '' : 'RACE_INDICATOR_FLAG_FINISHED');
  static const RaceIndicatorFlag RACE_INDICATOR_FLAG_FASTEST_LAP =
      RaceIndicatorFlag._(
          2, _omitEnumNames ? '' : 'RACE_INDICATOR_FLAG_FASTEST_LAP');

  static const $core.List<RaceIndicatorFlag> values = <RaceIndicatorFlag>[
    RACE_INDICATOR_FLAG_RUNNING,
    RACE_INDICATOR_FLAG_FINISHED,
    RACE_INDICATOR_FLAG_FASTEST_LAP,
  ];

  static final $core.List<RaceIndicatorFlag?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static RaceIndicatorFlag? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RaceIndicatorFlag._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
