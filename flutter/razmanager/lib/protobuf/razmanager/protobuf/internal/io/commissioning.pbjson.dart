// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/io/commissioning.proto.

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

@$core.Deprecated('Use commissioningCertificateRequestDescriptor instead')
const CommissioningCertificateRequest$json = {
  '1': 'CommissioningCertificateRequest',
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

/// Descriptor for `CommissioningCertificateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commissioningCertificateRequestDescriptor =
    $convert.base64Decode(
        'Ch9Db21taXNzaW9uaW5nQ2VydGlmaWNhdGVSZXF1ZXN0EjYKF2NlcnRpZmljYXRlX3JlcXVlc3'
        'RfcGVtGAEgASgJUhVjZXJ0aWZpY2F0ZVJlcXVlc3RQZW0SEgoEbmFtZRgCIAEoCVIEbmFtZQ==');

@$core.Deprecated('Use commissioningCertificateResponseDescriptor instead')
const CommissioningCertificateResponse$json = {
  '1': 'CommissioningCertificateResponse',
  '2': [
    {'1': 'certificate_pem', '3': 1, '4': 1, '5': 9, '10': 'certificatePem'},
  ],
};

/// Descriptor for `CommissioningCertificateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commissioningCertificateResponseDescriptor =
    $convert.base64Decode(
        'CiBDb21taXNzaW9uaW5nQ2VydGlmaWNhdGVSZXNwb25zZRInCg9jZXJ0aWZpY2F0ZV9wZW0YAS'
        'ABKAlSDmNlcnRpZmljYXRlUGVt');
