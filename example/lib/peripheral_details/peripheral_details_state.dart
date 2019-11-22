import 'package:blemulator_example/model/ble_peripheral.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class PeripheralDetailsState extends Equatable {
  final BlePeripheral peripheral;

  const PeripheralDetailsState({@required this.peripheral});

  @override
  List<Object> get props => [peripheral];
}
