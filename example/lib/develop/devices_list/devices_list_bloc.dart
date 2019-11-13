import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class DevicesListBloc extends Bloc<DevicesListEvent, DevicesListState> {
  // TODO: Get reference to DeviceRepository once it's implemented

  @override
  DevicesListState get initialState => InitialDevicesListState();

  @override
  Stream<DevicesListState> mapEventToState(
    DevicesListEvent event,
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
