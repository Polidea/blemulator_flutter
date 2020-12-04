part of internal;

mixin CharacteristicsMixin on SimulationManagerBaseWithErrorChecks {
  Future<SimulatedCharacteristic> _findCharacteristicForId(
      int characteristicIdentifier) async {
    SimulatedCharacteristic targetCharacteristic;

    for (var peripheral in _peripherals.values) {
      var characteristic =
          peripheral.characteristic(characteristicIdentifier);

      if (characteristic != null) {
        await _errorIfNotConnected(peripheral.id);
        targetCharacteristic = characteristic;
        break;
      }
    }

    return targetCharacteristic;
  }

  SimulatedCharacteristic _findCharacteristicForServiceId(
    int serviceIdentifier,
    String characteristicUuid,
  ) {
    for (var peripheral in _peripherals.values) {
      var characteristic =
          peripheral.service(serviceIdentifier)?.characteristics()?.firstWhere(
                (characteristic) => characteristic.uuid == characteristicUuid,
                orElse: () => null,
              );

      if (characteristic != null) {
        return characteristic;
      }
    }
    return null;
  }

  Future<CharacteristicResponse> _readCharacteristicForIdentifier(
    int characteristicIdentifier,
    String transactionId,
  ) =>
      _saveCancelableOperation(transactionId, () async {
        var peripheral =
            _findPeripheralWithCharacteristicId(characteristicIdentifier);
        await _errorIfPeripheralNull(peripheral);
        await _errorIfNotConnected(peripheral.id);
        await _errorIfDiscoveryNotDone(peripheral);

        var targetCharacteristic =
            await _findCharacteristicForId(characteristicIdentifier);

        await _errorIfCharacteristicIsNull(
            targetCharacteristic, characteristicIdentifier.toString());
        await _errorIfCharacteristicNotReadable(targetCharacteristic);
        var value = await targetCharacteristic.read();
        await _errorIfDisconnected(peripheral.id);
        return CharacteristicResponse(targetCharacteristic, value);
      });

  Future<CharacteristicResponse> _readCharacteristicForDevice(
    String peripheralId,
    String serviceUuid,
    String characteristicUUID,
    String transactionId,
  ) =>
      _saveCancelableOperation(transactionId, () async {
        await _errorIfNotConnected(peripheralId);
        var targetPeripheral = _peripherals[peripheralId];
        await _errorIfDiscoveryNotDone(targetPeripheral);

        var targetCharacteristic = targetPeripheral
            .getCharacteristicForService(serviceUuid, characteristicUUID);

        await _errorIfCharacteristicIsNull(
            targetCharacteristic, characteristicUUID);
        await _errorIfCharacteristicNotReadable(targetCharacteristic);
        var value = await targetCharacteristic.read();
        await _errorIfDisconnected(peripheralId);
        return CharacteristicResponse(targetCharacteristic, value);
      });

  Future<CharacteristicResponse> _readCharacteristicForService(
    int serviceIdentifier,
    String characteristicUUID,
    String transactionId,
  ) =>
      _saveCancelableOperation(transactionId, () async {
        var targetCharacteristic =
            _findCharacteristicForServiceId(
                serviceIdentifier, characteristicUUID);

        await _errorIfNotConnected(
            _findPeripheralWithServiceId(serviceIdentifier).id);

        await _errorIfDiscoveryNotDone(
            _findPeripheralWithServiceId(serviceIdentifier));

        await _errorIfCharacteristicIsNull(
            targetCharacteristic, characteristicUUID);

        await _errorIfCharacteristicNotReadable(targetCharacteristic);
        var value = await targetCharacteristic.read();
        await _errorIfDisconnected(
            _findPeripheralWithServiceId(serviceIdentifier).id);
        return CharacteristicResponse(targetCharacteristic, value);
      });

  Future<SimulatedCharacteristic> _writeCharacteristicForIdentifier(
    int characteristicIdentifier,
    Uint8List value,
    String transactionId, {
    bool withResponse = true,
  }) =>
      _saveCancelableOperation(transactionId, () async {
        var peripheral =
            _findPeripheralWithCharacteristicId(characteristicIdentifier);

        await _errorIfPeripheralNull(peripheral);
        await _errorIfNotConnected(peripheral.id);
        await _errorIfDiscoveryNotDone(peripheral);

        var targetCharacteristic =
            await _findCharacteristicForId(characteristicIdentifier);

        await _errorIfCharacteristicIsNull(
            targetCharacteristic, characteristicIdentifier.toString());
        if (withResponse) {
          await _errorIfCharacteristicNotWritableWithResponse(
              targetCharacteristic);
        } else {
          await _errorIfCharacteristicNotWritableWithoutResponse(
              targetCharacteristic);
        }
        await targetCharacteristic.write(value);
        await _errorIfDisconnected(peripheral.id);
        return targetCharacteristic;
      });

  Future<SimulatedCharacteristic> _writeCharacteristicForDevice(
    String peripheralId,
    String serviceUuid,
    String characteristicUUID,
    Uint8List value,
    String transactionId, {
    bool withResponse = true,
  }) =>
      _saveCancelableOperation(transactionId, () async {
        await _errorIfNotConnected(peripheralId);
        var targetPeripheral = _peripherals[peripheralId];
        await _errorIfDiscoveryNotDone(targetPeripheral);

        var targetCharacteristic = targetPeripheral
            .getCharacteristicForService(serviceUuid, characteristicUUID);

        await _errorIfCharacteristicIsNull(
            targetCharacteristic, characteristicUUID);
        if (withResponse) {
          await _errorIfCharacteristicNotWritableWithResponse(
              targetCharacteristic);
        } else {
          await _errorIfCharacteristicNotWritableWithoutResponse(
              targetCharacteristic);
        }
        await targetCharacteristic.write(value);
        await _errorIfDisconnected(peripheralId);
        return targetCharacteristic;
      });

  Future<SimulatedCharacteristic> _writeCharacteristicForService(
    int serviceIdentifier,
    String characteristicUUID,
    Uint8List value,
    String transactionId, {
    bool withResponse = true,
  }) =>
      _saveCancelableOperation(transactionId, () async {
        var targetCharacteristic =
            _findCharacteristicForServiceId(
                serviceIdentifier, characteristicUUID);

        await _errorIfCharacteristicIsNull(
            targetCharacteristic, characteristicUUID);
        await _errorIfNotConnected(
            _findPeripheralWithServiceId(serviceIdentifier).id);
        await _errorIfDiscoveryNotDone(
            _findPeripheralWithServiceId(serviceIdentifier));
        if (withResponse) {
          await _errorIfCharacteristicNotWritableWithResponse(
              targetCharacteristic);
        } else {
          await _errorIfCharacteristicNotWritableWithoutResponse(
              targetCharacteristic);
        }
        await targetCharacteristic.write(value);
        await _errorIfDisconnected(
            _findPeripheralWithServiceId(serviceIdentifier).id);
        return targetCharacteristic;
      });

  Future<void> _monitorCharacteristicForIdentifier(
    int characteristicIdentifier,
    String transactionId,
  ) async {
    var targetCharacteristic =
        await _findCharacteristicForId(characteristicIdentifier);

    await _errorIfCharacteristicIsNull(
        targetCharacteristic, characteristicIdentifier.toString());
    await _errorIfNotConnected(
        _findPeripheralWithCharacteristicId(characteristicIdentifier).id);
    await _errorIfDiscoveryNotDone(
        _findPeripheralWithCharacteristicId(characteristicIdentifier));
    await _errorIfCharacteristicNotNotifiable(targetCharacteristic);
    _monitoringSubscriptions.putIfAbsent(
      transactionId,
      () => _CharacteristicMonitoringSubscription(
        targetCharacteristic.id,
        targetCharacteristic.monitor().listen(
          (value) async {
            try {
              await _errorIfDisconnected(
                  _findPeripheralWithCharacteristicId(characteristicIdentifier)
                      .id);

              await _bridge.publishCharacteristicUpdate(
                _findPeripheralWithCharacteristicId(characteristicIdentifier)
                    .id,
                targetCharacteristic,
                value,
                transactionId,
              );
            } on SimulatedBleError catch (e) {
              await _bridge.publishCharacteristicMonitoringError(
                _findPeripheralWithCharacteristicId(characteristicIdentifier)
                    .id,
                characteristicIdentifier,
                e,
                transactionId,
              );

              await _monitoringSubscriptions[transactionId]
                  ?.subscription
                  ?.cancel();
              _monitoringSubscriptions.remove(transactionId);
            }
          },
          onError: (error) {
            _bridge.publishCharacteristicMonitoringError(
              _findPeripheralWithCharacteristicId(characteristicIdentifier).id,
              characteristicIdentifier,
              error,
              transactionId,
            );
          },
          cancelOnError: true,
        ),
      ),
    );
  }

  Future<void> _monitorCharacteristicForDevice(
    String peripheralId,
    String serviceUuid,
    String characteristicUUID,
    String transactionId,
  ) async {
    await _errorIfUnknown(peripheralId);
    await _errorIfNotConnected(peripheralId);
    var targetPeripheral = _peripherals[peripheralId];
    await _errorIfDiscoveryNotDone(targetPeripheral);

    var targetCharacteristic = targetPeripheral
        .getCharacteristicForService(serviceUuid, characteristicUUID);

    await _errorIfCharacteristicIsNull(
        targetCharacteristic, characteristicUUID);
    await _errorIfCharacteristicNotNotifiable(targetCharacteristic);
    _monitoringSubscriptions.putIfAbsent(
      transactionId,
      () => _CharacteristicMonitoringSubscription(
        targetCharacteristic.id,
        targetCharacteristic.monitor().listen(
          (value) async {
            try {
              await _errorIfDisconnected(peripheralId);

              await _bridge.publishCharacteristicUpdate(
                peripheralId,
                targetCharacteristic,
                value,
                transactionId,
              );
            } on SimulatedBleError catch (e) {
              await _bridge.publishCharacteristicMonitoringError(
                peripheralId,
                targetCharacteristic.id,
                e,
                transactionId,
              );

              await _monitoringSubscriptions[transactionId]
                  ?.subscription
                  ?.cancel();
              _monitoringSubscriptions.remove(transactionId);
            }
          },
          onError: (error) {
            _bridge.publishCharacteristicMonitoringError(
              peripheralId,
              targetCharacteristic.id,
              error,
              transactionId,
            );
          },
          cancelOnError: true,
        ),
      ),
    );
  }

  Future<void> _monitorCharacteristicForService(
    int serviceIdentifier,
    String characteristicUUID,
    String transactionId,
  ) async {
    var targetCharacteristic =
        _findCharacteristicForServiceId(serviceIdentifier, characteristicUUID);

    await _errorIfNotConnected(
        _findPeripheralWithServiceId(serviceIdentifier).id);
    await _errorIfDiscoveryNotDone(
        _findPeripheralWithServiceId(serviceIdentifier));
    await _errorIfCharacteristicIsNull(
        targetCharacteristic, characteristicUUID);
    await _errorIfCharacteristicNotNotifiable(targetCharacteristic);
    _monitoringSubscriptions.putIfAbsent(
      transactionId,
      () => _CharacteristicMonitoringSubscription(
        targetCharacteristic.id,
        targetCharacteristic.monitor().listen(
          (value) async {
            try {
              await _errorIfDisconnected(
                  _findPeripheralWithServiceId(serviceIdentifier).id);

              await _bridge.publishCharacteristicUpdate(
                _findPeripheralWithServiceId(serviceIdentifier).id,
                targetCharacteristic,
                value,
                transactionId,
              );
            } on SimulatedBleError catch (e) {
              await _bridge.publishCharacteristicMonitoringError(
                _findPeripheralWithServiceId(serviceIdentifier).id,
                targetCharacteristic.id,
                e,
                transactionId,
              );

              await _monitoringSubscriptions[transactionId]
                  ?.subscription
                  ?.cancel();
              _monitoringSubscriptions.remove(transactionId);
            }
          },
          onError: (error) {
            _bridge.publishCharacteristicMonitoringError(
              _findPeripheralWithServiceId(serviceIdentifier).id,
              targetCharacteristic.id,
              error,
              transactionId,
            );
          },
          cancelOnError: true,
        ),
      ),
    );
  }
}

class _CharacteristicMonitoringSubscription {
  int characteristicId;
  StreamSubscription subscription;

  _CharacteristicMonitoringSubscription(
      this.characteristicId, this.subscription);
}
