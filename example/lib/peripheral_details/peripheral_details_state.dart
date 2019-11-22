import 'package:equatable/equatable.dart';

abstract class PeripheralDetailsState extends Equatable {
  const PeripheralDetailsState();
}

class InitialPeripheralDetailsState extends PeripheralDetailsState {
  @override
  List<Object> get props => [];
}
