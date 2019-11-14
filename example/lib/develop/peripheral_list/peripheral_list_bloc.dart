import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PeripheralListBloc extends Bloc<PeripheralListEvent, PeripheralListState> {
  // TODO: Get reference to DeviceRepository once it's implemented

  @override
  PeripheralListState get initialState => PeripheralListState([], false);

  @override
  Stream<PeripheralListState> mapEventToState(
    PeripheralListEvent event,
  ) async* {
    if (event is StartPeripheralScan) {
      // TODO: Logic to start scanning
    } else if (event is StopPeripheralScan) {
      // TODO: Logic to stop scanning
    } else if (event is PickPeripheral) {
      // TODO: Logic to pick a device
    } else if (event is ConnectToPeripheral) {
      // TODO: Logic to connect to device
    } else if (event is DisconnectFromPeripheral) {
      // TODO: Logic to disconnect from device
    }
  }
}
