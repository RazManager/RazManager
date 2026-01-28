import '../../protobuf/razmanager/protobuf/public/device_configuration_input_type_id.v1.pbenum.dart';

class DeviceConfigurationInputType {
  DeviceConfigurationInputType({required this.id, required this.name});

  final DeviceConfigurationInputTypeId id;
  final String name;

  static DeviceConfigurationInputType fromDeviceConfigurationInputTypeId(DeviceConfigurationInputTypeId value) {
    return DeviceConfigurationInputTypes.all.singleWhere((x) => x.id == value);
  }
}

class DeviceConfigurationInputTypes {
  static Iterable<DeviceConfigurationInputType> all = [
    DeviceConfigurationInputType(
        id: DeviceConfigurationInputTypeId.DEVICE_CONFIGURATION_INPUT_TYPE_ID_START_FINISH_INDICATOR,
        name: 'Start/finish indicator'),
    DeviceConfigurationInputType(
        id: DeviceConfigurationInputTypeId.DEVICE_CONFIGURATION_INPUT_TYPE_ID_SECTOR_1_FINISH_INDICATOR,
        name: 'Sector 1 finish indicator'),
    DeviceConfigurationInputType(
        id: DeviceConfigurationInputTypeId.DEVICE_CONFIGURATION_INPUT_TYPE_ID_SECTOR_2_FINISH_INDICATOR,
        name: 'Sector 2 finish indicator'),
    DeviceConfigurationInputType(
        id: DeviceConfigurationInputTypeId.DEVICE_CONFIGURATION_INPUT_TYPE_ID_SPEED_TRAP_START_INDICATOR,
        name: 'Speed trap start indicator'),
    DeviceConfigurationInputType(
        id: DeviceConfigurationInputTypeId.DEVICE_CONFIGURATION_INPUT_TYPE_ID_SPEED_TRAP_FINISH_INDICATOR,
        name: 'Speed trap finish indicator'),
    DeviceConfigurationInputType(
        id: DeviceConfigurationInputTypeId.DEVICE_CONFIGURATION_INPUT_TYPE_ID_EXTRA_INDICATOR,
        name: 'Extra function indicator'),
    DeviceConfigurationInputType(
        id: DeviceConfigurationInputTypeId.DEVICE_CONFIGURATION_INPUT_TYPE_ID_PITLANE_ENTRY, name: 'Pitlane entry'),
    DeviceConfigurationInputType(
        id: DeviceConfigurationInputTypeId.DEVICE_CONFIGURATION_INPUT_TYPE_ID_PITLANE_EXIT, name: 'Pitlane exit'),
    DeviceConfigurationInputType(
        id: DeviceConfigurationInputTypeId.DEVICE_CONFIGURATION_INPUT_TYPE_ID_PITSTOP_ENTRY, name: 'Pitstop entry'),
    DeviceConfigurationInputType(
        id: DeviceConfigurationInputTypeId.DEVICE_CONFIGURATION_INPUT_TYPE_ID_PITSTOP_EXIT, name: 'Pitstop exit'),
    DeviceConfigurationInputType(
        id: DeviceConfigurationInputTypeId.DEVICE_CONFIGURATION_INPUT_TYPE_ID_CONTROLLER_ON, name: 'Controller on'),
    DeviceConfigurationInputType(
        id: DeviceConfigurationInputTypeId.DEVICE_CONFIGURATION_INPUT_TYPE_ID_CONTROLLER_BATTERY_OK,
        name: 'Controller battery OK'),
    DeviceConfigurationInputType(
        id: DeviceConfigurationInputTypeId.DEVICE_CONFIGURATION_INPUT_TYPE_ID_ENERGY, name: 'Energy'),
    DeviceConfigurationInputType(
        id: DeviceConfigurationInputTypeId.DEVICE_CONFIGURATION_INPUT_TYPE_ID_BRAKE, name: 'Brake button'),
    DeviceConfigurationInputType(
        id: DeviceConfigurationInputTypeId.DEVICE_CONFIGURATION_INPUT_TYPE_ID_LANE_CHANGE, name: 'Lane change button'),
    DeviceConfigurationInputType(
        id: DeviceConfigurationInputTypeId.DEVICE_CONFIGURATION_INPUT_TYPE_ID_LANE_CHANGE_UP,
        name: 'Lane change up button'),
    DeviceConfigurationInputType(
        id: DeviceConfigurationInputTypeId.DEVICE_CONFIGURATION_INPUT_TYPE_ID_LANE_CHANGE_DOWN,
        name: 'Lane change down button'),
    DeviceConfigurationInputType(
        id: DeviceConfigurationInputTypeId.DEVICE_CONFIGURATION_INPUT_TYPE_ID_LANE_CHANGE_DOUBLE_TAPPED,
        name: 'Lane change button double tapped'),
    DeviceConfigurationInputType(
        id: DeviceConfigurationInputTypeId.DEVICE_CONFIGURATION_INPUT_TYPE_ID_CAR_ON_TRACK,
        name: 'Car is on the track'),
    DeviceConfigurationInputType(
        id: DeviceConfigurationInputTypeId.DEVICE_CONFIGURATION_INPUT_TYPE_ID_YELLOW, name: 'Yellow flag'),
    DeviceConfigurationInputType(
        id: DeviceConfigurationInputTypeId.DEVICE_CONFIGURATION_INPUT_TYPE_ID_RED, name: 'Red flag'),
    DeviceConfigurationInputType(
        id: DeviceConfigurationInputTypeId.DEVICE_CONFIGURATION_INPUT_TYPE_ID_POWER_OVERLOAD, name: 'Power overload')
  ];
}
