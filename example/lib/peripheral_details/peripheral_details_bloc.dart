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
      yield _mapServicesFetchedEventToState(event);
    } else if (event is ServiceViewExpandedEvent) {
      yield _mapServiceViewExpandedEventToState(event);
    }
  }

  PeripheralDetailsState _mapServicesFetchedEventToState(
    ServicesFetchedEvent event,
  ) {
    return PeripheralDetailsState(
      peripheral: state.peripheral,
      bleServiceStates: event.services
          .map((service) => BleServiceState(service, false))
          .toList(),
    );
  }

  PeripheralDetailsState _mapServiceViewExpandedEventToState(
    ServiceViewExpandedEvent event,
  ) {
    List<BleServiceState> newBleServiceStates =
        List.from(state.bleServiceStates);

    newBleServiceStates[event.index] =
        BleServiceState(state.bleServiceStates[event.index].service, !state.bleServiceStates[event.index].expanded);

    return PeripheralDetailsState(
      peripheral: state.peripheral,
      bleServiceStates: newBleServiceStates,
    );
  }
}
