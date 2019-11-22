import 'dart:async';
import 'package:blemulator_example/model/ble_peripheral.dart';
import 'package:blemulator_example/adapter/ble_adapter.dart';
import 'package:blemulator_example/repository/peripheral_repository.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PeripheralListBloc
    extends Bloc<PeripheralListEvent, PeripheralListState> {
  BleAdapter _bleAdapter;
  BlePeripheralRepository _blePeripheralRepository;
  StreamSubscription _blePeripheralsSubscription;

  PeripheralListBloc(this._bleAdapter, this._blePeripheralRepository);

  @override
  PeripheralListState get initialState => InitialPeripheralList();

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
      yield* _mapPickPeripheralToState(event);
    }
  }

  Stream<PeripheralListState> _mapStartPeripheralScanToState(
      StartPeripheralScan event) async* {
    _blePeripheralsSubscription =
        _bleAdapter.startPeripheralScan().listen((BlePeripheral peripheral) {
      add(NewPeripheralScan(peripheral));
    });
    yield PeripheralList(peripherals: state.peripherals, scanningEnabled: true);
  }

  Stream<PeripheralListState> _mapStopPeripheralScanToState(
      StopPeripheralScan event) async* {
    _cancelBlePeripheralSubscription();
    await _bleAdapter.stopPeripheralScan();
    yield PeripheralList(
        peripherals: state.peripherals, scanningEnabled: false);
  }

  Stream<PeripheralListState> _mapNewPeripheralScanToState(
      NewPeripheralScan event) async* {
    List<BlePeripheral> updatedPeripherals = state.peripherals;
    if (!updatedPeripherals.contains(event.peripheral)) {
      updatedPeripherals = List.from(state.peripherals);
      updatedPeripherals.add(event.peripheral);
    }
    yield PeripheralList(
        peripherals: updatedPeripherals,
        scanningEnabled: state.scanningEnabled);
  }

  Stream<PeripheralListState> _mapPickPeripheralToState(
      PickPeripheral event) async* {
    _blePeripheralRepository.blePeripheral = event.peripheral;
    yield NavigateToPeripheralDetails(
        peripherals: state.peripherals, scanningEnabled: state.scanningEnabled);
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
