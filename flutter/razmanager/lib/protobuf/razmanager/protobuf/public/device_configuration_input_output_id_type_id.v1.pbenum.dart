// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/device_configuration_input_output_id_type_id.v1.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class DeviceConfigurationInputOutputIdTypeId extends $pb.ProtobufEnum {
  static const DeviceConfigurationInputOutputIdTypeId
      DEVICE_CONFIGURATION_INPUT_OUTPUT_ID_TYPE_ID_REQUIRED =
      DeviceConfigurationInputOutputIdTypeId._(
          0,
          _omitEnumNames
              ? ''
              : 'DEVICE_CONFIGURATION_INPUT_OUTPUT_ID_TYPE_ID_REQUIRED');
  static const DeviceConfigurationInputOutputIdTypeId
      DEVICE_CONFIGURATION_INPUT_OUTPUT_ID_TYPE_ID_OPTIONAL =
      DeviceConfigurationInputOutputIdTypeId._(
          1,
          _omitEnumNames
              ? ''
              : 'DEVICE_CONFIGURATION_INPUT_OUTPUT_ID_TYPE_ID_OPTIONAL');
  static const DeviceConfigurationInputOutputIdTypeId
      DEVICE_CONFIGURATION_INPUT_OUTPUT_ID_TYPE_ID_NONE =
      DeviceConfigurationInputOutputIdTypeId._(
          2,
          _omitEnumNames
              ? ''
              : 'DEVICE_CONFIGURATION_INPUT_OUTPUT_ID_TYPE_ID_NONE');

  static const $core.List<DeviceConfigurationInputOutputIdTypeId> values =
      <DeviceConfigurationInputOutputIdTypeId>[
    DEVICE_CONFIGURATION_INPUT_OUTPUT_ID_TYPE_ID_REQUIRED,
    DEVICE_CONFIGURATION_INPUT_OUTPUT_ID_TYPE_ID_OPTIONAL,
    DEVICE_CONFIGURATION_INPUT_OUTPUT_ID_TYPE_ID_NONE,
  ];

  static final $core.List<DeviceConfigurationInputOutputIdTypeId?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static DeviceConfigurationInputOutputIdTypeId? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const DeviceConfigurationInputOutputIdTypeId._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
