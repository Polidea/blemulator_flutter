import 'package:equatable/equatable.dart';

class BlePeripheral extends Equatable {
  final String name;
  final String id;
  final int rssi;
  final bool isConnected;
  final BlePeripheralCategory category;

  BlePeripheral(this.name, this.id, this.rssi, this.isConnected, this.category);

  @override
  List<Object> get props => [name, id];
}

enum BlePeripheralCategory { sensorTag, other }

class BlePeripheralCategoryResolver {
  static const String sensorTag = 'SensorTag';

  static BlePeripheralCategory categoryForName(String blePeripheralName) {
    return _isSensorTag(blePeripheralName)
        ? BlePeripheralCategory.sensorTag
        : BlePeripheralCategory.other;
  }

  static bool _isSensorTag(String blePeripheralName) {
    return blePeripheralName == sensorTag;
  }
}
