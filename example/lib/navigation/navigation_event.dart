 import 'package:blemulator_example/peripheral_details/peripheral_details_view_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class Pop extends NavigationEvent {}

class NavigateToPeripheralDetails extends NavigationEvent {
  final PeripheralDetailsViewModel peripheralDetails;

  const NavigateToPeripheralDetails({@required this.peripheralDetails});

  @override
  List<Object> get props => [peripheralDetails];
}