import 'package:blemulator_example/develop/model/ble_peripheral.dart';

class PeripheralListState {
  final List<BlePeripheral> peripherals;
  final bool scanningEnabled;

  const PeripheralListState(this.peripherals, this.scanningEnabled);
}