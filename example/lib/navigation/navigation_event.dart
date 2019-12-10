import 'package:blemulator_example/scan/scan_result_view_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class Pop extends NavigationEvent {}

class NavigateToPeripheralDetails extends NavigationEvent {
  final ScanResultViewModel scanResult;

  const NavigateToPeripheralDetails({@required this.scanResult});

  @override
  List<Object> get props => [scanResult];
}