// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/common.proto.

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

@$core.Deprecated('Use idRequestDescriptor instead')
const IdRequest$json = {
  '1': 'IdRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `IdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List idRequestDescriptor =
    $convert.base64Decode('CglJZFJlcXVlc3QSDgoCaWQYASABKAlSAmlk');

@$core.Deprecated('Use etagRequestDescriptor instead')
const EtagRequest$json = {
  '1': 'EtagRequest',
  '2': [
    {'1': 'etag', '3': 1, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `EtagRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List etagRequestDescriptor =
    $convert.base64Decode('CgtFdGFnUmVxdWVzdBISCgRldGFnGAEgASgJUgRldGFn');

@$core.Deprecated('Use createResponseDescriptor instead')
const CreateResponse$json = {
  '1': 'CreateResponse',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'etag', '3': 2, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `CreateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createResponseDescriptor = $convert.base64Decode(
    'Cg5DcmVhdGVSZXNwb25zZRIOCgJpZBgBIAEoCVICaWQSEgoEZXRhZxgCIAEoCVIEZXRhZw==');

@$core.Deprecated('Use updateResponseDescriptor instead')
const UpdateResponse$json = {
  '1': 'UpdateResponse',
  '2': [
    {'1': 'etag', '3': 1, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `UpdateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateResponseDescriptor =
    $convert.base64Decode('Cg5VcGRhdGVSZXNwb25zZRISCgRldGFnGAEgASgJUgRldGFn');

@$core.Deprecated('Use deleteRequestDescriptor instead')
const DeleteRequest$json = {
  '1': 'DeleteRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'etag', '3': 2, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `DeleteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteRequestDescriptor = $convert.base64Decode(
    'Cg1EZWxldGVSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZBISCgRldGFnGAIgASgJUgRldGFn');

@$core.Deprecated('Use listRequestDescriptor instead')
const ListRequest$json = {
  '1': 'ListRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `ListRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listRequestDescriptor = $convert.base64Decode(
    'CgtMaXN0UmVxdWVzdBIUCgVsaW1pdBgBIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAIgASgFUgZvZm'
    'ZzZXQ=');
