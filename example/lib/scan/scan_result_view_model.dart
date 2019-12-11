import 'package:blemulator_example/scan/scan_result.dart';
import 'package:equatable/equatable.dart';

class ScanResultViewModel extends Equatable {
  final String name;
  final String identifier;
  final PeripheralCategoryViewModel category;
  final RssiViewModel rssi;

  ScanResultViewModel(this.name, this.identifier, this.category, this.rssi);

  @override
  List<Object> get props => [name, identifier, category, rssi];
}

class PeripheralCategoryViewModel extends Equatable {
  final String name;
  final PeripheralLayout peripheralLayout;

  PeripheralCategoryViewModel(this.name, this.peripheralLayout);

  @override
  List<Object> get props => [name, peripheralLayout];
}

String parsePeripheralCategory(PeripheralCategory category) {
  if (category == null) return 'Unknown';
  switch (category) {
    case PeripheralCategory.sensorTag:
      return 'SensorTag';
    case PeripheralCategory.other:
      return 'Peripheral';
    default:
      return 'Unknown';
  }
}

PeripheralLayout determinePeripheralLayout(PeripheralCategory category) {
  if (category == PeripheralCategory.sensorTag) {
    return PeripheralLayout.tabbed;
  } else {
    return PeripheralLayout.simple;
  }
}

enum PeripheralLayout { simple, tabbed }

class RssiViewModel extends Equatable {
  final String value;
  final SignalLevel signalLevel;

  RssiViewModel(this.value, this.signalLevel);

  @override
  List<Object> get props => [value, signalLevel];
}

enum SignalLevel { high, medium, low, unknown }

SignalLevel parseRssi(int rssi) {
  if (rssi == null) return SignalLevel.unknown;
  if (rssi > -60) {
    return SignalLevel.high;
  } else if (rssi > -90) {
    return SignalLevel.medium;
  } else {
    return SignalLevel.low;
  }
}
