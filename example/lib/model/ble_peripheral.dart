import 'package:blemulator_example/styles/custom_colors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';

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

extension BlePeripheralCategoryExtenstion on BlePeripheralCategory {
  Color color(BuildContext context) {
    if (this == BlePeripheralCategory.sensorTag) {
      return CustomColors.sensorTagRed;
    } else {
      return Theme.of(context).primaryColor;
    }
  }
}

class BlePeripheralCategoryResolver {
  static const String sensorTag = 'SensorTag';

  static BlePeripheralCategory categoryForScanResult(ScanResult scanResult) {
    return _isSensorTag(scanResult.peripheral.name)
        ? BlePeripheralCategory.sensorTag
        : BlePeripheralCategory.other;
  }

  static bool _isSensorTag(String blePeripheralName) {
    return blePeripheralName == sensorTag;
  }
}
