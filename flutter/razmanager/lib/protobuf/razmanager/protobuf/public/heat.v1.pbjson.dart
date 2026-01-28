// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/heat.v1.proto.

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

@$core.Deprecated('Use heatCommandTypeIdDescriptor instead')
const HeatCommandTypeId$json = {
  '1': 'HeatCommandTypeId',
  '2': [
    {'1': 'HEAT_COMMAND_TYPE_ID_OPEN', '2': 0},
    {'1': 'HEAT_COMMAND_TYPE_ID_START', '2': 1},
    {'1': 'HEAT_COMMAND_TYPE_ID_YELLOW', '2': 2},
    {'1': 'HEAT_COMMAND_TYPE_ID_RED', '2': 3},
    {'1': 'HEAT_COMMAND_TYPE_ID_END', '2': 4},
    {'1': 'HEAT_COMMAND_TYPE_ID_REOPEN', '2': 5},
    {'1': 'HEAT_COMMAND_TYPE_ID_CLOSE', '2': 6},
    {'1': 'HEAT_COMMAND_TYPE_ID_RESET', '2': 7},
  ],
};

/// Descriptor for `HeatCommandTypeId`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List heatCommandTypeIdDescriptor = $convert.base64Decode(
    'ChFIZWF0Q29tbWFuZFR5cGVJZBIdChlIRUFUX0NPTU1BTkRfVFlQRV9JRF9PUEVOEAASHgoaSE'
    'VBVF9DT01NQU5EX1RZUEVfSURfU1RBUlQQARIfChtIRUFUX0NPTU1BTkRfVFlQRV9JRF9ZRUxM'
    'T1cQAhIcChhIRUFUX0NPTU1BTkRfVFlQRV9JRF9SRUQQAxIcChhIRUFUX0NPTU1BTkRfVFlQRV'
    '9JRF9FTkQQBBIfChtIRUFUX0NPTU1BTkRfVFlQRV9JRF9SRU9QRU4QBRIeChpIRUFUX0NPTU1B'
    'TkRfVFlQRV9JRF9DTE9TRRAGEh4KGkhFQVRfQ09NTUFORF9UWVBFX0lEX1JFU0VUEAc=');

@$core.Deprecated('Use heatStateTypeIdDescriptor instead')
const HeatStateTypeId$json = {
  '1': 'HeatStateTypeId',
  '2': [
    {'1': 'HEAT_STATE_TYPE_ID_PENDING', '2': 0},
    {'1': 'HEAT_STATE_TYPE_ID_OPENED', '2': 1},
    {'1': 'HEAT_STATE_TYPE_ID_COUNTDOWN', '2': 2},
    {'1': 'HEAT_STATE_TYPE_ID_RUNNING', '2': 3},
    {'1': 'HEAT_STATE_TYPE_ID_YELLOW', '2': 4},
    {'1': 'HEAT_STATE_TYPE_ID_COUNTDOWN_YELLOW', '2': 5},
    {'1': 'HEAT_STATE_TYPE_ID_RED', '2': 6},
    {'1': 'HEAT_STATE_TYPE_ID_COUNTDOWN_RED', '2': 7},
    {'1': 'HEAT_STATE_TYPE_ID_ENDED', '2': 8},
    {'1': 'HEAT_STATE_TYPE_ID_OFF', '2': 9},
    {'1': 'HEAT_STATE_TYPE_ID_CLOSED', '2': 10},
  ],
};

/// Descriptor for `HeatStateTypeId`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List heatStateTypeIdDescriptor = $convert.base64Decode(
    'Cg9IZWF0U3RhdGVUeXBlSWQSHgoaSEVBVF9TVEFURV9UWVBFX0lEX1BFTkRJTkcQABIdChlIRU'
    'FUX1NUQVRFX1RZUEVfSURfT1BFTkVEEAESIAocSEVBVF9TVEFURV9UWVBFX0lEX0NPVU5URE9X'
    'ThACEh4KGkhFQVRfU1RBVEVfVFlQRV9JRF9SVU5OSU5HEAMSHQoZSEVBVF9TVEFURV9UWVBFX0'
    'lEX1lFTExPVxAEEicKI0hFQVRfU1RBVEVfVFlQRV9JRF9DT1VOVERPV05fWUVMTE9XEAUSGgoW'
    'SEVBVF9TVEFURV9UWVBFX0lEX1JFRBAGEiQKIEhFQVRfU1RBVEVfVFlQRV9JRF9DT1VOVERPV0'
    '5fUkVEEAcSHAoYSEVBVF9TVEFURV9UWVBFX0lEX0VOREVEEAgSGgoWSEVBVF9TVEFURV9UWVBF'
    'X0lEX09GRhAJEh0KGUhFQVRfU1RBVEVfVFlQRV9JRF9DTE9TRUQQCg==');

@$core.Deprecated('Use heatEndTypeIdDescriptor instead')
const HeatEndTypeId$json = {
  '1': 'HeatEndTypeId',
  '2': [
    {'1': 'HEAT_END_TYPE_ID_UNDEFINED', '2': 0},
    {'1': 'HEAT_END_TYPE_ID_LAP', '2': 1},
    {'1': 'HEAT_END_TYPE_ID_DURATION', '2': 2},
    {'1': 'HEAT_END_TYPE_ID_MANUAL', '2': 3},
  ],
};

/// Descriptor for `HeatEndTypeId`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List heatEndTypeIdDescriptor = $convert.base64Decode(
    'Cg1IZWF0RW5kVHlwZUlkEh4KGkhFQVRfRU5EX1RZUEVfSURfVU5ERUZJTkVEEAASGAoUSEVBVF'
    '9FTkRfVFlQRV9JRF9MQVAQARIdChlIRUFUX0VORF9UWVBFX0lEX0RVUkFUSU9OEAISGwoXSEVB'
    'VF9FTkRfVFlQRV9JRF9NQU5VQUwQAw==');

@$core.Deprecated('Use heatIndicatorFlagDescriptor instead')
const HeatIndicatorFlag$json = {
  '1': 'HeatIndicatorFlag',
  '2': [
    {'1': 'HEAT_INDICATOR_FLAG_FINISHED', '2': 0},
    {'1': 'HEAT_INDICATOR_FLAG_FASTEST_LAP', '2': 1},
    {'1': 'HEAT_INDICATOR_FLAG_PITLANE', '2': 2},
    {'1': 'HEAT_INDICATOR_FLAG_CAR_OFF_TRACK', '2': 3},
    {'1': 'HEAT_INDICATOR_FLAG_CONTROLLER_BATTERY_WARNING', '2': 4},
    {'1': 'HEAT_INDICATOR_FLAG_CHARGING', '2': 5},
    {'1': 'HEAT_INDICATOR_FLAG_WARNING', '2': 10},
  ],
};

/// Descriptor for `HeatIndicatorFlag`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List heatIndicatorFlagDescriptor = $convert.base64Decode(
    'ChFIZWF0SW5kaWNhdG9yRmxhZxIgChxIRUFUX0lORElDQVRPUl9GTEFHX0ZJTklTSEVEEAASIw'
    'ofSEVBVF9JTkRJQ0FUT1JfRkxBR19GQVNURVNUX0xBUBABEh8KG0hFQVRfSU5ESUNBVE9SX0ZM'
    'QUdfUElUTEFORRACEiUKIUhFQVRfSU5ESUNBVE9SX0ZMQUdfQ0FSX09GRl9UUkFDSxADEjIKLk'
    'hFQVRfSU5ESUNBVE9SX0ZMQUdfQ09OVFJPTExFUl9CQVRURVJZX1dBUk5JTkcQBBIgChxIRUFU'
    'X0lORElDQVRPUl9GTEFHX0NIQVJHSU5HEAUSHwobSEVBVF9JTkRJQ0FUT1JfRkxBR19XQVJOSU'
    '5HEAo=');

@$core.Deprecated('Use heatIndicatorTimeTypeIdDescriptor instead')
const HeatIndicatorTimeTypeId$json = {
  '1': 'HeatIndicatorTimeTypeId',
  '2': [
    {'1': 'HEAT_INDICATOR_TIME_TYPE_ID_LAP', '2': 0},
    {'1': 'HEAT_INDICATOR_TIME_TYPE_ID_SECTOR1', '2': 1},
    {'1': 'HEAT_INDICATOR_TIME_TYPE_ID_SECTOR2', '2': 2},
    {'1': 'HEAT_INDICATOR_TIME_TYPE_ID_SECTOR3', '2': 3},
    {'1': 'HEAT_INDICATOR_TIME_TYPE_ID_SPEED_TRAP', '2': 4},
  ],
};

/// Descriptor for `HeatIndicatorTimeTypeId`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List heatIndicatorTimeTypeIdDescriptor = $convert.base64Decode(
    'ChdIZWF0SW5kaWNhdG9yVGltZVR5cGVJZBIjCh9IRUFUX0lORElDQVRPUl9USU1FX1RZUEVfSU'
    'RfTEFQEAASJwojSEVBVF9JTkRJQ0FUT1JfVElNRV9UWVBFX0lEX1NFQ1RPUjEQARInCiNIRUFU'
    'X0lORElDQVRPUl9USU1FX1RZUEVfSURfU0VDVE9SMhACEicKI0hFQVRfSU5ESUNBVE9SX1RJTU'
    'VfVFlQRV9JRF9TRUNUT1IzEAMSKgomSEVBVF9JTkRJQ0FUT1JfVElNRV9UWVBFX0lEX1NQRUVE'
    'X1RSQVAQBA==');

@$core.Deprecated('Use heatIndicatorFastestTimeTypeIdDescriptor instead')
const HeatIndicatorFastestTimeTypeId$json = {
  '1': 'HeatIndicatorFastestTimeTypeId',
  '2': [
    {'1': 'HEAT_INDICATOR_FASTEST_TIME_TYPE_ID_NONE', '2': 0},
    {'1': 'HEAT_INDICATOR_FASTEST_TIME_TYPE_ID_INDICATOR', '2': 1},
    {'1': 'HEAT_INDICATOR_FASTEST_TIME_TYPE_ID_ALL_INDICATORS', '2': 2},
  ],
};

/// Descriptor for `HeatIndicatorFastestTimeTypeId`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List heatIndicatorFastestTimeTypeIdDescriptor =
    $convert.base64Decode(
        'Ch5IZWF0SW5kaWNhdG9yRmFzdGVzdFRpbWVUeXBlSWQSLAooSEVBVF9JTkRJQ0FUT1JfRkFTVE'
        'VTVF9USU1FX1RZUEVfSURfTk9ORRAAEjEKLUhFQVRfSU5ESUNBVE9SX0ZBU1RFU1RfVElNRV9U'
        'WVBFX0lEX0lORElDQVRPUhABEjYKMkhFQVRfSU5ESUNBVE9SX0ZBU1RFU1RfVElNRV9UWVBFX0'
        'lEX0FMTF9JTkRJQ0FUT1JTEAI=');

@$core.Deprecated('Use heatCommandPermissionsDescriptor instead')
const HeatCommandPermissions$json = {
  '1': 'HeatCommandPermissions',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.HeatCommandTypeId',
      '10': 'items'
    },
  ],
};

/// Descriptor for `HeatCommandPermissions`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heatCommandPermissionsDescriptor =
    $convert.base64Decode(
        'ChZIZWF0Q29tbWFuZFBlcm1pc3Npb25zEkYKBWl0ZW1zGAEgAygOMjAucmF6bWFuYWdlci5wcm'
        '90b2J1Zi5wdWJsaWMudjEuSGVhdENvbW1hbmRUeXBlSWRSBWl0ZW1z');

@$core.Deprecated('Use sessionTypeDescriptor instead')
const SessionType$json = {
  '1': 'SessionType',
  '2': [
    {
      '1': 'id',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.SessionTypeId',
      '10': 'id'
    },
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `SessionType`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sessionTypeDescriptor = $convert.base64Decode(
    'CgtTZXNzaW9uVHlwZRI8CgJpZBgBIAEoDjIsLnJhem1hbmFnZXIucHJvdG9idWYucHVibGljLn'
    'YxLlNlc3Npb25UeXBlSWRSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWU=');

@$core.Deprecated('Use heatStateTypeDescriptor instead')
const HeatStateType$json = {
  '1': 'HeatStateType',
  '2': [
    {
      '1': 'id',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.HeatStateTypeId',
      '10': 'id'
    },
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `HeatStateType`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heatStateTypeDescriptor = $convert.base64Decode(
    'Cg1IZWF0U3RhdGVUeXBlEj4KAmlkGAEgASgOMi4ucmF6bWFuYWdlci5wcm90b2J1Zi5wdWJsaW'
    'MudjEuSGVhdFN0YXRlVHlwZUlkUgJpZBISCgRuYW1lGAIgASgJUgRuYW1l');

@$core.Deprecated('Use heatDescriptor instead')
const Heat$json = {
  '1': 'Heat',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'number', '3': 2, '4': 1, '5': 13, '10': 'number'},
    {'1': 'race_id', '3': 3, '4': 1, '5': 9, '10': 'raceId'},
    {
      '1': 'session_type',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.SessionType',
      '10': 'sessionType'
    },
    {
      '1': 'heat_state_type',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.HeatStateType',
      '10': 'heatStateType'
    },
    {
      '1': 'heat_indicators',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.HeatIndicator',
      '10': 'heatIndicators'
    },
  ],
};

/// Descriptor for `Heat`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heatDescriptor = $convert.base64Decode(
    'CgRIZWF0Eg4KAmlkGAEgASgJUgJpZBIWCgZudW1iZXIYAiABKA1SBm51bWJlchIXCgdyYWNlX2'
    'lkGAMgASgJUgZyYWNlSWQSTQoMc2Vzc2lvbl90eXBlGAQgASgLMioucmF6bWFuYWdlci5wcm90'
    'b2J1Zi5wdWJsaWMudjEuU2Vzc2lvblR5cGVSC3Nlc3Npb25UeXBlElQKD2hlYXRfc3RhdGVfdH'
    'lwZRgFIAEoCzIsLnJhem1hbmFnZXIucHJvdG9idWYucHVibGljLnYxLkhlYXRTdGF0ZVR5cGVS'
    'DWhlYXRTdGF0ZVR5cGUSVQoPaGVhdF9pbmRpY2F0b3JzGAYgAygLMiwucmF6bWFuYWdlci5wcm'
    '90b2J1Zi5wdWJsaWMudjEuSGVhdEluZGljYXRvclIOaGVhdEluZGljYXRvcnM=');

@$core.Deprecated('Use heatIndicatorDescriptor instead')
const HeatIndicator$json = {
  '1': 'HeatIndicator',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'indicator_id', '3': 2, '4': 1, '5': 13, '10': 'indicatorId'},
    {
      '1': 'color',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'color'
    },
    {'1': 'event_user_id', '3': 4, '4': 1, '5': 9, '10': 'eventUserId'},
    {
      '1': 'car_class_color',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'carClassColor'
    },
    {
      '1': 'car_image',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BytesValue',
      '10': 'carImage'
    },
    {
      '1': 'heat_indicator_stints',
      '3': 7,
      '4': 3,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.HeatIndicatorStint',
      '10': 'heatIndicatorStints'
    },
  ],
};

/// Descriptor for `HeatIndicator`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heatIndicatorDescriptor = $convert.base64Decode(
    'Cg1IZWF0SW5kaWNhdG9yEg4KAmlkGAEgASgJUgJpZBIhCgxpbmRpY2F0b3JfaWQYAiABKA1SC2'
    'luZGljYXRvcklkEjIKBWNvbG9yGAMgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlVJbnQzMlZhbHVl'
    'UgVjb2xvchIiCg1ldmVudF91c2VyX2lkGAQgASgJUgtldmVudFVzZXJJZBJECg9jYXJfY2xhc3'
    'NfY29sb3IYBSABKAsyHC5nb29nbGUucHJvdG9idWYuVUludDMyVmFsdWVSDWNhckNsYXNzQ29s'
    'b3ISOAoJY2FyX2ltYWdlGAYgASgLMhsuZ29vZ2xlLnByb3RvYnVmLkJ5dGVzVmFsdWVSCGNhck'
    'ltYWdlEmUKFWhlYXRfaW5kaWNhdG9yX3N0aW50cxgHIAMoCzIxLnJhem1hbmFnZXIucHJvdG9i'
    'dWYucHVibGljLnYxLkhlYXRJbmRpY2F0b3JTdGludFITaGVhdEluZGljYXRvclN0aW50cw==');

@$core.Deprecated('Use heatIndicatorStintDescriptor instead')
const HeatIndicatorStint$json = {
  '1': 'HeatIndicatorStint',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'lap', '3': 3, '4': 1, '5': 13, '10': 'lap'},
    {
      '1': 'event_user_id',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'eventUserId'
    },
    {
      '1': 'comments',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'comments'
    },
  ],
};

/// Descriptor for `HeatIndicatorStint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heatIndicatorStintDescriptor = $convert.base64Decode(
    'ChJIZWF0SW5kaWNhdG9yU3RpbnQSDgoCaWQYASABKAlSAmlkEhAKA2xhcBgDIAEoDVIDbGFwEk'
    'AKDWV2ZW50X3VzZXJfaWQYBCABKAsyHC5nb29nbGUucHJvdG9idWYuU3RyaW5nVmFsdWVSC2V2'
    'ZW50VXNlcklkEjgKCGNvbW1lbnRzGAUgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbH'
    'VlUghjb21tZW50cw==');

@$core.Deprecated('Use heatStateDescriptor instead')
const HeatState$json = {
  '1': 'HeatState',
  '2': [
    {
      '1': 'heat_state_type',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.HeatStateType',
      '10': 'heatStateType'
    },
    {
      '1': 'laps_current',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'lapsCurrent'
    },
    {'1': 'timer_is_running', '3': 3, '4': 1, '5': 8, '10': 'timerIsRunning'},
    {
      '1': 'timer_elapsed',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'timerElapsed'
    },
    {'1': 'start_light_id', '3': 5, '4': 1, '5': 13, '10': 'startLightId'},
  ],
};

/// Descriptor for `HeatState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heatStateDescriptor = $convert.base64Decode(
    'CglIZWF0U3RhdGUSVAoPaGVhdF9zdGF0ZV90eXBlGAEgASgLMiwucmF6bWFuYWdlci5wcm90b2'
    'J1Zi5wdWJsaWMudjEuSGVhdFN0YXRlVHlwZVINaGVhdFN0YXRlVHlwZRI/CgxsYXBzX2N1cnJl'
    'bnQYAiABKAsyHC5nb29nbGUucHJvdG9idWYuVUludDMyVmFsdWVSC2xhcHNDdXJyZW50EigKEH'
    'RpbWVyX2lzX3J1bm5pbmcYAyABKAhSDnRpbWVySXNSdW5uaW5nEj4KDXRpbWVyX2VsYXBzZWQY'
    'BCABKAsyGS5nb29nbGUucHJvdG9idWYuRHVyYXRpb25SDHRpbWVyRWxhcHNlZBIkCg5zdGFydF'
    '9saWdodF9pZBgFIAEoDVIMc3RhcnRMaWdodElk');

@$core.Deprecated('Use heatLeaderboardDescriptor instead')
const HeatLeaderboard$json = {
  '1': 'HeatLeaderboard',
  '2': [
    {
      '1': 'correlation_id',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'correlationId'
    },
    {
      '1': 'indicators',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.HeatLeaderboardIndicator',
      '10': 'indicators'
    },
  ],
};

/// Descriptor for `HeatLeaderboard`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heatLeaderboardDescriptor = $convert.base64Decode(
    'Cg9IZWF0TGVhZGVyYm9hcmQSQwoOY29ycmVsYXRpb25faWQYASABKAsyHC5nb29nbGUucHJvdG'
    '9idWYuU3RyaW5nVmFsdWVSDWNvcnJlbGF0aW9uSWQSVwoKaW5kaWNhdG9ycxgCIAMoCzI3LnJh'
    'em1hbmFnZXIucHJvdG9idWYucHVibGljLnYxLkhlYXRMZWFkZXJib2FyZEluZGljYXRvclIKaW'
    '5kaWNhdG9ycw==');

@$core.Deprecated('Use heatLeaderboardIndicatorDescriptor instead')
const HeatLeaderboardIndicator$json = {
  '1': 'HeatLeaderboardIndicator',
  '2': [
    {'1': 'indicator_id', '3': 1, '4': 1, '5': 13, '10': 'indicatorId'},
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
      '1': 'time_type_times',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.HeatIndicatorTimeTypeTime',
      '10': 'timeTypeTimes'
    },
    {
      '1': 'gap_leader',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'gapLeader'
    },
    {
      '1': 'gap_interval',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'gapInterval'
    },
    {'1': 'energy_percent', '3': 7, '4': 1, '5': 13, '10': 'energyPercent'},
    {
      '1': 'energy_laps_left',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'energyLapsLeft'
    },
    {
      '1': 'flags',
      '3': 9,
      '4': 3,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.HeatIndicatorFlag',
      '10': 'flags'
    },
    {'1': 'pit_lanes', '3': 10, '4': 1, '5': 13, '10': 'pitLanes'},
    {'1': 'car_off_tracks', '3': 11, '4': 1, '5': 13, '10': 'carOffTracks'},
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

/// Descriptor for `HeatLeaderboardIndicator`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heatLeaderboardIndicatorDescriptor = $convert.base64Decode(
    'ChhIZWF0TGVhZGVyYm9hcmRJbmRpY2F0b3ISIQoMaW5kaWNhdG9yX2lkGAEgASgNUgtpbmRpY2'
    'F0b3JJZBIaCghwb3NpdGlvbhgCIAEoDVIIcG9zaXRpb24SMAoEbGFwcxgDIAEoCzIcLmdvb2ds'
    'ZS5wcm90b2J1Zi5VSW50MzJWYWx1ZVIEbGFwcxJgCg90aW1lX3R5cGVfdGltZXMYBCADKAsyOC'
    '5yYXptYW5hZ2VyLnByb3RvYnVmLnB1YmxpYy52MS5IZWF0SW5kaWNhdG9yVGltZVR5cGVUaW1l'
    'Ug10aW1lVHlwZVRpbWVzEjsKCmdhcF9sZWFkZXIYBSABKAsyHC5nb29nbGUucHJvdG9idWYuU3'
    'RyaW5nVmFsdWVSCWdhcExlYWRlchI/CgxnYXBfaW50ZXJ2YWwYBiABKAsyHC5nb29nbGUucHJv'
    'dG9idWYuU3RyaW5nVmFsdWVSC2dhcEludGVydmFsEiUKDmVuZXJneV9wZXJjZW50GAcgASgNUg'
    '1lbmVyZ3lQZXJjZW50EkYKEGVuZXJneV9sYXBzX2xlZnQYCCABKAsyHC5nb29nbGUucHJvdG9i'
    'dWYuVUludDMyVmFsdWVSDmVuZXJneUxhcHNMZWZ0EkYKBWZsYWdzGAkgAygOMjAucmF6bWFuYW'
    'dlci5wcm90b2J1Zi5wdWJsaWMudjEuSGVhdEluZGljYXRvckZsYWdSBWZsYWdzEhsKCXBpdF9s'
    'YW5lcxgKIAEoDVIIcGl0TGFuZXMSJAoOY2FyX29mZl90cmFja3MYCyABKA1SDGNhck9mZlRyYW'
    'NrcxJJChJ0ZWFtX2V2ZW50X3VzZXJfaWQYDCABKAsyHC5nb29nbGUucHJvdG9idWYuU3RyaW5n'
    'VmFsdWVSD3RlYW1FdmVudFVzZXJJZA==');

@$core.Deprecated('Use heatIndicatorTimeTypeTimeDescriptor instead')
const HeatIndicatorTimeTypeTime$json = {
  '1': 'HeatIndicatorTimeTypeTime',
  '2': [
    {
      '1': 'time_type_id',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.HeatIndicatorTimeTypeId',
      '10': 'timeTypeId'
    },
    {
      '1': 'time',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.DoubleValue',
      '10': 'time'
    },
    {
      '1': 'fastest_time_type_id',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.HeatIndicatorFastestTimeTypeId',
      '10': 'fastestTimeTypeId'
    },
    {
      '1': 'fastest_time',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.DoubleValue',
      '10': 'fastestTime'
    },
  ],
};

/// Descriptor for `HeatIndicatorTimeTypeTime`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heatIndicatorTimeTypeTimeDescriptor = $convert.base64Decode(
    'ChlIZWF0SW5kaWNhdG9yVGltZVR5cGVUaW1lElgKDHRpbWVfdHlwZV9pZBgBIAEoDjI2LnJhem'
    '1hbmFnZXIucHJvdG9idWYucHVibGljLnYxLkhlYXRJbmRpY2F0b3JUaW1lVHlwZUlkUgp0aW1l'
    'VHlwZUlkEjAKBHRpbWUYAiABKAsyHC5nb29nbGUucHJvdG9idWYuRG91YmxlVmFsdWVSBHRpbW'
    'USbgoUZmFzdGVzdF90aW1lX3R5cGVfaWQYAyABKA4yPS5yYXptYW5hZ2VyLnByb3RvYnVmLnB1'
    'YmxpYy52MS5IZWF0SW5kaWNhdG9yRmFzdGVzdFRpbWVUeXBlSWRSEWZhc3Rlc3RUaW1lVHlwZU'
    'lkEj8KDGZhc3Rlc3RfdGltZRgEIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5Eb3VibGVWYWx1ZVIL'
    'ZmFzdGVzdFRpbWU=');

@$core.Deprecated('Use heatAnalysesDescriptor instead')
const HeatAnalyses$json = {
  '1': 'HeatAnalyses',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.HeatAnalysis',
      '10': 'items'
    },
  ],
};

/// Descriptor for `HeatAnalyses`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heatAnalysesDescriptor = $convert.base64Decode(
    'CgxIZWF0QW5hbHlzZXMSQQoFaXRlbXMYASADKAsyKy5yYXptYW5hZ2VyLnByb3RvYnVmLnB1Ym'
    'xpYy52MS5IZWF0QW5hbHlzaXNSBWl0ZW1z');

@$core.Deprecated('Use heatAnalysisDescriptor instead')
const HeatAnalysis$json = {
  '1': 'HeatAnalysis',
  '2': [
    {
      '1': 'timer_elapsed',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'timerElapsed'
    },
    {
      '1': 'indicator_id',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'indicatorId'
    },
    {
      '1': 'heat_state_type_id',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.HeatStateTypeId',
      '9': 0,
      '10': 'heatStateTypeId'
    },
    {
      '1': 'lap',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.HeatAnalysisLap',
      '9': 0,
      '10': 'lap'
    },
    {
      '1': 'gap',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.HeatAnalysisGap',
      '9': 0,
      '10': 'gap'
    },
  ],
  '8': [
    {'1': 'value'},
  ],
};

/// Descriptor for `HeatAnalysis`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heatAnalysisDescriptor = $convert.base64Decode(
    'CgxIZWF0QW5hbHlzaXMSPgoNdGltZXJfZWxhcHNlZBgBIAEoCzIZLmdvb2dsZS5wcm90b2J1Zi'
    '5EdXJhdGlvblIMdGltZXJFbGFwc2VkEj8KDGluZGljYXRvcl9pZBgCIAEoCzIcLmdvb2dsZS5w'
    'cm90b2J1Zi5VSW50MzJWYWx1ZVILaW5kaWNhdG9ySWQSXQoSaGVhdF9zdGF0ZV90eXBlX2lkGA'
    'MgASgOMi4ucmF6bWFuYWdlci5wcm90b2J1Zi5wdWJsaWMudjEuSGVhdFN0YXRlVHlwZUlkSABS'
    'D2hlYXRTdGF0ZVR5cGVJZBJCCgNsYXAYBCABKAsyLi5yYXptYW5hZ2VyLnByb3RvYnVmLnB1Ym'
    'xpYy52MS5IZWF0QW5hbHlzaXNMYXBIAFIDbGFwEkIKA2dhcBgFIAEoCzIuLnJhem1hbmFnZXIu'
    'cHJvdG9idWYucHVibGljLnYxLkhlYXRBbmFseXNpc0dhcEgAUgNnYXBCBwoFdmFsdWU=');

@$core.Deprecated('Use heatAnalysisLapDescriptor instead')
const HeatAnalysisLap$json = {
  '1': 'HeatAnalysisLap',
  '2': [
    {'1': 'position', '3': 1, '4': 1, '5': 13, '10': 'position'},
    {'1': 'lap', '3': 2, '4': 1, '5': 13, '10': 'lap'},
    {
      '1': 'time',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.DoubleValue',
      '10': 'time'
    },
    {'1': 'pitlanes', '3': 4, '4': 1, '5': 13, '10': 'pitlanes'},
    {'1': 'car_off_tracks', '3': 5, '4': 1, '5': 13, '10': 'carOffTracks'},
  ],
};

/// Descriptor for `HeatAnalysisLap`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heatAnalysisLapDescriptor = $convert.base64Decode(
    'Cg9IZWF0QW5hbHlzaXNMYXASGgoIcG9zaXRpb24YASABKA1SCHBvc2l0aW9uEhAKA2xhcBgCIA'
    'EoDVIDbGFwEjAKBHRpbWUYAyABKAsyHC5nb29nbGUucHJvdG9idWYuRG91YmxlVmFsdWVSBHRp'
    'bWUSGgoIcGl0bGFuZXMYBCABKA1SCHBpdGxhbmVzEiQKDmNhcl9vZmZfdHJhY2tzGAUgASgNUg'
    'xjYXJPZmZUcmFja3M=');

@$core.Deprecated('Use heatAnalysisGapDescriptor instead')
const HeatAnalysisGap$json = {
  '1': 'HeatAnalysisGap',
  '2': [
    {'1': 'indicator_id', '3': 1, '4': 1, '5': 13, '10': 'indicatorId'},
    {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
    {'1': 'display_value', '3': 3, '4': 1, '5': 9, '10': 'displayValue'},
    {
      '1': 'delta_value',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.DoubleValue',
      '10': 'deltaValue'
    },
    {
      '1': 'delta_fraction',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.DoubleValue',
      '10': 'deltaFraction'
    },
    {
      '1': 'flags',
      '3': 6,
      '4': 3,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.HeatIndicatorFlag',
      '10': 'flags'
    },
  ],
};

/// Descriptor for `HeatAnalysisGap`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heatAnalysisGapDescriptor = $convert.base64Decode(
    'Cg9IZWF0QW5hbHlzaXNHYXASIQoMaW5kaWNhdG9yX2lkGAEgASgNUgtpbmRpY2F0b3JJZBIUCg'
    'V2YWx1ZRgCIAEoAVIFdmFsdWUSIwoNZGlzcGxheV92YWx1ZRgDIAEoCVIMZGlzcGxheVZhbHVl'
    'Ej0KC2RlbHRhX3ZhbHVlGAQgASgLMhwuZ29vZ2xlLnByb3RvYnVmLkRvdWJsZVZhbHVlUgpkZW'
    'x0YVZhbHVlEkMKDmRlbHRhX2ZyYWN0aW9uGAUgASgLMhwuZ29vZ2xlLnByb3RvYnVmLkRvdWJs'
    'ZVZhbHVlUg1kZWx0YUZyYWN0aW9uEkYKBWZsYWdzGAYgAygOMjAucmF6bWFuYWdlci5wcm90b2'
    'J1Zi5wdWJsaWMudjEuSGVhdEluZGljYXRvckZsYWdSBWZsYWdz');

@$core.Deprecated('Use heatStintAnalysisDescriptor instead')
const HeatStintAnalysis$json = {
  '1': 'HeatStintAnalysis',
  '2': [
    {'1': 'refresh', '3': 1, '4': 1, '5': 8, '10': 'refresh'},
    {
      '1': 'heat_stint_analysis_indicator_stints',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.HeatStintAnalysisIndicatorStints',
      '10': 'heatStintAnalysisIndicatorStints'
    },
  ],
};

/// Descriptor for `HeatStintAnalysis`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heatStintAnalysisDescriptor = $convert.base64Decode(
    'ChFIZWF0U3RpbnRBbmFseXNpcxIYCgdyZWZyZXNoGAEgASgIUgdyZWZyZXNoEo8BCiRoZWF0X3'
    'N0aW50X2FuYWx5c2lzX2luZGljYXRvcl9zdGludHMYAiABKAsyPy5yYXptYW5hZ2VyLnByb3Rv'
    'YnVmLnB1YmxpYy52MS5IZWF0U3RpbnRBbmFseXNpc0luZGljYXRvclN0aW50c1IgaGVhdFN0aW'
    '50QW5hbHlzaXNJbmRpY2F0b3JTdGludHM=');

@$core.Deprecated('Use heatStintAnalysisIndicatorStintsDescriptor instead')
const HeatStintAnalysisIndicatorStints$json = {
  '1': 'HeatStintAnalysisIndicatorStints',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.HeatStintAnalysisIndicatorStint',
      '10': 'items'
    },
  ],
};

/// Descriptor for `HeatStintAnalysisIndicatorStints`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heatStintAnalysisIndicatorStintsDescriptor =
    $convert.base64Decode(
        'CiBIZWF0U3RpbnRBbmFseXNpc0luZGljYXRvclN0aW50cxJUCgVpdGVtcxgBIAMoCzI+LnJhem'
        '1hbmFnZXIucHJvdG9idWYucHVibGljLnYxLkhlYXRTdGludEFuYWx5c2lzSW5kaWNhdG9yU3Rp'
        'bnRSBWl0ZW1z');

@$core.Deprecated('Use heatStintAnalysisIndicatorStintDescriptor instead')
const HeatStintAnalysisIndicatorStint$json = {
  '1': 'HeatStintAnalysisIndicatorStint',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'indicator_id', '3': 2, '4': 1, '5': 13, '10': 'indicatorId'},
    {'1': 'lap', '3': 3, '4': 1, '5': 13, '10': 'lap'},
    {
      '1': 'event_user_id',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'eventUserId'
    },
    {
      '1': 'comments',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'comments'
    },
    {
      '1': 'laps',
      '3': 10,
      '4': 3,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.HeatStintAnalysisIndicatorStintLap',
      '10': 'laps'
    },
    {
      '1': 'duration',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'duration'
    },
    {
      '1': 'average_time',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.DoubleValue',
      '10': 'averageTime'
    },
  ],
};

/// Descriptor for `HeatStintAnalysisIndicatorStint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heatStintAnalysisIndicatorStintDescriptor = $convert.base64Decode(
    'Ch9IZWF0U3RpbnRBbmFseXNpc0luZGljYXRvclN0aW50Eg4KAmlkGAEgASgJUgJpZBIhCgxpbm'
    'RpY2F0b3JfaWQYAiABKA1SC2luZGljYXRvcklkEhAKA2xhcBgDIAEoDVIDbGFwEkAKDWV2ZW50'
    'X3VzZXJfaWQYBCABKAsyHC5nb29nbGUucHJvdG9idWYuU3RyaW5nVmFsdWVSC2V2ZW50VXNlck'
    'lkEjgKCGNvbW1lbnRzGAUgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUghjb21t'
    'ZW50cxJVCgRsYXBzGAogAygLMkEucmF6bWFuYWdlci5wcm90b2J1Zi5wdWJsaWMudjEuSGVhdF'
    'N0aW50QW5hbHlzaXNJbmRpY2F0b3JTdGludExhcFIEbGFwcxI1CghkdXJhdGlvbhgLIAEoCzIZ'
    'Lmdvb2dsZS5wcm90b2J1Zi5EdXJhdGlvblIIZHVyYXRpb24SPwoMYXZlcmFnZV90aW1lGAwgAS'
    'gLMhwuZ29vZ2xlLnByb3RvYnVmLkRvdWJsZVZhbHVlUgthdmVyYWdlVGltZQ==');

@$core.Deprecated('Use heatStintAnalysisIndicatorStintLapDescriptor instead')
const HeatStintAnalysisIndicatorStintLap$json = {
  '1': 'HeatStintAnalysisIndicatorStintLap',
  '2': [
    {'1': 'indicator_id', '3': 1, '4': 1, '5': 13, '10': 'indicatorId'},
    {'1': 'lap', '3': 2, '4': 1, '5': 13, '10': 'lap'},
    {
      '1': 'timer_elapsed',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'timerElapsed'
    },
    {
      '1': 'time',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.DoubleValue',
      '10': 'time'
    },
    {'1': 'pitlanes', '3': 5, '4': 1, '5': 13, '10': 'pitlanes'},
    {'1': 'car_off_tracks', '3': 6, '4': 1, '5': 13, '10': 'carOffTracks'},
  ],
};

/// Descriptor for `HeatStintAnalysisIndicatorStintLap`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heatStintAnalysisIndicatorStintLapDescriptor =
    $convert.base64Decode(
        'CiJIZWF0U3RpbnRBbmFseXNpc0luZGljYXRvclN0aW50TGFwEiEKDGluZGljYXRvcl9pZBgBIA'
        'EoDVILaW5kaWNhdG9ySWQSEAoDbGFwGAIgASgNUgNsYXASPgoNdGltZXJfZWxhcHNlZBgDIAEo'
        'CzIZLmdvb2dsZS5wcm90b2J1Zi5EdXJhdGlvblIMdGltZXJFbGFwc2VkEjAKBHRpbWUYBCABKA'
        'syHC5nb29nbGUucHJvdG9idWYuRG91YmxlVmFsdWVSBHRpbWUSGgoIcGl0bGFuZXMYBSABKA1S'
        'CHBpdGxhbmVzEiQKDmNhcl9vZmZfdHJhY2tzGAYgASgNUgxjYXJPZmZUcmFja3M=');
