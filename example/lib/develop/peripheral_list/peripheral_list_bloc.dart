import 'dart:async';
import 'package:blemulator_example/develop/model/ble_peripheral.dart';
import 'package:blemulator_example/develop/adapter/ble_adapter.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PeripheralListBloc
    extends Bloc<PeripheralListEvent, PeripheralListState> {
  BleAdapter _bleAdapter;

  PeripheralListBloc(this._bleAdapter);

  @override
  PeripheralListState get initialState => PeripheralListState([], false);

  @override
  Stream<PeripheralListState> mapEventToState(
    PeripheralListEvent event,
  ) async* {
    if (event is StartPeripheralScan) {
      yield* _mapStartPeripheralScanToState(event);
    } else if (event is StopPeripheralScan) {
      yield* _mapStopPeripheralScanToState(event);
    } else if (event is NewPeripheralScan) {
      yield* _mapNewPeripheralScanToState(event);
    } else if (event is PickPeripheral) {
      // TODO: Logic to pick a device
    } else if (event is ConnectToPeripheral) {
      // TODO: Logic to connect to device
    } else if (event is DisconnectFromPeripheral) {
      // TODO: Logic to disconnect from device
    }
  }

  Stream<PeripheralListState> _mapStartPeripheralScanToState(
      StartPeripheralScan event) async* {
    _bleAdapter.startPeripheralScan((BlePeripheral peripheral) {
      add(NewPeripheralScan(peripheral));
    });
    yield PeripheralListState(state.peripherals, true);
  }

  Stream<PeripheralListState> _mapStopPeripheralScanToState(
      StopPeripheralScan event) async* {
    await _bleAdapter.stopPeripheralScan();
    yield PeripheralListState(state.peripherals, false);
  }

  Stream<PeripheralListState> _mapNewPeripheralScanToState(
      NewPeripheralScan event) async* {
    List<BlePeripheral> updatedPeripherals = state.peripherals;
    if (!updatedPeripherals.contains(event.peripheral)) {
      updatedPeripherals = List.from(state.peripherals);
      updatedPeripherals.add(event.peripheral);
    } else {
      // TODO: - since we are using RSSI on the list screen,
      // we should replace exisiting peripheral with the newly received one
    }
    yield PeripheralListState(updatedPeripherals, state.scanningEnabled);
  }

  @override
  Future<void> close() {
    _bleAdapter.dispose();
    return super.close();
  }
}
