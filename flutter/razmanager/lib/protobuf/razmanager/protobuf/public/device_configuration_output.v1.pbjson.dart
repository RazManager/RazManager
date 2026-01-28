// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/device_configuration_output.v1.proto.

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

@$core.Deprecated('Use deviceConfigurationOutputDescriptor instead')
const DeviceConfigurationOutput$json = {
  '1': 'DeviceConfigurationOutput',
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
      '1': 'device_configuration_output_type_id',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.DeviceConfigurationOutputTypeId',
      '10': 'deviceConfigurationOutputTypeId'
    },
    {
      '1': 'device_configuration_output_id',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'deviceConfigurationOutputId'
    },
  ],
};

/// Descriptor for `DeviceConfigurationOutput`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceConfigurationOutputDescriptor = $convert.base64Decode(
    'ChlEZXZpY2VDb25maWd1cmF0aW9uT3V0cHV0EjYKF2RldmljZV9jb25maWd1cmF0aW9uX2lkGA'
    'EgASgJUhVkZXZpY2VDb25maWd1cmF0aW9uSWQSQwoOY29ycmVsYXRpb25faWQYAiABKAsyHC5n'
    'b29nbGUucHJvdG9idWYuU3RyaW5nVmFsdWVSDWNvcnJlbGF0aW9uSWQSjAEKI2RldmljZV9jb2'
    '5maWd1cmF0aW9uX291dHB1dF90eXBlX2lkGAMgASgOMj4ucmF6bWFuYWdlci5wcm90b2J1Zi5w'
    'dWJsaWMudjEuRGV2aWNlQ29uZmlndXJhdGlvbk91dHB1dFR5cGVJZFIfZGV2aWNlQ29uZmlndX'
    'JhdGlvbk91dHB1dFR5cGVJZBJhCh5kZXZpY2VfY29uZmlndXJhdGlvbl9vdXRwdXRfaWQYBCAB'
    'KAsyHC5nb29nbGUucHJvdG9idWYuVUludDMyVmFsdWVSG2RldmljZUNvbmZpZ3VyYXRpb25PdX'
    'RwdXRJZA==');

@$core.Deprecated('Use deviceConfigurationOutputsDescriptor instead')
const DeviceConfigurationOutputs$json = {
  '1': 'DeviceConfigurationOutputs',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.DeviceConfigurationOutput',
      '10': 'items'
    },
  ],
};

/// Descriptor for `DeviceConfigurationOutputs`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceConfigurationOutputsDescriptor =
    $convert.base64Decode(
        'ChpEZXZpY2VDb25maWd1cmF0aW9uT3V0cHV0cxJOCgVpdGVtcxgBIAMoCzI4LnJhem1hbmFnZX'
        'IucHJvdG9idWYucHVibGljLnYxLkRldmljZUNvbmZpZ3VyYXRpb25PdXRwdXRSBWl0ZW1z');
