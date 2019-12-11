import 'package:equatable/equatable.dart';

abstract class PeripheralDetailsEvent extends Equatable {
  const PeripheralDetailsEvent();
}

class RefreshPeripheral extends PeripheralDetailsEvent {
  @override
  List<Object> get props => [];
}
