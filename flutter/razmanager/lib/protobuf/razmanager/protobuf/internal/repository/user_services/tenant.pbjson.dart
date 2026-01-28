// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/user_services/tenant.proto.

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

@$core.Deprecated('Use tenantReadDescriptor instead')
const TenantRead$json = {
  '1': 'TenantRead',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `TenantRead`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tenantReadDescriptor = $convert.base64Decode(
    'CgpUZW5hbnRSZWFkEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1l');

@$core.Deprecated('Use tenantSelectResponseDescriptor instead')
const TenantSelectResponse$json = {
  '1': 'TenantSelectResponse',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.user_services.tenant.TenantSelect',
      '10': 'result'
    },
  ],
};

/// Descriptor for `TenantSelectResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tenantSelectResponseDescriptor = $convert.base64Decode(
    'ChRUZW5hbnRTZWxlY3RSZXNwb25zZRJiCgZyZXN1bHQYASADKAsySi5yYXptYW5hZ2VyLnByb3'
    'RvYnVmLmludGVybmFsLnJlcG9zaXRvcnkudXNlcl9zZXJ2aWNlcy50ZW5hbnQuVGVuYW50U2Vs'
    'ZWN0UgZyZXN1bHQ=');

@$core.Deprecated('Use tenantSelectDescriptor instead')
const TenantSelect$json = {
  '1': 'TenantSelect',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'image',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BytesValue',
      '10': 'image'
    },
    {'1': 'administrator', '3': 4, '4': 1, '5': 8, '10': 'administrator'},
  ],
};

/// Descriptor for `TenantSelect`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tenantSelectDescriptor = $convert.base64Decode(
    'CgxUZW5hbnRTZWxlY3QSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSMQoFaW'
    '1hZ2UYAyABKAsyGy5nb29nbGUucHJvdG9idWYuQnl0ZXNWYWx1ZVIFaW1hZ2USJAoNYWRtaW5p'
    'c3RyYXRvchgEIAEoCFINYWRtaW5pc3RyYXRvcg==');
