 import 'package:equatable/equatable.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class Pop extends NavigationEvent {}

class NavigateToPeripheralDetails extends NavigationEvent {
  final String peripheralIdentifier;

  const NavigateToPeripheralDetails({this.peripheralIdentifier});

  @override
  List<Object> get props => [peripheralIdentifier];
}