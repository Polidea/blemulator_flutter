import 'package:blemulator_example/peripheral_details/peripheral_info_view_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class PeripheralDetailsState extends Equatable {
  const PeripheralDetailsState();
}

class PeripheralNotAvailable extends PeripheralDetailsState {
  const PeripheralNotAvailable();

  @override
  List<Object> get props => [];
}

class PeripheralAvailable extends PeripheralDetailsState {
  final PeripheralInfoViewModel peripheralInfo;

  const PeripheralAvailable({@required this.peripheralInfo});

  @override
  List<Object> get props => [peripheralInfo];
}
