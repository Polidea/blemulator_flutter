import 'package:blemulator_example/model/ble_peripheral.dart';
import 'package:blemulator_example/model/ble_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class PeripheralDetailsState extends Equatable {
  final BlePeripheral peripheral;
  final List<BleService> bleServices;

  const PeripheralDetailsState(
      {@required this.peripheral, this.bleServices = const []});

  @override
  List<Object> get props => [peripheral, bleServices];
}
