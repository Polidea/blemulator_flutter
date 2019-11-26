import 'package:equatable/equatable.dart';

class BlePeripheral extends Equatable {
  final String name;
  final String id;
  final int rssi;
  final bool isConnected;

  BlePeripheralCategory get category {
    return KnownBlePeripheralCategory.isSensorTag(name) ? BlePeripheralCategory
        .sensorTag : BlePeripheralCategory.other;
  }

  BlePeripheral(this.name, this.id, this.rssi, this.isConnected);

  @override
  List<Object> get props => [name, id];
}

enum BlePeripheralCategory { sensorTag, other }

class KnownBlePeripheralCategory {
  static final String sensorTag = 'SensorTag';

  static bool isSensorTag(String blePeripheralName) {
    return blePeripheralName == sensorTag;
  }
}