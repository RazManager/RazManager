// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/user.proto.

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

@$core.Deprecated('Use userReadResponseDescriptor instead')
const UserReadResponse$json = {
  '1': 'UserReadResponse',
  '2': [
    {
      '1': 'entity',
      '3': 1,
      '4': 1,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.user.UserRead',
      '10': 'entity'
    },
    {'1': 'etag', '3': 2, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `UserReadResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userReadResponseDescriptor = $convert.base64Decode(
    'ChBVc2VyUmVhZFJlc3BvbnNlElwKBmVudGl0eRgBIAEoCzJELnJhem1hbmFnZXIucHJvdG9idW'
    'YuaW50ZXJuYWwucmVwb3NpdG9yeS5jcnVkX3NlcnZpY2VzLnVzZXIuVXNlclJlYWRSBmVudGl0'
    'eRISCgRldGFnGAIgASgJUgRldGFn');

@$core.Deprecated('Use userReadDescriptor instead')
const UserRead$json = {
  '1': 'UserRead',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'user_name',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'userName'
    },
    {
      '1': 'email',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'email'
    },
    {
      '1': 'name',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'name'
    },
    {
      '1': 'short_name',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'shortName'
    },
    {
      '1': 'image',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BytesValue',
      '10': 'image'
    },
    {
      '1': 'events',
      '3': 7,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.user_services.event.EventSelect',
      '10': 'events'
    },
    {
      '1': 'tenants',
      '3': 8,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.user_services.tenant.TenantSelect',
      '10': 'tenants'
    },
  ],
};

/// Descriptor for `UserRead`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userReadDescriptor = $convert.base64Decode(
    'CghVc2VyUmVhZBIOCgJpZBgBIAEoCVICaWQSOQoJdXNlcl9uYW1lGAIgASgLMhwuZ29vZ2xlLn'
    'Byb3RvYnVmLlN0cmluZ1ZhbHVlUgh1c2VyTmFtZRIyCgVlbWFpbBgDIAEoCzIcLmdvb2dsZS5w'
    'cm90b2J1Zi5TdHJpbmdWYWx1ZVIFZW1haWwSMAoEbmFtZRgEIAEoCzIcLmdvb2dsZS5wcm90b2'
    'J1Zi5TdHJpbmdWYWx1ZVIEbmFtZRI7CgpzaG9ydF9uYW1lGAUgASgLMhwuZ29vZ2xlLnByb3Rv'
    'YnVmLlN0cmluZ1ZhbHVlUglzaG9ydE5hbWUSMQoFaW1hZ2UYBiABKAsyGy5nb29nbGUucHJvdG'
    '9idWYuQnl0ZXNWYWx1ZVIFaW1hZ2USYAoGZXZlbnRzGAcgAygLMkgucmF6bWFuYWdlci5wcm90'
    'b2J1Zi5pbnRlcm5hbC5yZXBvc2l0b3J5LnVzZXJfc2VydmljZXMuZXZlbnQuRXZlbnRTZWxlY3'
    'RSBmV2ZW50cxJkCgd0ZW5hbnRzGAggAygLMkoucmF6bWFuYWdlci5wcm90b2J1Zi5pbnRlcm5h'
    'bC5yZXBvc2l0b3J5LnVzZXJfc2VydmljZXMudGVuYW50LlRlbmFudFNlbGVjdFIHdGVuYW50cw'
    '==');

@$core.Deprecated('Use userCreateDescriptor instead')
const UserCreate$json = {
  '1': 'UserCreate',
  '2': [
    {'1': 'user_name', '3': 2, '4': 1, '5': 9, '10': 'userName'},
    {
      '1': 'email',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'email'
    },
    {'1': 'name', '3': 4, '4': 1, '5': 9, '10': 'name'},
    {'1': 'short_name', '3': 5, '4': 1, '5': 9, '10': 'shortName'},
    {'1': 'image', '3': 6, '4': 1, '5': 12, '9': 0, '10': 'image', '17': true},
    {'1': 'password', '3': 7, '4': 1, '5': 9, '10': 'password'},
  ],
  '8': [
    {'1': '_image'},
  ],
};

/// Descriptor for `UserCreate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userCreateDescriptor = $convert.base64Decode(
    'CgpVc2VyQ3JlYXRlEhsKCXVzZXJfbmFtZRgCIAEoCVIIdXNlck5hbWUSMgoFZW1haWwYAyABKA'
    'syHC5nb29nbGUucHJvdG9idWYuU3RyaW5nVmFsdWVSBWVtYWlsEhIKBG5hbWUYBCABKAlSBG5h'
    'bWUSHQoKc2hvcnRfbmFtZRgFIAEoCVIJc2hvcnROYW1lEhkKBWltYWdlGAYgASgMSABSBWltYW'
    'dliAEBEhoKCHBhc3N3b3JkGAcgASgJUghwYXNzd29yZEIICgZfaW1hZ2U=');

@$core.Deprecated('Use userUpdateDescriptor instead')
const UserUpdate$json = {
  '1': 'UserUpdate',
  '2': [
    {
      '1': 'email',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'email'
    },
    {'1': 'name', '3': 4, '4': 1, '5': 9, '10': 'name'},
    {'1': 'short_name', '3': 5, '4': 1, '5': 9, '10': 'shortName'},
    {'1': 'image', '3': 6, '4': 1, '5': 12, '9': 0, '10': 'image', '17': true},
    {
      '1': 'image_deleted',
      '3': 7,
      '4': 1,
      '5': 8,
      '9': 1,
      '10': 'imageDeleted',
      '17': true
    },
    {'1': 'events_deleted', '3': 8, '4': 3, '5': 9, '10': 'eventsDeleted'},
    {'1': 'tenants_deleted', '3': 9, '4': 3, '5': 9, '10': 'tenantsDeleted'},
  ],
  '8': [
    {'1': '_image'},
    {'1': '_image_deleted'},
  ],
};

/// Descriptor for `UserUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userUpdateDescriptor = $convert.base64Decode(
    'CgpVc2VyVXBkYXRlEjIKBWVtYWlsGAMgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbH'
    'VlUgVlbWFpbBISCgRuYW1lGAQgASgJUgRuYW1lEh0KCnNob3J0X25hbWUYBSABKAlSCXNob3J0'
    'TmFtZRIZCgVpbWFnZRgGIAEoDEgAUgVpbWFnZYgBARIoCg1pbWFnZV9kZWxldGVkGAcgASgISA'
    'FSDGltYWdlRGVsZXRlZIgBARIlCg5ldmVudHNfZGVsZXRlZBgIIAMoCVINZXZlbnRzRGVsZXRl'
    'ZBInCg90ZW5hbnRzX2RlbGV0ZWQYCSADKAlSDnRlbmFudHNEZWxldGVkQggKBl9pbWFnZUIQCg'
    '5faW1hZ2VfZGVsZXRlZA==');

@$core.Deprecated('Use userUpdateRequestDescriptor instead')
const UserUpdateRequest$json = {
  '1': 'UserUpdateRequest',
  '2': [
    {
      '1': 'entity',
      '3': 2,
      '4': 1,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.user.UserUpdate',
      '10': 'entity'
    },
    {'1': 'etag', '3': 3, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `UserUpdateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userUpdateRequestDescriptor = $convert.base64Decode(
    'ChFVc2VyVXBkYXRlUmVxdWVzdBJeCgZlbnRpdHkYAiABKAsyRi5yYXptYW5hZ2VyLnByb3RvYn'
    'VmLmludGVybmFsLnJlcG9zaXRvcnkuY3J1ZF9zZXJ2aWNlcy51c2VyLlVzZXJVcGRhdGVSBmVu'
    'dGl0eRISCgRldGFnGAMgASgJUgRldGFn');

@$core.Deprecated('Use userSelectDescriptor instead')
const UserSelect$json = {
  '1': 'UserSelect',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'short_name', '3': 3, '4': 1, '5': 9, '10': 'shortName'},
  ],
};

/// Descriptor for `UserSelect`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userSelectDescriptor = $convert.base64Decode(
    'CgpVc2VyU2VsZWN0Eg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEh0KCnNob3'
    'J0X25hbWUYAyABKAlSCXNob3J0TmFtZQ==');
