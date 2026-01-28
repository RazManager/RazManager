// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/io/system_information.proto.

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

@$core.Deprecated('Use systemInformationReadDescriptor instead')
const SystemInformationRead$json = {
  '1': 'SystemInformationRead',
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
    {
      '1': 'network_ip_addresses',
      '3': 8,
      '4': 3,
      '5': 9,
      '10': 'networkIpAddresses'
    },
  ],
};

/// Descriptor for `SystemInformationRead`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List systemInformationReadDescriptor = $convert.base64Decode(
    'ChVTeXN0ZW1JbmZvcm1hdGlvblJlYWQSQwoOaGFyZHdhcmVfbW9kZWwYASABKAsyHC5nb29nbG'
    'UucHJvdG9idWYuU3RyaW5nVmFsdWVSDWhhcmR3YXJlTW9kZWwSSwoSaGFyZHdhcmVfcHJvY2Vz'
    'c29yGAIgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUhFoYXJkd2FyZVByb2Nlc3'
    'NvchJYChlzb2Z0d2FyZV9hc3NlbWJseV92ZXJzaW9uGAMgASgLMhwuZ29vZ2xlLnByb3RvYnVm'
    'LlN0cmluZ1ZhbHVlUhdzb2Z0d2FyZUFzc2VtYmx5VmVyc2lvbhJQChVzb2Z0d2FyZV9zbmFwX3'
    'ZlcnNpb24YBCABKAsyHC5nb29nbGUucHJvdG9idWYuU3RyaW5nVmFsdWVSE3NvZnR3YXJlU25h'
    'cFZlcnNpb24SVQoYc29mdHdhcmVfZG90X25ldF92ZXJzaW9uGAUgASgLMhwuZ29vZ2xlLnByb3'
    'RvYnVmLlN0cmluZ1ZhbHVlUhVzb2Z0d2FyZURvdE5ldFZlcnNpb24STAoTc29mdHdhcmVfb3Nf'
    'dmVyc2lvbhgGIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZVIRc29mdHdhcmVPc1'
    'ZlcnNpb24SWwobc29mdHdhcmVfb3NfcmVsZWFzZV92ZXJzaW9uGAcgASgLMhwuZ29vZ2xlLnBy'
    'b3RvYnVmLlN0cmluZ1ZhbHVlUhhzb2Z0d2FyZU9zUmVsZWFzZVZlcnNpb24SMAoUbmV0d29ya1'
    '9pcF9hZGRyZXNzZXMYCCADKAlSEm5ldHdvcmtJcEFkZHJlc3Nlcw==');
