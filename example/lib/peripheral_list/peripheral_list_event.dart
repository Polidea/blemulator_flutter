import 'package:blemulator_example/model/ble_peripheral.dart';

abstract class PeripheralListEvent {
  const PeripheralListEvent();
}

class StartPeripheralScan extends PeripheralListEvent {}

class StopPeripheralScan extends PeripheralListEvent {}

class NewPeripheralScan extends PeripheralListEvent {
  final BlePeripheral peripheral;

  const NewPeripheralScan(this.peripheral);
}

class PickPeripheral extends PeripheralListEvent {
  final BlePeripheral peripheral;

  const PickPeripheral(this.peripheral);
}