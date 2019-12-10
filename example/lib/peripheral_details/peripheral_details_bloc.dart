import 'dart:async';
import 'package:blemulator_example/adapter/ble_adapter.dart';
import 'package:blemulator_example/peripheral_details/peripheral_details_view_model.dart';
import 'package:blemulator_example/scan/scan_result.dart';
import 'package:blemulator_example/scan/scan_result_view_model.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PeripheralDetailsBloc
    extends Bloc<PeripheralDetailsEvent, PeripheralDetailsState> {
  BleAdapter _bleAdapter;
  final PeripheralDetailsViewModel _peripheralDetails;

  PeripheralDetailsBloc(this._bleAdapter, this._peripheralDetails);

  @override
  PeripheralDetailsState get initialState {
    return PeripheralDetailsState(peripheralDetails: _peripheralDetails);
  }

  @override
  Stream<PeripheralDetailsState> mapEventToState(
    PeripheralDetailsEvent event,
  ) async* {}
}
