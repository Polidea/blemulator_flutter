import 'package:blemulator_example/model/ble_peripheral.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class PeripheralDetailsState extends Equatable {
  final BlePeripheral peripheral;
  final MtuRequestState mtuRequestState;

  const PeripheralDetailsState({
    @required this.peripheral,
    @required this.mtuRequestState}
  );

  @override
  List<Object> get props => [peripheral, mtuRequestState];
}

class MtuRequestState extends Equatable {
  final bool showMtuDialog;
  final bool ongoingMtuRequest;

  const MtuRequestState({
    this.ongoingMtuRequest = false,
    this.showMtuDialog = false
  });

  @override
  List<Object> get props => [ongoingMtuRequest, showMtuDialog];
}
