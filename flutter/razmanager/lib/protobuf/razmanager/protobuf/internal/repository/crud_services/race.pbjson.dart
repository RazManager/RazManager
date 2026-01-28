// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/race.proto.

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

@$core.Deprecated('Use raceReadResponseDescriptor instead')
const RaceReadResponse$json = {
  '1': 'RaceReadResponse',
  '2': [
    {
      '1': 'entity',
      '3': 1,
      '4': 1,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.race.RaceRead',
      '10': 'entity'
    },
    {'1': 'etag', '3': 2, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `RaceReadResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List raceReadResponseDescriptor = $convert.base64Decode(
    'ChBSYWNlUmVhZFJlc3BvbnNlElwKBmVudGl0eRgBIAEoCzJELnJhem1hbmFnZXIucHJvdG9idW'
    'YuaW50ZXJuYWwucmVwb3NpdG9yeS5jcnVkX3NlcnZpY2VzLnJhY2UuUmFjZVJlYWRSBmVudGl0'
    'eRISCgRldGFnGAIgASgJUgRldGFn');

@$core.Deprecated('Use raceReadDescriptor instead')
const RaceRead$json = {
  '1': 'RaceRead',
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
      '1': 'event_id',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'eventId'
    },
    {
      '1': 'event',
      '3': 3,
      '4': 1,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.event.EventSelect',
      '10': 'event'
    },
    {
      '1': 'number',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'number'
    },
    {
      '1': 'name',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'name'
    },
    {
      '1': 'track_configuration_id',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'trackConfigurationId'
    },
    {
      '1': 'track_configuration',
      '3': 7,
      '4': 1,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.track_configuration.TrackConfigurationSelect',
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
      '1': 'points_scheme',
      '3': 9,
      '4': 1,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.points_scheme.PointsSchemeSelect',
      '10': 'pointsScheme'
    },
    {'1': 'practice_session', '3': 10, '4': 1, '5': 8, '10': 'practiceSession'},
    {
      '1': 'qualifying_session',
      '3': 11,
      '4': 1,
      '5': 8,
      '10': 'qualifyingSession'
    },
    {'1': 'race_session', '3': 12, '4': 1, '5': 8, '10': 'raceSession'},
    {
      '1': 'race_format_type_id',
      '3': 13,
      '4': 1,
      '5': 14,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.race_format_type.RaceFormatTypeId',
      '10': 'raceFormatTypeId'
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
    {'1': 'car_tag_ids', '3': 17, '4': 3, '5': 9, '10': 'carTagIds'},
    {
      '1': 'heat_car_type_id',
      '3': 18,
      '4': 1,
      '5': 14,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.heat_car_type.HeatCarTypeId',
      '10': 'heatCarTypeId'
    },
    {
      '1': 'race_indicators',
      '3': 19,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.race.RaceIndicatorReadCreateUpdate',
      '10': 'raceIndicators'
    },
    {
      '1': 'race_event_users',
      '3': 20,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.race.RaceEventUserReadCreateUpdate',
      '10': 'raceEventUsers'
    },
    {
      '1': 'race_indicator_event_users',
      '3': 21,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.race.RaceIndicatorEventUserReadCreateUpdate',
      '10': 'raceIndicatorEventUsers'
    },
    {
      '1': 'energy_simulation',
      '3': 22,
      '4': 1,
      '5': 8,
      '10': 'energySimulation'
    },
  ],
};

/// Descriptor for `RaceRead`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List raceReadDescriptor = $convert.base64Decode(
    'CghSYWNlUmVhZBIsCgJpZBgBIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZVICaW'
    'QSNwoIZXZlbnRfaWQYAiABKAsyHC5nb29nbGUucHJvdG9idWYuU3RyaW5nVmFsdWVSB2V2ZW50'
    'SWQSXgoFZXZlbnQYAyABKAsySC5yYXptYW5hZ2VyLnByb3RvYnVmLmludGVybmFsLnJlcG9zaX'
    'RvcnkuY3J1ZF9zZXJ2aWNlcy5ldmVudC5FdmVudFNlbGVjdFIFZXZlbnQSNAoGbnVtYmVyGAQg'
    'ASgLMhwuZ29vZ2xlLnByb3RvYnVmLlVJbnQzMlZhbHVlUgZudW1iZXISMAoEbmFtZRgFIAEoCz'
    'IcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZVIEbmFtZRJSChZ0cmFja19jb25maWd1cmF0'
    'aW9uX2lkGAYgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUhR0cmFja0NvbmZpZ3'
    'VyYXRpb25JZBKUAQoTdHJhY2tfY29uZmlndXJhdGlvbhgHIAEoCzJjLnJhem1hbmFnZXIucHJv'
    'dG9idWYuaW50ZXJuYWwucmVwb3NpdG9yeS5jcnVkX3NlcnZpY2VzLnRyYWNrX2NvbmZpZ3VyYX'
    'Rpb24uVHJhY2tDb25maWd1cmF0aW9uU2VsZWN0UhJ0cmFja0NvbmZpZ3VyYXRpb24SRgoQcG9p'
    'bnRzX3NjaGVtZV9pZBgIIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZVIOcG9pbn'
    'RzU2NoZW1lSWQSfAoNcG9pbnRzX3NjaGVtZRgJIAEoCzJXLnJhem1hbmFnZXIucHJvdG9idWYu'
    'aW50ZXJuYWwucmVwb3NpdG9yeS5jcnVkX3NlcnZpY2VzLnBvaW50c19zY2hlbWUuUG9pbnRzU2'
    'NoZW1lU2VsZWN0Ugxwb2ludHNTY2hlbWUSKQoQcHJhY3RpY2Vfc2Vzc2lvbhgKIAEoCFIPcHJh'
    'Y3RpY2VTZXNzaW9uEi0KEnF1YWxpZnlpbmdfc2Vzc2lvbhgLIAEoCFIRcXVhbGlmeWluZ1Nlc3'
    'Npb24SIQoMcmFjZV9zZXNzaW9uGAwgASgIUgtyYWNlU2Vzc2lvbhKHAQoTcmFjZV9mb3JtYXRf'
    'dHlwZV9pZBgNIAEoDjJYLnJhem1hbmFnZXIucHJvdG9idWYuaW50ZXJuYWwucmVwb3NpdG9yeS'
    '5jcnVkX3NlcnZpY2VzLnJhY2VfZm9ybWF0X3R5cGUuUmFjZUZvcm1hdFR5cGVJZFIQcmFjZUZv'
    'cm1hdFR5cGVJZBJeChVyYWNlX2hlYXRfZW5kX3R5cGVfaWQYDiABKA4yLC5yYXptYW5hZ2VyLn'
    'Byb3RvYnVmLnB1YmxpYy52MS5IZWF0RW5kVHlwZUlkUhFyYWNlSGVhdEVuZFR5cGVJZBJQChZy'
    'YWNlX2hlYXRfZW5kX2xhcF9sYXBzGA8gASgLMhwuZ29vZ2xlLnByb3RvYnVmLlVJbnQzMlZhbH'
    'VlUhJyYWNlSGVhdEVuZExhcExhcHMSXwofcmFjZV9oZWF0X2VuZF9kdXJhdGlvbl9kdXJhdGlv'
    'bhgQIAEoCzIZLmdvb2dsZS5wcm90b2J1Zi5EdXJhdGlvblIbcmFjZUhlYXRFbmREdXJhdGlvbk'
    'R1cmF0aW9uEh4KC2Nhcl90YWdfaWRzGBEgAygJUgljYXJUYWdJZHMSewoQaGVhdF9jYXJfdHlw'
    'ZV9pZBgSIAEoDjJSLnJhem1hbmFnZXIucHJvdG9idWYuaW50ZXJuYWwucmVwb3NpdG9yeS5jcn'
    'VkX3NlcnZpY2VzLmhlYXRfY2FyX3R5cGUuSGVhdENhclR5cGVJZFINaGVhdENhclR5cGVJZBKC'
    'AQoPcmFjZV9pbmRpY2F0b3JzGBMgAygLMlkucmF6bWFuYWdlci5wcm90b2J1Zi5pbnRlcm5hbC'
    '5yZXBvc2l0b3J5LmNydWRfc2VydmljZXMucmFjZS5SYWNlSW5kaWNhdG9yUmVhZENyZWF0ZVVw'
    'ZGF0ZVIOcmFjZUluZGljYXRvcnMSgwEKEHJhY2VfZXZlbnRfdXNlcnMYFCADKAsyWS5yYXptYW'
    '5hZ2VyLnByb3RvYnVmLmludGVybmFsLnJlcG9zaXRvcnkuY3J1ZF9zZXJ2aWNlcy5yYWNlLlJh'
    'Y2VFdmVudFVzZXJSZWFkQ3JlYXRlVXBkYXRlUg5yYWNlRXZlbnRVc2VycxKfAQoacmFjZV9pbm'
    'RpY2F0b3JfZXZlbnRfdXNlcnMYFSADKAsyYi5yYXptYW5hZ2VyLnByb3RvYnVmLmludGVybmFs'
    'LnJlcG9zaXRvcnkuY3J1ZF9zZXJ2aWNlcy5yYWNlLlJhY2VJbmRpY2F0b3JFdmVudFVzZXJSZW'
    'FkQ3JlYXRlVXBkYXRlUhdyYWNlSW5kaWNhdG9yRXZlbnRVc2VycxIrChFlbmVyZ3lfc2ltdWxh'
    'dGlvbhgWIAEoCFIQZW5lcmd5U2ltdWxhdGlvbg==');

@$core.Deprecated('Use raceCreateDescriptor instead')
const RaceCreate$json = {
  '1': 'RaceCreate',
  '2': [
    {'1': 'event_id', '3': 2, '4': 1, '5': 9, '10': 'eventId'},
    {
      '1': 'name',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'name'
    },
    {
      '1': 'track_configuration_id',
      '3': 6,
      '4': 1,
      '5': 9,
      '10': 'trackConfigurationId'
    },
    {
      '1': 'points_scheme_id',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'pointsSchemeId'
    },
    {'1': 'practice_session', '3': 10, '4': 1, '5': 8, '10': 'practiceSession'},
    {
      '1': 'qualifying_session',
      '3': 11,
      '4': 1,
      '5': 8,
      '10': 'qualifyingSession'
    },
    {'1': 'race_session', '3': 12, '4': 1, '5': 8, '10': 'raceSession'},
    {
      '1': 'race_format_type_id',
      '3': 13,
      '4': 1,
      '5': 14,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.race_format_type.RaceFormatTypeId',
      '10': 'raceFormatTypeId'
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
    {'1': 'car_tag_ids', '3': 17, '4': 3, '5': 9, '10': 'carTagIds'},
    {
      '1': 'heat_car_type_id',
      '3': 18,
      '4': 1,
      '5': 14,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.heat_car_type.HeatCarTypeId',
      '10': 'heatCarTypeId'
    },
    {
      '1': 'race_indicators',
      '3': 19,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.race.RaceIndicatorReadCreateUpdate',
      '10': 'raceIndicators'
    },
    {
      '1': 'race_event_users',
      '3': 20,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.race.RaceEventUserReadCreateUpdate',
      '10': 'raceEventUsers'
    },
    {
      '1': 'race_indicator_event_users',
      '3': 21,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.race.RaceIndicatorEventUserReadCreateUpdate',
      '10': 'raceIndicatorEventUsers'
    },
    {
      '1': 'energy_simulation',
      '3': 22,
      '4': 1,
      '5': 8,
      '10': 'energySimulation'
    },
  ],
};

/// Descriptor for `RaceCreate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List raceCreateDescriptor = $convert.base64Decode(
    'CgpSYWNlQ3JlYXRlEhkKCGV2ZW50X2lkGAIgASgJUgdldmVudElkEjAKBG5hbWUYBSABKAsyHC'
    '5nb29nbGUucHJvdG9idWYuU3RyaW5nVmFsdWVSBG5hbWUSNAoWdHJhY2tfY29uZmlndXJhdGlv'
    'bl9pZBgGIAEoCVIUdHJhY2tDb25maWd1cmF0aW9uSWQSRgoQcG9pbnRzX3NjaGVtZV9pZBgIIA'
    'EoCzIcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZVIOcG9pbnRzU2NoZW1lSWQSKQoQcHJh'
    'Y3RpY2Vfc2Vzc2lvbhgKIAEoCFIPcHJhY3RpY2VTZXNzaW9uEi0KEnF1YWxpZnlpbmdfc2Vzc2'
    'lvbhgLIAEoCFIRcXVhbGlmeWluZ1Nlc3Npb24SIQoMcmFjZV9zZXNzaW9uGAwgASgIUgtyYWNl'
    'U2Vzc2lvbhKHAQoTcmFjZV9mb3JtYXRfdHlwZV9pZBgNIAEoDjJYLnJhem1hbmFnZXIucHJvdG'
    '9idWYuaW50ZXJuYWwucmVwb3NpdG9yeS5jcnVkX3NlcnZpY2VzLnJhY2VfZm9ybWF0X3R5cGUu'
    'UmFjZUZvcm1hdFR5cGVJZFIQcmFjZUZvcm1hdFR5cGVJZBJeChVyYWNlX2hlYXRfZW5kX3R5cG'
    'VfaWQYDiABKA4yLC5yYXptYW5hZ2VyLnByb3RvYnVmLnB1YmxpYy52MS5IZWF0RW5kVHlwZUlk'
    'UhFyYWNlSGVhdEVuZFR5cGVJZBJQChZyYWNlX2hlYXRfZW5kX2xhcF9sYXBzGA8gASgLMhwuZ2'
    '9vZ2xlLnByb3RvYnVmLlVJbnQzMlZhbHVlUhJyYWNlSGVhdEVuZExhcExhcHMSXwofcmFjZV9o'
    'ZWF0X2VuZF9kdXJhdGlvbl9kdXJhdGlvbhgQIAEoCzIZLmdvb2dsZS5wcm90b2J1Zi5EdXJhdG'
    'lvblIbcmFjZUhlYXRFbmREdXJhdGlvbkR1cmF0aW9uEh4KC2Nhcl90YWdfaWRzGBEgAygJUglj'
    'YXJUYWdJZHMSewoQaGVhdF9jYXJfdHlwZV9pZBgSIAEoDjJSLnJhem1hbmFnZXIucHJvdG9idW'
    'YuaW50ZXJuYWwucmVwb3NpdG9yeS5jcnVkX3NlcnZpY2VzLmhlYXRfY2FyX3R5cGUuSGVhdENh'
    'clR5cGVJZFINaGVhdENhclR5cGVJZBKCAQoPcmFjZV9pbmRpY2F0b3JzGBMgAygLMlkucmF6bW'
    'FuYWdlci5wcm90b2J1Zi5pbnRlcm5hbC5yZXBvc2l0b3J5LmNydWRfc2VydmljZXMucmFjZS5S'
    'YWNlSW5kaWNhdG9yUmVhZENyZWF0ZVVwZGF0ZVIOcmFjZUluZGljYXRvcnMSgwEKEHJhY2VfZX'
    'ZlbnRfdXNlcnMYFCADKAsyWS5yYXptYW5hZ2VyLnByb3RvYnVmLmludGVybmFsLnJlcG9zaXRv'
    'cnkuY3J1ZF9zZXJ2aWNlcy5yYWNlLlJhY2VFdmVudFVzZXJSZWFkQ3JlYXRlVXBkYXRlUg5yYW'
    'NlRXZlbnRVc2VycxKfAQoacmFjZV9pbmRpY2F0b3JfZXZlbnRfdXNlcnMYFSADKAsyYi5yYXpt'
    'YW5hZ2VyLnByb3RvYnVmLmludGVybmFsLnJlcG9zaXRvcnkuY3J1ZF9zZXJ2aWNlcy5yYWNlLl'
    'JhY2VJbmRpY2F0b3JFdmVudFVzZXJSZWFkQ3JlYXRlVXBkYXRlUhdyYWNlSW5kaWNhdG9yRXZl'
    'bnRVc2VycxIrChFlbmVyZ3lfc2ltdWxhdGlvbhgWIAEoCFIQZW5lcmd5U2ltdWxhdGlvbg==');

@$core.Deprecated('Use raceUpdateRequestDescriptor instead')
const RaceUpdateRequest$json = {
  '1': 'RaceUpdateRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'entity',
      '3': 2,
      '4': 1,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.race.RaceUpdate',
      '10': 'entity'
    },
    {'1': 'etag', '3': 3, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `RaceUpdateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List raceUpdateRequestDescriptor = $convert.base64Decode(
    'ChFSYWNlVXBkYXRlUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSXgoGZW50aXR5GAIgASgLMkYucm'
    'F6bWFuYWdlci5wcm90b2J1Zi5pbnRlcm5hbC5yZXBvc2l0b3J5LmNydWRfc2VydmljZXMucmFj'
    'ZS5SYWNlVXBkYXRlUgZlbnRpdHkSEgoEZXRhZxgDIAEoCVIEZXRhZw==');

@$core.Deprecated('Use raceUpdateDescriptor instead')
const RaceUpdate$json = {
  '1': 'RaceUpdate',
  '2': [
    {
      '1': 'name',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'name'
    },
    {
      '1': 'points_scheme_id',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'pointsSchemeId'
    },
    {'1': 'practice_session', '3': 10, '4': 1, '5': 8, '10': 'practiceSession'},
    {
      '1': 'qualifying_session',
      '3': 11,
      '4': 1,
      '5': 8,
      '10': 'qualifyingSession'
    },
    {'1': 'race_session', '3': 12, '4': 1, '5': 8, '10': 'raceSession'},
    {
      '1': 'race_format_type_id',
      '3': 13,
      '4': 1,
      '5': 14,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.race_format_type.RaceFormatTypeId',
      '10': 'raceFormatTypeId'
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
    {'1': 'car_tag_ids', '3': 17, '4': 3, '5': 9, '10': 'carTagIds'},
    {
      '1': 'heat_car_type_id',
      '3': 18,
      '4': 1,
      '5': 14,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.heat_car_type.HeatCarTypeId',
      '10': 'heatCarTypeId'
    },
    {
      '1': 'race_indicators',
      '3': 19,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.race.RaceIndicatorReadCreateUpdate',
      '10': 'raceIndicators'
    },
    {
      '1': 'race_event_users',
      '3': 20,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.race.RaceEventUserReadCreateUpdate',
      '10': 'raceEventUsers'
    },
    {
      '1': 'race_indicator_event_users',
      '3': 21,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.race.RaceIndicatorEventUserReadCreateUpdate',
      '10': 'raceIndicatorEventUsers'
    },
    {
      '1': 'energy_simulation',
      '3': 22,
      '4': 1,
      '5': 8,
      '10': 'energySimulation'
    },
  ],
};

/// Descriptor for `RaceUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List raceUpdateDescriptor = $convert.base64Decode(
    'CgpSYWNlVXBkYXRlEjAKBG5hbWUYBSABKAsyHC5nb29nbGUucHJvdG9idWYuU3RyaW5nVmFsdW'
    'VSBG5hbWUSRgoQcG9pbnRzX3NjaGVtZV9pZBgIIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5TdHJp'
    'bmdWYWx1ZVIOcG9pbnRzU2NoZW1lSWQSKQoQcHJhY3RpY2Vfc2Vzc2lvbhgKIAEoCFIPcHJhY3'
    'RpY2VTZXNzaW9uEi0KEnF1YWxpZnlpbmdfc2Vzc2lvbhgLIAEoCFIRcXVhbGlmeWluZ1Nlc3Np'
    'b24SIQoMcmFjZV9zZXNzaW9uGAwgASgIUgtyYWNlU2Vzc2lvbhKHAQoTcmFjZV9mb3JtYXRfdH'
    'lwZV9pZBgNIAEoDjJYLnJhem1hbmFnZXIucHJvdG9idWYuaW50ZXJuYWwucmVwb3NpdG9yeS5j'
    'cnVkX3NlcnZpY2VzLnJhY2VfZm9ybWF0X3R5cGUuUmFjZUZvcm1hdFR5cGVJZFIQcmFjZUZvcm'
    '1hdFR5cGVJZBJeChVyYWNlX2hlYXRfZW5kX3R5cGVfaWQYDiABKA4yLC5yYXptYW5hZ2VyLnBy'
    'b3RvYnVmLnB1YmxpYy52MS5IZWF0RW5kVHlwZUlkUhFyYWNlSGVhdEVuZFR5cGVJZBJQChZyYW'
    'NlX2hlYXRfZW5kX2xhcF9sYXBzGA8gASgLMhwuZ29vZ2xlLnByb3RvYnVmLlVJbnQzMlZhbHVl'
    'UhJyYWNlSGVhdEVuZExhcExhcHMSXwofcmFjZV9oZWF0X2VuZF9kdXJhdGlvbl9kdXJhdGlvbh'
    'gQIAEoCzIZLmdvb2dsZS5wcm90b2J1Zi5EdXJhdGlvblIbcmFjZUhlYXRFbmREdXJhdGlvbkR1'
    'cmF0aW9uEh4KC2Nhcl90YWdfaWRzGBEgAygJUgljYXJUYWdJZHMSewoQaGVhdF9jYXJfdHlwZV'
    '9pZBgSIAEoDjJSLnJhem1hbmFnZXIucHJvdG9idWYuaW50ZXJuYWwucmVwb3NpdG9yeS5jcnVk'
    'X3NlcnZpY2VzLmhlYXRfY2FyX3R5cGUuSGVhdENhclR5cGVJZFINaGVhdENhclR5cGVJZBKCAQ'
    'oPcmFjZV9pbmRpY2F0b3JzGBMgAygLMlkucmF6bWFuYWdlci5wcm90b2J1Zi5pbnRlcm5hbC5y'
    'ZXBvc2l0b3J5LmNydWRfc2VydmljZXMucmFjZS5SYWNlSW5kaWNhdG9yUmVhZENyZWF0ZVVwZG'
    'F0ZVIOcmFjZUluZGljYXRvcnMSgwEKEHJhY2VfZXZlbnRfdXNlcnMYFCADKAsyWS5yYXptYW5h'
    'Z2VyLnByb3RvYnVmLmludGVybmFsLnJlcG9zaXRvcnkuY3J1ZF9zZXJ2aWNlcy5yYWNlLlJhY2'
    'VFdmVudFVzZXJSZWFkQ3JlYXRlVXBkYXRlUg5yYWNlRXZlbnRVc2VycxKfAQoacmFjZV9pbmRp'
    'Y2F0b3JfZXZlbnRfdXNlcnMYFSADKAsyYi5yYXptYW5hZ2VyLnByb3RvYnVmLmludGVybmFsLn'
    'JlcG9zaXRvcnkuY3J1ZF9zZXJ2aWNlcy5yYWNlLlJhY2VJbmRpY2F0b3JFdmVudFVzZXJSZWFk'
    'Q3JlYXRlVXBkYXRlUhdyYWNlSW5kaWNhdG9yRXZlbnRVc2VycxIrChFlbmVyZ3lfc2ltdWxhdG'
    'lvbhgWIAEoCFIQZW5lcmd5U2ltdWxhdGlvbg==');

@$core.Deprecated('Use raceIndicatorReadCreateUpdateDescriptor instead')
const RaceIndicatorReadCreateUpdate$json = {
  '1': 'RaceIndicatorReadCreateUpdate',
  '2': [
    {'1': 'indicator_id', '3': 1, '4': 1, '5': 13, '10': 'indicatorId'},
    {
      '1': 'car_id',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'carId'
    },
  ],
};

/// Descriptor for `RaceIndicatorReadCreateUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List raceIndicatorReadCreateUpdateDescriptor =
    $convert.base64Decode(
        'Ch1SYWNlSW5kaWNhdG9yUmVhZENyZWF0ZVVwZGF0ZRIhCgxpbmRpY2F0b3JfaWQYASABKA1SC2'
        'luZGljYXRvcklkEjMKBmNhcl9pZBgCIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1'
        'ZVIFY2FySWQ=');

@$core.Deprecated('Use raceEventUserReadCreateUpdateDescriptor instead')
const RaceEventUserReadCreateUpdate$json = {
  '1': 'RaceEventUserReadCreateUpdate',
  '2': [
    {'1': 'event_user_id', '3': 1, '4': 1, '5': 9, '10': 'eventUserId'},
    {
      '1': 'car_id',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'carId'
    },
  ],
};

/// Descriptor for `RaceEventUserReadCreateUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List raceEventUserReadCreateUpdateDescriptor =
    $convert.base64Decode(
        'Ch1SYWNlRXZlbnRVc2VyUmVhZENyZWF0ZVVwZGF0ZRIiCg1ldmVudF91c2VyX2lkGAEgASgJUg'
        'tldmVudFVzZXJJZBIzCgZjYXJfaWQYAiABKAsyHC5nb29nbGUucHJvdG9idWYuU3RyaW5nVmFs'
        'dWVSBWNhcklk');

@$core
    .Deprecated('Use raceIndicatorEventUserReadCreateUpdateDescriptor instead')
const RaceIndicatorEventUserReadCreateUpdate$json = {
  '1': 'RaceIndicatorEventUserReadCreateUpdate',
  '2': [
    {'1': 'indicator_id', '3': 1, '4': 1, '5': 13, '10': 'indicatorId'},
    {'1': 'event_user_id', '3': 2, '4': 1, '5': 9, '10': 'eventUserId'},
    {
      '1': 'car_class_color',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.UInt32Value',
      '10': 'carClassColor'
    },
    {
      '1': 'car_id',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'carId'
    },
  ],
};

/// Descriptor for `RaceIndicatorEventUserReadCreateUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List raceIndicatorEventUserReadCreateUpdateDescriptor =
    $convert.base64Decode(
        'CiZSYWNlSW5kaWNhdG9yRXZlbnRVc2VyUmVhZENyZWF0ZVVwZGF0ZRIhCgxpbmRpY2F0b3JfaW'
        'QYASABKA1SC2luZGljYXRvcklkEiIKDWV2ZW50X3VzZXJfaWQYAiABKAlSC2V2ZW50VXNlcklk'
        'EkQKD2Nhcl9jbGFzc19jb2xvchgDIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5VSW50MzJWYWx1ZV'
        'INY2FyQ2xhc3NDb2xvchIzCgZjYXJfaWQYBCABKAsyHC5nb29nbGUucHJvdG9idWYuU3RyaW5n'
        'VmFsdWVSBWNhcklk');

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

@$core.Deprecated('Use raceListResponseDescriptor instead')
const RaceListResponse$json = {
  '1': 'RaceListResponse',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.race.RaceList',
      '10': 'result'
    },
  ],
};

/// Descriptor for `RaceListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List raceListResponseDescriptor = $convert.base64Decode(
    'ChBSYWNlTGlzdFJlc3BvbnNlElwKBnJlc3VsdBgBIAMoCzJELnJhem1hbmFnZXIucHJvdG9idW'
    'YuaW50ZXJuYWwucmVwb3NpdG9yeS5jcnVkX3NlcnZpY2VzLnJhY2UuUmFjZUxpc3RSBnJlc3Vs'
    'dA==');

@$core.Deprecated('Use raceListDescriptor instead')
const RaceList$json = {
  '1': 'RaceList',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'event',
      '3': 2,
      '4': 1,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.event.EventSelect',
      '10': 'event'
    },
    {'1': 'number', '3': 3, '4': 1, '5': 13, '10': 'number'},
    {
      '1': 'name',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'name'
    },
    {
      '1': 'track_configuration',
      '3': 5,
      '4': 1,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.track_configuration.TrackConfigurationList',
      '10': 'trackConfiguration'
    },
    {
      '1': 'race_state_type',
      '3': 6,
      '4': 1,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.race.RaceStateType',
      '10': 'raceStateType'
    },
    {'1': 'etag', '3': 7, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `RaceList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List raceListDescriptor = $convert.base64Decode(
    'CghSYWNlTGlzdBIOCgJpZBgBIAEoCVICaWQSXgoFZXZlbnQYAiABKAsySC5yYXptYW5hZ2VyLn'
    'Byb3RvYnVmLmludGVybmFsLnJlcG9zaXRvcnkuY3J1ZF9zZXJ2aWNlcy5ldmVudC5FdmVudFNl'
    'bGVjdFIFZXZlbnQSFgoGbnVtYmVyGAMgASgNUgZudW1iZXISMAoEbmFtZRgEIAEoCzIcLmdvb2'
    'dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZVIEbmFtZRKSAQoTdHJhY2tfY29uZmlndXJhdGlvbhgF'
    'IAEoCzJhLnJhem1hbmFnZXIucHJvdG9idWYuaW50ZXJuYWwucmVwb3NpdG9yeS5jcnVkX3Nlcn'
    'ZpY2VzLnRyYWNrX2NvbmZpZ3VyYXRpb24uVHJhY2tDb25maWd1cmF0aW9uTGlzdFISdHJhY2tD'
    'b25maWd1cmF0aW9uEnEKD3JhY2Vfc3RhdGVfdHlwZRgGIAEoCzJJLnJhem1hbmFnZXIucHJvdG'
    '9idWYuaW50ZXJuYWwucmVwb3NpdG9yeS5jcnVkX3NlcnZpY2VzLnJhY2UuUmFjZVN0YXRlVHlw'
    'ZVINcmFjZVN0YXRlVHlwZRISCgRldGFnGAcgASgJUgRldGFn');

@$core.Deprecated('Use raceSelectRequestDescriptor instead')
const RaceSelectRequest$json = {
  '1': 'RaceSelectRequest',
  '2': [
    {'1': 'event_id', '3': 1, '4': 1, '5': 9, '10': 'eventId'},
  ],
};

/// Descriptor for `RaceSelectRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List raceSelectRequestDescriptor = $convert.base64Decode(
    'ChFSYWNlU2VsZWN0UmVxdWVzdBIZCghldmVudF9pZBgBIAEoCVIHZXZlbnRJZA==');

@$core.Deprecated('Use raceSelectResponseDescriptor instead')
const RaceSelectResponse$json = {
  '1': 'RaceSelectResponse',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.race.RaceSelect',
      '10': 'result'
    },
  ],
};

/// Descriptor for `RaceSelectResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List raceSelectResponseDescriptor = $convert.base64Decode(
    'ChJSYWNlU2VsZWN0UmVzcG9uc2USXgoGcmVzdWx0GAEgAygLMkYucmF6bWFuYWdlci5wcm90b2'
    'J1Zi5pbnRlcm5hbC5yZXBvc2l0b3J5LmNydWRfc2VydmljZXMucmFjZS5SYWNlU2VsZWN0UgZy'
    'ZXN1bHQ=');

@$core.Deprecated('Use raceSelectDescriptor instead')
const RaceSelect$json = {
  '1': 'RaceSelect',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'number', '3': 2, '4': 1, '5': 9, '10': 'number'},
    {
      '1': 'name',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'name'
    },
  ],
};

/// Descriptor for `RaceSelect`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List raceSelectDescriptor = $convert.base64Decode(
    'CgpSYWNlU2VsZWN0Eg4KAmlkGAEgASgJUgJpZBIWCgZudW1iZXIYAiABKAlSBm51bWJlchIwCg'
    'RuYW1lGAMgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUgRuYW1l');
