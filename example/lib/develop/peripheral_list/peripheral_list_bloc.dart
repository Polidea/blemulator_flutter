import 'dart:async';
import 'package:blemulator_example/develop/model/ble_peripheral.dart';
import 'package:blemulator_example/develop/adapter/ble_adapter.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PeripheralListBloc
    extends Bloc<PeripheralListEvent, PeripheralListState> {
  BleAdapter _bleAdapter;
  StreamSubscription _blePeripheralsSubscription;

  PeripheralListBloc(this._bleAdapter);

  @override
  PeripheralListState get initialState => PeripheralListState.initial();

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
    _blePeripheralsSubscription =
        _bleAdapter.startPeripheralScan().listen((BlePeripheral peripheral) {
      add(NewPeripheralScan(peripheral));
    });
    yield PeripheralListState(state.peripherals, true);
  }

  Stream<PeripheralListState> _mapStopPeripheralScanToState(
      StopPeripheralScan event) async* {
    _cancelBlePeripheralSubscription();
    await _bleAdapter.stopPeripheralScan();
    yield PeripheralListState(state.peripherals, false);
  }

  Stream<PeripheralListState> _mapNewPeripheralScanToState(
      NewPeripheralScan event) async* {
    List<BlePeripheral> updatedPeripherals = state.peripherals;
    if (!updatedPeripherals.contains(event.peripheral)) {
      updatedPeripherals = List.from(state.peripherals);
      updatedPeripherals.add(event.peripheral);
    }
    yield PeripheralListState(updatedPeripherals, state.scanningEnabled);
  }

  void _cancelBlePeripheralSubscription() async {
    if (_blePeripheralsSubscription != null) {
      await _blePeripheralsSubscription.cancel();
    }
  }

  @override
  Future<void> close() {
    _cancelBlePeripheralSubscription();
    return super.close();
  }
}
