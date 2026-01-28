// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/race_format_type.proto.

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

@$core.Deprecated('Use raceFormatTypeIdDescriptor instead')
const RaceFormatTypeId$json = {
  '1': 'RaceFormatTypeId',
  '2': [
    {'1': 'RACE_FORMAT_TYPE_ID_UNDEFINED', '2': 0},
    {'1': 'RACE_FORMAT_TYPE_ID_ALL_DRIVERS_ALL_LANES_NEXT', '2': 1},
    {'1': 'RACE_FORMAT_TYPE_ID_ALL_DRIVERS_ALL_LANES_SPREAD', '2': 2},
    {'1': 'RACE_FORMAT_TYPE_ID_ALL_DRIVERS_ALL_LANES_ALL_DRIVERS', '2': 3},
    {'1': 'RACE_FORMAT_TYPE_ID_ALL_DRIVERS_UNIQUE_CONTROLLER', '2': 4},
    {'1': 'RACE_FORMAT_TYPE_ID_STEP_UP', '2': 5},
    {'1': 'RACE_FORMAT_TYPE_ID_CUSTOM', '2': 6},
  ],
};

/// Descriptor for `RaceFormatTypeId`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List raceFormatTypeIdDescriptor = $convert.base64Decode(
    'ChBSYWNlRm9ybWF0VHlwZUlkEiEKHVJBQ0VfRk9STUFUX1RZUEVfSURfVU5ERUZJTkVEEAASMg'
    'ouUkFDRV9GT1JNQVRfVFlQRV9JRF9BTExfRFJJVkVSU19BTExfTEFORVNfTkVYVBABEjQKMFJB'
    'Q0VfRk9STUFUX1RZUEVfSURfQUxMX0RSSVZFUlNfQUxMX0xBTkVTX1NQUkVBRBACEjkKNVJBQ0'
    'VfRk9STUFUX1RZUEVfSURfQUxMX0RSSVZFUlNfQUxMX0xBTkVTX0FMTF9EUklWRVJTEAMSNQox'
    'UkFDRV9GT1JNQVRfVFlQRV9JRF9BTExfRFJJVkVSU19VTklRVUVfQ09OVFJPTExFUhAEEh8KG1'
    'JBQ0VfRk9STUFUX1RZUEVfSURfU1RFUF9VUBAFEh4KGlJBQ0VfRk9STUFUX1RZUEVfSURfQ1VT'
    'VE9NEAY=');

@$core.Deprecated('Use raceFormatTypeSelectDescriptor instead')
const RaceFormatTypeSelect$json = {
  '1': 'RaceFormatTypeSelect',
  '2': [
    {
      '1': 'id',
      '3': 1,
      '4': 1,
      '5': 14,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.race_format_type.RaceFormatTypeId',
      '10': 'id'
    },
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'indicator_event_user_combined',
      '3': 3,
      '4': 1,
      '5': 8,
      '10': 'indicatorEventUserCombined'
    },
  ],
};

/// Descriptor for `RaceFormatTypeSelect`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List raceFormatTypeSelectDescriptor = $convert.base64Decode(
    'ChRSYWNlRm9ybWF0VHlwZVNlbGVjdBJoCgJpZBgBIAEoDjJYLnJhem1hbmFnZXIucHJvdG9idW'
    'YuaW50ZXJuYWwucmVwb3NpdG9yeS5jcnVkX3NlcnZpY2VzLnJhY2VfZm9ybWF0X3R5cGUuUmFj'
    'ZUZvcm1hdFR5cGVJZFICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRJBCh1pbmRpY2F0b3JfZXZlbn'
    'RfdXNlcl9jb21iaW5lZBgDIAEoCFIaaW5kaWNhdG9yRXZlbnRVc2VyQ29tYmluZWQ=');

@$core.Deprecated('Use raceFormatTypeSelectResponseDescriptor instead')
const RaceFormatTypeSelectResponse$json = {
  '1': 'RaceFormatTypeSelectResponse',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.race_format_type.RaceFormatTypeSelect',
      '10': 'result'
    },
  ],
};

/// Descriptor for `RaceFormatTypeSelectResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List raceFormatTypeSelectResponseDescriptor =
    $convert.base64Decode(
        'ChxSYWNlRm9ybWF0VHlwZVNlbGVjdFJlc3BvbnNlEnQKBnJlc3VsdBgBIAMoCzJcLnJhem1hbm'
        'FnZXIucHJvdG9idWYuaW50ZXJuYWwucmVwb3NpdG9yeS5jcnVkX3NlcnZpY2VzLnJhY2VfZm9y'
        'bWF0X3R5cGUuUmFjZUZvcm1hdFR5cGVTZWxlY3RSBnJlc3VsdA==');
