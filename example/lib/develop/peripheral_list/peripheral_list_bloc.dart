import 'dart:async';
import 'package:blemulator_example/develop/model/ble_peripheral.dart';
import 'package:blemulator_example/develop/repository/peripheral_list_repository.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PeripheralListBloc
    extends Bloc<PeripheralListEvent, PeripheralListState> {
  List<BlePeripheral> _peripherals = <BlePeripheral>[];
  bool _scanningEnabled = false;
  PeripheralListRepository _peripheralListRepository;

  PeripheralListBloc(this._peripheralListRepository);

  @override
  PeripheralListState get initialState =>
      PeripheralListState(_peripherals, _scanningEnabled);

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
    _peripheralListRepository.startPeripheralScan(
        scanEventOutput: (BlePeripheral peripheral) {
      add(NewPeripheralScan(peripheral));
    });
    _setScanningEnabled(true);
    yield PeripheralListState(_peripherals, _scanningEnabled);
  }

  Stream<PeripheralListState> _mapStopPeripheralScanToState(
      StopPeripheralScan event) async* {
    await _peripheralListRepository.stopPeripheralScan();
    _setScanningEnabled(false);
    yield PeripheralListState(_peripherals, _scanningEnabled);
  }

  Stream<PeripheralListState> _mapNewPeripheralScanToState(
      NewPeripheralScan event) async* {
    if (!_peripherals.contains(event.peripheral)) {
      _peripherals.add(event.peripheral);
    } else {
      // TODO: - since we are using RSSI on the list screen,
      // we should replace exisiting peripheral with the newly received one
    }
    yield PeripheralListState(_peripherals, _scanningEnabled);
  }

  void _setScanningEnabled(bool scanningEnabled) {
    _scanningEnabled = scanningEnabled;
  }

  void _clearPeripherals() {
    _peripherals.clear();
  }

  @override
  Future<void> close() {
    _peripheralListRepository.dispose();
    return super.close();
  }
}
