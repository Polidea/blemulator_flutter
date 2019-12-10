part of internal;

class SimulationManager extends SimulationManagerBaseWithErrorChecks
    with
        ClientManagingMixin,
        CharacteristicsMixin,
        ErrorChecksMixin,
        PeripheralConnectionMixin,
        PeripheralScanningMixing,
        DiscoveryMixin,
        PeripheralRssiMixin,
        PeripheralMtuMixin {
  SimulationManager(DartToPlatformBridge bridge) : super(bridge);

  Map<String, CancelableOperation> _pendingTransactions = HashMap();

  Future<dynamic> handleCancelablePlatformCall(
      Future<dynamic> cancellablePlatformCallFuture,
      String transactionId) async {
    await cancelTransactionIfExists(transactionId);

    CancelableOperation operation = CancelableOperation.fromFuture(
        cancellablePlatformCallFuture, onCancel: () {
      return Future.error(SimulatedBleError(
        BleErrorCode.OperationCancelled,
        "Operation cancelled",
      ));
    });
    _pendingTransactions.putIfAbsent(transactionId, () => operation);

    return Future(() {
      return operation.valueOrCancellation().then(
        (result) {
          _pendingTransactions.remove(transactionId);
          return result;
        },
        onError: (error) {
          _pendingTransactions.remove(transactionId);
          return Future.error(error);
        },
      );
    });
  }

  void addSimulatedPeripheral(SimulatedPeripheral peripheral) {
    SimulatedPeripheral mapEntry =
        _peripherals.putIfAbsent(peripheral.id, () => peripheral);

    if (!identical(mapEntry, peripheral)) {
      print("Peripheral not added - there already"
          " exists a peripheral with the same id!");
    }
  }

  void removeAllSimulatedPeripherals() {
    _peripherals.clear();
    //TODO notify bridge?
  }

  Future<void> _createClient() async {}

  Future<void> _destroyClient() async {}

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

  Future<void> cancelTransactionIfExists(String transactionId) async {
    await _cancelMonitoringTransactionIfExists(transactionId);
    await _pendingTransactions.remove(transactionId)?.cancel()?.catchError(
        (error) {},
        test: (error) =>
            error is SimulatedBleError &&
            error.errorCode == BleErrorCode.OperationCancelled);
  }
}
