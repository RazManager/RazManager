// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/user_services/heat_indicator.proto.

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

@$core.Deprecated('Use heatIndicatorReadDescriptor instead')
const HeatIndicatorRead$json = {
  '1': 'HeatIndicatorRead',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'event_user_type_id',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.EventUserTypeId',
      '10': 'eventUserTypeId'
    },
    {
      '1': 'event_users',
      '3': 3,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.event.EventUserSelect',
      '10': 'eventUsers'
    },
  ],
};

/// Descriptor for `HeatIndicatorRead`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heatIndicatorReadDescriptor = $convert.base64Decode(
    'ChFIZWF0SW5kaWNhdG9yUmVhZBIOCgJpZBgBIAEoCVICaWQSWwoSZXZlbnRfdXNlcl90eXBlX2'
    'lkGAIgASgOMi4ucmF6bWFuYWdlci5wcm90b2J1Zi5wdWJsaWMudjEuRXZlbnRVc2VyVHlwZUlk'
    'Ug9ldmVudFVzZXJUeXBlSWQSbQoLZXZlbnRfdXNlcnMYAyADKAsyTC5yYXptYW5hZ2VyLnByb3'
    'RvYnVmLmludGVybmFsLnJlcG9zaXRvcnkuY3J1ZF9zZXJ2aWNlcy5ldmVudC5FdmVudFVzZXJT'
    'ZWxlY3RSCmV2ZW50VXNlcnM=');
