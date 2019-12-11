import 'dart:async';
import 'package:blemulator_example/adapter/ble_adapter.dart';
import 'package:blemulator_example/peripheral_details/peripheral_info.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PeripheralDetailsBloc
    extends Bloc<PeripheralDetailsEvent, PeripheralDetailsState> {
  BleAdapter _bleAdapter;
  final String _peripheralIdentifier;

  PeripheralDetailsBloc(this._bleAdapter, this._peripheralIdentifier);

  @override
  PeripheralDetailsState get initialState {
    PeripheralInfo peripheralInfo =
        _bleAdapter.peripheralDetailsForIdentifier(_peripheralIdentifier);
    return peripheralInfo != null
        ? PeripheralAvailable(peripheralInfo: peripheralInfo.viewModel())
        : PeripheralNotAvailable();
  }

  @override
  Stream<PeripheralDetailsState> mapEventToState(
    PeripheralDetailsEvent event,
  ) async* {}
}
