// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/version.v1.proto.

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

@$core.Deprecated('Use versionPlatformIdDescriptor instead')
const VersionPlatformId$json = {
  '1': 'VersionPlatformId',
  '2': [
    {'1': 'VERSION_PLATFORM_ID_SERVER', '2': 0},
    {'1': 'VERSION_PLATFORM_ID_WINDOWS', '2': 1},
    {'1': 'VERSION_PLATFORM_ID_LINUX', '2': 2},
    {'1': 'VERSION_PLATFORM_ID_MACOS', '2': 3},
    {'1': 'VERSION_PLATFORM_ID_IOS', '2': 4},
    {'1': 'VERSION_PLATFORM_ID_ANDROID', '2': 5},
  ],
};

/// Descriptor for `VersionPlatformId`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List versionPlatformIdDescriptor = $convert.base64Decode(
    'ChFWZXJzaW9uUGxhdGZvcm1JZBIeChpWRVJTSU9OX1BMQVRGT1JNX0lEX1NFUlZFUhAAEh8KG1'
    'ZFUlNJT05fUExBVEZPUk1fSURfV0lORE9XUxABEh0KGVZFUlNJT05fUExBVEZPUk1fSURfTElO'
    'VVgQAhIdChlWRVJTSU9OX1BMQVRGT1JNX0lEX01BQ09TEAMSGwoXVkVSU0lPTl9QTEFURk9STV'
    '9JRF9JT1MQBBIfChtWRVJTSU9OX1BMQVRGT1JNX0lEX0FORFJPSUQQBQ==');

@$core.Deprecated('Use versionDescriptor instead')
const Version$json = {
  '1': 'Version',
  '2': [
    {
      '1': 'date',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'date'
    },
    {'1': 'major', '3': 3, '4': 1, '5': 13, '10': 'major'},
    {'1': 'minor', '3': 4, '4': 1, '5': 13, '10': 'minor'},
    {'1': 'patch', '3': 5, '4': 1, '5': 13, '10': 'patch'},
    {'1': 'valid', '3': 7, '4': 1, '5': 8, '10': 'valid'},
    {
      '1': 'description',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'description'
    },
    {
      '1': 'notes',
      '3': 9,
      '4': 3,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.VersionNote',
      '10': 'notes'
    },
    {
      '1': 'platforms',
      '3': 10,
      '4': 3,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.VersionPlatform',
      '10': 'platforms'
    },
  ],
};

/// Descriptor for `Version`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List versionDescriptor = $convert.base64Decode(
    'CgdWZXJzaW9uEi4KBGRhdGUYAiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgRkYX'
    'RlEhQKBW1ham9yGAMgASgNUgVtYWpvchIUCgVtaW5vchgEIAEoDVIFbWlub3ISFAoFcGF0Y2gY'
    'BSABKA1SBXBhdGNoEhQKBXZhbGlkGAcgASgIUgV2YWxpZBI+CgtkZXNjcmlwdGlvbhgIIAEoCz'
    'IcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZVILZGVzY3JpcHRpb24SQAoFbm90ZXMYCSAD'
    'KAsyKi5yYXptYW5hZ2VyLnByb3RvYnVmLnB1YmxpYy52MS5WZXJzaW9uTm90ZVIFbm90ZXMSTA'
    'oJcGxhdGZvcm1zGAogAygLMi4ucmF6bWFuYWdlci5wcm90b2J1Zi5wdWJsaWMudjEuVmVyc2lv'
    'blBsYXRmb3JtUglwbGF0Zm9ybXM=');

@$core.Deprecated('Use versionNoteDescriptor instead')
const VersionNote$json = {
  '1': 'VersionNote',
  '2': [
    {'1': 'description', '3': 1, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `VersionNote`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List versionNoteDescriptor = $convert.base64Decode(
    'CgtWZXJzaW9uTm90ZRIgCgtkZXNjcmlwdGlvbhgBIAEoCVILZGVzY3JpcHRpb24=');

@$core.Deprecated('Use versionPlatformDescriptor instead')
const VersionPlatform$json = {
  '1': 'VersionPlatform',
  '2': [
    {
      '1': 'id',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.VersionPlatformId',
      '10': 'id'
    },
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `VersionPlatform`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List versionPlatformDescriptor = $convert.base64Decode(
    'Cg9WZXJzaW9uUGxhdGZvcm0SQAoCaWQYASABKA4yMC5yYXptYW5hZ2VyLnByb3RvYnVmLnB1Ym'
    'xpYy52MS5WZXJzaW9uUGxhdGZvcm1JZFICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZQ==');

@$core.Deprecated('Use versionAllRequestDescriptor instead')
const VersionAllRequest$json = {
  '1': 'VersionAllRequest',
  '2': [
    {
      '1': 'version_platform_id',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.VersionPlatformId',
      '10': 'versionPlatformId'
    },
  ],
};

/// Descriptor for `VersionAllRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List versionAllRequestDescriptor = $convert.base64Decode(
    'ChFWZXJzaW9uQWxsUmVxdWVzdBJgChN2ZXJzaW9uX3BsYXRmb3JtX2lkGAEgASgOMjAucmF6bW'
    'FuYWdlci5wcm90b2J1Zi5wdWJsaWMudjEuVmVyc2lvblBsYXRmb3JtSWRSEXZlcnNpb25QbGF0'
    'Zm9ybUlk');

@$core.Deprecated('Use versionAllResponseDescriptor instead')
const VersionAllResponse$json = {
  '1': 'VersionAllResponse',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.Version',
      '10': 'result'
    },
  ],
};

/// Descriptor for `VersionAllResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List versionAllResponseDescriptor = $convert.base64Decode(
    'ChJWZXJzaW9uQWxsUmVzcG9uc2USPgoGcmVzdWx0GAEgAygLMiYucmF6bWFuYWdlci5wcm90b2'
    'J1Zi5wdWJsaWMudjEuVmVyc2lvblIGcmVzdWx0');

@$core.Deprecated('Use versionNewerRequestDescriptor instead')
const VersionNewerRequest$json = {
  '1': 'VersionNewerRequest',
  '2': [
    {
      '1': 'version_platform_id',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.razmanager.protobuf.public.v1.VersionPlatformId',
      '10': 'versionPlatformId'
    },
    {
      '1': 'current_version_major',
      '3': 2,
      '4': 1,
      '5': 13,
      '10': 'currentVersionMajor'
    },
    {
      '1': 'current_version_minor',
      '3': 3,
      '4': 1,
      '5': 13,
      '10': 'currentVersionMinor'
    },
    {
      '1': 'current_version_patch',
      '3': 4,
      '4': 1,
      '5': 13,
      '10': 'currentVersionPatch'
    },
    {
      '1': 'confirmed_version_major',
      '3': 5,
      '4': 1,
      '5': 13,
      '10': 'confirmedVersionMajor'
    },
    {
      '1': 'confirmed_version_minor',
      '3': 6,
      '4': 1,
      '5': 13,
      '10': 'confirmedVersionMinor'
    },
    {
      '1': 'confirmed_version_patch',
      '3': 7,
      '4': 1,
      '5': 13,
      '10': 'confirmedVersionPatch'
    },
  ],
};

/// Descriptor for `VersionNewerRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List versionNewerRequestDescriptor = $convert.base64Decode(
    'ChNWZXJzaW9uTmV3ZXJSZXF1ZXN0EmAKE3ZlcnNpb25fcGxhdGZvcm1faWQYASABKA4yMC5yYX'
    'ptYW5hZ2VyLnByb3RvYnVmLnB1YmxpYy52MS5WZXJzaW9uUGxhdGZvcm1JZFIRdmVyc2lvblBs'
    'YXRmb3JtSWQSMgoVY3VycmVudF92ZXJzaW9uX21ham9yGAIgASgNUhNjdXJyZW50VmVyc2lvbk'
    '1ham9yEjIKFWN1cnJlbnRfdmVyc2lvbl9taW5vchgDIAEoDVITY3VycmVudFZlcnNpb25NaW5v'
    'chIyChVjdXJyZW50X3ZlcnNpb25fcGF0Y2gYBCABKA1SE2N1cnJlbnRWZXJzaW9uUGF0Y2gSNg'
    'oXY29uZmlybWVkX3ZlcnNpb25fbWFqb3IYBSABKA1SFWNvbmZpcm1lZFZlcnNpb25NYWpvchI2'
    'Chdjb25maXJtZWRfdmVyc2lvbl9taW5vchgGIAEoDVIVY29uZmlybWVkVmVyc2lvbk1pbm9yEj'
    'YKF2NvbmZpcm1lZF92ZXJzaW9uX3BhdGNoGAcgASgNUhVjb25maXJtZWRWZXJzaW9uUGF0Y2g=');

@$core.Deprecated('Use versionNewerResponseDescriptor instead')
const VersionNewerResponse$json = {
  '1': 'VersionNewerResponse',
  '2': [
    {
      '1': 'result',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.razmanager.protobuf.public.v1.Version',
      '10': 'result'
    },
    {
      '1': 'current_version_valid',
      '3': 2,
      '4': 1,
      '5': 8,
      '10': 'currentVersionValid'
    },
  ],
};

/// Descriptor for `VersionNewerResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List versionNewerResponseDescriptor = $convert.base64Decode(
    'ChRWZXJzaW9uTmV3ZXJSZXNwb25zZRI+CgZyZXN1bHQYASADKAsyJi5yYXptYW5hZ2VyLnByb3'
    'RvYnVmLnB1YmxpYy52MS5WZXJzaW9uUgZyZXN1bHQSMgoVY3VycmVudF92ZXJzaW9uX3ZhbGlk'
    'GAIgASgIUhNjdXJyZW50VmVyc2lvblZhbGlk');
