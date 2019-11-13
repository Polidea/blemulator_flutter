import 'package:blemulator_example/model/ble_device.dart';
import 'package:equatable/equatable.dart';

abstract class PeripheralListState extends Equatable {
  const PeripheralListState();
}

class InitialPeripheralListState extends PeripheralListState {
  @override
  List<Object> get props => [];
}

class ScanningStarted extends PeripheralListState {
  @override
  List<Object> get props => [];
}

class PeripheralListUpdated extends PeripheralListState {
  final List<BleDevice> blePeripheral;

  PeripheralListUpdated(this.blePeripheral);

  @override
  List<Object> get props => [blePeripheral];
}

class ScanningStopped extends PeripheralListState {
  @override
  List<Object> get props => [];
}

class ScanningError extends PeripheralListState {
  final String message;

  const ScanningError(this.message);

  @override
  List<Object> get props => [message];
}
