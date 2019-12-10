import 'dart:async';
import 'package:blemulator_example/adapter/ble_adapter.dart';
import 'package:blemulator_example/peripheral_details/peripheral_details.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PeripheralDetailsBloc
    extends Bloc<PeripheralDetailsEvent, PeripheralDetailsState> {
  BleAdapter _bleAdapter;
  final PeripheralDetails _peripheralDetails;

  PeripheralDetailsBloc(this._bleAdapter, this._peripheralDetails);

  @override
  PeripheralDetailsState get initialState {
    return PeripheralDetailsState(
        peripheralDetails: _peripheralDetails.viewModel());
  }

  @override
  Stream<PeripheralDetailsState> mapEventToState(
    PeripheralDetailsEvent event,
  ) async* {}
}
