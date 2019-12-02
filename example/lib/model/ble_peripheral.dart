import 'package:equatable/equatable.dart';

class BlePeripheral extends Equatable {
  final String name;
  final String id;
  final int rssi;
  final bool isConnected;

  BlePeripheralCategory get category =>
      BlePeripheralCategoryResolver.categoryForName(name);

  BlePeripheral(this.name, this.id, this.rssi, this.isConnected);

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
