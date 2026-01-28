import '../../protobuf/razmanager/protobuf/public/device_configuration_output_type_id.v1.pbenum.dart';

class DeviceConfigurationOutputType {
  DeviceConfigurationOutputType({required this.id, required this.name});

  final DeviceConfigurationOutputTypeId id;
  final String name;

  static DeviceConfigurationOutputType fromDeviceConfigurationOutputTypeId(
      DeviceConfigurationOutputTypeId value) {
    return DeviceConfigurationOutputTypes.all.singleWhere((x) => x.id == value);
  }
}

class DeviceConfigurationOutputTypes {
  static Iterable<DeviceConfigurationOutputType> all = [
    DeviceConfigurationOutputType(
        id: DeviceConfigurationOutputTypeId
            .DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_START_FINISH_INDICATOR,
        name: 'Start/finish indicator'),
    DeviceConfigurationOutputType(
        id: DeviceConfigurationOutputTypeId
            .DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_POWER_ON,
        name: 'Power on'),
    DeviceConfigurationOutputType(
        id: DeviceConfigurationOutputTypeId
            .DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_POWER_YELLOW,
        name: 'Power slow'),
    DeviceConfigurationOutputType(
        id: DeviceConfigurationOutputTypeId
            .DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_POWER_OFF,
        name: 'Power off'),
    DeviceConfigurationOutputType(
        id: DeviceConfigurationOutputTypeId
            .DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_COUNTDOWN_ON,
        name: 'Countdown on'),
    DeviceConfigurationOutputType(
        id: DeviceConfigurationOutputTypeId
            .DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_COUNTDOWN_OFF,
        name: 'Countdown off'),
    DeviceConfigurationOutputType(
        id: DeviceConfigurationOutputTypeId
            .DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_HEAT_GREEN,
        name: 'Heat green'),
    DeviceConfigurationOutputType(
        id: DeviceConfigurationOutputTypeId
            .DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_HEAT_YELLOW,
        name: 'Heat yellow'),
    DeviceConfigurationOutputType(
        id: DeviceConfigurationOutputTypeId
            .DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_HEAT_RED,
        name: 'Heat red'),
    DeviceConfigurationOutputType(
        id: DeviceConfigurationOutputTypeId
            .DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_HEAT_OFF,
        name: 'Heat off'),
    DeviceConfigurationOutputType(
        id: DeviceConfigurationOutputTypeId
            .DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_PITSTOP,
        name: 'Pitstop'),
    DeviceConfigurationOutputType(
        id: DeviceConfigurationOutputTypeId
            .DEVICE_CONFIGURATION_OUTPUT_TYPE_ID_ENERGY_LEVEL,
        name: 'Energy level'),
  ];
}
