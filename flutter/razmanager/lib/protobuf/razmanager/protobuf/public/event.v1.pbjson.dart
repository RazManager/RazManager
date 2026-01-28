// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/event.v1.proto.

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

@$core.Deprecated('Use eventDescriptor instead')
const Event$json = {
  '1': 'Event',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'starts_at',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'startsAt'
    },
    {
      '1': 'image',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BytesValue',
      '10': 'image'
    },
    {
      '1': 'event_users',
      '3': 7,
      '4': 3,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.EventUser',
      '10': 'eventUsers'
    },
    {
      '1': 'races',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.Race',
      '10': 'races'
    },
  ],
};

/// Descriptor for `Event`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventDescriptor = $convert.base64Decode(
    'CgVFdmVudBIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRI3CglzdGFydHNfYX'
    'QYAyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUghzdGFydHNBdBIxCgVpbWFnZRgE'
    'IAEoCzIbLmdvb2dsZS5wcm90b2J1Zi5CeXRlc1ZhbHVlUgVpbWFnZRJJCgtldmVudF91c2Vycx'
    'gHIAMoCzIoLnJhem1hbmFnZXIucHJvdG9idWYucHVibGljLnYxLkV2ZW50VXNlclIKZXZlbnRV'
    'c2VycxI5CgVyYWNlcxgIIAMoCzIjLnJhem1hbmFnZXIucHJvdG9idWYucHVibGljLnYxLlJhY2'
    'VSBXJhY2Vz');

@$core.Deprecated('Use eventUserDescriptor instead')
const EventUser$json = {
  '1': 'EventUser',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'name',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'name'
    },
    {
      '1': 'short_name',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'shortName'
    },
    {
      '1': 'image',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BytesValue',
      '10': 'image'
    },
    {
      '1': 'event_user_type_id',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.EventUserTypeId',
      '10': 'eventUserTypeId'
    },
    {
      '1': 'team_users',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.TeamUser',
      '10': 'teamUsers'
    },
  ],
};

/// Descriptor for `EventUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventUserDescriptor = $convert.base64Decode(
    'CglFdmVudFVzZXISDgoCaWQYASABKAlSAmlkEjAKBG5hbWUYAiABKAsyHC5nb29nbGUucHJvdG'
    '9idWYuU3RyaW5nVmFsdWVSBG5hbWUSOwoKc2hvcnRfbmFtZRgDIAEoCzIcLmdvb2dsZS5wcm90'
    'b2J1Zi5TdHJpbmdWYWx1ZVIJc2hvcnROYW1lEjEKBWltYWdlGAQgASgLMhsuZ29vZ2xlLnByb3'
    'RvYnVmLkJ5dGVzVmFsdWVSBWltYWdlElsKEmV2ZW50X3VzZXJfdHlwZV9pZBgFIAEoDjIuLnJh'
    'em1hbmFnZXIucHJvdG9idWYucHVibGljLnYxLkV2ZW50VXNlclR5cGVJZFIPZXZlbnRVc2VyVH'
    'lwZUlkEkYKCnRlYW1fdXNlcnMYBiADKAsyJy5yYXptYW5hZ2VyLnByb3RvYnVmLnB1YmxpYy52'
    'MS5UZWFtVXNlclIJdGVhbVVzZXJz');

@$core.Deprecated('Use teamUserDescriptor instead')
const TeamUser$json = {
  '1': 'TeamUser',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'name',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'name'
    },
    {
      '1': 'short_name',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'shortName'
    },
    {
      '1': 'image',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BytesValue',
      '10': 'image'
    },
  ],
};

/// Descriptor for `TeamUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List teamUserDescriptor = $convert.base64Decode(
    'CghUZWFtVXNlchIOCgJpZBgBIAEoCVICaWQSMAoEbmFtZRgCIAEoCzIcLmdvb2dsZS5wcm90b2'
    'J1Zi5TdHJpbmdWYWx1ZVIEbmFtZRI7CgpzaG9ydF9uYW1lGAMgASgLMhwuZ29vZ2xlLnByb3Rv'
    'YnVmLlN0cmluZ1ZhbHVlUglzaG9ydE5hbWUSMQoFaW1hZ2UYBCABKAsyGy5nb29nbGUucHJvdG'
    '9idWYuQnl0ZXNWYWx1ZVIFaW1hZ2U=');

@$core.Deprecated('Use eventStateDescriptor instead')
const EventState$json = {
  '1': 'EventState',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'race_id',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'raceId'
    },
    {
      '1': 'heat_id',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'heatId'
    },
  ],
};

/// Descriptor for `EventState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventStateDescriptor = $convert.base64Decode(
    'CgpFdmVudFN0YXRlEg4KAmlkGAEgASgJUgJpZBI1CgdyYWNlX2lkGAIgASgLMhwuZ29vZ2xlLn'
    'Byb3RvYnVmLlN0cmluZ1ZhbHVlUgZyYWNlSWQSNQoHaGVhdF9pZBgDIAEoCzIcLmdvb2dsZS5w'
    'cm90b2J1Zi5TdHJpbmdWYWx1ZVIGaGVhdElk');
