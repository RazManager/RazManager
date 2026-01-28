// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/device.v1.proto.

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

@$core.Deprecated('Use deviceInformationDescriptor instead')
const DeviceInformation$json = {
  '1': 'DeviceInformation',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'device_properties',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.DeviceProperty',
      '10': 'deviceProperties'
    },
    {
      '1': 'device_configurations',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.DeviceConfiguration',
      '10': 'deviceConfigurations'
    },
  ],
};

/// Descriptor for `DeviceInformation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceInformationDescriptor = $convert.base64Decode(
    'ChFEZXZpY2VJbmZvcm1hdGlvbhIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZR'
    'JaChFkZXZpY2VfcHJvcGVydGllcxgDIAMoCzItLnJhem1hbmFnZXIucHJvdG9idWYucHVibGlj'
    'LnYxLkRldmljZVByb3BlcnR5UhBkZXZpY2VQcm9wZXJ0aWVzEmcKFWRldmljZV9jb25maWd1cm'
    'F0aW9ucxgEIAMoCzIyLnJhem1hbmFnZXIucHJvdG9idWYucHVibGljLnYxLkRldmljZUNvbmZp'
    'Z3VyYXRpb25SFGRldmljZUNvbmZpZ3VyYXRpb25z');

@$core.Deprecated('Use devicePropertyDescriptor instead')
const DeviceProperty$json = {
  '1': 'DeviceProperty',
  '2': [
    {'1': 'label', '3': 1, '4': 1, '5': 9, '10': 'label'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
};

/// Descriptor for `DeviceProperty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List devicePropertyDescriptor = $convert.base64Decode(
    'Cg5EZXZpY2VQcm9wZXJ0eRIUCgVsYWJlbBgBIAEoCVIFbGFiZWwSFAoFdmFsdWUYAiABKAlSBX'
    'ZhbHVl');

@$core.Deprecated('Use deviceConfigurationDescriptor instead')
const DeviceConfiguration$json = {
  '1': 'DeviceConfiguration',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'device_configuration_inputs',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.DeviceDeviceConfigurationInput',
      '10': 'deviceConfigurationInputs'
    },
    {
      '1': 'device_configuration_outputs',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.DeviceDeviceConfigurationOutput',
      '10': 'deviceConfigurationOutputs'
    },
    {
      '1': 'device_configuration_features',
      '3': 5,
      '4': 3,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.DeviceConfigurationFeatureTypeId',
      '10': 'deviceConfigurationFeatures'
    },
  ],
};

/// Descriptor for `DeviceConfiguration`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceConfigurationDescriptor = $convert.base64Decode(
    'ChNEZXZpY2VDb25maWd1cmF0aW9uEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW'
    '1lEn0KG2RldmljZV9jb25maWd1cmF0aW9uX2lucHV0cxgDIAMoCzI9LnJhem1hbmFnZXIucHJv'
    'dG9idWYucHVibGljLnYxLkRldmljZURldmljZUNvbmZpZ3VyYXRpb25JbnB1dFIZZGV2aWNlQ2'
    '9uZmlndXJhdGlvbklucHV0cxKAAQocZGV2aWNlX2NvbmZpZ3VyYXRpb25fb3V0cHV0cxgEIAMo'
    'CzI+LnJhem1hbmFnZXIucHJvdG9idWYucHVibGljLnYxLkRldmljZURldmljZUNvbmZpZ3VyYX'
    'Rpb25PdXRwdXRSGmRldmljZUNvbmZpZ3VyYXRpb25PdXRwdXRzEoMBCh1kZXZpY2VfY29uZmln'
    'dXJhdGlvbl9mZWF0dXJlcxgFIAMoDjI/LnJhem1hbmFnZXIucHJvdG9idWYucHVibGljLnYxLk'
    'RldmljZUNvbmZpZ3VyYXRpb25GZWF0dXJlVHlwZUlkUhtkZXZpY2VDb25maWd1cmF0aW9uRmVh'
    'dHVyZXM=');

@$core.Deprecated('Use deviceDeviceConfigurationInputDescriptor instead')
const DeviceDeviceConfigurationInput$json = {
  '1': 'DeviceDeviceConfigurationInput',
  '2': [
    {
      '1': 'device_configuration_input_type_id',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.DeviceConfigurationInputTypeId',
      '10': 'deviceConfigurationInputTypeId'
    },
    {
      '1': 'device_configuration_input_id',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'deviceConfigurationInputId'
    },
    {
      '1': 'device_configuration_input_sub_id',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'deviceConfigurationInputSubId'
    },
  ],
};

/// Descriptor for `DeviceDeviceConfigurationInput`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceDeviceConfigurationInputDescriptor = $convert.base64Decode(
    'Ch5EZXZpY2VEZXZpY2VDb25maWd1cmF0aW9uSW5wdXQSiQEKImRldmljZV9jb25maWd1cmF0aW'
    '9uX2lucHV0X3R5cGVfaWQYASABKA4yPS5yYXptYW5hZ2VyLnByb3RvYnVmLnB1YmxpYy52MS5E'
    'ZXZpY2VDb25maWd1cmF0aW9uSW5wdXRUeXBlSWRSHmRldmljZUNvbmZpZ3VyYXRpb25JbnB1dF'
    'R5cGVJZBJfCh1kZXZpY2VfY29uZmlndXJhdGlvbl9pbnB1dF9pZBgCIAEoCzIcLmdvb2dsZS5w'
    'cm90b2J1Zi5VSW50MzJWYWx1ZVIaZGV2aWNlQ29uZmlndXJhdGlvbklucHV0SWQSZgohZGV2aW'
    'NlX2NvbmZpZ3VyYXRpb25faW5wdXRfc3ViX2lkGAMgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlVJ'
    'bnQzMlZhbHVlUh1kZXZpY2VDb25maWd1cmF0aW9uSW5wdXRTdWJJZA==');

@$core.Deprecated('Use deviceDeviceConfigurationOutputDescriptor instead')
const DeviceDeviceConfigurationOutput$json = {
  '1': 'DeviceDeviceConfigurationOutput',
  '2': [
    {
      '1': 'device_configuration_output_type_id',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.DeviceConfigurationOutputTypeId',
      '10': 'deviceConfigurationOutputTypeId'
    },
    {
      '1': 'device_configuration_output_id',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'deviceConfigurationOutputId'
    },
  ],
};

/// Descriptor for `DeviceDeviceConfigurationOutput`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceDeviceConfigurationOutputDescriptor = $convert.base64Decode(
    'Ch9EZXZpY2VEZXZpY2VDb25maWd1cmF0aW9uT3V0cHV0EowBCiNkZXZpY2VfY29uZmlndXJhdG'
    'lvbl9vdXRwdXRfdHlwZV9pZBgBIAEoDjI+LnJhem1hbmFnZXIucHJvdG9idWYucHVibGljLnYx'
    'LkRldmljZUNvbmZpZ3VyYXRpb25PdXRwdXRUeXBlSWRSH2RldmljZUNvbmZpZ3VyYXRpb25PdX'
    'RwdXRUeXBlSWQSYQoeZGV2aWNlX2NvbmZpZ3VyYXRpb25fb3V0cHV0X2lkGAIgASgLMhwuZ29v'
    'Z2xlLnByb3RvYnVmLlVJbnQzMlZhbHVlUhtkZXZpY2VDb25maWd1cmF0aW9uT3V0cHV0SWQ=');
