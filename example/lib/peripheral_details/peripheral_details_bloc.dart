import 'dart:async';
import 'package:blemulator_example/adapter/ble_adapter.dart';
import 'package:blemulator_example/model/ble_peripheral.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PeripheralDetailsBloc
    extends Bloc<PeripheralDetailsEvent, PeripheralDetailsState> {
  BleAdapter _bleAdapter;
  final BlePeripheral _chosenPeripheral;

  PeripheralDetailsBloc(this._bleAdapter, this._chosenPeripheral) {
    _bleAdapter
        .discoverAndGetServicesCharacteristics(_chosenPeripheral.id)
        .then(
      (bleServices) {
        add(ServicesFetchedEvent(bleServices));
      },
    );
  }

  @override
  PeripheralDetailsState get initialState =>
      PeripheralDetailsState(peripheral: _chosenPeripheral);

  @override
  Stream<PeripheralDetailsState> mapEventToState(
    PeripheralDetailsEvent event,
  ) async* {
    if (event is ServicesFetchedEvent) {
      yield PeripheralDetailsState(
        peripheral: state.peripheral,
        bleServiceStates: event.services
            .map((service) => BleServiceState(service, false))
            .toList(),
      );
    } else if (event is ServiceViewExpandedEvent) {
      List<BleServiceState> newBleServiceStates =
          List.from(state.bleServiceStates);

      int serviceIndex =
          newBleServiceStates.indexOf(event.serviceStateToChange);
      newBleServiceStates[serviceIndex] =
          BleServiceState(event.serviceStateToChange.service, event.expanded);

      yield PeripheralDetailsState(
        peripheral: state.peripheral,
        bleServiceStates: newBleServiceStates,
      );
    }
  }
}
