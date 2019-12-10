import 'package:blemulator_example/scan/scan_result.dart';

class PeripheralCategoryResolver {
  static const String sensorTag = 'SensorTag';

  static PeripheralCategory categoryForPeripheralName(String peripheralName) {
    return _isSensorTag(peripheralName)
        ? PeripheralCategory.sensorTag
        : PeripheralCategory.other;
  }

  static bool _isSensorTag(String peripheralName) {
    return peripheralName == sensorTag;
  }
}