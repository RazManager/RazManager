// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/device_request_response.v1.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class DeviceIntegrationTypeId extends $pb.ProtobufEnum {
  static const DeviceIntegrationTypeId DEVICE_INTEGRATION_TYPE_ID_UNDEFINED =
      DeviceIntegrationTypeId._(
          0, _omitEnumNames ? '' : 'DEVICE_INTEGRATION_TYPE_ID_UNDEFINED');
  static const DeviceIntegrationTypeId DEVICE_INTEGRATION_TYPE_ID_GPIO =
      DeviceIntegrationTypeId._(
          1, _omitEnumNames ? '' : 'DEVICE_INTEGRATION_TYPE_ID_GPIO');
  static const DeviceIntegrationTypeId DEVICE_INTEGRATION_TYPE_ID_OXIGEN =
      DeviceIntegrationTypeId._(
          2, _omitEnumNames ? '' : 'DEVICE_INTEGRATION_TYPE_ID_OXIGEN');
  static const DeviceIntegrationTypeId
      DEVICE_INTEGRATION_TYPE_ID_SCALEXTRIC_ARC = DeviceIntegrationTypeId._(
          3, _omitEnumNames ? '' : 'DEVICE_INTEGRATION_TYPE_ID_SCALEXTRIC_ARC');
  static const DeviceIntegrationTypeId
      DEVICE_INTEGRATION_TYPE_ID_SCALEXTRIC_APB = DeviceIntegrationTypeId._(
          4, _omitEnumNames ? '' : 'DEVICE_INTEGRATION_TYPE_ID_SCALEXTRIC_APB');
  static const DeviceIntegrationTypeId
      DEVICE_INTEGRATION_TYPE_ID_SCALEXTRIC_PIT_PRO = DeviceIntegrationTypeId._(
          5,
          _omitEnumNames
              ? ''
              : 'DEVICE_INTEGRATION_TYPE_ID_SCALEXTRIC_PIT_PRO');
  static const DeviceIntegrationTypeId DEVICE_INTEGRATION_TYPE_ID_PHILIPS_HUE =
      DeviceIntegrationTypeId._(
          6, _omitEnumNames ? '' : 'DEVICE_INTEGRATION_TYPE_ID_PHILIPS_HUE');
  static const DeviceIntegrationTypeId DEVICE_INTEGRATION_TYPE_ID_RGB =
      DeviceIntegrationTypeId._(
          7, _omitEnumNames ? '' : 'DEVICE_INTEGRATION_TYPE_ID_RGB');
  static const DeviceIntegrationTypeId DEVICE_INTEGRATION_TYPE_ID_LAP_MASTER =
      DeviceIntegrationTypeId._(
          8, _omitEnumNames ? '' : 'DEVICE_INTEGRATION_TYPE_ID_LAP_MASTER');

  static const $core.List<DeviceIntegrationTypeId> values =
      <DeviceIntegrationTypeId>[
    DEVICE_INTEGRATION_TYPE_ID_UNDEFINED,
    DEVICE_INTEGRATION_TYPE_ID_GPIO,
    DEVICE_INTEGRATION_TYPE_ID_OXIGEN,
    DEVICE_INTEGRATION_TYPE_ID_SCALEXTRIC_ARC,
    DEVICE_INTEGRATION_TYPE_ID_SCALEXTRIC_APB,
    DEVICE_INTEGRATION_TYPE_ID_SCALEXTRIC_PIT_PRO,
    DEVICE_INTEGRATION_TYPE_ID_PHILIPS_HUE,
    DEVICE_INTEGRATION_TYPE_ID_RGB,
    DEVICE_INTEGRATION_TYPE_ID_LAP_MASTER,
  ];

  static final $core.List<DeviceIntegrationTypeId?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 8);
  static DeviceIntegrationTypeId? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const DeviceIntegrationTypeId._(super.value, super.name);
}

class OxigenTxPitlaneLapCountingTypeId extends $pb.ProtobufEnum {
  static const OxigenTxPitlaneLapCountingTypeId
      OXIGEN_TX_PIT_LANE_LAP_COUNTING_TYPE_ID_ENABLED =
      OxigenTxPitlaneLapCountingTypeId._(
          0,
          _omitEnumNames
              ? ''
              : 'OXIGEN_TX_PIT_LANE_LAP_COUNTING_TYPE_ID_ENABLED');
  static const OxigenTxPitlaneLapCountingTypeId
      OXIGEN_TX_PIT_LANE_LAP_COUNTING_TYPE_ID_DISABLED =
      OxigenTxPitlaneLapCountingTypeId._(
          1,
          _omitEnumNames
              ? ''
              : 'OXIGEN_TX_PIT_LANE_LAP_COUNTING_TYPE_ID_DISABLED');

  static const $core.List<OxigenTxPitlaneLapCountingTypeId> values =
      <OxigenTxPitlaneLapCountingTypeId>[
    OXIGEN_TX_PIT_LANE_LAP_COUNTING_TYPE_ID_ENABLED,
    OXIGEN_TX_PIT_LANE_LAP_COUNTING_TYPE_ID_DISABLED,
  ];

  static final $core.List<OxigenTxPitlaneLapCountingTypeId?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static OxigenTxPitlaneLapCountingTypeId? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const OxigenTxPitlaneLapCountingTypeId._(super.value, super.name);
}

class OxigenTxPitlaneLapTriggerTypeId extends $pb.ProtobufEnum {
  static const OxigenTxPitlaneLapTriggerTypeId
      OXIGEN_TX_PIT_LANE_LAP_TRIGGER_TYPE_ID_UNDEFINED =
      OxigenTxPitlaneLapTriggerTypeId._(
          0,
          _omitEnumNames
              ? ''
              : 'OXIGEN_TX_PIT_LANE_LAP_TRIGGER_TYPE_ID_UNDEFINED');
  static const OxigenTxPitlaneLapTriggerTypeId
      OXIGEN_TX_PIT_LANE_LAP_TRIGGER_TYPE_ID_PIT_LANE_ENTRY =
      OxigenTxPitlaneLapTriggerTypeId._(
          1,
          _omitEnumNames
              ? ''
              : 'OXIGEN_TX_PIT_LANE_LAP_TRIGGER_TYPE_ID_PIT_LANE_ENTRY');
  static const OxigenTxPitlaneLapTriggerTypeId
      OXIGEN_TX_PIT_LANE_LAP_TRIGGER_TYPE_ID_PIT_LANE_EXIT =
      OxigenTxPitlaneLapTriggerTypeId._(
          2,
          _omitEnumNames
              ? ''
              : 'OXIGEN_TX_PIT_LANE_LAP_TRIGGER_TYPE_ID_PIT_LANE_EXIT');

  static const $core.List<OxigenTxPitlaneLapTriggerTypeId> values =
      <OxigenTxPitlaneLapTriggerTypeId>[
    OXIGEN_TX_PIT_LANE_LAP_TRIGGER_TYPE_ID_UNDEFINED,
    OXIGEN_TX_PIT_LANE_LAP_TRIGGER_TYPE_ID_PIT_LANE_ENTRY,
    OXIGEN_TX_PIT_LANE_LAP_TRIGGER_TYPE_ID_PIT_LANE_EXIT,
  ];

  static final $core.List<OxigenTxPitlaneLapTriggerTypeId?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static OxigenTxPitlaneLapTriggerTypeId? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const OxigenTxPitlaneLapTriggerTypeId._(super.value, super.name);
}

class OxigenRxLapTimesTypeId extends $pb.ProtobufEnum {
  static const OxigenRxLapTimesTypeId OXIGEN_RX_LAP_TIMES_TYPE_ID_CONTROLLER =
      OxigenRxLapTimesTypeId._(
          0, _omitEnumNames ? '' : 'OXIGEN_RX_LAP_TIMES_TYPE_ID_CONTROLLER');
  static const OxigenRxLapTimesTypeId OXIGEN_RX_LAP_TIMES_TYPE_ID_TIMER =
      OxigenRxLapTimesTypeId._(
          1, _omitEnumNames ? '' : 'OXIGEN_RX_LAP_TIMES_TYPE_ID_TIMER');

  static const $core.List<OxigenRxLapTimesTypeId> values =
      <OxigenRxLapTimesTypeId>[
    OXIGEN_RX_LAP_TIMES_TYPE_ID_CONTROLLER,
    OXIGEN_RX_LAP_TIMES_TYPE_ID_TIMER,
  ];

  static final $core.List<OxigenRxLapTimesTypeId?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static OxigenRxLapTimesTypeId? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const OxigenRxLapTimesTypeId._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
