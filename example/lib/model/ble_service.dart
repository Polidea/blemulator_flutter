import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';

class BleService extends Equatable {
  final String uuid;
  final List<BleCharacteristic> characteristics;

  BleService(this.uuid, this.characteristics);

  @override
  List<Object> get props => [uuid, characteristics];
}

class BleCharacteristic extends Equatable {
  final String uuid;
  final Uint8List value;
  final bool isReadable;
  final bool isWritableWithResponse;
  final bool isWritableWithoutResponse;
  final bool isNotifiable;
  final bool isIndicatable;

  BleCharacteristic(
    this.uuid,
    this.value,
    this.isReadable,
    this.isWritableWithResponse,
    this.isWritableWithoutResponse,
    this.isNotifiable,
    this.isIndicatable,
  );

  @override
  List<Object> get props => [
        uuid,
        value,
        isReadable,
        isWritableWithResponse,
        isWritableWithoutResponse,
        isNotifiable,
        isIndicatable
      ];

  BleCharacteristic.fromCharacteristic(Characteristic characteristic)
      : uuid = characteristic.uuid,
        value = null,
        isReadable = characteristic.isReadable,
        isWritableWithResponse = characteristic.isWritableWithResponse,
        isWritableWithoutResponse = characteristic.isWritableWithoutResponse,
        isNotifiable = characteristic.isNotifiable,
        isIndicatable = characteristic.isIndicatable;
}
