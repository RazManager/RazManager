// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/race.v1.proto.

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

@$core.Deprecated('Use raceCommandTypeIdDescriptor instead')
const RaceCommandTypeId$json = {
  '1': 'RaceCommandTypeId',
  '2': [
    {'1': 'RACE_COMMAND_TYPE_ID_START', '2': 0},
    {'1': 'RACE_COMMAND_TYPE_ID_PAUSE', '2': 1},
    {'1': 'RACE_COMMAND_TYPE_ID_END', '2': 2},
    {'1': 'RACE_COMMAND_TYPE_ID_RESET', '2': 3},
  ],
};

/// Descriptor for `RaceCommandTypeId`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List raceCommandTypeIdDescriptor = $convert.base64Decode(
    'ChFSYWNlQ29tbWFuZFR5cGVJZBIeChpSQUNFX0NPTU1BTkRfVFlQRV9JRF9TVEFSVBAAEh4KGl'
    'JBQ0VfQ09NTUFORF9UWVBFX0lEX1BBVVNFEAESHAoYUkFDRV9DT01NQU5EX1RZUEVfSURfRU5E'
    'EAISHgoaUkFDRV9DT01NQU5EX1RZUEVfSURfUkVTRVQQAw==');

@$core.Deprecated('Use raceStateTypeIdDescriptor instead')
const RaceStateTypeId$json = {
  '1': 'RaceStateTypeId',
  '2': [
    {'1': 'RACE_STATE_TYPE_ID_PENDING', '2': 0},
    {'1': 'RACE_STATE_TYPE_ID_STARTED', '2': 1},
    {'1': 'RACE_STATE_TYPE_ID_PAUSED', '2': 2},
    {'1': 'RACE_STATE_TYPE_ID_ENDED', '2': 3},
  ],
};

/// Descriptor for `RaceStateTypeId`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List raceStateTypeIdDescriptor = $convert.base64Decode(
    'Cg9SYWNlU3RhdGVUeXBlSWQSHgoaUkFDRV9TVEFURV9UWVBFX0lEX1BFTkRJTkcQABIeChpSQU'
    'NFX1NUQVRFX1RZUEVfSURfU1RBUlRFRBABEh0KGVJBQ0VfU1RBVEVfVFlQRV9JRF9QQVVTRUQQ'
    'AhIcChhSQUNFX1NUQVRFX1RZUEVfSURfRU5ERUQQAw==');

@$core.Deprecated('Use raceIndicatorFlagDescriptor instead')
const RaceIndicatorFlag$json = {
  '1': 'RaceIndicatorFlag',
  '2': [
    {'1': 'RACE_INDICATOR_FLAG_RUNNING', '2': 0},
    {'1': 'RACE_INDICATOR_FLAG_FINISHED', '2': 1},
    {'1': 'RACE_INDICATOR_FLAG_FASTEST_LAP', '2': 2},
  ],
};

/// Descriptor for `RaceIndicatorFlag`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List raceIndicatorFlagDescriptor = $convert.base64Decode(
    'ChFSYWNlSW5kaWNhdG9yRmxhZxIfChtSQUNFX0lORElDQVRPUl9GTEFHX1JVTk5JTkcQABIgCh'
    'xSQUNFX0lORElDQVRPUl9GTEFHX0ZJTklTSEVEEAESIwofUkFDRV9JTkRJQ0FUT1JfRkxBR19G'
    'QVNURVNUX0xBUBAC');

@$core.Deprecated('Use raceCommandPermissionsDescriptor instead')
const RaceCommandPermissions$json = {
  '1': 'RaceCommandPermissions',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.RaceCommandTypeId',
      '10': 'items'
    },
  ],
};

/// Descriptor for `RaceCommandPermissions`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List raceCommandPermissionsDescriptor =
    $convert.base64Decode(
        'ChZSYWNlQ29tbWFuZFBlcm1pc3Npb25zEkYKBWl0ZW1zGAEgAygOMjAucmF6bWFuYWdlci5wcm'
        '90b2J1Zi5wdWJsaWMudjEuUmFjZUNvbW1hbmRUeXBlSWRSBWl0ZW1z');

@$core.Deprecated('Use raceStateTypeDescriptor instead')
const RaceStateType$json = {
  '1': 'RaceStateType',
  '2': [
    {
      '1': 'id',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.RaceStateTypeId',
      '10': 'id'
    },
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `RaceStateType`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List raceStateTypeDescriptor = $convert.base64Decode(
    'Cg1SYWNlU3RhdGVUeXBlEj4KAmlkGAEgASgOMi4ucmF6bWFuYWdlci5wcm90b2J1Zi5wdWJsaW'
    'MudjEuUmFjZVN0YXRlVHlwZUlkUgJpZBISCgRuYW1lGAIgASgJUgRuYW1l');

@$core.Deprecated('Use raceDescriptor instead')
const Race$json = {
  '1': 'Race',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'number', '3': 2, '4': 1, '5': 13, '10': 'number'},
    {
      '1': 'name',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'name'
    },
    {'1': 'event_id', '3': 4, '4': 1, '5': 9, '10': 'eventId'},
    {
      '1': 'track_configuration',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.TrackConfiguration',
      '10': 'trackConfiguration'
    },
    {
      '1': 'points_scheme_id',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'pointsSchemeId'
    },
    {'1': 'practice_session', '3': 7, '4': 1, '5': 8, '10': 'practiceSession'},
    {
      '1': 'qualifying_session',
      '3': 8,
      '4': 1,
      '5': 8,
      '10': 'qualifyingSession'
    },
    {'1': 'race_session', '3': 9, '4': 1, '5': 8, '10': 'raceSession'},
    {
      '1': 'race_heat_end_type_id',
      '3': 10,
      '4': 1,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.HeatEndTypeId',
      '10': 'raceHeatEndTypeId'
    },
    {
      '1': 'race_heat_end_lap_laps',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'raceHeatEndLapLaps'
    },
    {
      '1': 'race_heat_end_duration_duration',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'raceHeatEndDurationDuration'
    },
    {
      '1': 'race_state_type',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.RaceStateType',
      '10': 'raceStateType'
    },
    {
      '1': 'race_features',
      '3': 14,
      '4': 3,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.RaceFeatureTypeId',
      '10': 'raceFeatures'
    },
    {
      '1': 'heats',
      '3': 15,
      '4': 3,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.Heat',
      '10': 'heats'
    },
  ],
};

/// Descriptor for `Race`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List raceDescriptor = $convert.base64Decode(
    'CgRSYWNlEg4KAmlkGAEgASgJUgJpZBIWCgZudW1iZXIYAiABKA1SBm51bWJlchIwCgRuYW1lGA'
    'MgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUgRuYW1lEhkKCGV2ZW50X2lkGAQg'
    'ASgJUgdldmVudElkEmIKE3RyYWNrX2NvbmZpZ3VyYXRpb24YBSABKAsyMS5yYXptYW5hZ2VyLn'
    'Byb3RvYnVmLnB1YmxpYy52MS5UcmFja0NvbmZpZ3VyYXRpb25SEnRyYWNrQ29uZmlndXJhdGlv'
    'bhJGChBwb2ludHNfc2NoZW1lX2lkGAYgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbH'
    'VlUg5wb2ludHNTY2hlbWVJZBIpChBwcmFjdGljZV9zZXNzaW9uGAcgASgIUg9wcmFjdGljZVNl'
    'c3Npb24SLQoScXVhbGlmeWluZ19zZXNzaW9uGAggASgIUhFxdWFsaWZ5aW5nU2Vzc2lvbhIhCg'
    'xyYWNlX3Nlc3Npb24YCSABKAhSC3JhY2VTZXNzaW9uEl4KFXJhY2VfaGVhdF9lbmRfdHlwZV9p'
    'ZBgKIAEoDjIsLnJhem1hbmFnZXIucHJvdG9idWYucHVibGljLnYxLkhlYXRFbmRUeXBlSWRSEX'
    'JhY2VIZWF0RW5kVHlwZUlkElAKFnJhY2VfaGVhdF9lbmRfbGFwX2xhcHMYCyABKAsyHC5nb29n'
    'bGUucHJvdG9idWYuVUludDMyVmFsdWVSEnJhY2VIZWF0RW5kTGFwTGFwcxJfCh9yYWNlX2hlYX'
    'RfZW5kX2R1cmF0aW9uX2R1cmF0aW9uGAwgASgLMhkuZ29vZ2xlLnByb3RvYnVmLkR1cmF0aW9u'
    'UhtyYWNlSGVhdEVuZER1cmF0aW9uRHVyYXRpb24SVAoPcmFjZV9zdGF0ZV90eXBlGA0gASgLMi'
    'wucmF6bWFuYWdlci5wcm90b2J1Zi5wdWJsaWMudjEuUmFjZVN0YXRlVHlwZVINcmFjZVN0YXRl'
    'VHlwZRJVCg1yYWNlX2ZlYXR1cmVzGA4gAygOMjAucmF6bWFuYWdlci5wcm90b2J1Zi5wdWJsaW'
    'MudjEuUmFjZUZlYXR1cmVUeXBlSWRSDHJhY2VGZWF0dXJlcxI5CgVoZWF0cxgPIAMoCzIjLnJh'
    'em1hbmFnZXIucHJvdG9idWYucHVibGljLnYxLkhlYXRSBWhlYXRz');

@$core.Deprecated('Use raceLeaderboardDescriptor instead')
const RaceLeaderboard$json = {
  '1': 'RaceLeaderboard',
  '2': [
    {
      '1': 'event_users',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.RaceLeaderboardEventUser',
      '10': 'eventUsers'
    },
  ],
};

/// Descriptor for `RaceLeaderboard`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List raceLeaderboardDescriptor = $convert.base64Decode(
    'Cg9SYWNlTGVhZGVyYm9hcmQSWAoLZXZlbnRfdXNlcnMYASADKAsyNy5yYXptYW5hZ2VyLnByb3'
    'RvYnVmLnB1YmxpYy52MS5SYWNlTGVhZGVyYm9hcmRFdmVudFVzZXJSCmV2ZW50VXNlcnM=');

@$core.Deprecated('Use raceLeaderboardEventUserDescriptor instead')
const RaceLeaderboardEventUser$json = {
  '1': 'RaceLeaderboardEventUser',
  '2': [
    {'1': 'event_user_id', '3': 1, '4': 1, '5': 9, '10': 'eventUserId'},
    {'1': 'position', '3': 2, '4': 1, '5': 13, '10': 'position'},
    {
      '1': 'laps',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'laps'
    },
    {
      '1': 'points',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'points'
    },
    {
      '1': 'indicators',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.RaceLeaderboardHeatIndicator',
      '10': 'indicators'
    },
    {
      '1': 'flags',
      '3': 6,
      '4': 3,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.RaceIndicatorFlag',
      '10': 'flags'
    },
  ],
};

/// Descriptor for `RaceLeaderboardEventUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List raceLeaderboardEventUserDescriptor = $convert.base64Decode(
    'ChhSYWNlTGVhZGVyYm9hcmRFdmVudFVzZXISIgoNZXZlbnRfdXNlcl9pZBgBIAEoCVILZXZlbn'
    'RVc2VySWQSGgoIcG9zaXRpb24YAiABKA1SCHBvc2l0aW9uEjAKBGxhcHMYAyABKAsyHC5nb29n'
    'bGUucHJvdG9idWYuVUludDMyVmFsdWVSBGxhcHMSNAoGcG9pbnRzGAQgASgLMhwuZ29vZ2xlLn'
    'Byb3RvYnVmLlVJbnQzMlZhbHVlUgZwb2ludHMSWwoKaW5kaWNhdG9ycxgFIAMoCzI7LnJhem1h'
    'bmFnZXIucHJvdG9idWYucHVibGljLnYxLlJhY2VMZWFkZXJib2FyZEhlYXRJbmRpY2F0b3JSCm'
    'luZGljYXRvcnMSRgoFZmxhZ3MYBiADKA4yMC5yYXptYW5hZ2VyLnByb3RvYnVmLnB1YmxpYy52'
    'MS5SYWNlSW5kaWNhdG9yRmxhZ1IFZmxhZ3M=');

@$core.Deprecated('Use raceLeaderboardHeatIndicatorDescriptor instead')
const RaceLeaderboardHeatIndicator$json = {
  '1': 'RaceLeaderboardHeatIndicator',
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

/// Descriptor for `RaceLeaderboardHeatIndicator`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List raceLeaderboardHeatIndicatorDescriptor =
    $convert.base64Decode(
        'ChxSYWNlTGVhZGVyYm9hcmRIZWF0SW5kaWNhdG9yEiEKDGluZGljYXRvcl9pZBgBIAEoDVILaW'
        '5kaWNhdG9ySWQSMgoFY29sb3IYAiABKAsyHC5nb29nbGUucHJvdG9idWYuVUludDMyVmFsdWVS'
        'BWNvbG9y');
