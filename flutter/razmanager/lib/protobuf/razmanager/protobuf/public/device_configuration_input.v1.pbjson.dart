// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/device_configuration_input.v1.proto.

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

@$core.Deprecated('Use deviceConfigurationInputDescriptor instead')
const DeviceConfigurationInput$json = {
  '1': 'DeviceConfigurationInput',
  '2': [
    {
      '1': 'device_configuration_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'deviceConfigurationId'
    },
    {
      '1': 'correlation_id',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'correlationId'
    },
    {
      '1': 'timestamp',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'timestamp'
    },
    {
      '1': 'device_configuration_input_type_id',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.DeviceConfigurationInputTypeId',
      '10': 'deviceConfigurationInputTypeId'
    },
    {
      '1': 'device_configuration_input_id',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'deviceConfigurationInputId'
    },
    {
      '1': 'device_configuration_input_sub_id',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'deviceConfigurationInputSubId'
    },
    {'1': 'int_value', '3': 7, '4': 1, '5': 13, '9': 0, '10': 'intValue'},
    {'1': 'bool_value', '3': 8, '4': 1, '5': 8, '9': 0, '10': 'boolValue'},
    {
      '1': 'information',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'information'
    },
    {
      '1': 'lap_time',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.DoubleValue',
      '10': 'lapTime'
    },
  ],
  '8': [
    {'1': 'value'},
  ],
};

/// Descriptor for `DeviceConfigurationInput`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceConfigurationInputDescriptor = $convert.base64Decode(
    'ChhEZXZpY2VDb25maWd1cmF0aW9uSW5wdXQSNgoXZGV2aWNlX2NvbmZpZ3VyYXRpb25faWQYAS'
    'ABKAlSFWRldmljZUNvbmZpZ3VyYXRpb25JZBJDCg5jb3JyZWxhdGlvbl9pZBgCIAEoCzIcLmdv'
    'b2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZVINY29ycmVsYXRpb25JZBI4Cgl0aW1lc3RhbXAYAy'
    'ABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl0aW1lc3RhbXASiQEKImRldmljZV9j'
    'b25maWd1cmF0aW9uX2lucHV0X3R5cGVfaWQYBCABKA4yPS5yYXptYW5hZ2VyLnByb3RvYnVmLn'
    'B1YmxpYy52MS5EZXZpY2VDb25maWd1cmF0aW9uSW5wdXRUeXBlSWRSHmRldmljZUNvbmZpZ3Vy'
    'YXRpb25JbnB1dFR5cGVJZBJfCh1kZXZpY2VfY29uZmlndXJhdGlvbl9pbnB1dF9pZBgFIAEoCz'
    'IcLmdvb2dsZS5wcm90b2J1Zi5VSW50MzJWYWx1ZVIaZGV2aWNlQ29uZmlndXJhdGlvbklucHV0'
    'SWQSZgohZGV2aWNlX2NvbmZpZ3VyYXRpb25faW5wdXRfc3ViX2lkGAYgASgLMhwuZ29vZ2xlLn'
    'Byb3RvYnVmLlVJbnQzMlZhbHVlUh1kZXZpY2VDb25maWd1cmF0aW9uSW5wdXRTdWJJZBIdCglp'
    'bnRfdmFsdWUYByABKA1IAFIIaW50VmFsdWUSHwoKYm9vbF92YWx1ZRgIIAEoCEgAUglib29sVm'
    'FsdWUSPgoLaW5mb3JtYXRpb24YCSABKAsyHC5nb29nbGUucHJvdG9idWYuU3RyaW5nVmFsdWVS'
    'C2luZm9ybWF0aW9uEjcKCGxhcF90aW1lGAogASgLMhwuZ29vZ2xlLnByb3RvYnVmLkRvdWJsZV'
    'ZhbHVlUgdsYXBUaW1lQgcKBXZhbHVl');

@$core.Deprecated('Use deviceConfigurationInputsDescriptor instead')
const DeviceConfigurationInputs$json = {
  '1': 'DeviceConfigurationInputs',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.DeviceConfigurationInput',
      '10': 'items'
    },
  ],
};

/// Descriptor for `DeviceConfigurationInputs`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceConfigurationInputsDescriptor =
    $convert.base64Decode(
        'ChlEZXZpY2VDb25maWd1cmF0aW9uSW5wdXRzEk0KBWl0ZW1zGAEgAygLMjcucmF6bWFuYWdlci'
        '5wcm90b2J1Zi5wdWJsaWMudjEuRGV2aWNlQ29uZmlndXJhdGlvbklucHV0UgVpdGVtcw==');
