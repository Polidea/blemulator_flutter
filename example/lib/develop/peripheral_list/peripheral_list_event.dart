import 'package:equatable/equatable.dart';

abstract class PeripheralListEvent extends Equatable {
  const PeripheralListEvent();
}

class StartScanning extends PeripheralListEvent {
  @override
  List<Object> get props => [];
}

class StopScanning extends PeripheralListEvent {
  @override
  List<Object> get props => [];
}

class PickDevice extends PeripheralListEvent {
  final String id;

  const PickDevice(this.id);

  @override
  List<Object> get props => [];
}

class ConnectToDevice extends PeripheralListEvent {
  final String id;

  const ConnectToDevice(this.id);

  @override
  List<Object> get props => [];
}

class DisconnectFromDevice extends PeripheralListEvent {
  final String id;

  const DisconnectFromDevice(this.id);

  @override
  List<Object> get props => [id];
}
