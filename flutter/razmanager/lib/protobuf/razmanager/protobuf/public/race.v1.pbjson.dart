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
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.TrackConfiguration',
      '10': 'trackConfiguration'
    },
    {
      '1': 'points_scheme_id',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'pointsSchemeId'
    },
    {
      '1': 'race_heat_end_type_id',
      '3': 14,
      '4': 1,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.HeatEndTypeId',
      '10': 'raceHeatEndTypeId'
    },
    {
      '1': 'race_heat_end_lap_laps',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'raceHeatEndLapLaps'
    },
    {
      '1': 'race_heat_end_duration_duration',
      '3': 16,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'raceHeatEndDurationDuration'
    },
    {
      '1': 'race_indicators',
      '3': 19,
      '4': 3,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.RaceIndicator',
      '10': 'raceIndicators'
    },
    {'1': 'race_event_users', '3': 20, '4': 3, '5': 9, '10': 'raceEventUsers'},
    {
      '1': 'race_state_type',
      '3': 21,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.RaceStateType',
      '10': 'raceStateType'
    },
    {
      '1': 'race_features',
      '3': 22,
      '4': 3,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.RaceFeatureTypeId',
      '10': 'raceFeatures'
    },
    {
      '1': 'heats',
      '3': 23,
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
    'ASgJUgdldmVudElkEmIKE3RyYWNrX2NvbmZpZ3VyYXRpb24YByABKAsyMS5yYXptYW5hZ2VyLn'
    'Byb3RvYnVmLnB1YmxpYy52MS5UcmFja0NvbmZpZ3VyYXRpb25SEnRyYWNrQ29uZmlndXJhdGlv'
    'bhJGChBwb2ludHNfc2NoZW1lX2lkGAggASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbH'
    'VlUg5wb2ludHNTY2hlbWVJZBJeChVyYWNlX2hlYXRfZW5kX3R5cGVfaWQYDiABKA4yLC5yYXpt'
    'YW5hZ2VyLnByb3RvYnVmLnB1YmxpYy52MS5IZWF0RW5kVHlwZUlkUhFyYWNlSGVhdEVuZFR5cG'
    'VJZBJQChZyYWNlX2hlYXRfZW5kX2xhcF9sYXBzGA8gASgLMhwuZ29vZ2xlLnByb3RvYnVmLlVJ'
    'bnQzMlZhbHVlUhJyYWNlSGVhdEVuZExhcExhcHMSXwofcmFjZV9oZWF0X2VuZF9kdXJhdGlvbl'
    '9kdXJhdGlvbhgQIAEoCzIZLmdvb2dsZS5wcm90b2J1Zi5EdXJhdGlvblIbcmFjZUhlYXRFbmRE'
    'dXJhdGlvbkR1cmF0aW9uElUKD3JhY2VfaW5kaWNhdG9ycxgTIAMoCzIsLnJhem1hbmFnZXIucH'
    'JvdG9idWYucHVibGljLnYxLlJhY2VJbmRpY2F0b3JSDnJhY2VJbmRpY2F0b3JzEigKEHJhY2Vf'
    'ZXZlbnRfdXNlcnMYFCADKAlSDnJhY2VFdmVudFVzZXJzElQKD3JhY2Vfc3RhdGVfdHlwZRgVIA'
    'EoCzIsLnJhem1hbmFnZXIucHJvdG9idWYucHVibGljLnYxLlJhY2VTdGF0ZVR5cGVSDXJhY2VT'
    'dGF0ZVR5cGUSVQoNcmFjZV9mZWF0dXJlcxgWIAMoDjIwLnJhem1hbmFnZXIucHJvdG9idWYucH'
    'VibGljLnYxLlJhY2VGZWF0dXJlVHlwZUlkUgxyYWNlRmVhdHVyZXMSOQoFaGVhdHMYFyADKAsy'
    'Iy5yYXptYW5hZ2VyLnByb3RvYnVmLnB1YmxpYy52MS5IZWF0UgVoZWF0cw==');

@$core.Deprecated('Use raceIndicatorDescriptor instead')
const RaceIndicator$json = {
  '1': 'RaceIndicator',
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

/// Descriptor for `RaceIndicator`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List raceIndicatorDescriptor = $convert.base64Decode(
    'Cg1SYWNlSW5kaWNhdG9yEiEKDGluZGljYXRvcl9pZBgBIAEoDVILaW5kaWNhdG9ySWQSMgoFY2'
    '9sb3IYAiABKAsyHC5nb29nbGUucHJvdG9idWYuVUludDMyVmFsdWVSBWNvbG9y');

@$core.Deprecated('Use raceStateDescriptor instead')
const RaceState$json = {
  '1': 'RaceState',
  '2': [
    {
      '1': 'session_type_id',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.SessionTypeId',
      '10': 'sessionTypeId'
    },
    {
      '1': 'race_state_type',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.RaceStateType',
      '10': 'raceStateType'
    },
    {
      '1': 'race_event_user_states',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.RaceEventUserState',
      '10': 'raceEventUserStates'
    },
    {
      '1': 'heat_id',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'heatId'
    },
    {
      '1': 'heat_number',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'heatNumber'
    },
    {
      '1': 'heat_state',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.HeatState',
      '10': 'heatState'
    },
  ],
};

/// Descriptor for `RaceState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List raceStateDescriptor = $convert.base64Decode(
    'CglSYWNlU3RhdGUSVAoPc2Vzc2lvbl90eXBlX2lkGAEgASgOMiwucmF6bWFuYWdlci5wcm90b2'
    'J1Zi5wdWJsaWMudjEuU2Vzc2lvblR5cGVJZFINc2Vzc2lvblR5cGVJZBJUCg9yYWNlX3N0YXRl'
    'X3R5cGUYAiABKAsyLC5yYXptYW5hZ2VyLnByb3RvYnVmLnB1YmxpYy52MS5SYWNlU3RhdGVUeX'
    'BlUg1yYWNlU3RhdGVUeXBlEmYKFnJhY2VfZXZlbnRfdXNlcl9zdGF0ZXMYAyADKAsyMS5yYXpt'
    'YW5hZ2VyLnByb3RvYnVmLnB1YmxpYy52MS5SYWNlRXZlbnRVc2VyU3RhdGVSE3JhY2VFdmVudF'
    'VzZXJTdGF0ZXMSNQoHaGVhdF9pZBgEIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1'
    'ZVIGaGVhdElkEj0KC2hlYXRfbnVtYmVyGAUgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlVJbnQzMl'
    'ZhbHVlUgpoZWF0TnVtYmVyEkcKCmhlYXRfc3RhdGUYBiABKAsyKC5yYXptYW5hZ2VyLnByb3Rv'
    'YnVmLnB1YmxpYy52MS5IZWF0U3RhdGVSCWhlYXRTdGF0ZQ==');

@$core.Deprecated('Use raceEventUserStateDescriptor instead')
const RaceEventUserState$json = {
  '1': 'RaceEventUserState',
  '2': [
    {'1': 'event_user_id', '3': 1, '4': 1, '5': 9, '10': 'eventUserId'},
    {
      '1': 'indicator_id_current',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'indicatorIdCurrent'
    },
    {
      '1': 'indicator_ids_finished',
      '3': 3,
      '4': 3,
      '5': 13,
      '10': 'indicatorIdsFinished'
    },
  ],
};

/// Descriptor for `RaceEventUserState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List raceEventUserStateDescriptor = $convert.base64Decode(
    'ChJSYWNlRXZlbnRVc2VyU3RhdGUSIgoNZXZlbnRfdXNlcl9pZBgBIAEoCVILZXZlbnRVc2VySW'
    'QSTgoUaW5kaWNhdG9yX2lkX2N1cnJlbnQYAiABKAsyHC5nb29nbGUucHJvdG9idWYuVUludDMy'
    'VmFsdWVSEmluZGljYXRvcklkQ3VycmVudBI0ChZpbmRpY2F0b3JfaWRzX2ZpbmlzaGVkGAMgAy'
    'gNUhRpbmRpY2F0b3JJZHNGaW5pc2hlZA==');

@$core.Deprecated('Use raceLeaderboardDescriptor instead')
const RaceLeaderboard$json = {
  '1': 'RaceLeaderboard',
  '2': [
    {
      '1': 'session_type_id',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.SessionTypeId',
      '10': 'sessionTypeId'
    },
    {
      '1': 'event_users',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.RaceLeaderboardEventUser',
      '10': 'eventUsers'
    },
  ],
};

/// Descriptor for `RaceLeaderboard`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List raceLeaderboardDescriptor = $convert.base64Decode(
    'Cg9SYWNlTGVhZGVyYm9hcmQSVAoPc2Vzc2lvbl90eXBlX2lkGAEgASgOMiwucmF6bWFuYWdlci'
    '5wcm90b2J1Zi5wdWJsaWMudjEuU2Vzc2lvblR5cGVJZFINc2Vzc2lvblR5cGVJZBJYCgtldmVu'
    'dF91c2VycxgCIAMoCzI3LnJhem1hbmFnZXIucHJvdG9idWYucHVibGljLnYxLlJhY2VMZWFkZX'
    'Jib2FyZEV2ZW50VXNlclIKZXZlbnRVc2Vycw==');

@$core.Deprecated('Use raceLeaderboardEventUserDescriptor instead')
const RaceLeaderboardEventUser$json = {
  '1': 'RaceLeaderboardEventUser',
  '2': [
    {'1': 'event_user_id', '3': 1, '4': 1, '5': 9, '10': 'eventUserId'},
    {'1': 'position', '3': 2, '4': 1, '5': 13, '10': 'position'},
    {
      '1': 'laps_completed',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'lapsCompleted'
    },
    {
      '1': 'laps_predicted',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'lapsPredicted'
    },
    {
      '1': 'gap_laps_predicted_leader',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'gapLapsPredictedLeader'
    },
    {
      '1': 'gap_laps_predicted_interval',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'gapLapsPredictedInterval'
    },
    {
      '1': 'gap_laps_predicted_interval_fraction',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.DoubleValue',
      '10': 'gapLapsPredictedIntervalFraction'
    },
    {
      '1': 'flags',
      '3': 11,
      '4': 3,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.HeatIndicatorFlag',
      '10': 'flags'
    },
    {
      '1': 'team_event_user_id',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'teamEventUserId'
    },
  ],
};

/// Descriptor for `RaceLeaderboardEventUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List raceLeaderboardEventUserDescriptor = $convert.base64Decode(
    'ChhSYWNlTGVhZGVyYm9hcmRFdmVudFVzZXISIgoNZXZlbnRfdXNlcl9pZBgBIAEoCVILZXZlbn'
    'RVc2VySWQSGgoIcG9zaXRpb24YAiABKA1SCHBvc2l0aW9uEkMKDmxhcHNfY29tcGxldGVkGAQg'
    'ASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUg1sYXBzQ29tcGxldGVkEkMKDmxhcH'
    'NfcHJlZGljdGVkGAUgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUg1sYXBzUHJl'
    'ZGljdGVkElcKGWdhcF9sYXBzX3ByZWRpY3RlZF9sZWFkZXIYCCABKAsyHC5nb29nbGUucHJvdG'
    '9idWYuU3RyaW5nVmFsdWVSFmdhcExhcHNQcmVkaWN0ZWRMZWFkZXISWwobZ2FwX2xhcHNfcHJl'
    'ZGljdGVkX2ludGVydmFsGAkgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUhhnYX'
    'BMYXBzUHJlZGljdGVkSW50ZXJ2YWwSbAokZ2FwX2xhcHNfcHJlZGljdGVkX2ludGVydmFsX2Zy'
    'YWN0aW9uGAogASgLMhwuZ29vZ2xlLnByb3RvYnVmLkRvdWJsZVZhbHVlUiBnYXBMYXBzUHJlZG'
    'ljdGVkSW50ZXJ2YWxGcmFjdGlvbhJGCgVmbGFncxgLIAMoDjIwLnJhem1hbmFnZXIucHJvdG9i'
    'dWYucHVibGljLnYxLkhlYXRJbmRpY2F0b3JGbGFnUgVmbGFncxJJChJ0ZWFtX2V2ZW50X3VzZX'
    'JfaWQYDCABKAsyHC5nb29nbGUucHJvdG9idWYuU3RyaW5nVmFsdWVSD3RlYW1FdmVudFVzZXJJ'
    'ZA==');

@$core.Deprecated('Use raceLeaderboardHeatEventUserUpdateDescriptor instead')
const RaceLeaderboardHeatEventUserUpdate$json = {
  '1': 'RaceLeaderboardHeatEventUserUpdate',
  '2': [
    {'1': 'heat_id', '3': 1, '4': 1, '5': 9, '10': 'heatId'},
    {'1': 'event_user_id', '3': 2, '4': 1, '5': 9, '10': 'eventUserId'},
    {
      '1': 'timer_elapsed',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'timerElapsed'
    },
    {
      '1': 'laps',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.DoubleValue',
      '9': 0,
      '10': 'laps'
    },
    {'1': 'finished', '3': 9, '4': 1, '5': 8, '9': 0, '10': 'finished'},
    {
      '1': 'flags',
      '3': 10,
      '4': 1,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.HeatIndicatorFlag',
      '9': 0,
      '10': 'flags'
    },
  ],
  '8': [
    {'1': 'value'},
  ],
};

/// Descriptor for `RaceLeaderboardHeatEventUserUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List raceLeaderboardHeatEventUserUpdateDescriptor = $convert.base64Decode(
    'CiJSYWNlTGVhZGVyYm9hcmRIZWF0RXZlbnRVc2VyVXBkYXRlEhcKB2hlYXRfaWQYASABKAlSBm'
    'hlYXRJZBIiCg1ldmVudF91c2VyX2lkGAIgASgJUgtldmVudFVzZXJJZBI+Cg10aW1lcl9lbGFw'
    'c2VkGAMgASgLMhkuZ29vZ2xlLnByb3RvYnVmLkR1cmF0aW9uUgx0aW1lckVsYXBzZWQSMgoEbG'
    'FwcxgEIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5Eb3VibGVWYWx1ZUgAUgRsYXBzEhwKCGZpbmlz'
    'aGVkGAkgASgISABSCGZpbmlzaGVkEkgKBWZsYWdzGAogASgOMjAucmF6bWFuYWdlci5wcm90b2'
    'J1Zi5wdWJsaWMudjEuSGVhdEluZGljYXRvckZsYWdIAFIFZmxhZ3NCBwoFdmFsdWU=');
