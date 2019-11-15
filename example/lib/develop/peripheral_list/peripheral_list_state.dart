import 'package:blemulator_example/develop/model/ble_peripheral.dart';
import 'package:equatable/equatable.dart';

class PeripheralListState extends Equatable {
  final List<BlePeripheral> peripherals;
  final bool scanningEnabled;

  const PeripheralListState(this.peripherals, this.scanningEnabled);

  @override
  List<Object> get props => [peripherals, scanningEnabled];
}