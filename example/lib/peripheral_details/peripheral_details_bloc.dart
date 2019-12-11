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
    return _refreshStateFromAdapter();
  }

  @override
  Stream<PeripheralDetailsState> mapEventToState(
    PeripheralDetailsEvent event,
  ) async* {
    if (event is RefreshPeripheral) {
      yield _mapRefreshPeripheralToState(event);
    }
  }

  PeripheralDetailsState _mapRefreshPeripheralToState(RefreshPeripheral event) {
    return _refreshStateFromAdapter();
  }

  PeripheralDetailsState _refreshStateFromAdapter() {
    PeripheralInfo peripheralInfo =
    _bleAdapter.peripheralInfoForIdentifier(_peripheralIdentifier);
    return peripheralInfo != null
        ? PeripheralAvailable(peripheralInfo: peripheralInfo.viewModel())
        : PeripheralUnavailable(identifier: _peripheralIdentifier);
  }
}
