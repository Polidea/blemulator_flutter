import 'package:blemulator_example/model/ble_peripheral.dart';

class SampleBlePeripheral extends BlePeripheral {
  SampleBlePeripheral({
    String name = 'Sample peripheral',
    String id = 'peripheral id',
    int rssi = -30,
    bool isConnected = false,
  }) : super(name, id, rssi, isConnected,
      BlePeripheralCategory.other);

  SampleBlePeripheral.different({
    String name = 'Different sample peripheral',
    String id = 'different peripheral id',
    int rssi = -30,
    bool isConnected = false,
  }) : super(name, id, rssi, isConnected,
      BlePeripheralCategory.other);
}
