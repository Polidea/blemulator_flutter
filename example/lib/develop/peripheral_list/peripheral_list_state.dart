class PeripheralListState {
  final List<PeripheralInfo> peripherals;
  final bool isScanningEnabled;

  const PeripheralListState(this.peripherals, this.isScanningEnabled);
}

class PeripheralInfo {
  String name;
  String id;
  int rssi;
  bool isConnected;
}