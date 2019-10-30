import 'dart:convert';

import 'package:blemulator/blemulator.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:blemulator_example/main.dart' as app;


import 'Command.dart';
import 'advance_sensor_tag.dart';
import 'basic_sensor_tag.dart';
import 'peripherals.dart';
import 'test_simulated_peripheral.dart';



void main() {

  SimulatedPeripheral basicSensorTag = BasicSensorTag(id: "12:12:12:12:12:11");
  SimulatedPeripheral advancedSensorTag = AdvancedSensorTag(id: "12:12:12:12:12:22");
  SimulatedPeripheral unconnectableSensorTag = UnconnectableSensorTag(id: "12:12:12:12:12:33");

  var peripherals = [basicSensorTag, advancedSensorTag, unconnectableSensorTag];

  Future<String> dataHandler(String msg) async {
    DeviceCommand deviceCommand = DeviceCommand.fromMappedJson(jsonDecode(msg));
    SimulatedPeripheral simulatedPeripheral = peripherals.firstWhere((peripheral) => peripheral.id == deviceCommand.deviceId);
    (simulatedPeripheral as CommandHandlerInterface).handleDeviceCommand(deviceCommand);
  }

  // This line enables the extension.
  enableFlutterDriverExtension(handler: dataHandler);

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main(peripherals: peripherals);
}