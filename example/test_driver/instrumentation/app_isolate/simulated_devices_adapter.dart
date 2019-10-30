import 'dart:convert';

import 'package:blemulator/blemulator.dart';


import '../Command.dart';
import '../test_isolate/test_devices.dart';
import 'simulated_devices/advance_sensor_tag.dart';
import 'simulated_devices/basic_sensor_tag.dart';
import 'simulated_devices/test_simulated_peripheral.dart';
import 'simulated_devices/unconnectable_peripheral.dart';

class SimulatedDevicesAdapter {

  SimulatedPeripheral basicSensorTag = SensorTagWithDelayedDisconnect(sensorTagWithDelayedDisconnectStub.deviceId);
  SimulatedPeripheral advancedSensorTag = SensorTag(sensorStagStub.deviceId);
  SimulatedPeripheral unconnectableSensorTag = UnconnectablePeripheral(unconnectablePeripheralStub.deviceId);

  List<SimulatedPeripheral> peripherals;

  SimulatedDevicesAdapter() {
    peripherals = [basicSensorTag, advancedSensorTag, unconnectableSensorTag];
  }

  Future<String> dataHandler(String msg) async {
    DeviceCommand deviceCommand = DeviceCommand.fromMappedJson(jsonDecode(msg));
    SimulatedPeripheral simulatedPeripheral = peripherals.firstWhere((peripheral) => peripheral.id == deviceCommand.deviceId);
    (simulatedPeripheral as CommandHandlerInterface).handleDeviceCommand(deviceCommand);
  }

}