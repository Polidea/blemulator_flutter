abstract class PeripheralListEvent {
  const PeripheralListEvent();
}

class StartScanning extends PeripheralListEvent {}

class StopScanning extends PeripheralListEvent {}

class PickDevice extends PeripheralListEvent {
  final String id;

  const PickDevice(this.id);
}

class ConnectToDevice extends PeripheralListEvent {
  final String id;

  const ConnectToDevice(this.id);
}

class DisconnectFromDevice extends PeripheralListEvent {
  final String id;

  const DisconnectFromDevice(this.id);
}
