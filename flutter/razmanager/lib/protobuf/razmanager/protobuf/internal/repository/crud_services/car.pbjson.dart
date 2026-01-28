// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/car.proto.

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

@$core.Deprecated('Use carReadResponseDescriptor instead')
const CarReadResponse$json = {
  '1': 'CarReadResponse',
  '2': [
    {
      '1': 'entity',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.internal.repository.crud_services.car.CarRead',
      '10': 'entity'
    },
    {'1': 'etag', '3': 2, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `CarReadResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List carReadResponseDescriptor = $convert.base64Decode(
    'Cg9DYXJSZWFkUmVzcG9uc2USWgoGZW50aXR5GAEgASgLMkIucmF6bWFuYWdlci5wcm90b2J1Zi'
    '5pbnRlcm5hbC5yZXBvc2l0b3J5LmNydWRfc2VydmljZXMuY2FyLkNhclJlYWRSBmVudGl0eRIS'
    'CgRldGFnGAIgASgJUgRldGFn');

@$core.Deprecated('Use carReadDescriptor instead')
const CarRead$json = {
  '1': 'CarRead',
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
      '1': 'number',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'number'
    },
    {
      '1': 'description',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'description'
    },
    {'1': 'car_tag_ids', '3': 5, '4': 3, '5': 9, '10': 'carTagIds'},
    {
      '1': 'track_configuration_ids',
      '3': 6,
      '4': 3,
      '5': 9,
      '10': 'trackConfigurationIds'
    },
    {
      '1': 'image',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BytesValue',
      '10': 'image'
    },
  ],
};

/// Descriptor for `CarRead`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List carReadDescriptor = $convert.base64Decode(
    'CgdDYXJSZWFkEiwKAmlkGAEgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUgJpZB'
    'IwCgRuYW1lGAIgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUgRuYW1lEjQKBm51'
    'bWJlchgDIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5VSW50MzJWYWx1ZVIGbnVtYmVyEj4KC2Rlc2'
    'NyaXB0aW9uGAQgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUgtkZXNjcmlwdGlv'
    'bhIeCgtjYXJfdGFnX2lkcxgFIAMoCVIJY2FyVGFnSWRzEjYKF3RyYWNrX2NvbmZpZ3VyYXRpb2'
    '5faWRzGAYgAygJUhV0cmFja0NvbmZpZ3VyYXRpb25JZHMSMQoFaW1hZ2UYByABKAsyGy5nb29n'
    'bGUucHJvdG9idWYuQnl0ZXNWYWx1ZVIFaW1hZ2U=');

@$core.Deprecated('Use carCreateUpdateDescriptor instead')
const CarCreateUpdate$json = {
  '1': 'CarCreateUpdate',
  '2': [
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'number',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'number'
    },
    {
      '1': 'description',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'description'
    },
    {'1': 'car_tag_ids', '3': 5, '4': 3, '5': 9, '10': 'carTagIds'},
    {
      '1': 'track_configuration_ids',
      '3': 6,
      '4': 3,
      '5': 9,
      '10': 'trackConfigurationIds'
    },
    {'1': 'image', '3': 7, '4': 1, '5': 12, '9': 0, '10': 'image', '17': true},
    {
      '1': 'image_deleted',
      '3': 8,
      '4': 1,
      '5': 8,
      '9': 1,
      '10': 'imageDeleted',
      '17': true
    },
  ],
  '8': [
    {'1': '_image'},
    {'1': '_image_deleted'},
  ],
};

/// Descriptor for `CarCreateUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List carCreateUpdateDescriptor = $convert.base64Decode(
    'Cg9DYXJDcmVhdGVVcGRhdGUSEgoEbmFtZRgCIAEoCVIEbmFtZRI0CgZudW1iZXIYAyABKAsyHC'
    '5nb29nbGUucHJvdG9idWYuVUludDMyVmFsdWVSBm51bWJlchI+CgtkZXNjcmlwdGlvbhgEIAEo'
    'CzIcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZVILZGVzY3JpcHRpb24SHgoLY2FyX3RhZ1'
    '9pZHMYBSADKAlSCWNhclRhZ0lkcxI2Chd0cmFja19jb25maWd1cmF0aW9uX2lkcxgGIAMoCVIV'
    'dHJhY2tDb25maWd1cmF0aW9uSWRzEhkKBWltYWdlGAcgASgMSABSBWltYWdliAEBEigKDWltYW'
    'dlX2RlbGV0ZWQYCCABKAhIAVIMaW1hZ2VEZWxldGVkiAEBQggKBl9pbWFnZUIQCg5faW1hZ2Vf'
    'ZGVsZXRlZA==');

@$core.Deprecated('Use carUpdateRequestDescriptor instead')
const CarUpdateRequest$json = {
  '1': 'CarUpdateRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'entity',
      '3': 2,
      '4': 1,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.car.CarCreateUpdate',
      '10': 'entity'
    },
    {'1': 'etag', '3': 3, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `CarUpdateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List carUpdateRequestDescriptor = $convert.base64Decode(
    'ChBDYXJVcGRhdGVSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZBJiCgZlbnRpdHkYAiABKAsySi5yYX'
    'ptYW5hZ2VyLnByb3RvYnVmLmludGVybmFsLnJlcG9zaXRvcnkuY3J1ZF9zZXJ2aWNlcy5jYXIu'
    'Q2FyQ3JlYXRlVXBkYXRlUgZlbnRpdHkSEgoEZXRhZxgDIAEoCVIEZXRhZw==');

@$core.Deprecated('Use carListRequestDescriptor instead')
const CarListRequest$json = {
  '1': 'CarListRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
    {'1': 'car_tag_ids', '3': 3, '4': 3, '5': 9, '10': 'carTagIds'},
  ],
};

/// Descriptor for `CarListRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List carListRequestDescriptor = $convert.base64Decode(
    'Cg5DYXJMaXN0UmVxdWVzdBIUCgVsaW1pdBgBIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAIgASgFUg'
    'ZvZmZzZXQSHgoLY2FyX3RhZ19pZHMYAyADKAlSCWNhclRhZ0lkcw==');

@$core.Deprecated('Use carListResponseDescriptor instead')
const CarListResponse$json = {
  '1': 'CarListResponse',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.razmanager.protobuf.internal.repository.crud_services.car.CarList',
      '10': 'result'
    },
  ],
};

/// Descriptor for `CarListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List carListResponseDescriptor = $convert.base64Decode(
    'Cg9DYXJMaXN0UmVzcG9uc2USWgoGcmVzdWx0GAEgAygLMkIucmF6bWFuYWdlci5wcm90b2J1Zi'
    '5pbnRlcm5hbC5yZXBvc2l0b3J5LmNydWRfc2VydmljZXMuY2FyLkNhckxpc3RSBnJlc3VsdA==');

@$core.Deprecated('Use carListDescriptor instead')
const CarList$json = {
  '1': 'CarList',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'number',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'number'
    },
    {
      '1': 'description',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'description'
    },
    {'1': 'car_tag_names', '3': 5, '4': 1, '5': 9, '10': 'carTagNames'},
    {
      '1': 'image',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BytesValue',
      '10': 'image'
    },
    {'1': 'etag', '3': 7, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `CarList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List carListDescriptor = $convert.base64Decode(
    'CgdDYXJMaXN0Eg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEjQKBm51bWJlch'
    'gDIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5VSW50MzJWYWx1ZVIGbnVtYmVyEj4KC2Rlc2NyaXB0'
    'aW9uGAQgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUgtkZXNjcmlwdGlvbhIiCg'
    '1jYXJfdGFnX25hbWVzGAUgASgJUgtjYXJUYWdOYW1lcxIxCgVpbWFnZRgGIAEoCzIbLmdvb2ds'
    'ZS5wcm90b2J1Zi5CeXRlc1ZhbHVlUgVpbWFnZRISCgRldGFnGAcgASgJUgRldGFn');

@$core.Deprecated('Use carSelectResponseDescriptor instead')
const CarSelectResponse$json = {
  '1': 'CarSelectResponse',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.car.CarSelect',
      '10': 'result'
    },
  ],
};

/// Descriptor for `CarSelectResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List carSelectResponseDescriptor = $convert.base64Decode(
    'ChFDYXJTZWxlY3RSZXNwb25zZRJcCgZyZXN1bHQYASADKAsyRC5yYXptYW5hZ2VyLnByb3RvYn'
    'VmLmludGVybmFsLnJlcG9zaXRvcnkuY3J1ZF9zZXJ2aWNlcy5jYXIuQ2FyU2VsZWN0UgZyZXN1'
    'bHQ=');

@$core.Deprecated('Use carSelectDescriptor instead')
const CarSelect$json = {
  '1': 'CarSelect',
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
    {'1': 'car_tag_ids', '3': 4, '4': 3, '5': 9, '10': 'carTagIds'},
  ],
};

/// Descriptor for `CarSelect`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List carSelectDescriptor = $convert.base64Decode(
    'CglDYXJTZWxlY3QSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSMQoFaW1hZ2'
    'UYAyABKAsyGy5nb29nbGUucHJvdG9idWYuQnl0ZXNWYWx1ZVIFaW1hZ2USHgoLY2FyX3RhZ19p'
    'ZHMYBCADKAlSCWNhclRhZ0lkcw==');
