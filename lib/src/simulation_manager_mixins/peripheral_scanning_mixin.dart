part of internal;

mixin PeripheralScanningMixing on SimulationManagerBase {
  final List<StreamSubscription> _scanSubscriptions = [];

  Future<void> _startDeviceScan() async {
    _peripherals.values.forEach((peripheral) {
      _scanSubscriptions
          .add(peripheral.onScan(allowDuplicates: true).listen((scanResult) {
        return _bridge.publishScanResult(scanResult);
      }));
    });
  }

  Future<void> _stopDeviceScan() async {
    _scanSubscriptions
        .forEach((subscription) async => await subscription.cancel());
    _scanSubscriptions.clear();
  }
}
