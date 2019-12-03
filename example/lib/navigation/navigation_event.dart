import 'package:blemulator_example/model/ble_peripheral.dart';
import 'package:equatable/equatable.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class Pop extends NavigationEvent {}

class NavigateToPeripheralDetails extends NavigationEvent {
  final BlePeripheral peripheral;

  const NavigateToPeripheralDetails({this.peripheral});

  @override
  List<Object> get props => [peripheral];
}