import 'package:blemulator_example/model/ble_service.dart';
import 'package:equatable/equatable.dart';

abstract class PeripheralDetailsEvent extends Equatable {
  const PeripheralDetailsEvent();
}

class ServicesFetchedEvent extends PeripheralDetailsEvent {
  @override
  List<Object> get props => [services];

  final List<BleService> services;

  ServicesFetchedEvent(this.services);
}

class ServiceViewExpandedEvent extends PeripheralDetailsEvent {
  @override
  List<Object> get props => [index];

  final int index;

  ServiceViewExpandedEvent(this.index);
}
