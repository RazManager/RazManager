// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/track_configuration.v1.proto.

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

@$core.Deprecated('Use trackConfigurationDescriptor instead')
const TrackConfiguration$json = {
  '1': 'TrackConfiguration',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'track',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.Track',
      '10': 'track'
    },
    {
      '1': 'device_configuration_features',
      '3': 4,
      '4': 3,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.DeviceConfigurationFeatureTypeId',
      '10': 'deviceConfigurationFeatures'
    },
  ],
};

/// Descriptor for `TrackConfiguration`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List trackConfigurationDescriptor = $convert.base64Decode(
    'ChJUcmFja0NvbmZpZ3VyYXRpb24SDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbW'
    'USOgoFdHJhY2sYAyABKAsyJC5yYXptYW5hZ2VyLnByb3RvYnVmLnB1YmxpYy52MS5UcmFja1IF'
    'dHJhY2sSgwEKHWRldmljZV9jb25maWd1cmF0aW9uX2ZlYXR1cmVzGAQgAygOMj8ucmF6bWFuYW'
    'dlci5wcm90b2J1Zi5wdWJsaWMudjEuRGV2aWNlQ29uZmlndXJhdGlvbkZlYXR1cmVUeXBlSWRS'
    'G2RldmljZUNvbmZpZ3VyYXRpb25GZWF0dXJlcw==');
