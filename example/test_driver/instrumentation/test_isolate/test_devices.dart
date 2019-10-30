

class TestDevice {
  String deviceId;

  TestDevice(this.deviceId);
}

TestDevice unconnectablePeripheralStub = TestDevice("1");
TestDevice sensorTagWithDelayedDisconnectStub = TestDevice("2");
TestDevice sensorStagStub = TestDevice("3");