import 'package:blemulator_example/util/signal_level.dart';
import 'package:flutter/material.dart';

class ColorManager {
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
