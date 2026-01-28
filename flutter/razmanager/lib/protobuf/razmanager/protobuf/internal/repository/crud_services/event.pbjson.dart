// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/crud_services/event.proto.

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

@$core.Deprecated('Use eventVisibilityTypeIdDescriptor instead')
const EventVisibilityTypeId$json = {
  '1': 'EventVisibilityTypeId',
  '2': [
    {'1': 'EVENT_VISIBILITY_TYPE_ID_UNDEFINED', '2': 0},
    {'1': 'EVENT_VISIBILITY_TYPE_ID_PUBLIC', '2': 1},
    {'1': 'EVENT_VISIBILITY_TYPE_ID_MEMBERS_AND_GUESTS', '2': 2},
  ],
};

/// Descriptor for `EventVisibilityTypeId`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List eventVisibilityTypeIdDescriptor = $convert.base64Decode(
    'ChVFdmVudFZpc2liaWxpdHlUeXBlSWQSJgoiRVZFTlRfVklTSUJJTElUWV9UWVBFX0lEX1VORE'
    'VGSU5FRBAAEiMKH0VWRU5UX1ZJU0lCSUxJVFlfVFlQRV9JRF9QVUJMSUMQARIvCitFVkVOVF9W'
    'SVNJQklMSVRZX1RZUEVfSURfTUVNQkVSU19BTkRfR1VFU1RTEAI=');

@$core.Deprecated('Use eventReadResponseDescriptor instead')
const EventReadResponse$json = {
  '1': 'EventReadResponse',
  '2': [
    {
      '1': 'entity',
      '3': 1,
      '4': 1,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.event.EventRead',
      '10': 'entity'
    },
    {'1': 'etag', '3': 2, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `EventReadResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventReadResponseDescriptor = $convert.base64Decode(
    'ChFFdmVudFJlYWRSZXNwb25zZRJeCgZlbnRpdHkYASABKAsyRi5yYXptYW5hZ2VyLnByb3RvYn'
    'VmLmludGVybmFsLnJlcG9zaXRvcnkuY3J1ZF9zZXJ2aWNlcy5ldmVudC5FdmVudFJlYWRSBmVu'
    'dGl0eRISCgRldGFnGAIgASgJUgRldGFn');

@$core.Deprecated('Use eventReadDescriptor instead')
const EventRead$json = {
  '1': 'EventRead',
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
      '1': 'starts_at',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'startsAt'
    },
    {
      '1': 'publish_from',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'publishFrom'
    },
    {
      '1': 'publish_until',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'publishUntil'
    },
    {
      '1': 'event_visibility_type_id',
      '3': 7,
      '4': 1,
      '5': 14,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.event.EventVisibilityTypeId',
      '10': 'eventVisibilityTypeId'
    },
    {
      '1': 'image',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BytesValue',
      '10': 'image'
    },
    {
      '1': 'event_invites',
      '3': 10,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.event.EventInviteReadCreateUpdate',
      '10': 'eventInvites'
    },
    {
      '1': 'event_users',
      '3': 11,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.event.EventUserRead',
      '10': 'eventUsers'
    },
  ],
};

/// Descriptor for `EventRead`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventReadDescriptor = $convert.base64Decode(
    'CglFdmVudFJlYWQSLAoCaWQYASABKAsyHC5nb29nbGUucHJvdG9idWYuU3RyaW5nVmFsdWVSAm'
    'lkEjAKBG5hbWUYAiABKAsyHC5nb29nbGUucHJvdG9idWYuU3RyaW5nVmFsdWVSBG5hbWUSPgoL'
    'ZGVzY3JpcHRpb24YAyABKAsyHC5nb29nbGUucHJvdG9idWYuU3RyaW5nVmFsdWVSC2Rlc2NyaX'
    'B0aW9uEjcKCXN0YXJ0c19hdBgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCHN0'
    'YXJ0c0F0Ej0KDHB1Ymxpc2hfZnJvbRgFIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbX'
    'BSC3B1Ymxpc2hGcm9tEj8KDXB1Ymxpc2hfdW50aWwYBiABKAsyGi5nb29nbGUucHJvdG9idWYu'
    'VGltZXN0YW1wUgxwdWJsaXNoVW50aWwSiwEKGGV2ZW50X3Zpc2liaWxpdHlfdHlwZV9pZBgHIA'
    'EoDjJSLnJhem1hbmFnZXIucHJvdG9idWYuaW50ZXJuYWwucmVwb3NpdG9yeS5jcnVkX3NlcnZp'
    'Y2VzLmV2ZW50LkV2ZW50VmlzaWJpbGl0eVR5cGVJZFIVZXZlbnRWaXNpYmlsaXR5VHlwZUlkEj'
    'EKBWltYWdlGAggASgLMhsuZ29vZ2xlLnByb3RvYnVmLkJ5dGVzVmFsdWVSBWltYWdlEn0KDWV2'
    'ZW50X2ludml0ZXMYCiADKAsyWC5yYXptYW5hZ2VyLnByb3RvYnVmLmludGVybmFsLnJlcG9zaX'
    'RvcnkuY3J1ZF9zZXJ2aWNlcy5ldmVudC5FdmVudEludml0ZVJlYWRDcmVhdGVVcGRhdGVSDGV2'
    'ZW50SW52aXRlcxJrCgtldmVudF91c2VycxgLIAMoCzJKLnJhem1hbmFnZXIucHJvdG9idWYuaW'
    '50ZXJuYWwucmVwb3NpdG9yeS5jcnVkX3NlcnZpY2VzLmV2ZW50LkV2ZW50VXNlclJlYWRSCmV2'
    'ZW50VXNlcnM=');

@$core.Deprecated('Use eventCreateUpdateDescriptor instead')
const EventCreateUpdate$json = {
  '1': 'EventCreateUpdate',
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
    {
      '1': 'starts_at',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'startsAt'
    },
    {
      '1': 'publish_from',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'publishFrom'
    },
    {
      '1': 'publish_until',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'publishUntil'
    },
    {
      '1': 'event_visibility_type_id',
      '3': 7,
      '4': 1,
      '5': 14,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.event.EventVisibilityTypeId',
      '10': 'eventVisibilityTypeId'
    },
    {'1': 'image', '3': 8, '4': 1, '5': 12, '9': 0, '10': 'image', '17': true},
    {
      '1': 'image_deleted',
      '3': 9,
      '4': 1,
      '5': 8,
      '9': 1,
      '10': 'imageDeleted',
      '17': true
    },
    {
      '1': 'event_invites',
      '3': 10,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.event.EventInviteReadCreateUpdate',
      '10': 'eventInvites'
    },
    {
      '1': 'event_invites_deleted',
      '3': 11,
      '4': 3,
      '5': 9,
      '10': 'eventInvitesDeleted'
    },
    {
      '1': 'event_users',
      '3': 12,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.event.EventUserCreateUpdate',
      '10': 'eventUsers'
    },
    {
      '1': 'event_users_deleted',
      '3': 13,
      '4': 3,
      '5': 9,
      '10': 'eventUsersDeleted'
    },
  ],
  '8': [
    {'1': '_image'},
    {'1': '_image_deleted'},
  ],
};

/// Descriptor for `EventCreateUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventCreateUpdateDescriptor = $convert.base64Decode(
    'ChFFdmVudENyZWF0ZVVwZGF0ZRISCgRuYW1lGAIgASgJUgRuYW1lEj4KC2Rlc2NyaXB0aW9uGA'
    'MgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUgtkZXNjcmlwdGlvbhI3CglzdGFy'
    'dHNfYXQYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUghzdGFydHNBdBI9CgxwdW'
    'JsaXNoX2Zyb20YBSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtwdWJsaXNoRnJv'
    'bRI/Cg1wdWJsaXNoX3VudGlsGAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMcH'
    'VibGlzaFVudGlsEosBChhldmVudF92aXNpYmlsaXR5X3R5cGVfaWQYByABKA4yUi5yYXptYW5h'
    'Z2VyLnByb3RvYnVmLmludGVybmFsLnJlcG9zaXRvcnkuY3J1ZF9zZXJ2aWNlcy5ldmVudC5Fdm'
    'VudFZpc2liaWxpdHlUeXBlSWRSFWV2ZW50VmlzaWJpbGl0eVR5cGVJZBIZCgVpbWFnZRgIIAEo'
    'DEgAUgVpbWFnZYgBARIoCg1pbWFnZV9kZWxldGVkGAkgASgISAFSDGltYWdlRGVsZXRlZIgBAR'
    'J9Cg1ldmVudF9pbnZpdGVzGAogAygLMlgucmF6bWFuYWdlci5wcm90b2J1Zi5pbnRlcm5hbC5y'
    'ZXBvc2l0b3J5LmNydWRfc2VydmljZXMuZXZlbnQuRXZlbnRJbnZpdGVSZWFkQ3JlYXRlVXBkYX'
    'RlUgxldmVudEludml0ZXMSMgoVZXZlbnRfaW52aXRlc19kZWxldGVkGAsgAygJUhNldmVudElu'
    'dml0ZXNEZWxldGVkEnMKC2V2ZW50X3VzZXJzGAwgAygLMlIucmF6bWFuYWdlci5wcm90b2J1Zi'
    '5pbnRlcm5hbC5yZXBvc2l0b3J5LmNydWRfc2VydmljZXMuZXZlbnQuRXZlbnRVc2VyQ3JlYXRl'
    'VXBkYXRlUgpldmVudFVzZXJzEi4KE2V2ZW50X3VzZXJzX2RlbGV0ZWQYDSADKAlSEWV2ZW50VX'
    'NlcnNEZWxldGVkQggKBl9pbWFnZUIQCg5faW1hZ2VfZGVsZXRlZA==');

@$core.Deprecated('Use eventUpdateRequestDescriptor instead')
const EventUpdateRequest$json = {
  '1': 'EventUpdateRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'entity',
      '3': 2,
      '4': 1,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.event.EventCreateUpdate',
      '10': 'entity'
    },
    {'1': 'etag', '3': 3, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `EventUpdateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventUpdateRequestDescriptor = $convert.base64Decode(
    'ChJFdmVudFVwZGF0ZVJlcXVlc3QSDgoCaWQYASABKAlSAmlkEmYKBmVudGl0eRgCIAEoCzJOLn'
    'Jhem1hbmFnZXIucHJvdG9idWYuaW50ZXJuYWwucmVwb3NpdG9yeS5jcnVkX3NlcnZpY2VzLmV2'
    'ZW50LkV2ZW50Q3JlYXRlVXBkYXRlUgZlbnRpdHkSEgoEZXRhZxgDIAEoCVIEZXRhZw==');

@$core.Deprecated('Use eventListResponseDescriptor instead')
const EventListResponse$json = {
  '1': 'EventListResponse',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.event.EventList',
      '10': 'result'
    },
  ],
};

/// Descriptor for `EventListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventListResponseDescriptor = $convert.base64Decode(
    'ChFFdmVudExpc3RSZXNwb25zZRJeCgZyZXN1bHQYASADKAsyRi5yYXptYW5hZ2VyLnByb3RvYn'
    'VmLmludGVybmFsLnJlcG9zaXRvcnkuY3J1ZF9zZXJ2aWNlcy5ldmVudC5FdmVudExpc3RSBnJl'
    'c3VsdA==');

@$core.Deprecated('Use eventListDescriptor instead')
const EventList$json = {
  '1': 'EventList',
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
      '1': 'publish_from',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'publishFrom'
    },
    {
      '1': 'publish_until',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'publishUntil'
    },
    {
      '1': 'image',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BytesValue',
      '10': 'image'
    },
    {'1': 'etag', '3': 7, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `EventList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventListDescriptor = $convert.base64Decode(
    'CglFdmVudExpc3QSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSPgoLZGVzY3'
    'JpcHRpb24YAyABKAsyHC5nb29nbGUucHJvdG9idWYuU3RyaW5nVmFsdWVSC2Rlc2NyaXB0aW9u'
    'Ej0KDHB1Ymxpc2hfZnJvbRgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC3B1Ym'
    'xpc2hGcm9tEj8KDXB1Ymxpc2hfdW50aWwYBSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0'
    'YW1wUgxwdWJsaXNoVW50aWwSMQoFaW1hZ2UYBiABKAsyGy5nb29nbGUucHJvdG9idWYuQnl0ZX'
    'NWYWx1ZVIFaW1hZ2USEgoEZXRhZxgHIAEoCVIEZXRhZw==');

@$core.Deprecated('Use eventSelectResponseDescriptor instead')
const EventSelectResponse$json = {
  '1': 'EventSelectResponse',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.event.EventSelect',
      '10': 'result'
    },
  ],
};

/// Descriptor for `EventSelectResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventSelectResponseDescriptor = $convert.base64Decode(
    'ChNFdmVudFNlbGVjdFJlc3BvbnNlEmAKBnJlc3VsdBgBIAMoCzJILnJhem1hbmFnZXIucHJvdG'
    '9idWYuaW50ZXJuYWwucmVwb3NpdG9yeS5jcnVkX3NlcnZpY2VzLmV2ZW50LkV2ZW50U2VsZWN0'
    'UgZyZXN1bHQ=');

@$core.Deprecated('Use eventSelectDescriptor instead')
const EventSelect$json = {
  '1': 'EventSelect',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'event_users',
      '3': 9,
      '4': 3,
      '5': 11,
      '6':
          '.razmanager.protobuf.internal.repository.crud_services.event.EventUserSelect',
      '10': 'eventUsers'
    },
  ],
};

/// Descriptor for `EventSelect`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventSelectDescriptor = $convert.base64Decode(
    'CgtFdmVudFNlbGVjdBIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRJtCgtldm'
    'VudF91c2VycxgJIAMoCzJMLnJhem1hbmFnZXIucHJvdG9idWYuaW50ZXJuYWwucmVwb3NpdG9y'
    'eS5jcnVkX3NlcnZpY2VzLmV2ZW50LkV2ZW50VXNlclNlbGVjdFIKZXZlbnRVc2Vycw==');

@$core.Deprecated('Use eventInviteReadCreateUpdateDescriptor instead')
const EventInviteReadCreateUpdate$json = {
  '1': 'EventInviteReadCreateUpdate',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'code', '3': 2, '4': 1, '5': 5, '10': 'code'},
    {'1': 'multiple', '3': 3, '4': 1, '5': 8, '10': 'multiple'},
    {
      '1': 'time_to_live_at',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'timeToLiveAt'
    },
  ],
};

/// Descriptor for `EventInviteReadCreateUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventInviteReadCreateUpdateDescriptor =
    $convert.base64Decode(
        'ChtFdmVudEludml0ZVJlYWRDcmVhdGVVcGRhdGUSDgoCaWQYASABKAlSAmlkEhIKBGNvZGUYAi'
        'ABKAVSBGNvZGUSGgoIbXVsdGlwbGUYAyABKAhSCG11bHRpcGxlEkEKD3RpbWVfdG9fbGl2ZV9h'
        'dBgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDHRpbWVUb0xpdmVBdA==');

@$core.Deprecated('Use eventUserReadDescriptor instead')
const EventUserRead$json = {
  '1': 'EventUserRead',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'event_user_id',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'eventUserId'
    },
    {
      '1': 'user_id',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'userId'
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
      '1': 'short_name',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'shortName'
    },
    {
      '1': 'event_user_type_id',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.EventUserTypeId',
      '10': 'eventUserTypeId'
    },
    {
      '1': 'image',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BytesValue',
      '10': 'image'
    },
  ],
};

/// Descriptor for `EventUserRead`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventUserReadDescriptor = $convert.base64Decode(
    'Cg1FdmVudFVzZXJSZWFkEg4KAmlkGAEgASgJUgJpZBJACg1ldmVudF91c2VyX2lkGAIgASgLMh'
    'wuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUgtldmVudFVzZXJJZBI1Cgd1c2VyX2lkGAMg'
    'ASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUgZ1c2VySWQSMAoEbmFtZRgFIAEoCz'
    'IcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZVIEbmFtZRI7CgpzaG9ydF9uYW1lGAYgASgL'
    'MhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUglzaG9ydE5hbWUSWwoSZXZlbnRfdXNlcl'
    '90eXBlX2lkGAcgASgOMi4ucmF6bWFuYWdlci5wcm90b2J1Zi5wdWJsaWMudjEuRXZlbnRVc2Vy'
    'VHlwZUlkUg9ldmVudFVzZXJUeXBlSWQSMQoFaW1hZ2UYCCABKAsyGy5nb29nbGUucHJvdG9idW'
    'YuQnl0ZXNWYWx1ZVIFaW1hZ2U=');

@$core.Deprecated('Use eventUserCreateUpdateDescriptor instead')
const EventUserCreateUpdate$json = {
  '1': 'EventUserCreateUpdate',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'event_user_id',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'eventUserId'
    },
    {
      '1': 'user_id',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'userId'
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
      '1': 'short_name',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'shortName'
    },
    {
      '1': 'event_user_type_id',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.EventUserTypeId',
      '10': 'eventUserTypeId'
    },
    {'1': 'image', '3': 8, '4': 1, '5': 12, '9': 0, '10': 'image', '17': true},
    {
      '1': 'image_deleted',
      '3': 9,
      '4': 1,
      '5': 8,
      '9': 1,
      '10': 'imageDeleted',
      '17': true
    },
  ],
  '8': [
    {'1': '_image'},
    {'1': '_image_deleted'},
  ],
};

/// Descriptor for `EventUserCreateUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventUserCreateUpdateDescriptor = $convert.base64Decode(
    'ChVFdmVudFVzZXJDcmVhdGVVcGRhdGUSDgoCaWQYASABKAlSAmlkEkAKDWV2ZW50X3VzZXJfaW'
    'QYAiABKAsyHC5nb29nbGUucHJvdG9idWYuU3RyaW5nVmFsdWVSC2V2ZW50VXNlcklkEjUKB3Vz'
    'ZXJfaWQYAyABKAsyHC5nb29nbGUucHJvdG9idWYuU3RyaW5nVmFsdWVSBnVzZXJJZBIwCgRuYW'
    '1lGAUgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUgRuYW1lEjsKCnNob3J0X25h'
    'bWUYBiABKAsyHC5nb29nbGUucHJvdG9idWYuU3RyaW5nVmFsdWVSCXNob3J0TmFtZRJbChJldm'
    'VudF91c2VyX3R5cGVfaWQYByABKA4yLi5yYXptYW5hZ2VyLnByb3RvYnVmLnB1YmxpYy52MS5F'
    'dmVudFVzZXJUeXBlSWRSD2V2ZW50VXNlclR5cGVJZBIZCgVpbWFnZRgIIAEoDEgAUgVpbWFnZY'
    'gBARIoCg1pbWFnZV9kZWxldGVkGAkgASgISAFSDGltYWdlRGVsZXRlZIgBAUIICgZfaW1hZ2VC'
    'EAoOX2ltYWdlX2RlbGV0ZWQ=');

@$core.Deprecated('Use eventUserSelectDescriptor instead')
const EventUserSelect$json = {
  '1': 'EventUserSelect',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'short_name',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'shortName'
    },
    {
      '1': 'image',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BytesValue',
      '10': 'image'
    },
  ],
};

/// Descriptor for `EventUserSelect`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventUserSelectDescriptor = $convert.base64Decode(
    'Cg9FdmVudFVzZXJTZWxlY3QSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSOw'
    'oKc2hvcnRfbmFtZRgDIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZVIJc2hvcnRO'
    'YW1lEjEKBWltYWdlGAQgASgLMhsuZ29vZ2xlLnByb3RvYnVmLkJ5dGVzVmFsdWVSBWltYWdl');
