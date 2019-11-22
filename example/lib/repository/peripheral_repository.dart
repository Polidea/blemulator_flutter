import 'package:blemulator_example/model/ble_peripheral.dart';

class BlePeripheralRepository {
  BlePeripheral blePeripheral;

  static BlePeripheralRepository _instance;

  factory BlePeripheralRepository() {
    if (_instance == null) {
      _instance = BlePeripheralRepository._internal();
    }
    return _instance;
  }

  BlePeripheralRepository._internal();
}
