// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/tenant.proto.

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

@$core.Deprecated('Use tenantReadResponseDescriptor instead')
const TenantReadResponse$json = {
  '1': 'TenantReadResponse',
  '2': [
    {
      '1': 'entity',
      '3': 1,
      '4': 1,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.tenant.TenantRead',
      '10': 'entity'
    },
    {'1': 'etag', '3': 2, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `TenantReadResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tenantReadResponseDescriptor = $convert.base64Decode(
    'ChJUZW5hbnRSZWFkUmVzcG9uc2USYAoGZW50aXR5GAEgASgLMkgucmF6bWFuYWdlci5wcm90b2'
    'J1Zi5pbnRlcm5hbC5yZXBvc2l0b3J5LmNydWRfc2VydmljZXMudGVuYW50LlRlbmFudFJlYWRS'
    'BmVudGl0eRISCgRldGFnGAIgASgJUgRldGFn');

@$core.Deprecated('Use tenantReadDescriptor instead')
const TenantRead$json = {
  '1': 'TenantRead',
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
    {
      '1': 'image',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BytesValue',
      '10': 'image'
    },
    {
      '1': 'tenant_invites',
      '3': 6,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.tenant.TenantInviteReadCreateUpdate',
      '10': 'tenantInvites'
    },
    {
      '1': 'tenant_users',
      '3': 7,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.tenant.TenantUserReadCreateUpdate',
      '10': 'tenantUsers'
    },
  ],
};

/// Descriptor for `TenantRead`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tenantReadDescriptor = $convert.base64Decode(
    'CgpUZW5hbnRSZWFkEiwKAmlkGAEgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUg'
    'JpZBIwCgRuYW1lGAIgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUgRuYW1lEj4K'
    'C2Rlc2NyaXB0aW9uGAMgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUgtkZXNjcm'
    'lwdGlvbhIxCgVpbWFnZRgEIAEoCzIbLmdvb2dsZS5wcm90b2J1Zi5CeXRlc1ZhbHVlUgVpbWFn'
    'ZRKBAQoOdGVuYW50X2ludml0ZXMYBiADKAsyWi5yYXptYW5hZ2VyLnByb3RvYnVmLmludGVybm'
    'FsLnJlcG9zaXRvcnkuY3J1ZF9zZXJ2aWNlcy50ZW5hbnQuVGVuYW50SW52aXRlUmVhZENyZWF0'
    'ZVVwZGF0ZVINdGVuYW50SW52aXRlcxJ7Cgx0ZW5hbnRfdXNlcnMYByADKAsyWC5yYXptYW5hZ2'
    'VyLnByb3RvYnVmLmludGVybmFsLnJlcG9zaXRvcnkuY3J1ZF9zZXJ2aWNlcy50ZW5hbnQuVGVu'
    'YW50VXNlclJlYWRDcmVhdGVVcGRhdGVSC3RlbmFudFVzZXJz');

@$core.Deprecated('Use tenantCreateUpdateDescriptor instead')
const TenantCreateUpdate$json = {
  '1': 'TenantCreateUpdate',
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
    {'1': 'image', '3': 4, '4': 1, '5': 12, '9': 0, '10': 'image', '17': true},
    {
      '1': 'image_deleted',
      '3': 5,
      '4': 1,
      '5': 8,
      '9': 1,
      '10': 'imageDeleted',
      '17': true
    },
    {
      '1': 'tenant_invites',
      '3': 6,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.tenant.TenantInviteReadCreateUpdate',
      '10': 'tenantInvites'
    },
    {
      '1': 'tenant_invites_deleted',
      '3': 7,
      '4': 3,
      '5': 9,
      '10': 'tenantInvitesDeleted'
    },
    {
      '1': 'tenant_users',
      '3': 8,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.tenant.TenantUserReadCreateUpdate',
      '10': 'tenantUsers'
    },
    {
      '1': 'tenant_users_deleted',
      '3': 9,
      '4': 3,
      '5': 9,
      '10': 'tenantUsersDeleted'
    },
  ],
  '8': [
    {'1': '_image'},
    {'1': '_image_deleted'},
  ],
};

/// Descriptor for `TenantCreateUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tenantCreateUpdateDescriptor = $convert.base64Decode(
    'ChJUZW5hbnRDcmVhdGVVcGRhdGUSEgoEbmFtZRgCIAEoCVIEbmFtZRI+CgtkZXNjcmlwdGlvbh'
    'gDIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZVILZGVzY3JpcHRpb24SGQoFaW1h'
    'Z2UYBCABKAxIAFIFaW1hZ2WIAQESKAoNaW1hZ2VfZGVsZXRlZBgFIAEoCEgBUgxpbWFnZURlbG'
    'V0ZWSIAQESgQEKDnRlbmFudF9pbnZpdGVzGAYgAygLMloucmF6bWFuYWdlci5wcm90b2J1Zi5p'
    'bnRlcm5hbC5yZXBvc2l0b3J5LmNydWRfc2VydmljZXMudGVuYW50LlRlbmFudEludml0ZVJlYW'
    'RDcmVhdGVVcGRhdGVSDXRlbmFudEludml0ZXMSNAoWdGVuYW50X2ludml0ZXNfZGVsZXRlZBgH'
    'IAMoCVIUdGVuYW50SW52aXRlc0RlbGV0ZWQSewoMdGVuYW50X3VzZXJzGAggAygLMlgucmF6bW'
    'FuYWdlci5wcm90b2J1Zi5pbnRlcm5hbC5yZXBvc2l0b3J5LmNydWRfc2VydmljZXMudGVuYW50'
    'LlRlbmFudFVzZXJSZWFkQ3JlYXRlVXBkYXRlUgt0ZW5hbnRVc2VycxIwChR0ZW5hbnRfdXNlcn'
    'NfZGVsZXRlZBgJIAMoCVISdGVuYW50VXNlcnNEZWxldGVkQggKBl9pbWFnZUIQCg5faW1hZ2Vf'
    'ZGVsZXRlZA==');

@$core.Deprecated('Use tenantUpdateRequestDescriptor instead')
const TenantUpdateRequest$json = {
  '1': 'TenantUpdateRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'entity',
      '3': 2,
      '4': 1,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.tenant.TenantCreateUpdate',
      '10': 'entity'
    },
    {'1': 'etag', '3': 3, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `TenantUpdateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tenantUpdateRequestDescriptor = $convert.base64Decode(
    'ChNUZW5hbnRVcGRhdGVSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZBJoCgZlbnRpdHkYAiABKAsyUC'
    '5yYXptYW5hZ2VyLnByb3RvYnVmLmludGVybmFsLnJlcG9zaXRvcnkuY3J1ZF9zZXJ2aWNlcy50'
    'ZW5hbnQuVGVuYW50Q3JlYXRlVXBkYXRlUgZlbnRpdHkSEgoEZXRhZxgDIAEoCVIEZXRhZw==');

@$core.Deprecated('Use tenantInviteReadCreateUpdateDescriptor instead')
const TenantInviteReadCreateUpdate$json = {
  '1': 'TenantInviteReadCreateUpdate',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'code', '3': 2, '4': 1, '5': 5, '10': 'code'},
    {'1': 'multiple', '3': 3, '4': 1, '5': 8, '10': 'multiple'},
    {
      '1': 'time_to_live_at',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'timeToLiveAt'
    },
  ],
};

/// Descriptor for `TenantInviteReadCreateUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tenantInviteReadCreateUpdateDescriptor =
    $convert.base64Decode(
        'ChxUZW5hbnRJbnZpdGVSZWFkQ3JlYXRlVXBkYXRlEg4KAmlkGAEgASgJUgJpZBISCgRjb2RlGA'
        'IgASgFUgRjb2RlEhoKCG11bHRpcGxlGAMgASgIUghtdWx0aXBsZRJBCg90aW1lX3RvX2xpdmVf'
        'YXQYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgx0aW1lVG9MaXZlQXQ=');

@$core.Deprecated('Use tenantUserReadCreateUpdateDescriptor instead')
const TenantUserReadCreateUpdate$json = {
  '1': 'TenantUserReadCreateUpdate',
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
    {
      '1': 'name',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'name'
    },
    {
      '1': 'short_name',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'shortName'
    },
    {'1': 'administrator', '3': 5, '4': 1, '5': 8, '10': 'administrator'},
  ],
};

/// Descriptor for `TenantUserReadCreateUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tenantUserReadCreateUpdateDescriptor = $convert.base64Decode(
    'ChpUZW5hbnRVc2VyUmVhZENyZWF0ZVVwZGF0ZRIOCgJpZBgBIAEoCVICaWQSNQoHdXNlcl9pZB'
    'gCIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZVIGdXNlcklkEjAKBG5hbWUYAyAB'
    'KAsyHC5nb29nbGUucHJvdG9idWYuU3RyaW5nVmFsdWVSBG5hbWUSOwoKc2hvcnRfbmFtZRgEIA'
    'EoCzIcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZVIJc2hvcnROYW1lEiQKDWFkbWluaXN0'
    'cmF0b3IYBSABKAhSDWFkbWluaXN0cmF0b3I=');
