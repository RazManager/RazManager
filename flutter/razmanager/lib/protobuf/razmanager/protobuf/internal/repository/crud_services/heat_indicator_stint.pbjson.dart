// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/heat_indicator_stint.proto.

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

@$core.Deprecated('Use heatIndicatorStintReadResponseDescriptor instead')
const HeatIndicatorStintReadResponse$json = {
  '1': 'HeatIndicatorStintReadResponse',
  '2': [
    {
      '1': 'entity',
      '3': 1,
      '4': 1,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.heat_indicator_stint.HeatIndicatorStintRead',
      '10': 'entity'
    },
    {'1': 'etag', '3': 2, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `HeatIndicatorStintReadResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heatIndicatorStintReadResponseDescriptor =
    $convert.base64Decode(
        'Ch5IZWF0SW5kaWNhdG9yU3RpbnRSZWFkUmVzcG9uc2USegoGZW50aXR5GAEgASgLMmIucmF6bW'
        'FuYWdlci5wcm90b2J1Zi5pbnRlcm5hbC5yZXBvc2l0b3J5LmNydWRfc2VydmljZXMuaGVhdF9p'
        'bmRpY2F0b3Jfc3RpbnQuSGVhdEluZGljYXRvclN0aW50UmVhZFIGZW50aXR5EhIKBGV0YWcYAi'
        'ABKAlSBGV0YWc=');

@$core.Deprecated('Use heatIndicatorStintReadDescriptor instead')
const HeatIndicatorStintRead$json = {
  '1': 'HeatIndicatorStintRead',
  '2': [
    {
      '1': 'id',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'id'
    },
    {'1': 'lap', '3': 3, '4': 1, '5': 13, '10': 'lap'},
    {
      '1': 'event_user_id',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'eventUserId'
    },
    {
      '1': 'comments',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'comments'
    },
  ],
};

/// Descriptor for `HeatIndicatorStintRead`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heatIndicatorStintReadDescriptor = $convert.base64Decode(
    'ChZIZWF0SW5kaWNhdG9yU3RpbnRSZWFkEiwKAmlkGAEgASgLMhwuZ29vZ2xlLnByb3RvYnVmLl'
    'N0cmluZ1ZhbHVlUgJpZBIQCgNsYXAYAyABKA1SA2xhcBJACg1ldmVudF91c2VyX2lkGAQgASgL'
    'MhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUgtldmVudFVzZXJJZBI4Cghjb21tZW50cx'
    'gFIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZVIIY29tbWVudHM=');

@$core.Deprecated('Use heatIndicatorStintCreateDescriptor instead')
const HeatIndicatorStintCreate$json = {
  '1': 'HeatIndicatorStintCreate',
  '2': [
    {'1': 'heat_indicator_id', '3': 2, '4': 1, '5': 9, '10': 'heatIndicatorId'},
    {'1': 'lap', '3': 3, '4': 1, '5': 13, '10': 'lap'},
    {
      '1': 'event_user_id',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'eventUserId'
    },
    {
      '1': 'comments',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'comments'
    },
  ],
};

/// Descriptor for `HeatIndicatorStintCreate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heatIndicatorStintCreateDescriptor = $convert.base64Decode(
    'ChhIZWF0SW5kaWNhdG9yU3RpbnRDcmVhdGUSKgoRaGVhdF9pbmRpY2F0b3JfaWQYAiABKAlSD2'
    'hlYXRJbmRpY2F0b3JJZBIQCgNsYXAYAyABKA1SA2xhcBJACg1ldmVudF91c2VyX2lkGAQgASgL'
    'MhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUgtldmVudFVzZXJJZBI4Cghjb21tZW50cx'
    'gFIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZVIIY29tbWVudHM=');

@$core.Deprecated('Use heatIndicatorStintUpdateDescriptor instead')
const HeatIndicatorStintUpdate$json = {
  '1': 'HeatIndicatorStintUpdate',
  '2': [
    {'1': 'lap', '3': 3, '4': 1, '5': 13, '10': 'lap'},
    {
      '1': 'event_user_id',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'eventUserId'
    },
    {
      '1': 'comments',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'comments'
    },
  ],
};

/// Descriptor for `HeatIndicatorStintUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heatIndicatorStintUpdateDescriptor = $convert.base64Decode(
    'ChhIZWF0SW5kaWNhdG9yU3RpbnRVcGRhdGUSEAoDbGFwGAMgASgNUgNsYXASQAoNZXZlbnRfdX'
    'Nlcl9pZBgEIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZVILZXZlbnRVc2VySWQS'
    'OAoIY29tbWVudHMYBSABKAsyHC5nb29nbGUucHJvdG9idWYuU3RyaW5nVmFsdWVSCGNvbW1lbn'
    'Rz');

@$core.Deprecated('Use heatIndicatorStintUpdateRequestDescriptor instead')
const HeatIndicatorStintUpdateRequest$json = {
  '1': 'HeatIndicatorStintUpdateRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'entity',
      '3': 2,
      '4': 1,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.heat_indicator_stint.HeatIndicatorStintUpdate',
      '10': 'entity'
    },
    {'1': 'etag', '3': 3, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `HeatIndicatorStintUpdateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heatIndicatorStintUpdateRequestDescriptor =
    $convert.base64Decode(
        'Ch9IZWF0SW5kaWNhdG9yU3RpbnRVcGRhdGVSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZBJ8CgZlbn'
        'RpdHkYAiABKAsyZC5yYXptYW5hZ2VyLnByb3RvYnVmLmludGVybmFsLnJlcG9zaXRvcnkuY3J1'
        'ZF9zZXJ2aWNlcy5oZWF0X2luZGljYXRvcl9zdGludC5IZWF0SW5kaWNhdG9yU3RpbnRVcGRhdG'
        'VSBmVudGl0eRISCgRldGFnGAMgASgJUgRldGFn');
