
import 'package:blemulator/blemulator.dart';

class SimulatedPeripheralBuilder {

  String deviceId = "defaultDeviceId";
  bool isConnected = false;
  int mtu = 11;

  SimulatedPeripheral build() {
    SamplePeripheral samplePeripheral
      = SamplePeripheral(id: deviceId)
        ..mtu = mtu;

    if (isConnected) samplePeripheral.onConnect();

    return samplePeripheral;
  }
}

class SamplePeripheral extends SimulatedPeripheral {
  SamplePeripheral({String id = "4B:99:4C:34:DE:77",
    String name = "SamplePeripheral"})
      : super(id: id, name: name, services: []);
}