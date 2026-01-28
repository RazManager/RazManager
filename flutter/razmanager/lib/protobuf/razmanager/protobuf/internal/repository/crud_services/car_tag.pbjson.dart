// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/car_tag.proto.

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

@$core.Deprecated('Use carTagReadResponseDescriptor instead')
const CarTagReadResponse$json = {
  '1': 'CarTagReadResponse',
  '2': [
    {
      '1': 'entity',
      '3': 1,
      '4': 1,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.car_tag.CarTagRead',
      '10': 'entity'
    },
    {'1': 'etag', '3': 2, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `CarTagReadResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List carTagReadResponseDescriptor = $convert.base64Decode(
    'ChJDYXJUYWdSZWFkUmVzcG9uc2USYQoGZW50aXR5GAEgASgLMkkucmF6bWFuYWdlci5wcm90b2'
    'J1Zi5pbnRlcm5hbC5yZXBvc2l0b3J5LmNydWRfc2VydmljZXMuY2FyX3RhZy5DYXJUYWdSZWFk'
    'UgZlbnRpdHkSEgoEZXRhZxgCIAEoCVIEZXRhZw==');

@$core.Deprecated('Use carTagReadDescriptor instead')
const CarTagRead$json = {
  '1': 'CarTagRead',
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
    {'1': 'position', '3': 4, '4': 1, '5': 13, '10': 'position'},
  ],
};

/// Descriptor for `CarTagRead`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List carTagReadDescriptor = $convert.base64Decode(
    'CgpDYXJUYWdSZWFkEiwKAmlkGAEgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUg'
    'JpZBIwCgRuYW1lGAIgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUgRuYW1lEj4K'
    'C2Rlc2NyaXB0aW9uGAMgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUgtkZXNjcm'
    'lwdGlvbhIaCghwb3NpdGlvbhgEIAEoDVIIcG9zaXRpb24=');

@$core.Deprecated('Use carTagCreateUpdateDescriptor instead')
const CarTagCreateUpdate$json = {
  '1': 'CarTagCreateUpdate',
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
    {'1': 'position', '3': 4, '4': 1, '5': 13, '10': 'position'},
  ],
};

/// Descriptor for `CarTagCreateUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List carTagCreateUpdateDescriptor = $convert.base64Decode(
    'ChJDYXJUYWdDcmVhdGVVcGRhdGUSEgoEbmFtZRgCIAEoCVIEbmFtZRI+CgtkZXNjcmlwdGlvbh'
    'gDIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZVILZGVzY3JpcHRpb24SGgoIcG9z'
    'aXRpb24YBCABKA1SCHBvc2l0aW9u');

@$core.Deprecated('Use carTagUpdateRequestDescriptor instead')
const CarTagUpdateRequest$json = {
  '1': 'CarTagUpdateRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'entity',
      '3': 2,
      '4': 1,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.car_tag.CarTagCreateUpdate',
      '10': 'entity'
    },
    {'1': 'etag', '3': 3, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `CarTagUpdateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List carTagUpdateRequestDescriptor = $convert.base64Decode(
    'ChNDYXJUYWdVcGRhdGVSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZBJpCgZlbnRpdHkYAiABKAsyUS'
    '5yYXptYW5hZ2VyLnByb3RvYnVmLmludGVybmFsLnJlcG9zaXRvcnkuY3J1ZF9zZXJ2aWNlcy5j'
    'YXJfdGFnLkNhclRhZ0NyZWF0ZVVwZGF0ZVIGZW50aXR5EhIKBGV0YWcYAyABKAlSBGV0YWc=');

@$core.Deprecated('Use carTagListDescriptor instead')
const CarTagList$json = {
  '1': 'CarTagList',
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
    {'1': 'etag', '3': 4, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `CarTagList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List carTagListDescriptor = $convert.base64Decode(
    'CgpDYXJUYWdMaXN0Eg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEj4KC2Rlc2'
    'NyaXB0aW9uGAMgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUgtkZXNjcmlwdGlv'
    'bhISCgRldGFnGAQgASgJUgRldGFn');

@$core.Deprecated('Use carTagListResponseDescriptor instead')
const CarTagListResponse$json = {
  '1': 'CarTagListResponse',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.car_tag.CarTagList',
      '10': 'result'
    },
  ],
};

/// Descriptor for `CarTagListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List carTagListResponseDescriptor = $convert.base64Decode(
    'ChJDYXJUYWdMaXN0UmVzcG9uc2USYQoGcmVzdWx0GAEgAygLMkkucmF6bWFuYWdlci5wcm90b2'
    'J1Zi5pbnRlcm5hbC5yZXBvc2l0b3J5LmNydWRfc2VydmljZXMuY2FyX3RhZy5DYXJUYWdMaXN0'
    'UgZyZXN1bHQ=');

@$core.Deprecated('Use carTagSelectDescriptor instead')
const CarTagSelect$json = {
  '1': 'CarTagSelect',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `CarTagSelect`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List carTagSelectDescriptor = $convert.base64Decode(
    'CgxDYXJUYWdTZWxlY3QSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWU=');

@$core.Deprecated('Use carTagSelectResponseDescriptor instead')
const CarTagSelectResponse$json = {
  '1': 'CarTagSelectResponse',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.car_tag.CarTagSelect',
      '10': 'result'
    },
  ],
};

/// Descriptor for `CarTagSelectResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List carTagSelectResponseDescriptor = $convert.base64Decode(
    'ChRDYXJUYWdTZWxlY3RSZXNwb25zZRJjCgZyZXN1bHQYASADKAsySy5yYXptYW5hZ2VyLnByb3'
    'RvYnVmLmludGVybmFsLnJlcG9zaXRvcnkuY3J1ZF9zZXJ2aWNlcy5jYXJfdGFnLkNhclRhZ1Nl'
    'bGVjdFIGcmVzdWx0');
