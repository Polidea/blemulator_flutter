import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';

class PeripheralContainer extends Equatable {
  final Peripheral peripheral;
  final AdvertisementData advertisementData;

  PeripheralContainer({@required this.peripheral, @required this.advertisementData});

  @override
  List<Object> get props => [peripheral, advertisementData];
}
