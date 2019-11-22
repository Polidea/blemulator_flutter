import 'dart:async';
import 'package:blemulator_example/adapter/ble_adapter.dart';
import 'package:blemulator_example/repository/peripheral_repository.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PeripheralDetailsBloc
    extends Bloc<PeripheralDetailsEvent, PeripheralDetailsState> {
  BleAdapter _bleAdapter;
  BlePeripheralRepository _blePeripheralRepository;

  PeripheralDetailsBloc(this._bleAdapter, this._blePeripheralRepository);

  @override
  PeripheralDetailsState get initialState =>
      PeripheralDetailsState(peripheral: _blePeripheralRepository.blePeripheral);

  @override
  Stream<PeripheralDetailsState> mapEventToState(
    PeripheralDetailsEvent event,
  ) async* {}
}
