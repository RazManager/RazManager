// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/user_services/event.proto.

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

@$core.Deprecated('Use eventAuthorizedRequestDescriptor instead')
const EventAuthorizedRequest$json = {
  '1': 'EventAuthorizedRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'user_id',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'userId'
    },
  ],
};

/// Descriptor for `EventAuthorizedRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventAuthorizedRequestDescriptor =
    $convert.base64Decode(
        'ChZFdmVudEF1dGhvcml6ZWRSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZBI1Cgd1c2VyX2lkGAQgAS'
        'gLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUgZ1c2VySWQ=');

@$core.Deprecated('Use eventSelectResponseDescriptor instead')
const EventSelectResponse$json = {
  '1': 'EventSelectResponse',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.user_services.event.EventSelect',
      '10': 'result'
    },
  ],
};

/// Descriptor for `EventSelectResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventSelectResponseDescriptor = $convert.base64Decode(
    'ChNFdmVudFNlbGVjdFJlc3BvbnNlEmAKBnJlc3VsdBgBIAMoCzJILnJhem1hbmFnZXIucHJvdG'
    '9idWYuaW50ZXJuYWwucmVwb3NpdG9yeS51c2VyX3NlcnZpY2VzLmV2ZW50LkV2ZW50U2VsZWN0'
    'UgZyZXN1bHQ=');

@$core.Deprecated('Use eventSelectDescriptor instead')
const EventSelect$json = {
  '1': 'EventSelect',
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
    {
      '1': 'starts_at',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'startsAt'
    },
    {
      '1': 'image',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BytesValue',
      '10': 'image'
    },
    {
      '1': 'tenant',
      '3': 6,
      '4': 1,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.user_services.tenant.TenantSelect',
      '10': 'tenant'
    },
  ],
};

/// Descriptor for `EventSelect`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventSelectDescriptor = $convert.base64Decode(
    'CgtFdmVudFNlbGVjdBIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRI+CgtkZX'
    'NjcmlwdGlvbhgDIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZVILZGVzY3JpcHRp'
    'b24SNwoJc3RhcnRzX2F0GAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIIc3Rhcn'
    'RzQXQSMQoFaW1hZ2UYBSABKAsyGy5nb29nbGUucHJvdG9idWYuQnl0ZXNWYWx1ZVIFaW1hZ2US'
    'YgoGdGVuYW50GAYgASgLMkoucmF6bWFuYWdlci5wcm90b2J1Zi5pbnRlcm5hbC5yZXBvc2l0b3'
    'J5LnVzZXJfc2VydmljZXMudGVuYW50LlRlbmFudFNlbGVjdFIGdGVuYW50');
