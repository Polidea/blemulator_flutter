abstract class PeripheralListEvent {
  const PeripheralListEvent();
}

class StartPeripheralScan extends PeripheralListEvent {}

class StopPeripheralScan extends PeripheralListEvent {}

class PickPeripheral extends PeripheralListEvent {
  final String id;

  const PickPeripheral(this.id);
}

class ConnectToPeripheral extends PeripheralListEvent {
  final String id;

  const ConnectToPeripheral(this.id);
}

class DisconnectFromPeripheral extends PeripheralListEvent {
  final String id;

  const DisconnectFromPeripheral(this.id);
}
