import 'package:blemulator_example/peripheral_details/peripheral_info_view_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class PeripheralDetailsState extends Equatable {
  const PeripheralDetailsState();
}

class PeripheralNotFoundState extends PeripheralDetailsState {
  const PeripheralNotFoundState();

  @override
  List<Object> get props => [];
}

class PeripheralFoundState extends PeripheralDetailsState {
  final PeripheralInfoViewModel peripheralInfo;

  const PeripheralFoundState({@required this.peripheralInfo});

  @override
  List<Object> get props => [peripheralInfo];
}
