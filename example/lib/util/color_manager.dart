import 'package:blemulator_example/scan/scan_result.dart';
import 'package:blemulator_example/scan/scan_result_view_model.dart';
import 'package:blemulator_example/styles/custom_colors.dart';
import 'package:flutter/material.dart';

class ColorManager {
  static Color colorForPeripheral(BuildContext context, PeripheralCategory category) {
    if (category == PeripheralCategory.sensorTag) {
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