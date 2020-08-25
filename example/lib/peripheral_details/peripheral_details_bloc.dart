import 'dart:async';
import 'package:blemulator_example/adapter/ble_adapter.dart';
import 'package:blemulator_example/model/ble_peripheral.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';

class PeripheralDetailsBloc
    extends Bloc<PeripheralDetailsEvent, PeripheralDetailsState> {
  final BleAdapter _bleAdapter;
  final BlePeripheral _chosenPeripheral;

  PeripheralDetailsBloc(this._bleAdapter, this._chosenPeripheral) {
    try {
      //TODO check if device is connected
      _bleAdapter
          .discoverAndGetServicesCharacteristics(_chosenPeripheral.id)
          .then(
            (bleServices) {
          add(ServicesFetchedEvent(bleServices));
        },
      );
    } on BleError catch (e) {
      // TODO handle the error. To my knowledge only possible cause is either peripheral got disconnected or Bluetooth has been turned off,
      //  so it should be handled the same way as disconnection.
    }
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
          .map((service) => BleServiceState(service: service, expanded: false))
          .toList(),
    );
  }

  PeripheralDetailsState _mapServiceViewExpandedEventToState(
    ServiceViewExpandedEvent event,
  ) {
    var newBleServiceStates =
        List<BleServiceState>.from(state.bleServiceStates);

    newBleServiceStates[event.expandedViewIndex] =
        BleServiceState(service: state.bleServiceStates[event.expandedViewIndex].service, expanded: !state.bleServiceStates[event.expandedViewIndex].expanded);

    return PeripheralDetailsState(
      peripheral: state.peripheral,
      bleServiceStates: newBleServiceStates,
    );
  }
}
