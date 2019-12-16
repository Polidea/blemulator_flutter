import 'package:blemulator_example/model/ble_peripheral.dart';
import 'package:blemulator_example/styles/custom_colors.dart';
import 'package:blemulator_example/util/signal_level.dart';
import 'package:flutter/material.dart';

class ColorManager {
  static Color colorForPeripheral(
      BuildContext context, BlePeripheralCategory category) {
    if (category == BlePeripheralCategory.sensorTag) {
      return CustomColors.sensorTagRed;
    } else {
      return Theme.of(context).primaryColor;
    }
  }

  static Color colorForSignalLevel(SignalLevel signalLevel) {
    switch (signalLevel) {
      case SignalLevel.high:
        return Colors.green;
      case SignalLevel.medium:
        return Colors.orange;
      case SignalLevel.low:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
