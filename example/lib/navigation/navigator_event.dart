import 'package:blemulator_example/model/ble_peripheral.dart';
import 'package:equatable/equatable.dart';

abstract class NavigatorEvent extends Equatable {
  const NavigatorEvent();

  @override
  List<Object> get props => [];
}

class NavigatorPop extends NavigatorEvent {}

class NavigateToPeripheralDetails extends NavigatorEvent {
  final BlePeripheral peripheral;

  const NavigateToPeripheralDetails({this.peripheral});

  @override
  List<Object> get props => [peripheral];
}