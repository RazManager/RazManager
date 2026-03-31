// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/device_request_response.v1.proto.

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

@$core.Deprecated('Use deviceIntegrationTypeIdDescriptor instead')
const DeviceIntegrationTypeId$json = {
  '1': 'DeviceIntegrationTypeId',
  '2': [
    {'1': 'DEVICE_INTEGRATION_TYPE_ID_UNDEFINED', '2': 0},
    {'1': 'DEVICE_INTEGRATION_TYPE_ID_GPIO', '2': 1},
    {'1': 'DEVICE_INTEGRATION_TYPE_ID_OXIGEN', '2': 2},
    {'1': 'DEVICE_INTEGRATION_TYPE_ID_SCALEXTRIC_ARC', '2': 3},
    {'1': 'DEVICE_INTEGRATION_TYPE_ID_SCALEXTRIC_APB', '2': 4},
    {'1': 'DEVICE_INTEGRATION_TYPE_ID_SCALEXTRIC_PIT_PRO', '2': 5},
    {'1': 'DEVICE_INTEGRATION_TYPE_ID_PHILIPS_HUE', '2': 6},
    {'1': 'DEVICE_INTEGRATION_TYPE_ID_RGB', '2': 7},
    {'1': 'DEVICE_INTEGRATION_TYPE_ID_LAP_MASTER', '2': 8},
    {'1': 'DEVICE_INTEGRATION_TYPE_ID_CHRONO_LOG', '2': 100},
    {'1': 'DEVICE_INTEGRATION_TYPE_ID_PERFORMANCE_TEST', '2': 101},
  ],
};

/// Descriptor for `DeviceIntegrationTypeId`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List deviceIntegrationTypeIdDescriptor = $convert.base64Decode(
    'ChdEZXZpY2VJbnRlZ3JhdGlvblR5cGVJZBIoCiRERVZJQ0VfSU5URUdSQVRJT05fVFlQRV9JRF'
    '9VTkRFRklORUQQABIjCh9ERVZJQ0VfSU5URUdSQVRJT05fVFlQRV9JRF9HUElPEAESJQohREVW'
    'SUNFX0lOVEVHUkFUSU9OX1RZUEVfSURfT1hJR0VOEAISLQopREVWSUNFX0lOVEVHUkFUSU9OX1'
    'RZUEVfSURfU0NBTEVYVFJJQ19BUkMQAxItCilERVZJQ0VfSU5URUdSQVRJT05fVFlQRV9JRF9T'
    'Q0FMRVhUUklDX0FQQhAEEjEKLURFVklDRV9JTlRFR1JBVElPTl9UWVBFX0lEX1NDQUxFWFRSSU'
    'NfUElUX1BSTxAFEioKJkRFVklDRV9JTlRFR1JBVElPTl9UWVBFX0lEX1BISUxJUFNfSFVFEAYS'
    'IgoeREVWSUNFX0lOVEVHUkFUSU9OX1RZUEVfSURfUkdCEAcSKQolREVWSUNFX0lOVEVHUkFUSU'
    '9OX1RZUEVfSURfTEFQX01BU1RFUhAIEikKJURFVklDRV9JTlRFR1JBVElPTl9UWVBFX0lEX0NI'
    'Uk9OT19MT0cQZBIvCitERVZJQ0VfSU5URUdSQVRJT05fVFlQRV9JRF9QRVJGT1JNQU5DRV9URV'
    'NUEGU=');

@$core.Deprecated('Use oxigenRxLapTimeTypeIdDescriptor instead')
const OxigenRxLapTimeTypeId$json = {
  '1': 'OxigenRxLapTimeTypeId',
  '2': [
    {'1': 'OXIGEN_RX_LAP_TIME_TYPE_ID_NONE', '2': 0},
    {'1': 'OXIGEN_RX_LAP_TIME_TYPE_ID_CONTROLLER', '2': 1},
    {'1': 'OXIGEN_RX_LAP_TIME_TYPE_ID_TIMER', '2': 2},
  ],
};

/// Descriptor for `OxigenRxLapTimeTypeId`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List oxigenRxLapTimeTypeIdDescriptor = $convert.base64Decode(
    'ChVPeGlnZW5SeExhcFRpbWVUeXBlSWQSIwofT1hJR0VOX1JYX0xBUF9USU1FX1RZUEVfSURfTk'
    '9ORRAAEikKJU9YSUdFTl9SWF9MQVBfVElNRV9UWVBFX0lEX0NPTlRST0xMRVIQARIkCiBPWElH'
    'RU5fUlhfTEFQX1RJTUVfVFlQRV9JRF9USU1FUhAC');

@$core.Deprecated('Use oxigenTxPitLaneLapCountingTypeIdDescriptor instead')
const OxigenTxPitLaneLapCountingTypeId$json = {
  '1': 'OxigenTxPitLaneLapCountingTypeId',
  '2': [
    {'1': 'OXIGEN_TX_PIT_LANE_LAP_COUNTING_TYPE_ID_ENABLED', '2': 0},
    {'1': 'OXIGEN_TX_PIT_LANE_LAP_COUNTING_TYPE_ID_DISABLED', '2': 1},
  ],
};

/// Descriptor for `OxigenTxPitLaneLapCountingTypeId`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List oxigenTxPitLaneLapCountingTypeIdDescriptor =
    $convert.base64Decode(
        'CiBPeGlnZW5UeFBpdExhbmVMYXBDb3VudGluZ1R5cGVJZBIzCi9PWElHRU5fVFhfUElUX0xBTk'
        'VfTEFQX0NPVU5USU5HX1RZUEVfSURfRU5BQkxFRBAAEjQKME9YSUdFTl9UWF9QSVRfTEFORV9M'
        'QVBfQ09VTlRJTkdfVFlQRV9JRF9ESVNBQkxFRBAB');

@$core.Deprecated('Use oxigenTxPitLaneLapTriggerTypeIdDescriptor instead')
const OxigenTxPitLaneLapTriggerTypeId$json = {
  '1': 'OxigenTxPitLaneLapTriggerTypeId',
  '2': [
    {'1': 'OXIGEN_TX_PIT_LANE_LAP_TRIGGER_TYPE_ID_UNDEFINED', '2': 0},
    {'1': 'OXIGEN_TX_PIT_LANE_LAP_TRIGGER_TYPE_ID_PIT_LANE_ENTRY', '2': 1},
    {'1': 'OXIGEN_TX_PIT_LANE_LAP_TRIGGER_TYPE_ID_PIT_LANE_EXIT', '2': 2},
  ],
};

/// Descriptor for `OxigenTxPitLaneLapTriggerTypeId`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List oxigenTxPitLaneLapTriggerTypeIdDescriptor =
    $convert.base64Decode(
        'Ch9PeGlnZW5UeFBpdExhbmVMYXBUcmlnZ2VyVHlwZUlkEjQKME9YSUdFTl9UWF9QSVRfTEFORV'
        '9MQVBfVFJJR0dFUl9UWVBFX0lEX1VOREVGSU5FRBAAEjkKNU9YSUdFTl9UWF9QSVRfTEFORV9M'
        'QVBfVFJJR0dFUl9UWVBFX0lEX1BJVF9MQU5FX0VOVFJZEAESOAo0T1hJR0VOX1RYX1BJVF9MQU'
        '5FX0xBUF9UUklHR0VSX1RZUEVfSURfUElUX0xBTkVfRVhJVBAC');

@$core.Deprecated('Use deviceRequestDescriptor instead')
const DeviceRequest$json = {
  '1': 'DeviceRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'correlation_id', '3': 2, '4': 1, '5': 9, '10': 'correlationId'},
    {
      '1': 'device_connection_request',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.DeviceConnectionRequest',
      '9': 0,
      '10': 'deviceConnectionRequest'
    },
    {
      '1': 'device_system_information_request',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.DeviceSystemInformationRequest',
      '9': 0,
      '10': 'deviceSystemInformationRequest'
    },
    {
      '1': 'device_settings_read_request',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.DeviceSettingsReadRequest',
      '9': 0,
      '10': 'deviceSettingsReadRequest'
    },
    {
      '1': 'device_settings_upsert_request',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.DeviceSettingsUpsertRequest',
      '9': 0,
      '10': 'deviceSettingsUpsertRequest'
    },
  ],
  '8': [
    {'1': 'value'},
  ],
};

/// Descriptor for `DeviceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceRequestDescriptor = $convert.base64Decode(
    'Cg1EZXZpY2VSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZBIlCg5jb3JyZWxhdGlvbl9pZBgCIAEoCV'
    'INY29ycmVsYXRpb25JZBJ0ChlkZXZpY2VfY29ubmVjdGlvbl9yZXF1ZXN0GAMgASgLMjYucmF6'
    'bWFuYWdlci5wcm90b2J1Zi5wdWJsaWMudjEuRGV2aWNlQ29ubmVjdGlvblJlcXVlc3RIAFIXZG'
    'V2aWNlQ29ubmVjdGlvblJlcXVlc3QSigEKIWRldmljZV9zeXN0ZW1faW5mb3JtYXRpb25fcmVx'
    'dWVzdBgEIAEoCzI9LnJhem1hbmFnZXIucHJvdG9idWYucHVibGljLnYxLkRldmljZVN5c3RlbU'
    'luZm9ybWF0aW9uUmVxdWVzdEgAUh5kZXZpY2VTeXN0ZW1JbmZvcm1hdGlvblJlcXVlc3QSewoc'
    'ZGV2aWNlX3NldHRpbmdzX3JlYWRfcmVxdWVzdBgFIAEoCzI4LnJhem1hbmFnZXIucHJvdG9idW'
    'YucHVibGljLnYxLkRldmljZVNldHRpbmdzUmVhZFJlcXVlc3RIAFIZZGV2aWNlU2V0dGluZ3NS'
    'ZWFkUmVxdWVzdBKBAQoeZGV2aWNlX3NldHRpbmdzX3Vwc2VydF9yZXF1ZXN0GAYgASgLMjoucm'
    'F6bWFuYWdlci5wcm90b2J1Zi5wdWJsaWMudjEuRGV2aWNlU2V0dGluZ3NVcHNlcnRSZXF1ZXN0'
    'SABSG2RldmljZVNldHRpbmdzVXBzZXJ0UmVxdWVzdEIHCgV2YWx1ZQ==');

@$core.Deprecated('Use deviceResponseDescriptor instead')
const DeviceResponse$json = {
  '1': 'DeviceResponse',
  '2': [
    {'1': 'correlation_id', '3': 2, '4': 1, '5': 9, '10': 'correlationId'},
    {
      '1': 'device_connection_response',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.DeviceConnectionResponse',
      '9': 0,
      '10': 'deviceConnectionResponse'
    },
    {
      '1': 'device_system_information_response',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.DeviceSystemInformationResponse',
      '9': 0,
      '10': 'deviceSystemInformationResponse'
    },
    {
      '1': 'device_settings_response',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.DeviceSettingsResponse',
      '9': 0,
      '10': 'deviceSettingsResponse'
    },
  ],
  '8': [
    {'1': 'value'},
  ],
};

/// Descriptor for `DeviceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceResponseDescriptor = $convert.base64Decode(
    'Cg5EZXZpY2VSZXNwb25zZRIlCg5jb3JyZWxhdGlvbl9pZBgCIAEoCVINY29ycmVsYXRpb25JZB'
    'J3ChpkZXZpY2VfY29ubmVjdGlvbl9yZXNwb25zZRgDIAEoCzI3LnJhem1hbmFnZXIucHJvdG9i'
    'dWYucHVibGljLnYxLkRldmljZUNvbm5lY3Rpb25SZXNwb25zZUgAUhhkZXZpY2VDb25uZWN0aW'
    '9uUmVzcG9uc2USjQEKImRldmljZV9zeXN0ZW1faW5mb3JtYXRpb25fcmVzcG9uc2UYBCABKAsy'
    'Pi5yYXptYW5hZ2VyLnByb3RvYnVmLnB1YmxpYy52MS5EZXZpY2VTeXN0ZW1JbmZvcm1hdGlvbl'
    'Jlc3BvbnNlSABSH2RldmljZVN5c3RlbUluZm9ybWF0aW9uUmVzcG9uc2UScQoYZGV2aWNlX3Nl'
    'dHRpbmdzX3Jlc3BvbnNlGAUgASgLMjUucmF6bWFuYWdlci5wcm90b2J1Zi5wdWJsaWMudjEuRG'
    'V2aWNlU2V0dGluZ3NSZXNwb25zZUgAUhZkZXZpY2VTZXR0aW5nc1Jlc3BvbnNlQgcKBXZhbHVl');

@$core.Deprecated('Use deviceConnectionRequestDescriptor instead')
const DeviceConnectionRequest$json = {
  '1': 'DeviceConnectionRequest',
};

/// Descriptor for `DeviceConnectionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceConnectionRequestDescriptor =
    $convert.base64Decode('ChdEZXZpY2VDb25uZWN0aW9uUmVxdWVzdA==');

@$core.Deprecated('Use deviceConnectionResponseDescriptor instead')
const DeviceConnectionResponse$json = {
  '1': 'DeviceConnectionResponse',
  '2': [
    {'1': 'connected', '3': 1, '4': 1, '5': 8, '10': 'connected'},
  ],
};

/// Descriptor for `DeviceConnectionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceConnectionResponseDescriptor =
    $convert.base64Decode(
        'ChhEZXZpY2VDb25uZWN0aW9uUmVzcG9uc2USHAoJY29ubmVjdGVkGAEgASgIUgljb25uZWN0ZW'
        'Q=');

@$core.Deprecated('Use deviceSystemInformationRequestDescriptor instead')
const DeviceSystemInformationRequest$json = {
  '1': 'DeviceSystemInformationRequest',
};

/// Descriptor for `DeviceSystemInformationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceSystemInformationRequestDescriptor =
    $convert.base64Decode('Ch5EZXZpY2VTeXN0ZW1JbmZvcm1hdGlvblJlcXVlc3Q=');

@$core.Deprecated('Use deviceSystemInformationResponseDescriptor instead')
const DeviceSystemInformationResponse$json = {
  '1': 'DeviceSystemInformationResponse',
  '2': [
    {
      '1': 'hardware_model',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'hardwareModel'
    },
    {
      '1': 'hardware_processor',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'hardwareProcessor'
    },
    {
      '1': 'software_assembly_version',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'softwareAssemblyVersion'
    },
    {
      '1': 'software_snap_version',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'softwareSnapVersion'
    },
    {
      '1': 'software_dot_net_version',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'softwareDotNetVersion'
    },
    {
      '1': 'software_os_version',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'softwareOsVersion'
    },
    {
      '1': 'software_os_release_version',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'softwareOsReleaseVersion'
    },
    {'1': 'serial_port_names', '3': 8, '4': 3, '5': 9, '10': 'serialPortNames'},
  ],
};

/// Descriptor for `DeviceSystemInformationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceSystemInformationResponseDescriptor = $convert.base64Decode(
    'Ch9EZXZpY2VTeXN0ZW1JbmZvcm1hdGlvblJlc3BvbnNlEkMKDmhhcmR3YXJlX21vZGVsGAEgAS'
    'gLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUg1oYXJkd2FyZU1vZGVsEksKEmhhcmR3'
    'YXJlX3Byb2Nlc3NvchgCIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZVIRaGFyZH'
    'dhcmVQcm9jZXNzb3ISWAoZc29mdHdhcmVfYXNzZW1ibHlfdmVyc2lvbhgDIAEoCzIcLmdvb2ds'
    'ZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZVIXc29mdHdhcmVBc3NlbWJseVZlcnNpb24SUAoVc29mdH'
    'dhcmVfc25hcF92ZXJzaW9uGAQgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUhNz'
    'b2Z0d2FyZVNuYXBWZXJzaW9uElUKGHNvZnR3YXJlX2RvdF9uZXRfdmVyc2lvbhgFIAEoCzIcLm'
    'dvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZVIVc29mdHdhcmVEb3ROZXRWZXJzaW9uEkwKE3Nv'
    'ZnR3YXJlX29zX3ZlcnNpb24YBiABKAsyHC5nb29nbGUucHJvdG9idWYuU3RyaW5nVmFsdWVSEX'
    'NvZnR3YXJlT3NWZXJzaW9uElsKG3NvZnR3YXJlX29zX3JlbGVhc2VfdmVyc2lvbhgHIAEoCzIc'
    'Lmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZVIYc29mdHdhcmVPc1JlbGVhc2VWZXJzaW9uEi'
    'oKEXNlcmlhbF9wb3J0X25hbWVzGAggAygJUg9zZXJpYWxQb3J0TmFtZXM=');

@$core.Deprecated('Use deviceSettingsReadRequestDescriptor instead')
const DeviceSettingsReadRequest$json = {
  '1': 'DeviceSettingsReadRequest',
};

/// Descriptor for `DeviceSettingsReadRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceSettingsReadRequestDescriptor =
    $convert.base64Decode('ChlEZXZpY2VTZXR0aW5nc1JlYWRSZXF1ZXN0');

@$core.Deprecated('Use deviceSettingsUpsertRequestDescriptor instead')
const DeviceSettingsUpsertRequest$json = {
  '1': 'DeviceSettingsUpsertRequest',
  '2': [
    {
      '1': 'device_settings',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.DeviceSettings',
      '10': 'deviceSettings'
    },
  ],
};

/// Descriptor for `DeviceSettingsUpsertRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceSettingsUpsertRequestDescriptor =
    $convert.base64Decode(
        'ChtEZXZpY2VTZXR0aW5nc1Vwc2VydFJlcXVlc3QSVgoPZGV2aWNlX3NldHRpbmdzGAEgASgLMi'
        '0ucmF6bWFuYWdlci5wcm90b2J1Zi5wdWJsaWMudjEuRGV2aWNlU2V0dGluZ3NSDmRldmljZVNl'
        'dHRpbmdz');

@$core.Deprecated('Use deviceSettingsResponseDescriptor instead')
const DeviceSettingsResponse$json = {
  '1': 'DeviceSettingsResponse',
  '2': [
    {
      '1': 'device_settings',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.DeviceSettings',
      '10': 'deviceSettings'
    },
  ],
};

/// Descriptor for `DeviceSettingsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceSettingsResponseDescriptor = $convert.base64Decode(
    'ChZEZXZpY2VTZXR0aW5nc1Jlc3BvbnNlElYKD2RldmljZV9zZXR0aW5ncxgBIAEoCzItLnJhem'
    '1hbmFnZXIucHJvdG9idWYucHVibGljLnYxLkRldmljZVNldHRpbmdzUg5kZXZpY2VTZXR0aW5n'
    'cw==');

@$core.Deprecated('Use deviceSettingsDescriptor instead')
const DeviceSettings$json = {
  '1': 'DeviceSettings',
  '2': [
    {
      '1': 'device_configuration_settings',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.DeviceConfigurationSettings',
      '10': 'deviceConfigurationSettings'
    },
  ],
};

/// Descriptor for `DeviceSettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceSettingsDescriptor = $convert.base64Decode(
    'Cg5EZXZpY2VTZXR0aW5ncxJ+Ch1kZXZpY2VfY29uZmlndXJhdGlvbl9zZXR0aW5ncxgBIAMoCz'
    'I6LnJhem1hbmFnZXIucHJvdG9idWYucHVibGljLnYxLkRldmljZUNvbmZpZ3VyYXRpb25TZXR0'
    'aW5nc1IbZGV2aWNlQ29uZmlndXJhdGlvblNldHRpbmdz');

@$core.Deprecated('Use deviceConfigurationSettingsDescriptor instead')
const DeviceConfigurationSettings$json = {
  '1': 'DeviceConfigurationSettings',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'device_integrations',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.DeviceIntegration',
      '10': 'deviceIntegrations'
    },
  ],
};

/// Descriptor for `DeviceConfigurationSettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceConfigurationSettingsDescriptor = $convert.base64Decode(
    'ChtEZXZpY2VDb25maWd1cmF0aW9uU2V0dGluZ3MSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAi'
    'ABKAlSBG5hbWUSYQoTZGV2aWNlX2ludGVncmF0aW9ucxgDIAMoCzIwLnJhem1hbmFnZXIucHJv'
    'dG9idWYucHVibGljLnYxLkRldmljZUludGVncmF0aW9uUhJkZXZpY2VJbnRlZ3JhdGlvbnM=');

@$core.Deprecated('Use deviceIntegrationDescriptor instead')
const DeviceIntegration$json = {
  '1': 'DeviceIntegration',
  '2': [
    {
      '1': 'device_integration_gpio',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.DeviceIntegrationGpio',
      '9': 0,
      '10': 'deviceIntegrationGpio'
    },
    {
      '1': 'device_integration_oxigen',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.DeviceIntegrationOxigen',
      '9': 0,
      '10': 'deviceIntegrationOxigen'
    },
    {
      '1': 'device_integration_scalextric_arc',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.DeviceIntegrationScalextricArc',
      '9': 0,
      '10': 'deviceIntegrationScalextricArc'
    },
    {
      '1': 'device_integration_scalextric_apb',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.DeviceIntegrationScalextricApb',
      '9': 0,
      '10': 'deviceIntegrationScalextricApb'
    },
    {
      '1': 'device_integration_scalextric_pit_pro',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.DeviceIntegrationScalextricPitPro',
      '9': 0,
      '10': 'deviceIntegrationScalextricPitPro'
    },
    {
      '1': 'device_integration_philips_hue',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.DeviceIntegrationPhilipsHue',
      '9': 0,
      '10': 'deviceIntegrationPhilipsHue'
    },
    {
      '1': 'device_integration_rgb',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.DeviceIntegrationRgb',
      '9': 0,
      '10': 'deviceIntegrationRgb'
    },
    {
      '1': 'device_integration_lap_master',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.DeviceIntegrationLapMaster',
      '9': 0,
      '10': 'deviceIntegrationLapMaster'
    },
    {
      '1': 'device_integration_chrono_log',
      '3': 100,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.DeviceIntegrationChronoLog',
      '9': 0,
      '10': 'deviceIntegrationChronoLog'
    },
    {
      '1': 'device_integration_performance_test',
      '3': 101,
      '4': 1,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.DeviceIntegrationPerformanceTest',
      '9': 0,
      '10': 'deviceIntegrationPerformanceTest'
    },
  ],
  '8': [
    {'1': 'value'},
  ],
};

/// Descriptor for `DeviceIntegration`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceIntegrationDescriptor = $convert.base64Decode(
    'ChFEZXZpY2VJbnRlZ3JhdGlvbhJuChdkZXZpY2VfaW50ZWdyYXRpb25fZ3BpbxgBIAEoCzI0Ln'
    'Jhem1hbmFnZXIucHJvdG9idWYucHVibGljLnYxLkRldmljZUludGVncmF0aW9uR3Bpb0gAUhVk'
    'ZXZpY2VJbnRlZ3JhdGlvbkdwaW8SdAoZZGV2aWNlX2ludGVncmF0aW9uX294aWdlbhgCIAEoCz'
    'I2LnJhem1hbmFnZXIucHJvdG9idWYucHVibGljLnYxLkRldmljZUludGVncmF0aW9uT3hpZ2Vu'
    'SABSF2RldmljZUludGVncmF0aW9uT3hpZ2VuEooBCiFkZXZpY2VfaW50ZWdyYXRpb25fc2NhbG'
    'V4dHJpY19hcmMYAyABKAsyPS5yYXptYW5hZ2VyLnByb3RvYnVmLnB1YmxpYy52MS5EZXZpY2VJ'
    'bnRlZ3JhdGlvblNjYWxleHRyaWNBcmNIAFIeZGV2aWNlSW50ZWdyYXRpb25TY2FsZXh0cmljQX'
    'JjEooBCiFkZXZpY2VfaW50ZWdyYXRpb25fc2NhbGV4dHJpY19hcGIYBCABKAsyPS5yYXptYW5h'
    'Z2VyLnByb3RvYnVmLnB1YmxpYy52MS5EZXZpY2VJbnRlZ3JhdGlvblNjYWxleHRyaWNBcGJIAF'
    'IeZGV2aWNlSW50ZWdyYXRpb25TY2FsZXh0cmljQXBiEpQBCiVkZXZpY2VfaW50ZWdyYXRpb25f'
    'c2NhbGV4dHJpY19waXRfcHJvGAUgASgLMkAucmF6bWFuYWdlci5wcm90b2J1Zi5wdWJsaWMudj'
    'EuRGV2aWNlSW50ZWdyYXRpb25TY2FsZXh0cmljUGl0UHJvSABSIWRldmljZUludGVncmF0aW9u'
    'U2NhbGV4dHJpY1BpdFBybxKBAQoeZGV2aWNlX2ludGVncmF0aW9uX3BoaWxpcHNfaHVlGAYgAS'
    'gLMjoucmF6bWFuYWdlci5wcm90b2J1Zi5wdWJsaWMudjEuRGV2aWNlSW50ZWdyYXRpb25QaGls'
    'aXBzSHVlSABSG2RldmljZUludGVncmF0aW9uUGhpbGlwc0h1ZRJrChZkZXZpY2VfaW50ZWdyYX'
    'Rpb25fcmdiGAcgASgLMjMucmF6bWFuYWdlci5wcm90b2J1Zi5wdWJsaWMudjEuRGV2aWNlSW50'
    'ZWdyYXRpb25SZ2JIAFIUZGV2aWNlSW50ZWdyYXRpb25SZ2ISfgodZGV2aWNlX2ludGVncmF0aW'
    '9uX2xhcF9tYXN0ZXIYCCABKAsyOS5yYXptYW5hZ2VyLnByb3RvYnVmLnB1YmxpYy52MS5EZXZp'
    'Y2VJbnRlZ3JhdGlvbkxhcE1hc3RlckgAUhpkZXZpY2VJbnRlZ3JhdGlvbkxhcE1hc3RlchJ+Ch'
    '1kZXZpY2VfaW50ZWdyYXRpb25fY2hyb25vX2xvZxhkIAEoCzI5LnJhem1hbmFnZXIucHJvdG9i'
    'dWYucHVibGljLnYxLkRldmljZUludGVncmF0aW9uQ2hyb25vTG9nSABSGmRldmljZUludGVncm'
    'F0aW9uQ2hyb25vTG9nEpABCiNkZXZpY2VfaW50ZWdyYXRpb25fcGVyZm9ybWFuY2VfdGVzdBhl'
    'IAEoCzI/LnJhem1hbmFnZXIucHJvdG9idWYucHVibGljLnYxLkRldmljZUludGVncmF0aW9uUG'
    'VyZm9ybWFuY2VUZXN0SABSIGRldmljZUludGVncmF0aW9uUGVyZm9ybWFuY2VUZXN0QgcKBXZh'
    'bHVl');

@$core.Deprecated('Use deviceIntegrationGpioDescriptor instead')
const DeviceIntegrationGpio$json = {
  '1': 'DeviceIntegrationGpio',
};

/// Descriptor for `DeviceIntegrationGpio`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceIntegrationGpioDescriptor =
    $convert.base64Decode('ChVEZXZpY2VJbnRlZ3JhdGlvbkdwaW8=');

@$core.Deprecated('Use deviceIntegrationOxigenDescriptor instead')
const DeviceIntegrationOxigen$json = {
  '1': 'DeviceIntegrationOxigen',
  '2': [
    {'1': 'serial_port_name', '3': 1, '4': 1, '5': 9, '10': 'serialPortName'},
    {
      '1': 'oxigen_rx_lap_time_type_id',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.OxigenRxLapTimeTypeId',
      '10': 'oxigenRxLapTimeTypeId'
    },
    {
      '1': 'oxigen_tx_pit_lane_lap_counting_type_id',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.OxigenTxPitLaneLapCountingTypeId',
      '10': 'oxigenTxPitLaneLapCountingTypeId'
    },
    {
      '1': 'oxigen_tx_pit_lane_lap_trigger_type_id',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.OxigenTxPitLaneLapTriggerTypeId',
      '10': 'oxigenTxPitLaneLapTriggerTypeId'
    },
    {
      '1': 'max_controller_id',
      '3': 5,
      '4': 1,
      '5': 13,
      '10': 'maxControllerId'
    },
  ],
};

/// Descriptor for `DeviceIntegrationOxigen`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceIntegrationOxigenDescriptor = $convert.base64Decode(
    'ChdEZXZpY2VJbnRlZ3JhdGlvbk94aWdlbhIoChBzZXJpYWxfcG9ydF9uYW1lGAEgASgJUg5zZX'
    'JpYWxQb3J0TmFtZRJvChpveGlnZW5fcnhfbGFwX3RpbWVfdHlwZV9pZBgCIAEoDjI0LnJhem1h'
    'bmFnZXIucHJvdG9idWYucHVibGljLnYxLk94aWdlblJ4TGFwVGltZVR5cGVJZFIVb3hpZ2VuUn'
    'hMYXBUaW1lVHlwZUlkEpIBCidveGlnZW5fdHhfcGl0X2xhbmVfbGFwX2NvdW50aW5nX3R5cGVf'
    'aWQYAyABKA4yPy5yYXptYW5hZ2VyLnByb3RvYnVmLnB1YmxpYy52MS5PeGlnZW5UeFBpdExhbm'
    'VMYXBDb3VudGluZ1R5cGVJZFIgb3hpZ2VuVHhQaXRMYW5lTGFwQ291bnRpbmdUeXBlSWQSjwEK'
    'Jm94aWdlbl90eF9waXRfbGFuZV9sYXBfdHJpZ2dlcl90eXBlX2lkGAQgASgOMj4ucmF6bWFuYW'
    'dlci5wcm90b2J1Zi5wdWJsaWMudjEuT3hpZ2VuVHhQaXRMYW5lTGFwVHJpZ2dlclR5cGVJZFIf'
    'b3hpZ2VuVHhQaXRMYW5lTGFwVHJpZ2dlclR5cGVJZBIqChFtYXhfY29udHJvbGxlcl9pZBgFIA'
    'EoDVIPbWF4Q29udHJvbGxlcklk');

@$core.Deprecated('Use deviceIntegrationScalextricArcDescriptor instead')
const DeviceIntegrationScalextricArc$json = {
  '1': 'DeviceIntegrationScalextricArc',
};

/// Descriptor for `DeviceIntegrationScalextricArc`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceIntegrationScalextricArcDescriptor =
    $convert.base64Decode('Ch5EZXZpY2VJbnRlZ3JhdGlvblNjYWxleHRyaWNBcmM=');

@$core.Deprecated('Use deviceIntegrationScalextricApbDescriptor instead')
const DeviceIntegrationScalextricApb$json = {
  '1': 'DeviceIntegrationScalextricApb',
  '2': [
    {'1': 'serial_port_name', '3': 1, '4': 1, '5': 9, '10': 'serialPortName'},
  ],
};

/// Descriptor for `DeviceIntegrationScalextricApb`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceIntegrationScalextricApbDescriptor =
    $convert.base64Decode(
        'Ch5EZXZpY2VJbnRlZ3JhdGlvblNjYWxleHRyaWNBcGISKAoQc2VyaWFsX3BvcnRfbmFtZRgBIA'
        'EoCVIOc2VyaWFsUG9ydE5hbWU=');

@$core.Deprecated('Use deviceIntegrationScalextricPitProDescriptor instead')
const DeviceIntegrationScalextricPitPro$json = {
  '1': 'DeviceIntegrationScalextricPitPro',
  '2': [
    {'1': 'serial_port_name', '3': 1, '4': 1, '5': 9, '10': 'serialPortName'},
  ],
};

/// Descriptor for `DeviceIntegrationScalextricPitPro`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceIntegrationScalextricPitProDescriptor =
    $convert.base64Decode(
        'CiFEZXZpY2VJbnRlZ3JhdGlvblNjYWxleHRyaWNQaXRQcm8SKAoQc2VyaWFsX3BvcnRfbmFtZR'
        'gBIAEoCVIOc2VyaWFsUG9ydE5hbWU=');

@$core.Deprecated('Use deviceIntegrationPhilipsHueDescriptor instead')
const DeviceIntegrationPhilipsHue$json = {
  '1': 'DeviceIntegrationPhilipsHue',
};

/// Descriptor for `DeviceIntegrationPhilipsHue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceIntegrationPhilipsHueDescriptor =
    $convert.base64Decode('ChtEZXZpY2VJbnRlZ3JhdGlvblBoaWxpcHNIdWU=');

@$core.Deprecated('Use deviceIntegrationRgbDescriptor instead')
const DeviceIntegrationRgb$json = {
  '1': 'DeviceIntegrationRgb',
};

/// Descriptor for `DeviceIntegrationRgb`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceIntegrationRgbDescriptor =
    $convert.base64Decode('ChREZXZpY2VJbnRlZ3JhdGlvblJnYg==');

@$core.Deprecated('Use deviceIntegrationLapMasterDescriptor instead')
const DeviceIntegrationLapMaster$json = {
  '1': 'DeviceIntegrationLapMaster',
  '2': [
    {'1': 'serial_port_name', '3': 1, '4': 1, '5': 9, '10': 'serialPortName'},
    {'1': 'lanes', '3': 2, '4': 1, '5': 13, '10': 'lanes'},
  ],
};

/// Descriptor for `DeviceIntegrationLapMaster`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceIntegrationLapMasterDescriptor =
    $convert.base64Decode(
        'ChpEZXZpY2VJbnRlZ3JhdGlvbkxhcE1hc3RlchIoChBzZXJpYWxfcG9ydF9uYW1lGAEgASgJUg'
        '5zZXJpYWxQb3J0TmFtZRIUCgVsYW5lcxgCIAEoDVIFbGFuZXM=');

@$core.Deprecated('Use deviceIntegrationChronoLogDescriptor instead')
const DeviceIntegrationChronoLog$json = {
  '1': 'DeviceIntegrationChronoLog',
};

/// Descriptor for `DeviceIntegrationChronoLog`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceIntegrationChronoLogDescriptor =
    $convert.base64Decode('ChpEZXZpY2VJbnRlZ3JhdGlvbkNocm9ub0xvZw==');

@$core.Deprecated('Use deviceIntegrationPerformanceTestDescriptor instead')
const DeviceIntegrationPerformanceTest$json = {
  '1': 'DeviceIntegrationPerformanceTest',
};

/// Descriptor for `DeviceIntegrationPerformanceTest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceIntegrationPerformanceTestDescriptor =
    $convert.base64Decode('CiBEZXZpY2VJbnRlZ3JhdGlvblBlcmZvcm1hbmNlVGVzdA==');
