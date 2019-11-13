import 'package:equatable/equatable.dart';

abstract class DevicesListEvent extends Equatable {
  const DevicesListEvent();
}

class StartScanning extends DevicesListEvent {
  @override
  List<Object> get props => [];
}

class StopScanning extends DevicesListEvent {
  @override
  List<Object> get props => [];
}

class PickDevice extends DevicesListEvent {
  final String id;

  const PickDevice(this.id);

  @override
  List<Object> get props => [];
}

class ConnectToDevice extends DevicesListEvent {
  final String id;

  const ConnectToDevice(this.id);

  @override
  List<Object> get props => [];
}

class DisconnectFromDevice extends DevicesListEvent {
  final String id;

  const DisconnectFromDevice(this.id);

  @override
  List<Object> get props => [id];
}
