import 'package:blemulator_example/model/ble_peripheral.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';

class SampleBlePeripheral extends BlePeripheral {
  SampleBlePeripheral({
    String name = 'Sample peripheral',
    String id = 'peripheral id',
    int rssi = -30,
    PeripheralConnectionState connectionState =
        PeripheralConnectionState.disconnected,
  }) : super(name, id, rssi, connectionState,
            BlePeripheralCategoryResolver.categoryForName(name));

  SampleBlePeripheral.different({
    String name = 'Different sample peripheral',
    String id = 'different peripheral id',
    int rssi = -30,
    PeripheralConnectionState connectionState =
        PeripheralConnectionState.disconnected,
  }) : super(name, id, rssi, connectionState,
            BlePeripheralCategoryResolver.categoryForName(name));
}
