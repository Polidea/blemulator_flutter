import 'dart:typed_data';

import 'package:blemulator_example/model/ble_service.dart';

class SampleBleService extends BleService {
  SampleBleService({
    String uuid = 'F000AA00-0001-4000-B000-000000000000',
    List<BleCharacteristic> characteristics
  }) : super(uuid, characteristics) {
    characteristics ??= [SampleBleCharacteristic()];
  }
}

class SampleBleCharacteristic extends BleCharacteristic {
  SampleBleCharacteristic({
    String uuid = 'F000AA00-0001-4000-B000-000000000000',
    Uint8List value,
    bool isReadable = true,
    bool isWritableWithResponse = false,
    bool isWritableWithoutResponse = false,
    bool isNotifiable = false,
    bool isIndicatable = false
  }) : super(
      uuid,
      value,
      isReadable,
      isWritableWithResponse,
      isWritableWithoutResponse,
      isNotifiable,
      isIndicatable) {
    value ??= Uint8List(1);
  }
}