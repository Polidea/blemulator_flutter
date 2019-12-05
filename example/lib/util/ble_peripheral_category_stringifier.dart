import 'package:blemulator_example/model/ble_peripheral.dart';

class BlePeripheralCategoryStringifier {
  static String name(BlePeripheralCategory category) {
    switch (category) {
      case BlePeripheralCategory.sensorTag:
        return 'SensorTag';
      case BlePeripheralCategory.other:
        return 'Other';
      default:
        return 'Unknown';
    }
  }
}