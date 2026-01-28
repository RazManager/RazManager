// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/points_scheme.proto.

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

@$core.Deprecated('Use pointsSchemeReadResponseDescriptor instead')
const PointsSchemeReadResponse$json = {
  '1': 'PointsSchemeReadResponse',
  '2': [
    {
      '1': 'entity',
      '3': 1,
      '4': 1,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.points_scheme.PointsSchemeRead',
      '10': 'entity'
    },
    {'1': 'etag', '3': 2, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `PointsSchemeReadResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pointsSchemeReadResponseDescriptor = $convert.base64Decode(
    'ChhQb2ludHNTY2hlbWVSZWFkUmVzcG9uc2USbQoGZW50aXR5GAEgASgLMlUucmF6bWFuYWdlci'
    '5wcm90b2J1Zi5pbnRlcm5hbC5yZXBvc2l0b3J5LmNydWRfc2VydmljZXMucG9pbnRzX3NjaGVt'
    'ZS5Qb2ludHNTY2hlbWVSZWFkUgZlbnRpdHkSEgoEZXRhZxgCIAEoCVIEZXRhZw==');

@$core.Deprecated('Use pointsSchemeReadDescriptor instead')
const PointsSchemeRead$json = {
  '1': 'PointsSchemeRead',
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
    {'1': 'position', '3': 4, '4': 1, '5': 13, '10': 'position'},
    {
      '1': 'points_race_session_heat_fastest_lap',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'pointsRaceSessionHeatFastestLap'
    },
    {
      '1': 'points_race_session_heat_most_led_laps',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'pointsRaceSessionHeatMostLedLaps'
    },
    {
      '1': 'points_race_session_heat_led_at_least_one_lap',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'pointsRaceSessionHeatLedAtLeastOneLap'
    },
    {
      '1': 'points_race_session_overall_fastest_lap',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'pointsRaceSessionOverallFastestLap'
    },
    {
      '1': 'points_race_session_overall_most_led_laps',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'pointsRaceSessionOverallMostLedLaps'
    },
    {'1': 'min_drivers', '3': 11, '4': 1, '5': 13, '10': 'minDrivers'},
    {'1': 'max_drivers', '3': 12, '4': 1, '5': 13, '10': 'maxDrivers'},
    {
      '1': 'points_scheme_positions',
      '3': 14,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.points_scheme.PointsSchemePositionReadCreateUpdate',
      '10': 'pointsSchemePositions'
    },
  ],
};

/// Descriptor for `PointsSchemeRead`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pointsSchemeReadDescriptor = $convert.base64Decode(
    'ChBQb2ludHNTY2hlbWVSZWFkEiwKAmlkGAEgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1'
    'ZhbHVlUgJpZBIwCgRuYW1lGAIgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUgRu'
    'YW1lEj4KC2Rlc2NyaXB0aW9uGAMgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUg'
    'tkZXNjcmlwdGlvbhIaCghwb3NpdGlvbhgEIAEoDVIIcG9zaXRpb24SawokcG9pbnRzX3JhY2Vf'
    'c2Vzc2lvbl9oZWF0X2Zhc3Rlc3RfbGFwGAUgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlVJbnQzMl'
    'ZhbHVlUh9wb2ludHNSYWNlU2Vzc2lvbkhlYXRGYXN0ZXN0TGFwEm4KJnBvaW50c19yYWNlX3Nl'
    'c3Npb25faGVhdF9tb3N0X2xlZF9sYXBzGAYgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlVJbnQzMl'
    'ZhbHVlUiBwb2ludHNSYWNlU2Vzc2lvbkhlYXRNb3N0TGVkTGFwcxJ6Ci1wb2ludHNfcmFjZV9z'
    'ZXNzaW9uX2hlYXRfbGVkX2F0X2xlYXN0X29uZV9sYXAYByABKAsyHC5nb29nbGUucHJvdG9idW'
    'YuVUludDMyVmFsdWVSJXBvaW50c1JhY2VTZXNzaW9uSGVhdExlZEF0TGVhc3RPbmVMYXAScQon'
    'cG9pbnRzX3JhY2Vfc2Vzc2lvbl9vdmVyYWxsX2Zhc3Rlc3RfbGFwGAggASgLMhwuZ29vZ2xlLn'
    'Byb3RvYnVmLlVJbnQzMlZhbHVlUiJwb2ludHNSYWNlU2Vzc2lvbk92ZXJhbGxGYXN0ZXN0TGFw'
    'EnQKKXBvaW50c19yYWNlX3Nlc3Npb25fb3ZlcmFsbF9tb3N0X2xlZF9sYXBzGAkgASgLMhwuZ2'
    '9vZ2xlLnByb3RvYnVmLlVJbnQzMlZhbHVlUiNwb2ludHNSYWNlU2Vzc2lvbk92ZXJhbGxNb3N0'
    'TGVkTGFwcxIfCgttaW5fZHJpdmVycxgLIAEoDVIKbWluRHJpdmVycxIfCgttYXhfZHJpdmVycx'
    'gMIAEoDVIKbWF4RHJpdmVycxKhAQoXcG9pbnRzX3NjaGVtZV9wb3NpdGlvbnMYDiADKAsyaS5y'
    'YXptYW5hZ2VyLnByb3RvYnVmLmludGVybmFsLnJlcG9zaXRvcnkuY3J1ZF9zZXJ2aWNlcy5wb2'
    'ludHNfc2NoZW1lLlBvaW50c1NjaGVtZVBvc2l0aW9uUmVhZENyZWF0ZVVwZGF0ZVIVcG9pbnRz'
    'U2NoZW1lUG9zaXRpb25z');

@$core.Deprecated('Use pointsSchemeCreateUpdateDescriptor instead')
const PointsSchemeCreateUpdate$json = {
  '1': 'PointsSchemeCreateUpdate',
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
    {'1': 'position', '3': 4, '4': 1, '5': 13, '10': 'position'},
    {
      '1': 'points_race_session_heat_fastest_lap',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'pointsRaceSessionHeatFastestLap'
    },
    {
      '1': 'points_race_session_heat_most_led_laps',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'pointsRaceSessionHeatMostLedLaps'
    },
    {
      '1': 'points_race_session_heat_led_at_least_one_lap',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'pointsRaceSessionHeatLedAtLeastOneLap'
    },
    {
      '1': 'points_race_session_overall_fastest_lap',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'pointsRaceSessionOverallFastestLap'
    },
    {
      '1': 'points_race_session_overall_most_led_laps',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'pointsRaceSessionOverallMostLedLaps'
    },
    {'1': 'min_drivers', '3': 11, '4': 1, '5': 13, '10': 'minDrivers'},
    {'1': 'max_drivers', '3': 12, '4': 1, '5': 13, '10': 'maxDrivers'},
    {
      '1': 'points_scheme_positions',
      '3': 14,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.points_scheme.PointsSchemePositionReadCreateUpdate',
      '10': 'pointsSchemePositions'
    },
  ],
};

/// Descriptor for `PointsSchemeCreateUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pointsSchemeCreateUpdateDescriptor = $convert.base64Decode(
    'ChhQb2ludHNTY2hlbWVDcmVhdGVVcGRhdGUSEgoEbmFtZRgCIAEoCVIEbmFtZRI+CgtkZXNjcm'
    'lwdGlvbhgDIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZVILZGVzY3JpcHRpb24S'
    'GgoIcG9zaXRpb24YBCABKA1SCHBvc2l0aW9uEmsKJHBvaW50c19yYWNlX3Nlc3Npb25faGVhdF'
    '9mYXN0ZXN0X2xhcBgFIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5VSW50MzJWYWx1ZVIfcG9pbnRz'
    'UmFjZVNlc3Npb25IZWF0RmFzdGVzdExhcBJuCiZwb2ludHNfcmFjZV9zZXNzaW9uX2hlYXRfbW'
    '9zdF9sZWRfbGFwcxgGIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5VSW50MzJWYWx1ZVIgcG9pbnRz'
    'UmFjZVNlc3Npb25IZWF0TW9zdExlZExhcHMSegotcG9pbnRzX3JhY2Vfc2Vzc2lvbl9oZWF0X2'
    'xlZF9hdF9sZWFzdF9vbmVfbGFwGAcgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlVJbnQzMlZhbHVl'
    'UiVwb2ludHNSYWNlU2Vzc2lvbkhlYXRMZWRBdExlYXN0T25lTGFwEnEKJ3BvaW50c19yYWNlX3'
    'Nlc3Npb25fb3ZlcmFsbF9mYXN0ZXN0X2xhcBgIIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5VSW50'
    'MzJWYWx1ZVIicG9pbnRzUmFjZVNlc3Npb25PdmVyYWxsRmFzdGVzdExhcBJ0Cilwb2ludHNfcm'
    'FjZV9zZXNzaW9uX292ZXJhbGxfbW9zdF9sZWRfbGFwcxgJIAEoCzIcLmdvb2dsZS5wcm90b2J1'
    'Zi5VSW50MzJWYWx1ZVIjcG9pbnRzUmFjZVNlc3Npb25PdmVyYWxsTW9zdExlZExhcHMSHwoLbW'
    'luX2RyaXZlcnMYCyABKA1SCm1pbkRyaXZlcnMSHwoLbWF4X2RyaXZlcnMYDCABKA1SCm1heERy'
    'aXZlcnMSoQEKF3BvaW50c19zY2hlbWVfcG9zaXRpb25zGA4gAygLMmkucmF6bWFuYWdlci5wcm'
    '90b2J1Zi5pbnRlcm5hbC5yZXBvc2l0b3J5LmNydWRfc2VydmljZXMucG9pbnRzX3NjaGVtZS5Q'
    'b2ludHNTY2hlbWVQb3NpdGlvblJlYWRDcmVhdGVVcGRhdGVSFXBvaW50c1NjaGVtZVBvc2l0aW'
    '9ucw==');

@$core.Deprecated('Use pointsSchemeUpdateRequestDescriptor instead')
const PointsSchemeUpdateRequest$json = {
  '1': 'PointsSchemeUpdateRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'entity',
      '3': 2,
      '4': 1,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.points_scheme.PointsSchemeCreateUpdate',
      '10': 'entity'
    },
    {'1': 'etag', '3': 3, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `PointsSchemeUpdateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pointsSchemeUpdateRequestDescriptor = $convert.base64Decode(
    'ChlQb2ludHNTY2hlbWVVcGRhdGVSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZBJ1CgZlbnRpdHkYAi'
    'ABKAsyXS5yYXptYW5hZ2VyLnByb3RvYnVmLmludGVybmFsLnJlcG9zaXRvcnkuY3J1ZF9zZXJ2'
    'aWNlcy5wb2ludHNfc2NoZW1lLlBvaW50c1NjaGVtZUNyZWF0ZVVwZGF0ZVIGZW50aXR5EhIKBG'
    'V0YWcYAyABKAlSBGV0YWc=');

@$core.Deprecated('Use pointsSchemePositionReadCreateUpdateDescriptor instead')
const PointsSchemePositionReadCreateUpdate$json = {
  '1': 'PointsSchemePositionReadCreateUpdate',
  '2': [
    {'1': 'position', '3': 2, '4': 1, '5': 13, '10': 'position'},
    {'1': 'points', '3': 3, '4': 1, '5': 13, '10': 'points'},
  ],
};

/// Descriptor for `PointsSchemePositionReadCreateUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pointsSchemePositionReadCreateUpdateDescriptor =
    $convert.base64Decode(
        'CiRQb2ludHNTY2hlbWVQb3NpdGlvblJlYWRDcmVhdGVVcGRhdGUSGgoIcG9zaXRpb24YAiABKA'
        '1SCHBvc2l0aW9uEhYKBnBvaW50cxgDIAEoDVIGcG9pbnRz');

@$core.Deprecated('Use pointsSchemeListResponseDescriptor instead')
const PointsSchemeListResponse$json = {
  '1': 'PointsSchemeListResponse',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.points_scheme.PointsSchemeList',
      '10': 'result'
    },
  ],
};

/// Descriptor for `PointsSchemeListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pointsSchemeListResponseDescriptor = $convert.base64Decode(
    'ChhQb2ludHNTY2hlbWVMaXN0UmVzcG9uc2USbQoGcmVzdWx0GAEgAygLMlUucmF6bWFuYWdlci'
    '5wcm90b2J1Zi5pbnRlcm5hbC5yZXBvc2l0b3J5LmNydWRfc2VydmljZXMucG9pbnRzX3NjaGVt'
    'ZS5Qb2ludHNTY2hlbWVMaXN0UgZyZXN1bHQ=');

@$core.Deprecated('Use pointsSchemeListDescriptor instead')
const PointsSchemeList$json = {
  '1': 'PointsSchemeList',
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
    {'1': 'etag', '3': 4, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `PointsSchemeList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pointsSchemeListDescriptor = $convert.base64Decode(
    'ChBQb2ludHNTY2hlbWVMaXN0Eg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEj'
    '4KC2Rlc2NyaXB0aW9uGAMgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUgtkZXNj'
    'cmlwdGlvbhISCgRldGFnGAQgASgJUgRldGFn');

@$core.Deprecated('Use pointsSchemeSelectResponseDescriptor instead')
const PointsSchemeSelectResponse$json = {
  '1': 'PointsSchemeSelectResponse',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.points_scheme.PointsSchemeSelect',
      '10': 'result'
    },
  ],
};

/// Descriptor for `PointsSchemeSelectResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pointsSchemeSelectResponseDescriptor =
    $convert.base64Decode(
        'ChpQb2ludHNTY2hlbWVTZWxlY3RSZXNwb25zZRJvCgZyZXN1bHQYASADKAsyVy5yYXptYW5hZ2'
        'VyLnByb3RvYnVmLmludGVybmFsLnJlcG9zaXRvcnkuY3J1ZF9zZXJ2aWNlcy5wb2ludHNfc2No'
        'ZW1lLlBvaW50c1NjaGVtZVNlbGVjdFIGcmVzdWx0');

@$core.Deprecated('Use pointsSchemeSelectDescriptor instead')
const PointsSchemeSelect$json = {
  '1': 'PointsSchemeSelect',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'min_drivers', '3': 3, '4': 1, '5': 13, '10': 'minDrivers'},
    {'1': 'max_drivers', '3': 4, '4': 1, '5': 13, '10': 'maxDrivers'},
  ],
};

/// Descriptor for `PointsSchemeSelect`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pointsSchemeSelectDescriptor = $convert.base64Decode(
    'ChJQb2ludHNTY2hlbWVTZWxlY3QSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbW'
    'USHwoLbWluX2RyaXZlcnMYAyABKA1SCm1pbkRyaXZlcnMSHwoLbWF4X2RyaXZlcnMYBCABKA1S'
    'Cm1heERyaXZlcnM=');
