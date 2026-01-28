// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/track.proto.

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

@$core.Deprecated('Use trackReadResponseDescriptor instead')
const TrackReadResponse$json = {
  '1': 'TrackReadResponse',
  '2': [
    {
      '1': 'entity',
      '3': 1,
      '4': 1,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.track.TrackRead',
      '10': 'entity'
    },
    {'1': 'etag', '3': 2, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `TrackReadResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List trackReadResponseDescriptor = $convert.base64Decode(
    'ChFUcmFja1JlYWRSZXNwb25zZRJeCgZlbnRpdHkYASABKAsyRi5yYXptYW5hZ2VyLnByb3RvYn'
    'VmLmludGVybmFsLnJlcG9zaXRvcnkuY3J1ZF9zZXJ2aWNlcy50cmFjay5UcmFja1JlYWRSBmVu'
    'dGl0eRISCgRldGFnGAIgASgJUgRldGFn');

@$core.Deprecated('Use trackReadDescriptor instead')
const TrackRead$json = {
  '1': 'TrackRead',
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
      '1': 'track_configurations',
      '3': 5,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.track.TrackConfigurationReadCreateUpdate',
      '10': 'trackConfigurations'
    },
  ],
};

/// Descriptor for `TrackRead`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List trackReadDescriptor = $convert.base64Decode(
    'CglUcmFja1JlYWQSLAoCaWQYASABKAsyHC5nb29nbGUucHJvdG9idWYuU3RyaW5nVmFsdWVSAm'
    'lkEjAKBG5hbWUYAiABKAsyHC5nb29nbGUucHJvdG9idWYuU3RyaW5nVmFsdWVSBG5hbWUSPgoL'
    'ZGVzY3JpcHRpb24YAyABKAsyHC5nb29nbGUucHJvdG9idWYuU3RyaW5nVmFsdWVSC2Rlc2NyaX'
    'B0aW9uEjEKBWltYWdlGAQgASgLMhsuZ29vZ2xlLnByb3RvYnVmLkJ5dGVzVmFsdWVSBWltYWdl'
    'EpIBChR0cmFja19jb25maWd1cmF0aW9ucxgFIAMoCzJfLnJhem1hbmFnZXIucHJvdG9idWYuaW'
    '50ZXJuYWwucmVwb3NpdG9yeS5jcnVkX3NlcnZpY2VzLnRyYWNrLlRyYWNrQ29uZmlndXJhdGlv'
    'blJlYWRDcmVhdGVVcGRhdGVSE3RyYWNrQ29uZmlndXJhdGlvbnM=');

@$core.Deprecated('Use trackCreateUpdateDescriptor instead')
const TrackCreateUpdate$json = {
  '1': 'TrackCreateUpdate',
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
      '1': 'track_configurations',
      '3': 6,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.track.TrackConfigurationReadCreateUpdate',
      '10': 'trackConfigurations'
    },
  ],
  '8': [
    {'1': '_image'},
    {'1': '_image_deleted'},
  ],
};

/// Descriptor for `TrackCreateUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List trackCreateUpdateDescriptor = $convert.base64Decode(
    'ChFUcmFja0NyZWF0ZVVwZGF0ZRISCgRuYW1lGAIgASgJUgRuYW1lEj4KC2Rlc2NyaXB0aW9uGA'
    'MgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUgtkZXNjcmlwdGlvbhIZCgVpbWFn'
    'ZRgEIAEoDEgAUgVpbWFnZYgBARIoCg1pbWFnZV9kZWxldGVkGAUgASgISAFSDGltYWdlRGVsZX'
    'RlZIgBARKSAQoUdHJhY2tfY29uZmlndXJhdGlvbnMYBiADKAsyXy5yYXptYW5hZ2VyLnByb3Rv'
    'YnVmLmludGVybmFsLnJlcG9zaXRvcnkuY3J1ZF9zZXJ2aWNlcy50cmFjay5UcmFja0NvbmZpZ3'
    'VyYXRpb25SZWFkQ3JlYXRlVXBkYXRlUhN0cmFja0NvbmZpZ3VyYXRpb25zQggKBl9pbWFnZUIQ'
    'Cg5faW1hZ2VfZGVsZXRlZA==');

@$core.Deprecated('Use trackUpdateRequestDescriptor instead')
const TrackUpdateRequest$json = {
  '1': 'TrackUpdateRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'entity',
      '3': 2,
      '4': 1,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.track.TrackCreateUpdate',
      '10': 'entity'
    },
    {'1': 'etag', '3': 3, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `TrackUpdateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List trackUpdateRequestDescriptor = $convert.base64Decode(
    'ChJUcmFja1VwZGF0ZVJlcXVlc3QSDgoCaWQYASABKAlSAmlkEmYKBmVudGl0eRgCIAEoCzJOLn'
    'Jhem1hbmFnZXIucHJvdG9idWYuaW50ZXJuYWwucmVwb3NpdG9yeS5jcnVkX3NlcnZpY2VzLnRy'
    'YWNrLlRyYWNrQ3JlYXRlVXBkYXRlUgZlbnRpdHkSEgoEZXRhZxgDIAEoCVIEZXRhZw==');

@$core.Deprecated('Use trackConfigurationReadCreateUpdateDescriptor instead')
const TrackConfigurationReadCreateUpdate$json = {
  '1': 'TrackConfigurationReadCreateUpdate',
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
      '1': 'laptime_min_seconds',
      '3': 3,
      '4': 1,
      '5': 13,
      '10': 'laptimeMinSeconds'
    },
    {
      '1': 'laptime_max_seconds',
      '3': 4,
      '4': 1,
      '5': 13,
      '10': 'laptimeMaxSeconds'
    },
    {
      '1': 'device_configuration_ids',
      '3': 5,
      '4': 3,
      '5': 9,
      '10': 'deviceConfigurationIds'
    },
    {
      '1': 'race_format_type_ids',
      '3': 6,
      '4': 3,
      '5': 14,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.race_format_type.RaceFormatTypeId',
      '10': 'raceFormatTypeIds'
    },
    {
      '1': 'track_configuration_indicators',
      '3': 7,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.track.TrackConfigurationIndicatorReadCreateUpdate',
      '10': 'trackConfigurationIndicators'
    },
  ],
};

/// Descriptor for `TrackConfigurationReadCreateUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List trackConfigurationReadCreateUpdateDescriptor = $convert.base64Decode(
    'CiJUcmFja0NvbmZpZ3VyYXRpb25SZWFkQ3JlYXRlVXBkYXRlEiwKAmlkGAEgASgLMhwuZ29vZ2'
    'xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUgJpZBIwCgRuYW1lGAIgASgLMhwuZ29vZ2xlLnByb3Rv'
    'YnVmLlN0cmluZ1ZhbHVlUgRuYW1lEi4KE2xhcHRpbWVfbWluX3NlY29uZHMYAyABKA1SEWxhcH'
    'RpbWVNaW5TZWNvbmRzEi4KE2xhcHRpbWVfbWF4X3NlY29uZHMYBCABKA1SEWxhcHRpbWVNYXhT'
    'ZWNvbmRzEjgKGGRldmljZV9jb25maWd1cmF0aW9uX2lkcxgFIAMoCVIWZGV2aWNlQ29uZmlndX'
    'JhdGlvbklkcxKJAQoUcmFjZV9mb3JtYXRfdHlwZV9pZHMYBiADKA4yWC5yYXptYW5hZ2VyLnBy'
    'b3RvYnVmLmludGVybmFsLnJlcG9zaXRvcnkuY3J1ZF9zZXJ2aWNlcy5yYWNlX2Zvcm1hdF90eX'
    'BlLlJhY2VGb3JtYXRUeXBlSWRSEXJhY2VGb3JtYXRUeXBlSWRzEq4BCh50cmFja19jb25maWd1'
    'cmF0aW9uX2luZGljYXRvcnMYByADKAsyaC5yYXptYW5hZ2VyLnByb3RvYnVmLmludGVybmFsLn'
    'JlcG9zaXRvcnkuY3J1ZF9zZXJ2aWNlcy50cmFjay5UcmFja0NvbmZpZ3VyYXRpb25JbmRpY2F0'
    'b3JSZWFkQ3JlYXRlVXBkYXRlUhx0cmFja0NvbmZpZ3VyYXRpb25JbmRpY2F0b3Jz');

@$core.Deprecated(
    'Use trackConfigurationIndicatorReadCreateUpdateDescriptor instead')
const TrackConfigurationIndicatorReadCreateUpdate$json = {
  '1': 'TrackConfigurationIndicatorReadCreateUpdate',
  '2': [
    {'1': 'indicator_id', '3': 2, '4': 1, '5': 13, '10': 'indicatorId'},
    {'1': 'color', '3': 3, '4': 1, '5': 13, '10': 'color'},
  ],
};

/// Descriptor for `TrackConfigurationIndicatorReadCreateUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List
    trackConfigurationIndicatorReadCreateUpdateDescriptor =
    $convert.base64Decode(
        'CitUcmFja0NvbmZpZ3VyYXRpb25JbmRpY2F0b3JSZWFkQ3JlYXRlVXBkYXRlEiEKDGluZGljYX'
        'Rvcl9pZBgCIAEoDVILaW5kaWNhdG9ySWQSFAoFY29sb3IYAyABKA1SBWNvbG9y');

@$core.Deprecated('Use trackListResponseDescriptor instead')
const TrackListResponse$json = {
  '1': 'TrackListResponse',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.track.TrackList',
      '10': 'result'
    },
  ],
};

/// Descriptor for `TrackListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List trackListResponseDescriptor = $convert.base64Decode(
    'ChFUcmFja0xpc3RSZXNwb25zZRJeCgZyZXN1bHQYASADKAsyRi5yYXptYW5hZ2VyLnByb3RvYn'
    'VmLmludGVybmFsLnJlcG9zaXRvcnkuY3J1ZF9zZXJ2aWNlcy50cmFjay5UcmFja0xpc3RSBnJl'
    'c3VsdA==');

@$core.Deprecated('Use trackListDescriptor instead')
const TrackList$json = {
  '1': 'TrackList',
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
      '1': 'image',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BytesValue',
      '10': 'image'
    },
    {'1': 'etag', '3': 5, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `TrackList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List trackListDescriptor = $convert.base64Decode(
    'CglUcmFja0xpc3QSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSPgoLZGVzY3'
    'JpcHRpb24YAyABKAsyHC5nb29nbGUucHJvdG9idWYuU3RyaW5nVmFsdWVSC2Rlc2NyaXB0aW9u'
    'EjEKBWltYWdlGAQgASgLMhsuZ29vZ2xlLnByb3RvYnVmLkJ5dGVzVmFsdWVSBWltYWdlEhIKBG'
    'V0YWcYBSABKAlSBGV0YWc=');

@$core.Deprecated('Use trackSelectDescriptor instead')
const TrackSelect$json = {
  '1': 'TrackSelect',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `TrackSelect`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List trackSelectDescriptor = $convert.base64Decode(
    'CgtUcmFja1NlbGVjdBIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZQ==');
