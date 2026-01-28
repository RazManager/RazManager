// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/event.service.v1.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use eventSpeechDescriptor instead')
const EventSpeech$json = {
  '1': 'EventSpeech',
  '2': [
    {
      '1': 'speech',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BytesValue',
      '10': 'speech'
    },
  ],
};

/// Descriptor for `EventSpeech`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventSpeechDescriptor = $convert.base64Decode(
    'CgtFdmVudFNwZWVjaBIzCgZzcGVlY2gYASABKAsyGy5nb29nbGUucHJvdG9idWYuQnl0ZXNWYW'
    'x1ZVIGc3BlZWNo');

@$core.Deprecated('Use eventUserSpeechSubscribeRequestDescriptor instead')
const EventUserSpeechSubscribeRequest$json = {
  '1': 'EventUserSpeechSubscribeRequest',
  '2': [
    {'1': 'event_id', '3': 1, '4': 1, '5': 9, '10': 'eventId'},
    {'1': 'event_user_id', '3': 2, '4': 1, '5': 9, '10': 'eventUserId'},
    {'1': 'locale', '3': 3, '4': 1, '5': 9, '10': 'locale'},
    {'1': 'local_name', '3': 4, '4': 1, '5': 9, '10': 'localName'},
  ],
};

/// Descriptor for `EventUserSpeechSubscribeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventUserSpeechSubscribeRequestDescriptor =
    $convert.base64Decode(
        'Ch9FdmVudFVzZXJTcGVlY2hTdWJzY3JpYmVSZXF1ZXN0EhkKCGV2ZW50X2lkGAEgASgJUgdldm'
        'VudElkEiIKDWV2ZW50X3VzZXJfaWQYAiABKAlSC2V2ZW50VXNlcklkEhYKBmxvY2FsZRgDIAEo'
        'CVIGbG9jYWxlEh0KCmxvY2FsX25hbWUYBCABKAlSCWxvY2FsTmFtZQ==');

@$core.Deprecated('Use eventSpeechSettingsRequestDescriptor instead')
const EventSpeechSettingsRequest$json = {
  '1': 'EventSpeechSettingsRequest',
  '2': [
    {'1': 'locale', '3': 1, '4': 1, '5': 9, '10': 'locale'},
  ],
};

/// Descriptor for `EventSpeechSettingsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventSpeechSettingsRequestDescriptor =
    $convert.base64Decode(
        'ChpFdmVudFNwZWVjaFNldHRpbmdzUmVxdWVzdBIWCgZsb2NhbGUYASABKAlSBmxvY2FsZQ==');

@$core.Deprecated('Use eventSpeechSettingsReponseDescriptor instead')
const EventSpeechSettingsReponse$json = {
  '1': 'EventSpeechSettingsReponse',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.EventSpeechSettings',
      '10': 'items'
    },
  ],
};

/// Descriptor for `EventSpeechSettingsReponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventSpeechSettingsReponseDescriptor =
    $convert.base64Decode(
        'ChpFdmVudFNwZWVjaFNldHRpbmdzUmVwb25zZRJICgVpdGVtcxgBIAMoCzIyLnJhem1hbmFnZX'
        'IucHJvdG9idWYucHVibGljLnYxLkV2ZW50U3BlZWNoU2V0dGluZ3NSBWl0ZW1z');

@$core.Deprecated('Use eventSpeechSettingsDescriptor instead')
const EventSpeechSettings$json = {
  '1': 'EventSpeechSettings',
  '2': [
    {'1': 'locale', '3': 1, '4': 1, '5': 9, '10': 'locale'},
    {'1': 'locale_name', '3': 2, '4': 1, '5': 9, '10': 'localeName'},
    {'1': 'local_name', '3': 3, '4': 1, '5': 9, '10': 'localName'},
  ],
};

/// Descriptor for `EventSpeechSettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventSpeechSettingsDescriptor = $convert.base64Decode(
    'ChNFdmVudFNwZWVjaFNldHRpbmdzEhYKBmxvY2FsZRgBIAEoCVIGbG9jYWxlEh8KC2xvY2FsZV'
    '9uYW1lGAIgASgJUgpsb2NhbGVOYW1lEh0KCmxvY2FsX25hbWUYAyABKAlSCWxvY2FsTmFtZQ==');
