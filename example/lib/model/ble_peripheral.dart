import 'package:equatable/equatable.dart';

class BlePeripheral extends Equatable {
  final String name;
  final String id;
  final int rssi;
  final bool isConnected;

  BlePeripheralCategory get category => _nameToCategory(name);

  BlePeripheral(this.name, this.id, this.rssi, this.isConnected);

  BlePeripheralCategory _nameToCategory(String name) {
    if (name == "SensorTag") {
      return BlePeripheralCategory.sensorTag;
    } else {
      return BlePeripheralCategory.other;
    }
  }

  @override
  List<Object> get props => [name, id];
}

enum BlePeripheralCategory { sensorTag, other }
