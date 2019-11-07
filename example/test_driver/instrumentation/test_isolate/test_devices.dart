

import 'dart:convert';

import 'package:flutter_driver/flutter_driver.dart';

import '../Command.dart';

class TestDevice {
  String deviceId;

  TestDevice(this.deviceId);

  disconnect(FlutterDriver driver) {
    var command = DeviceCommand(CommandType.DISCONNECT, deviceId);
    driver.requestData(jsonEncode(command));
  }
}

TestDevice unconnectablePeripheralStub = TestDevice("1");
TestDevice sensorTagWithDelayedDisconnectStub = TestDevice("2");
TestDevice sensorStagStub = TestDevice("3");