// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/device.proto.

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

@$core.Deprecated('Use deviceReadResponseDescriptor instead')
const DeviceReadResponse$json = {
  '1': 'DeviceReadResponse',
  '2': [
    {
      '1': 'entity',
      '3': 1,
      '4': 1,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.device.DeviceRead',
      '10': 'entity'
    },
    {'1': 'etag', '3': 2, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `DeviceReadResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceReadResponseDescriptor = $convert.base64Decode(
    'ChJEZXZpY2VSZWFkUmVzcG9uc2USYAoGZW50aXR5GAEgASgLMkgucmF6bWFuYWdlci5wcm90b2'
    'J1Zi5pbnRlcm5hbC5yZXBvc2l0b3J5LmNydWRfc2VydmljZXMuZGV2aWNlLkRldmljZVJlYWRS'
    'BmVudGl0eRISCgRldGFnGAIgASgJUgRldGFn');

@$core.Deprecated('Use deviceReadDescriptor instead')
const DeviceRead$json = {
  '1': 'DeviceRead',
  '2': [
    {
      '1': 'id',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'id'
    },
    {
      '1': 'name',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'name'
    },
    {
      '1': 'description',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'description'
    },
    {'1': 'simulated', '3': 4, '4': 1, '5': 8, '10': 'simulated'},
    {
      '1': 'device_configurations',
      '3': 6,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.device.DeviceConfigurationRead',
      '10': 'deviceConfigurations'
    },
  ],
};

/// Descriptor for `DeviceRead`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceReadDescriptor = $convert.base64Decode(
    'CgpEZXZpY2VSZWFkEiwKAmlkGAEgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUg'
    'JpZBIwCgRuYW1lGAIgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUgRuYW1lEj4K'
    'C2Rlc2NyaXB0aW9uGAMgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUgtkZXNjcm'
    'lwdGlvbhIcCglzaW11bGF0ZWQYBCABKAhSCXNpbXVsYXRlZBKKAQoVZGV2aWNlX2NvbmZpZ3Vy'
    'YXRpb25zGAYgAygLMlUucmF6bWFuYWdlci5wcm90b2J1Zi5pbnRlcm5hbC5yZXBvc2l0b3J5Lm'
    'NydWRfc2VydmljZXMuZGV2aWNlLkRldmljZUNvbmZpZ3VyYXRpb25SZWFkUhRkZXZpY2VDb25m'
    'aWd1cmF0aW9ucw==');

@$core.Deprecated('Use deviceCreateUpdateDescriptor instead')
const DeviceCreateUpdate$json = {
  '1': 'DeviceCreateUpdate',
  '2': [
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'description',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'description'
    },
    {
      '1': 'device_configurations',
      '3': 6,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.device.DeviceConfigurationCreateUpdate',
      '10': 'deviceConfigurations'
    },
  ],
};

/// Descriptor for `DeviceCreateUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceCreateUpdateDescriptor = $convert.base64Decode(
    'ChJEZXZpY2VDcmVhdGVVcGRhdGUSEgoEbmFtZRgCIAEoCVIEbmFtZRI+CgtkZXNjcmlwdGlvbh'
    'gDIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZVILZGVzY3JpcHRpb24SkgEKFWRl'
    'dmljZV9jb25maWd1cmF0aW9ucxgGIAMoCzJdLnJhem1hbmFnZXIucHJvdG9idWYuaW50ZXJuYW'
    'wucmVwb3NpdG9yeS5jcnVkX3NlcnZpY2VzLmRldmljZS5EZXZpY2VDb25maWd1cmF0aW9uQ3Jl'
    'YXRlVXBkYXRlUhRkZXZpY2VDb25maWd1cmF0aW9ucw==');

@$core.Deprecated('Use deviceUpdateRequestDescriptor instead')
const DeviceUpdateRequest$json = {
  '1': 'DeviceUpdateRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'entity',
      '3': 2,
      '4': 1,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.device.DeviceCreateUpdate',
      '10': 'entity'
    },
    {'1': 'etag', '3': 3, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `DeviceUpdateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceUpdateRequestDescriptor = $convert.base64Decode(
    'ChNEZXZpY2VVcGRhdGVSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZBJoCgZlbnRpdHkYAiABKAsyUC'
    '5yYXptYW5hZ2VyLnByb3RvYnVmLmludGVybmFsLnJlcG9zaXRvcnkuY3J1ZF9zZXJ2aWNlcy5k'
    'ZXZpY2UuRGV2aWNlQ3JlYXRlVXBkYXRlUgZlbnRpdHkSEgoEZXRhZxgDIAEoCVIEZXRhZw==');

@$core.Deprecated('Use deviceConfigurationReadDescriptor instead')
const DeviceConfigurationRead$json = {
  '1': 'DeviceConfigurationRead',
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
  ],
};

/// Descriptor for `DeviceConfigurationRead`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceConfigurationReadDescriptor = $convert.base64Decode(
    'ChdEZXZpY2VDb25maWd1cmF0aW9uUmVhZBIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCV'
    'IEbmFtZRJ9ChtkZXZpY2VfY29uZmlndXJhdGlvbl9pbnB1dHMYAyADKAsyPS5yYXptYW5hZ2Vy'
    'LnByb3RvYnVmLnB1YmxpYy52MS5EZXZpY2VEZXZpY2VDb25maWd1cmF0aW9uSW5wdXRSGWRldm'
    'ljZUNvbmZpZ3VyYXRpb25JbnB1dHMSgAEKHGRldmljZV9jb25maWd1cmF0aW9uX291dHB1dHMY'
    'BCADKAsyPi5yYXptYW5hZ2VyLnByb3RvYnVmLnB1YmxpYy52MS5EZXZpY2VEZXZpY2VDb25maW'
    'd1cmF0aW9uT3V0cHV0UhpkZXZpY2VDb25maWd1cmF0aW9uT3V0cHV0cw==');

@$core.Deprecated('Use deviceConfigurationCreateUpdateDescriptor instead')
const DeviceConfigurationCreateUpdate$json = {
  '1': 'DeviceConfigurationCreateUpdate',
  '2': [
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
  ],
};

/// Descriptor for `DeviceConfigurationCreateUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceConfigurationCreateUpdateDescriptor = $convert.base64Decode(
    'Ch9EZXZpY2VDb25maWd1cmF0aW9uQ3JlYXRlVXBkYXRlEn0KG2RldmljZV9jb25maWd1cmF0aW'
    '9uX2lucHV0cxgDIAMoCzI9LnJhem1hbmFnZXIucHJvdG9idWYucHVibGljLnYxLkRldmljZURl'
    'dmljZUNvbmZpZ3VyYXRpb25JbnB1dFIZZGV2aWNlQ29uZmlndXJhdGlvbklucHV0cxKAAQocZG'
    'V2aWNlX2NvbmZpZ3VyYXRpb25fb3V0cHV0cxgEIAMoCzI+LnJhem1hbmFnZXIucHJvdG9idWYu'
    'cHVibGljLnYxLkRldmljZURldmljZUNvbmZpZ3VyYXRpb25PdXRwdXRSGmRldmljZUNvbmZpZ3'
    'VyYXRpb25PdXRwdXRz');

@$core.Deprecated('Use deviceListResponseDescriptor instead')
const DeviceListResponse$json = {
  '1': 'DeviceListResponse',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.device.DeviceList',
      '10': 'result'
    },
  ],
};

/// Descriptor for `DeviceListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceListResponseDescriptor = $convert.base64Decode(
    'ChJEZXZpY2VMaXN0UmVzcG9uc2USYAoGcmVzdWx0GAEgAygLMkgucmF6bWFuYWdlci5wcm90b2'
    'J1Zi5pbnRlcm5hbC5yZXBvc2l0b3J5LmNydWRfc2VydmljZXMuZGV2aWNlLkRldmljZUxpc3RS'
    'BnJlc3VsdA==');

@$core.Deprecated('Use deviceListDescriptor instead')
const DeviceList$json = {
  '1': 'DeviceList',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'description',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'description'
    },
    {'1': 'connected', '3': 4, '4': 1, '5': 8, '10': 'connected'},
    {
      '1': 'last_connected_at',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'lastConnectedAt'
    },
    {'1': 'simulated', '3': 6, '4': 1, '5': 8, '10': 'simulated'},
    {'1': 'etag', '3': 7, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `DeviceList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceListDescriptor = $convert.base64Decode(
    'CgpEZXZpY2VMaXN0Eg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEj4KC2Rlc2'
    'NyaXB0aW9uGAMgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUgtkZXNjcmlwdGlv'
    'bhIcCgljb25uZWN0ZWQYBCABKAhSCWNvbm5lY3RlZBJGChFsYXN0X2Nvbm5lY3RlZF9hdBgFIA'
    'EoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSD2xhc3RDb25uZWN0ZWRBdBIcCglzaW11'
    'bGF0ZWQYBiABKAhSCXNpbXVsYXRlZBISCgRldGFnGAcgASgJUgRldGFn');

@$core.Deprecated('Use deviceSelectDescriptor instead')
const DeviceSelect$json = {
  '1': 'DeviceSelect',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `DeviceSelect`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceSelectDescriptor = $convert.base64Decode(
    'CgxEZXZpY2VTZWxlY3QSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWU=');

@$core.Deprecated('Use deviceCommissioningCertificateRequestDescriptor instead')
const DeviceCommissioningCertificateRequest$json = {
  '1': 'DeviceCommissioningCertificateRequest',
  '2': [
    {
      '1': 'certificate_request_pem',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'certificateRequestPem'
    },
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `DeviceCommissioningCertificateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceCommissioningCertificateRequestDescriptor =
    $convert.base64Decode(
        'CiVEZXZpY2VDb21taXNzaW9uaW5nQ2VydGlmaWNhdGVSZXF1ZXN0EjYKF2NlcnRpZmljYXRlX3'
        'JlcXVlc3RfcGVtGAEgASgJUhVjZXJ0aWZpY2F0ZVJlcXVlc3RQZW0SEgoEbmFtZRgCIAEoCVIE'
        'bmFtZQ==');

@$core
    .Deprecated('Use deviceCommissioningCertificateResponseDescriptor instead')
const DeviceCommissioningCertificateResponse$json = {
  '1': 'DeviceCommissioningCertificateResponse',
  '2': [
    {'1': 'certificate_pem', '3': 1, '4': 1, '5': 9, '10': 'certificatePem'},
  ],
};

/// Descriptor for `DeviceCommissioningCertificateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceCommissioningCertificateResponseDescriptor =
    $convert.base64Decode(
        'CiZEZXZpY2VDb21taXNzaW9uaW5nQ2VydGlmaWNhdGVSZXNwb25zZRInCg9jZXJ0aWZpY2F0ZV'
        '9wZW0YASABKAlSDmNlcnRpZmljYXRlUGVt');
