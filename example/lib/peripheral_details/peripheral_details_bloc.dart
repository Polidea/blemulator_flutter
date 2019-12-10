import 'dart:async';
import 'package:blemulator_example/adapter/ble_adapter.dart';
import 'package:blemulator_example/scan/scan_result.dart';
import 'package:blemulator_example/scan/scan_result_view_model.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PeripheralDetailsBloc
    extends Bloc<PeripheralDetailsEvent, PeripheralDetailsState> {
  BleAdapter _bleAdapter;
  final String _peripheralIdentifier;

  PeripheralDetailsBloc(this._bleAdapter, this._peripheralIdentifier);

  @override
  PeripheralDetailsState get initialState {
    final scanResult =
        _bleAdapter.scanResultForIdentifier(_peripheralIdentifier);
    return PeripheralDetailsState(
        name: scanResult.name,
        identifier: scanResult.identifier,
        category:
            PeripheralCategoryViewModel.fromCategory(scanResult.category));
  }

  @override
  Stream<PeripheralDetailsState> mapEventToState(
    PeripheralDetailsEvent event,
  ) async* {}
}
