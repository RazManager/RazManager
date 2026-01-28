// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/heat.service.v1.proto.

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

@$core.Deprecated('Use heatCommandRequestDescriptor instead')
const HeatCommandRequest$json = {
  '1': 'HeatCommandRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'heat_command_type_id',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.HeatCommandTypeId',
      '10': 'heatCommandTypeId'
    },
  ],
};

/// Descriptor for `HeatCommandRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heatCommandRequestDescriptor = $convert.base64Decode(
    'ChJIZWF0Q29tbWFuZFJlcXVlc3QSDgoCaWQYASABKAlSAmlkEmEKFGhlYXRfY29tbWFuZF90eX'
    'BlX2lkGAIgASgOMjAucmF6bWFuYWdlci5wcm90b2J1Zi5wdWJsaWMudjEuSGVhdENvbW1hbmRU'
    'eXBlSWRSEWhlYXRDb21tYW5kVHlwZUlk');

@$core.Deprecated('Use heatStintAnalysesRequestDescriptor instead')
const HeatStintAnalysesRequest$json = {
  '1': 'HeatStintAnalysesRequest',
  '2': [
    {'1': 'heat_id', '3': 1, '4': 1, '5': 9, '10': 'heatId'},
    {'1': 'indicator_id', '3': 2, '4': 1, '5': 13, '10': 'indicatorId'},
  ],
};

/// Descriptor for `HeatStintAnalysesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heatStintAnalysesRequestDescriptor =
    $convert.base64Decode(
        'ChhIZWF0U3RpbnRBbmFseXNlc1JlcXVlc3QSFwoHaGVhdF9pZBgBIAEoCVIGaGVhdElkEiEKDG'
        'luZGljYXRvcl9pZBgCIAEoDVILaW5kaWNhdG9ySWQ=');
