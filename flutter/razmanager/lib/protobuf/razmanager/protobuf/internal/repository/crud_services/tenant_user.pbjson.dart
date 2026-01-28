// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/tenant_user.proto.

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

@$core.Deprecated('Use tenantUserSelectRequestDescriptor instead')
const TenantUserSelectRequest$json = {
  '1': 'TenantUserSelectRequest',
  '2': [
    {'1': 'user_ids_exclude', '3': 1, '4': 3, '5': 9, '10': 'userIdsExclude'},
    {
      '1': 'short_names_exclude',
      '3': 2,
      '4': 3,
      '5': 9,
      '10': 'shortNamesExclude'
    },
  ],
};

/// Descriptor for `TenantUserSelectRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tenantUserSelectRequestDescriptor = $convert.base64Decode(
    'ChdUZW5hbnRVc2VyU2VsZWN0UmVxdWVzdBIoChB1c2VyX2lkc19leGNsdWRlGAEgAygJUg51c2'
    'VySWRzRXhjbHVkZRIuChNzaG9ydF9uYW1lc19leGNsdWRlGAIgAygJUhFzaG9ydE5hbWVzRXhj'
    'bHVkZQ==');

@$core.Deprecated('Use tenantUserSelectResponseDescriptor instead')
const TenantUserSelectResponse$json = {
  '1': 'TenantUserSelectResponse',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.tenant_user.TenantUserSelect',
      '10': 'result'
    },
  ],
};

/// Descriptor for `TenantUserSelectResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tenantUserSelectResponseDescriptor = $convert.base64Decode(
    'ChhUZW5hbnRVc2VyU2VsZWN0UmVzcG9uc2USawoGcmVzdWx0GAEgAygLMlMucmF6bWFuYWdlci'
    '5wcm90b2J1Zi5pbnRlcm5hbC5yZXBvc2l0b3J5LmNydWRfc2VydmljZXMudGVuYW50X3VzZXIu'
    'VGVuYW50VXNlclNlbGVjdFIGcmVzdWx0');

@$core.Deprecated('Use tenantUserSelectDescriptor instead')
const TenantUserSelect$json = {
  '1': 'TenantUserSelect',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'user_id',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'userId'
    },
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'short_name',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'shortName'
    },
    {
      '1': 'image',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BytesValue',
      '10': 'image'
    },
  ],
};

/// Descriptor for `TenantUserSelect`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tenantUserSelectDescriptor = $convert.base64Decode(
    'ChBUZW5hbnRVc2VyU2VsZWN0Eg4KAmlkGAEgASgJUgJpZBI1Cgd1c2VyX2lkGAIgASgLMhwuZ2'
    '9vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUgZ1c2VySWQSEgoEbmFtZRgDIAEoCVIEbmFtZRI7'
    'CgpzaG9ydF9uYW1lGAQgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUglzaG9ydE'
    '5hbWUSMQoFaW1hZ2UYBSABKAsyGy5nb29nbGUucHJvdG9idWYuQnl0ZXNWYWx1ZVIFaW1hZ2U=');
