part of internal;

typedef CancelableFuture<T> = Future<T> Function();

abstract class SimulationManagerBase {
  final Map<String, SimulatedPeripheral> _peripherals = {};
  final DartToPlatformBridge _bridge;
  final Map<String, CancelableOperation> _pendingTransactions = HashMap();
  final Map<String, _CharacteristicMonitoringSubscription> _monitoringSubscriptions =
      HashMap();

  SimulationManagerBase(this._bridge);

  Future<T> _saveCancelableOperation<T>(
    String transactionId,
    CancelableFuture<T> cancelableFuture,
  ) async {
    await cancelTransactionIfExists(transactionId);

    var operation =
        CancelableOperation<T>.fromFuture(cancelableFuture(), onCancel: () {
      return Future.error(SimulatedBleError(
        BleErrorCode.OperationCancelled,
        'Operation cancelled',
      ));
    });
    _pendingTransactions.putIfAbsent(transactionId, () => operation);

    return operation.valueOrCancellation().then(
      (result) {
        _pendingTransactions.remove(transactionId);
        return result;
      },
      onError: (error) {
        _pendingTransactions.remove(transactionId);
        throw error;
      },
    );
  }

  SimulatedPeripheral _findPeripheralWithServiceId(int id) =>
      _peripherals.values.firstWhere(
        (peripheral) => peripheral.hasService(id),
        orElse: () => null,
      );

  SimulatedPeripheral _findPeripheralWithCharacteristicId(int id) =>
      _peripherals.values.firstWhere(
        (peripheral) => peripheral.hasCharacteristic(id),
        orElse: () => null,
      );

  SimulatedPeripheral _findPeripheralWithDescriptorId(int id) =>
      _peripherals.values.firstWhere(
        (peripheral) => peripheral.hasDescriptor(id),
        orElse: () => null,
      );

  Future<void> cancelTransactionIfExists(String transactionId) async {
    await _cancelMonitoringTransactionIfExists(transactionId);
    await _pendingTransactions.remove(transactionId)?.cancel()?.catchError(
        (error) {},
        test: (error) =>
            error is SimulatedBleError &&
            error.errorCode == BleErrorCode.OperationCancelled);
  }

  Future<void> _cancelMonitoringTransactionIfExists(
      String transactionId) async {
    var subscription =
        _monitoringSubscriptions.remove(transactionId);
    if (subscription != null) {
      await subscription.subscription.cancel();
      await _bridge.publishCharacteristicMonitoringError(
        _findPeripheralWithCharacteristicId(subscription.characteristicId).id,
        subscription.characteristicId,
        SimulatedBleError(
          BleErrorCode.OperationCancelled,
          'Operation cancelled',
        ),
        transactionId,
      );
    }
  }
}

abstract class SimulationManagerBaseWithErrorChecks
    extends SimulationManagerBase with ErrorChecksMixin {
  SimulationManagerBaseWithErrorChecks(DartToPlatformBridge bridge)
      : super(bridge);
}
