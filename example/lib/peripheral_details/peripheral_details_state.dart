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

  PeripheralDetailsState.clone(PeripheralDetailsState state, {
    BlePeripheral peripheral,
    MtuRequestState mtuRequestState
  })
    : this(
      peripheral: peripheral ?? state.peripheral,
      mtuRequestState: mtuRequestState ?? state.mtuRequestState,
  );

  @override
  List<Object> get props => [peripheral, mtuRequestState];
}

enum MtuRequestStatus {
  idle,
  ongoing,
  success,
  error
}

class MtuRequestState extends Equatable {
  final bool showMtuDialog;
  final MtuRequestStatus status;

  const MtuRequestState({
    this.showMtuDialog = false,
    this.status = MtuRequestStatus.idle
  });

  MtuRequestState.clone(MtuRequestState state, {
    bool showMtuDialog,
    MtuRequestStatus status
  })
    : this(
      showMtuDialog: showMtuDialog ?? state.showMtuDialog,
      status: status ?? state.status,
  );

  @override
  List<Object> get props => [showMtuDialog, status];
}
