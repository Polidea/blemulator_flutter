import 'dart:async';
import 'package:blemulator_example/model/ble_peripheral.dart';
import 'package:blemulator_example/adapter/ble_adapter.dart';
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
    }
  }

  Stream<PeripheralListState> _mapStartPeripheralScanToState(
      StartPeripheralScan event) async* {
    _cancelBlePeripheralSubscription();
    _blePeripheralsSubscription =
        _bleAdapter.startPeripheralScan().listen((BlePeripheral peripheral) {
      add(NewPeripheralScan(peripheral));
    });
    yield PeripheralListState(
        peripherals: state.peripherals, scanningEnabled: true);
  }

  Stream<PeripheralListState> _mapStopPeripheralScanToState(
      StopPeripheralScan event) async* {
    _cancelBlePeripheralSubscription();
    await _bleAdapter.stopPeripheralScan();
    yield PeripheralListState(
        peripherals: state.peripherals, scanningEnabled: false);
  }

  Stream<PeripheralListState> _mapNewPeripheralScanToState(
      NewPeripheralScan event) async* {
    Map<String, BlePeripheral> updatedPeripherals = state.peripherals;
    String peripheralId = event.peripheral.id;

    if (updatedPeripherals.containsKey(peripheralId)) {
      if (updatedPeripherals[peripheralId] != event.peripheral) {
        updatedPeripherals = Map.from(state.peripherals);
        updatedPeripherals[peripheralId] = event.peripheral;
      }
    } else {
      updatedPeripherals = Map.from(state.peripherals);
      updatedPeripherals.addEntries([MapEntry(peripheralId, event.peripheral)]);
    }
    yield PeripheralListState(
        peripherals: updatedPeripherals,
        scanningEnabled: state.scanningEnabled);
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
