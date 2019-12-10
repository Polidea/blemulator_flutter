import 'package:blemulator_example/scan/scan_result_view_model.dart';
import 'package:equatable/equatable.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class Pop extends NavigationEvent {}

class NavigateToPeripheralDetails extends NavigationEvent {
  final ScanResultViewModel peripheral;

  const NavigateToPeripheralDetails({this.peripheral});

  @override
  List<Object> get props => [peripheral];
}