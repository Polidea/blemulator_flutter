import 'package:blemulator_example/scan/scan_result.dart';
import 'package:equatable/equatable.dart';

class ScanResultViewModel extends Equatable {
  final String name;
  final String identifier;
  final PeripheralCategory category;
  final RssiViewModel rssi;

  ScanResultViewModel(this.name, this.identifier, this.category, this.rssi);

  @override
  List<Object> get props => [name, identifier, category, rssi];
}

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
