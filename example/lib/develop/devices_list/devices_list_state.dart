import 'package:blemulator_example/model/ble_device.dart';
import 'package:equatable/equatable.dart';

abstract class DevicesListState extends Equatable {
  const DevicesListState();
}

class InitialDevicesListState extends DevicesListState {
  @override
  List<Object> get props => [];
}

class ScanningStarted extends DevicesListState {
  @override
  List<Object> get props => [];
}

class DevicesListUpdated extends DevicesListState {
  final List<BleDevice> bleDevices;

  DevicesListUpdated(this.bleDevices);

  @override
  List<Object> get props => [bleDevices];
}

class ScanningStopped extends DevicesListState {
  @override
  List<Object> get props => [];
}

class ScanningError extends DevicesListState {
  final String message;

  const ScanningError(this.message);

  @override
  List<Object> get props => [message];
}
