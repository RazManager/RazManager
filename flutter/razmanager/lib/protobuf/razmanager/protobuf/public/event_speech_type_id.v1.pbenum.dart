// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/event_speech_type_id.v1.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class EventSpeechTypeId extends $pb.ProtobufEnum {
  static const EventSpeechTypeId EVENT_SPEECH_TYPE_ID_LAP =
      EventSpeechTypeId._(0, _omitEnumNames ? '' : 'EVENT_SPEECH_TYPE_ID_LAP');
  static const EventSpeechTypeId EVENT_SPEECH_TYPE_ID_AVERAGE_LAP =
      EventSpeechTypeId._(
          1, _omitEnumNames ? '' : 'EVENT_SPEECH_TYPE_ID_AVERAGE_LAP');
  static const EventSpeechTypeId EVENT_SPEECH_TYPE_ID_FASTER =
      EventSpeechTypeId._(
          2, _omitEnumNames ? '' : 'EVENT_SPEECH_TYPE_ID_FASTER');
  static const EventSpeechTypeId EVENT_SPEECH_TYPE_ID_FASTEST =
      EventSpeechTypeId._(
          3, _omitEnumNames ? '' : 'EVENT_SPEECH_TYPE_ID_FASTEST');
  static const EventSpeechTypeId EVENT_SPEECH_TYPE_ID_POSITION_LEADER =
      EventSpeechTypeId._(
          4, _omitEnumNames ? '' : 'EVENT_SPEECH_TYPE_ID_POSITION_LEADER');
  static const EventSpeechTypeId EVENT_SPEECH_TYPE_ID_POSITION_GAINED =
      EventSpeechTypeId._(
          5, _omitEnumNames ? '' : 'EVENT_SPEECH_TYPE_ID_POSITION_GAINED');
  static const EventSpeechTypeId EVENT_SPEECH_TYPE_ID_POSITION_LOST =
      EventSpeechTypeId._(
          6, _omitEnumNames ? '' : 'EVENT_SPEECH_TYPE_ID_POSITION_LOST');
  static const EventSpeechTypeId EVENT_SPEECH_TYPE_ID_GAP_AFTER =
      EventSpeechTypeId._(
          7, _omitEnumNames ? '' : 'EVENT_SPEECH_TYPE_ID_GAP_AFTER');
  static const EventSpeechTypeId EVENT_SPEECH_TYPE_ID_GAP_BEFORE =
      EventSpeechTypeId._(
          8, _omitEnumNames ? '' : 'EVENT_SPEECH_TYPE_ID_GAP_BEFORE');
  static const EventSpeechTypeId EVENT_SPEECH_TYPE_ID_GAP_NEAREST =
      EventSpeechTypeId._(
          9, _omitEnumNames ? '' : 'EVENT_SPEECH_TYPE_ID_GAP_NEAREST');

  static const $core.List<EventSpeechTypeId> values = <EventSpeechTypeId>[
    EVENT_SPEECH_TYPE_ID_LAP,
    EVENT_SPEECH_TYPE_ID_AVERAGE_LAP,
    EVENT_SPEECH_TYPE_ID_FASTER,
    EVENT_SPEECH_TYPE_ID_FASTEST,
    EVENT_SPEECH_TYPE_ID_POSITION_LEADER,
    EVENT_SPEECH_TYPE_ID_POSITION_GAINED,
    EVENT_SPEECH_TYPE_ID_POSITION_LOST,
    EVENT_SPEECH_TYPE_ID_GAP_AFTER,
    EVENT_SPEECH_TYPE_ID_GAP_BEFORE,
    EVENT_SPEECH_TYPE_ID_GAP_NEAREST,
  ];

  static final $core.List<EventSpeechTypeId?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 9);
  static EventSpeechTypeId? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const EventSpeechTypeId._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
