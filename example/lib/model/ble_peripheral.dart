import 'package:equatable/equatable.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';

class BlePeripheral extends Equatable {
  final String name;
  final String id;
  final int rssi;
  final PeripheralConnectionState connectionState;
  final BlePeripheralCategory category;

  BlePeripheral(
      this.name, this.id, this.rssi, this.connectionState, this.category);

  BlePeripheral copyWith(
      {String name,
      String id,
      int rssi,
      PeripheralConnectionState connectionState,
      BlePeripheralCategory category}) {
    return BlePeripheral(
      name ?? this.name,
      id ?? this.id,
      rssi ?? this.rssi,
      connectionState ?? this.connectionState,
      category ?? this.category,
    );
  }

  factory BlePeripheral.fromScanResult(ScanResult scanResult) {
    return BlePeripheral(
      scanResult.peripheral.name ??
          scanResult.advertisementData.localName ??
          'Unknown peripheral',
      scanResult.peripheral.identifier,
      scanResult.rssi,
      PeripheralConnectionState.disconnected,
      BlePeripheralCategoryResolver.categoryForName(scanResult.peripheral.name),
    );
  }

  @override
  List<Object> get props => [name, id, rssi, connectionState];
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
