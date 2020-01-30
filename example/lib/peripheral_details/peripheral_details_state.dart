import 'package:blemulator_example/model/ble_peripheral.dart';
import 'package:blemulator_example/model/ble_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class PeripheralDetailsState extends Equatable {
  final BlePeripheral peripheral;
  final List<BleServiceState> bleServiceStates;

  const PeripheralDetailsState(
      {@required this.peripheral, this.bleServiceStates = const []});

  @override
  List<Object> get props => [peripheral, bleServiceStates];
}

class BleServiceState extends Equatable {
  final BleService service;
  final bool expanded;

  @override
  List<Object> get props => [service, expanded];

  BleServiceState({@required this.service, @required this.expanded});
}