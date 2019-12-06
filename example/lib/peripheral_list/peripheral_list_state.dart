import 'dart:collection';

import 'package:blemulator_example/model/ble_peripheral.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class PeripheralListState extends Equatable {
  final Map<String, BlePeripheral> peripherals;
  final bool scanningEnabled;

  const PeripheralListState({@required this.peripherals, @required this.scanningEnabled});

  const PeripheralListState.initial(
      {this.peripherals = const {}, this.scanningEnabled = false});

  @override
  List<Object> get props => [peripherals, scanningEnabled];
}
