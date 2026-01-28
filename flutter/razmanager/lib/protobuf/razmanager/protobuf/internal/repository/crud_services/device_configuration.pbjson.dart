// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/device_configuration.proto.

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

@$core.Deprecated('Use deviceConfigurationSelectResponseDescriptor instead')
const DeviceConfigurationSelectResponse$json = {
  '1': 'DeviceConfigurationSelectResponse',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.device_configuration.DeviceConfigurationSelect',
      '10': 'result'
    },
  ],
};

/// Descriptor for `DeviceConfigurationSelectResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceConfigurationSelectResponseDescriptor =
    $convert.base64Decode(
        'CiFEZXZpY2VDb25maWd1cmF0aW9uU2VsZWN0UmVzcG9uc2USfQoGcmVzdWx0GAEgAygLMmUucm'
        'F6bWFuYWdlci5wcm90b2J1Zi5pbnRlcm5hbC5yZXBvc2l0b3J5LmNydWRfc2VydmljZXMuZGV2'
        'aWNlX2NvbmZpZ3VyYXRpb24uRGV2aWNlQ29uZmlndXJhdGlvblNlbGVjdFIGcmVzdWx0');

@$core.Deprecated('Use deviceConfigurationSelectDescriptor instead')
const DeviceConfigurationSelect$json = {
  '1': 'DeviceConfigurationSelect',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'device',
      '3': 3,
      '4': 1,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.device.DeviceSelect',
      '10': 'device'
    },
  ],
};

/// Descriptor for `DeviceConfigurationSelect`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceConfigurationSelectDescriptor = $convert.base64Decode(
    'ChlEZXZpY2VDb25maWd1cmF0aW9uU2VsZWN0Eg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgAS'
    'gJUgRuYW1lEmIKBmRldmljZRgDIAEoCzJKLnJhem1hbmFnZXIucHJvdG9idWYuaW50ZXJuYWwu'
    'cmVwb3NpdG9yeS5jcnVkX3NlcnZpY2VzLmRldmljZS5EZXZpY2VTZWxlY3RSBmRldmljZQ==');
