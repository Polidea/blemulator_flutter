part of internal;

mixin DescriptorsMixin on SimulationManagerBaseWithErrorChecks {
  Future<DescriptorResponse> _readDescriptorForIdentifier(
    int descriptorIdentifier,
    String transactionId,
  ) =>
      _saveCancelableOperation(transactionId, () async {
        var peripheral =
            _findPeripheralWithDescriptorId(descriptorIdentifier);
        await _errorIfPeripheralNull(peripheral);
        await _errorIfNotConnected(peripheral.id);

        var descriptor =
            peripheral.descriptor(descriptorIdentifier);
        await _errorIfDescriptorNotFound(descriptor);
        await _errorIfDescriptorNotReadable(descriptor);

        var value = await descriptor.read();

        await _errorIfDisconnected(peripheral.id);

        return DescriptorResponse(peripheral.id, descriptor, value);
      });

  Future<DescriptorResponse> _readDescriptorForCharacteristic(
    int characteristicIdentifier,
    String descriptorUuid,
    String transactionId,
  ) =>
      _saveCancelableOperation(transactionId, () async {
        var peripheral =
            _findPeripheralWithCharacteristicId(characteristicIdentifier);
        await _errorIfPeripheralNull(peripheral);
        await _errorIfNotConnected(peripheral.id);

        var characteristic =
            peripheral.characteristic(characteristicIdentifier);

        await _errorIfCharacteristicIsNull(
          characteristic,
          characteristicIdentifier.toString(),
        );

        var descriptor =
            characteristic.descriptorByUuid(descriptorUuid);
        await _errorIfDescriptorNotFound(descriptor);
        await _errorIfDescriptorNotReadable(descriptor);

        var value = await descriptor.read();

        await _errorIfDisconnected(peripheral.id);

        return DescriptorResponse(peripheral.id, descriptor, value);
      });

  Future<DescriptorResponse> _readDescriptorForService(
    int serviceIdentifier,
    String characteristicUuid,
    String descriptorUuid,
    String transactionId,
  ) =>
      _saveCancelableOperation(transactionId, () async {
        var peripheral =
            _findPeripheralWithServiceId(serviceIdentifier);
        await _errorIfPeripheralNull(peripheral);
        await _errorIfNotConnected(peripheral.id);

        var service = peripheral.service(serviceIdentifier);

        var characteristic =
            service.characteristicByUuid(characteristicUuid);

        await _errorIfCharacteristicIsNull(
          characteristic,
          characteristicUuid,
        );

        var descriptor =
            characteristic.descriptorByUuid(descriptorUuid);

        await _errorIfDescriptorNotFound(descriptor);
        await _errorIfDescriptorNotReadable(descriptor);

        var value = await descriptor.read();

        await _errorIfDisconnected(peripheral.id);

        return DescriptorResponse(peripheral.id, descriptor, value);
      });

  Future<DescriptorResponse> _readDescriptorForDevice(
    String deviceIdentifier,
    String serviceUuid,
    String characteristicUuid,
    String descriptorUuid,
    String transactionId,
  ) =>
      _saveCancelableOperation(transactionId, () async {
        var peripheral = _peripherals[deviceIdentifier];
        await _errorIfPeripheralNull(peripheral);
        await _errorIfNotConnected(peripheral.id);

        var characteristic = peripheral
            .getCharacteristicForService(serviceUuid, characteristicUuid);

        await _errorIfCharacteristicIsNull(
          characteristic,
          characteristicUuid,
        );

        var descriptor =
            characteristic.descriptorByUuid(descriptorUuid);

        await _errorIfDescriptorNotFound(descriptor);
        await _errorIfDescriptorNotReadable(descriptor);

        var value = await descriptor.read();

        await _errorIfDisconnected(peripheral.id);

        return DescriptorResponse(peripheral.id, descriptor, value);
      });

  Future<DescriptorResponse> _writeDescriptorForIdentifier(
    int descriptorIdentifier,
    Uint8List value,
    String transactionId,
  ) =>
      _saveCancelableOperation(transactionId, () async {
        var peripheral =
            _findPeripheralWithDescriptorId(descriptorIdentifier);
        await _errorIfPeripheralNull(peripheral);
        await _errorIfNotConnected(peripheral.id);

        var descriptor =
            peripheral.descriptor(descriptorIdentifier);
        await _errorIfDescriptorNotFound(descriptor);
        await _errorIfDescriptorNotWritable(descriptor);

        await descriptor.write(value);

        await _errorIfDisconnected(peripheral.id);

        return DescriptorResponse(peripheral.id, descriptor, null);
      });

  Future<DescriptorResponse> _writeDescriptorForCharacteristic(
    int characteristicIdentifier,
    String descriptorUuid,
    Uint8List value,
    String transactionId,
  ) =>
      _saveCancelableOperation(transactionId, () async {
        var peripheral =
            _findPeripheralWithCharacteristicId(characteristicIdentifier);
        await _errorIfPeripheralNull(peripheral);
        await _errorIfNotConnected(peripheral.id);

        var characteristic =
            peripheral.characteristic(characteristicIdentifier);

        await _errorIfCharacteristicIsNull(
          characteristic,
          characteristicIdentifier.toString(),
        );

        var descriptor =
            characteristic.descriptorByUuid(descriptorUuid);

        await _errorIfDescriptorNotFound(descriptor);
        await _errorIfDescriptorNotWritable(descriptor);

        await descriptor.write(value);

        await _errorIfDisconnected(peripheral.id);

        return DescriptorResponse(peripheral.id, descriptor, null);
      });

  Future<DescriptorResponse> _writeDescriptorForService(
    int serviceIdentifier,
    String characteristicUuid,
    String descriptorUuid,
    Uint8List value,
    String transactionId,
  ) =>
      _saveCancelableOperation(transactionId, () async {
        var peripheral =
            _findPeripheralWithServiceId(serviceIdentifier);
        await _errorIfPeripheralNull(peripheral);
        await _errorIfNotConnected(peripheral.id);

        var service = peripheral.service(serviceIdentifier);

        var characteristic =
            service.characteristicByUuid(characteristicUuid);

        await _errorIfCharacteristicIsNull(
          characteristic,
          characteristicUuid,
        );

        var descriptor =
            characteristic.descriptorByUuid(descriptorUuid);

        await _errorIfDescriptorNotFound(descriptor);
        await _errorIfDescriptorNotWritable(descriptor);

        await descriptor.write(value);

        await _errorIfDisconnected(peripheral.id);

        return DescriptorResponse(peripheral.id, descriptor, null);
      });

  Future<DescriptorResponse> _writeDescriptorForDevice(
    String deviceIdentifier,
    String serviceUuid,
    String characteristicUuid,
    String descriptorUuid,
    Uint8List value,
    String transactionId,
  ) =>
      _saveCancelableOperation(transactionId, () async {
        var peripheral = _peripherals[deviceIdentifier];
        await _errorIfPeripheralNull(peripheral);
        await _errorIfNotConnected(peripheral.id);

        var characteristic = peripheral
            .getCharacteristicForService(serviceUuid, characteristicUuid);

        await _errorIfCharacteristicIsNull(
          characteristic,
          characteristicUuid,
        );

        var descriptor =
            characteristic.descriptorByUuid(descriptorUuid);

        await _errorIfDescriptorNotFound(descriptor);
        await _errorIfDescriptorNotWritable(descriptor);

        await descriptor.write(value);

        await _errorIfDisconnected(peripheral.id);

        return DescriptorResponse(peripheral.id, descriptor, null);
      });
}
