import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PeripheralListBloc extends Bloc<PeripheralListEvent, PeripheralListState> {
  // TODO: Get reference to DeviceRepository once it's implemented

  @override
  PeripheralListState get initialState => InitialPeripheralListState();

  @override
  Stream<PeripheralListState> mapEventToState(
    PeripheralListEvent event,
  ) async* {
    if (event is StartScanning) {
      // TODO: Logic to start scanning
      yield ScanningStarted();
    } else if (event is StopScanning) {
      // TODO: Logic to stop scanning
      yield ScanningStopped();
    } else if (event is PickDevice) {
      // TODO: Logic to pick a device
    } else if (event is ConnectToDevice) {
      // TODO: Logic to connect to device
    } else if (event is DisconnectFromDevice) {
      // TODO: Logic to disconnect from device
    }
  }
}
