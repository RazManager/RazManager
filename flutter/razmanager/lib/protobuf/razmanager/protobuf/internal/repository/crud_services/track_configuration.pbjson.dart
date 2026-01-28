// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/track_configuration.proto.

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

@$core.Deprecated('Use trackConfigurationListDescriptor instead')
const TrackConfigurationList$json = {
  '1': 'TrackConfigurationList',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'track',
      '3': 3,
      '4': 1,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.track.TrackSelect',
      '10': 'track'
    },
  ],
};

/// Descriptor for `TrackConfigurationList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List trackConfigurationListDescriptor = $convert.base64Decode(
    'ChZUcmFja0NvbmZpZ3VyYXRpb25MaXN0Eg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUg'
    'RuYW1lEl4KBXRyYWNrGAMgASgLMkgucmF6bWFuYWdlci5wcm90b2J1Zi5pbnRlcm5hbC5yZXBv'
    'c2l0b3J5LmNydWRfc2VydmljZXMudHJhY2suVHJhY2tTZWxlY3RSBXRyYWNr');

@$core.Deprecated('Use trackConfigurationSelectResponseDescriptor instead')
const TrackConfigurationSelectResponse$json = {
  '1': 'TrackConfigurationSelectResponse',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.track_configuration.TrackConfigurationSelect',
      '10': 'result'
    },
  ],
};

/// Descriptor for `TrackConfigurationSelectResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List trackConfigurationSelectResponseDescriptor =
    $convert.base64Decode(
        'CiBUcmFja0NvbmZpZ3VyYXRpb25TZWxlY3RSZXNwb25zZRJ7CgZyZXN1bHQYASADKAsyYy5yYX'
        'ptYW5hZ2VyLnByb3RvYnVmLmludGVybmFsLnJlcG9zaXRvcnkuY3J1ZF9zZXJ2aWNlcy50cmFj'
        'a19jb25maWd1cmF0aW9uLlRyYWNrQ29uZmlndXJhdGlvblNlbGVjdFIGcmVzdWx0');

@$core.Deprecated('Use trackConfigurationSelectDescriptor instead')
const TrackConfigurationSelect$json = {
  '1': 'TrackConfigurationSelect',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'track',
      '3': 3,
      '4': 1,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.track.TrackSelect',
      '10': 'track'
    },
    {
      '1': 'track_configuration_race_formats',
      '3': 4,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.race_format_type.RaceFormatTypeSelect',
      '10': 'trackConfigurationRaceFormats'
    },
    {
      '1': 'track_configuration_indicators',
      '3': 5,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.track_configuration.TrackConfigurationIndicatorSelect',
      '10': 'trackConfigurationIndicators'
    },
  ],
};

/// Descriptor for `TrackConfigurationSelect`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List trackConfigurationSelectDescriptor = $convert.base64Decode(
    'ChhUcmFja0NvbmZpZ3VyYXRpb25TZWxlY3QSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKA'
    'lSBG5hbWUSXgoFdHJhY2sYAyABKAsySC5yYXptYW5hZ2VyLnByb3RvYnVmLmludGVybmFsLnJl'
    'cG9zaXRvcnkuY3J1ZF9zZXJ2aWNlcy50cmFjay5UcmFja1NlbGVjdFIFdHJhY2sSpQEKIHRyYW'
    'NrX2NvbmZpZ3VyYXRpb25fcmFjZV9mb3JtYXRzGAQgAygLMlwucmF6bWFuYWdlci5wcm90b2J1'
    'Zi5pbnRlcm5hbC5yZXBvc2l0b3J5LmNydWRfc2VydmljZXMucmFjZV9mb3JtYXRfdHlwZS5SYW'
    'NlRm9ybWF0VHlwZVNlbGVjdFIddHJhY2tDb25maWd1cmF0aW9uUmFjZUZvcm1hdHMSsgEKHnRy'
    'YWNrX2NvbmZpZ3VyYXRpb25faW5kaWNhdG9ycxgFIAMoCzJsLnJhem1hbmFnZXIucHJvdG9idW'
    'YuaW50ZXJuYWwucmVwb3NpdG9yeS5jcnVkX3NlcnZpY2VzLnRyYWNrX2NvbmZpZ3VyYXRpb24u'
    'VHJhY2tDb25maWd1cmF0aW9uSW5kaWNhdG9yU2VsZWN0Uhx0cmFja0NvbmZpZ3VyYXRpb25Jbm'
    'RpY2F0b3Jz');

@$core.Deprecated('Use trackConfigurationIndicatorSelectDescriptor instead')
const TrackConfigurationIndicatorSelect$json = {
  '1': 'TrackConfigurationIndicatorSelect',
  '2': [
    {'1': 'indicator_id', '3': 1, '4': 1, '5': 13, '10': 'indicatorId'},
    {
      '1': 'color',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'color'
    },
  ],
};

/// Descriptor for `TrackConfigurationIndicatorSelect`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List trackConfigurationIndicatorSelectDescriptor =
    $convert.base64Decode(
        'CiFUcmFja0NvbmZpZ3VyYXRpb25JbmRpY2F0b3JTZWxlY3QSIQoMaW5kaWNhdG9yX2lkGAEgAS'
        'gNUgtpbmRpY2F0b3JJZBIyCgVjb2xvchgCIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5VSW50MzJW'
        'YWx1ZVIFY29sb3I=');
