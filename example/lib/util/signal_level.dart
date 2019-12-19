import 'package:flutter/material.dart';

enum SignalLevel { high, medium, low, unknown }

extension SignalLevelExtenstion on SignalLevel {
  Color color() {
    switch (this) {
      case SignalLevel.high:
        return Colors.green;
      case SignalLevel.medium:
        return Colors.orange;
      case SignalLevel.low:
        return Colors.red;
      case SignalLevel.unknown:
      default:
        return Colors.grey;
    }
  }
}

SignalLevel signalLevelForRssi(int rssi) {
  if (rssi == null) return SignalLevel.unknown;
  if (rssi > -60) {
    return SignalLevel.high;
  } else if (rssi > -90) {
    return SignalLevel.medium;
  } else {
    return SignalLevel.low;
  }
}