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
  static const DeviceIntegrationTypeId DEVICE_INTEGRATION_TYPE_ID_CHRONO_LOG =
      DeviceIntegrationTypeId._(
          100, _omitEnumNames ? '' : 'DEVICE_INTEGRATION_TYPE_ID_CHRONO_LOG');

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
    DEVICE_INTEGRATION_TYPE_ID_CHRONO_LOG,
  ];

  static final $core.Map<$core.int, DeviceIntegrationTypeId> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static DeviceIntegrationTypeId? valueOf($core.int value) => _byValue[value];

  const DeviceIntegrationTypeId._(super.value, super.name);
}

class OxigenRxLapTimeTypeId extends $pb.ProtobufEnum {
  static const OxigenRxLapTimeTypeId OXIGEN_RX_LAP_TIME_TYPE_ID_NONE =
      OxigenRxLapTimeTypeId._(
          0, _omitEnumNames ? '' : 'OXIGEN_RX_LAP_TIME_TYPE_ID_NONE');
  static const OxigenRxLapTimeTypeId OXIGEN_RX_LAP_TIME_TYPE_ID_CONTROLLER =
      OxigenRxLapTimeTypeId._(
          1, _omitEnumNames ? '' : 'OXIGEN_RX_LAP_TIME_TYPE_ID_CONTROLLER');
  static const OxigenRxLapTimeTypeId OXIGEN_RX_LAP_TIME_TYPE_ID_TIMER =
      OxigenRxLapTimeTypeId._(
          2, _omitEnumNames ? '' : 'OXIGEN_RX_LAP_TIME_TYPE_ID_TIMER');

  static const $core.List<OxigenRxLapTimeTypeId> values =
      <OxigenRxLapTimeTypeId>[
    OXIGEN_RX_LAP_TIME_TYPE_ID_NONE,
    OXIGEN_RX_LAP_TIME_TYPE_ID_CONTROLLER,
    OXIGEN_RX_LAP_TIME_TYPE_ID_TIMER,
  ];

  static final $core.List<OxigenRxLapTimeTypeId?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static OxigenRxLapTimeTypeId? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const OxigenRxLapTimeTypeId._(super.value, super.name);
}

class OxigenTxPitLaneLapCountingTypeId extends $pb.ProtobufEnum {
  static const OxigenTxPitLaneLapCountingTypeId
      OXIGEN_TX_PIT_LANE_LAP_COUNTING_TYPE_ID_ENABLED =
      OxigenTxPitLaneLapCountingTypeId._(
          0,
          _omitEnumNames
              ? ''
              : 'OXIGEN_TX_PIT_LANE_LAP_COUNTING_TYPE_ID_ENABLED');
  static const OxigenTxPitLaneLapCountingTypeId
      OXIGEN_TX_PIT_LANE_LAP_COUNTING_TYPE_ID_DISABLED =
      OxigenTxPitLaneLapCountingTypeId._(
          1,
          _omitEnumNames
              ? ''
              : 'OXIGEN_TX_PIT_LANE_LAP_COUNTING_TYPE_ID_DISABLED');

  static const $core.List<OxigenTxPitLaneLapCountingTypeId> values =
      <OxigenTxPitLaneLapCountingTypeId>[
    OXIGEN_TX_PIT_LANE_LAP_COUNTING_TYPE_ID_ENABLED,
    OXIGEN_TX_PIT_LANE_LAP_COUNTING_TYPE_ID_DISABLED,
  ];

  static final $core.List<OxigenTxPitLaneLapCountingTypeId?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static OxigenTxPitLaneLapCountingTypeId? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const OxigenTxPitLaneLapCountingTypeId._(super.value, super.name);
}

class OxigenTxPitLaneLapTriggerTypeId extends $pb.ProtobufEnum {
  static const OxigenTxPitLaneLapTriggerTypeId
      OXIGEN_TX_PIT_LANE_LAP_TRIGGER_TYPE_ID_UNDEFINED =
      OxigenTxPitLaneLapTriggerTypeId._(
          0,
          _omitEnumNames
              ? ''
              : 'OXIGEN_TX_PIT_LANE_LAP_TRIGGER_TYPE_ID_UNDEFINED');
  static const OxigenTxPitLaneLapTriggerTypeId
      OXIGEN_TX_PIT_LANE_LAP_TRIGGER_TYPE_ID_PIT_LANE_ENTRY =
      OxigenTxPitLaneLapTriggerTypeId._(
          1,
          _omitEnumNames
              ? ''
              : 'OXIGEN_TX_PIT_LANE_LAP_TRIGGER_TYPE_ID_PIT_LANE_ENTRY');
  static const OxigenTxPitLaneLapTriggerTypeId
      OXIGEN_TX_PIT_LANE_LAP_TRIGGER_TYPE_ID_PIT_LANE_EXIT =
      OxigenTxPitLaneLapTriggerTypeId._(
          2,
          _omitEnumNames
              ? ''
              : 'OXIGEN_TX_PIT_LANE_LAP_TRIGGER_TYPE_ID_PIT_LANE_EXIT');

  static const $core.List<OxigenTxPitLaneLapTriggerTypeId> values =
      <OxigenTxPitLaneLapTriggerTypeId>[
    OXIGEN_TX_PIT_LANE_LAP_TRIGGER_TYPE_ID_UNDEFINED,
    OXIGEN_TX_PIT_LANE_LAP_TRIGGER_TYPE_ID_PIT_LANE_ENTRY,
    OXIGEN_TX_PIT_LANE_LAP_TRIGGER_TYPE_ID_PIT_LANE_EXIT,
  ];

  static final $core.List<OxigenTxPitLaneLapTriggerTypeId?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static OxigenTxPitLaneLapTriggerTypeId? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const OxigenTxPitLaneLapTriggerTypeId._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
