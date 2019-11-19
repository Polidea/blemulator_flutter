import 'package:blemulator_example/develop/model/ble_peripheral.dart';

abstract class PeripheralListEvent {
  const PeripheralListEvent();
}

class StartPeripheralScan extends PeripheralListEvent {}

class StopPeripheralScan extends PeripheralListEvent {}

class NewPeripheralScan extends PeripheralListEvent {
  final BlePeripheral peripheral;

  const NewPeripheralScan(this.peripheral);
}