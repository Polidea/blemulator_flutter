part of internal;

mixin DescriptorsMixin on SimulationManagerBaseWithErrorChecks {
  Future<DescriptorResponse> _readDescriptorForIdentifier(
    int descriptorIdentifier,
    String transactionId,
  ) =>
      _saveCancelableOperation(transactionId, () async {
        SimulatedPeripheral peripheral =
            _findPeripheralWithDescriptorId(descriptorIdentifier);
        await _errorIfPeripheralNull(peripheral);
        await _errorIfNotConnected(peripheral.id);

        SimulatedDescriptor descriptor =
            peripheral.descriptor(descriptorIdentifier);
        await _errorIfDescriptorNotFound(descriptor);
        await _errorIfDescriptorNotReadable(descriptor);

        Uint8List value = await descriptor.read();

        await _errorIfDisconnected(peripheral.id);

        return DescriptorResponse(descriptor, value);
      });

  Future<DescriptorResponse> _readDescriptorForCharacteristic(
    int characteristicIdentifier,
    String descriptorUuid,
    String transactionId,
  ) =>
      _saveCancelableOperation(transactionId, () async {
        SimulatedPeripheral peripheral =
            _findPeripheralWithCharacteristicId(characteristicIdentifier);
        await _errorIfPeripheralNull(peripheral);
        await _errorIfNotConnected(peripheral.id);

        SimulatedCharacteristic characteristic =
            peripheral.characteristic(characteristicIdentifier);

        await _errorIfCharacteristicIsNull(
          characteristic,
          characteristicIdentifier.toString(),
        );

        SimulatedDescriptor descriptor =
            characteristic.descriptorByUuid(descriptorUuid);
        await _errorIfDescriptorNotFound(descriptor);
        await _errorIfDescriptorNotReadable(descriptor);

        Uint8List value = await descriptor.read();

        await _errorIfDisconnected(peripheral.id);

        return DescriptorResponse(descriptor, value);
      });

  Future<DescriptorResponse> _readDescriptorForService(
    int serviceIdentifier,
    String characteristicUuid,
    String descriptorUuid,
    String transactionId,
  ) =>
      _saveCancelableOperation(transactionId, () async {
        SimulatedPeripheral peripheral =
            _findPeripheralWithServiceId(serviceIdentifier);
        await _errorIfPeripheralNull(peripheral);
        await _errorIfNotConnected(peripheral.id);

        SimulatedService service = peripheral.service(serviceIdentifier);

        SimulatedCharacteristic characteristic =
            service.characteristicByUuid(characteristicUuid);

        await _errorIfCharacteristicIsNull(
          characteristic,
          characteristicUuid,
        );

        SimulatedDescriptor descriptor =
            characteristic.descriptorByUuid(descriptorUuid);

        await _errorIfDescriptorNotFound(descriptor);
        await _errorIfDescriptorNotReadable(descriptor);

        Uint8List value = await descriptor.read();

        await _errorIfDisconnected(peripheral.id);

        return DescriptorResponse(descriptor, value);
      });

  Future<DescriptorResponse> _readDescriptorForDevice(
    String deviceIdentifier,
    String serviceUuid,
    String characteristicUuid,
    String descriptorUuid,
    String transactionId,
  ) =>
      _saveCancelableOperation(transactionId, () async {
        SimulatedPeripheral peripheral = _peripherals[deviceIdentifier];
        await _errorIfPeripheralNull(peripheral);
        await _errorIfNotConnected(peripheral.id);

        SimulatedCharacteristic characteristic = peripheral
            .getCharacteristicForService(serviceUuid, characteristicUuid);

        await _errorIfCharacteristicIsNull(
          characteristic,
          characteristicUuid,
        );

        SimulatedDescriptor descriptor =
            characteristic.descriptorByUuid(descriptorUuid);

        await _errorIfDescriptorNotFound(descriptor);
        await _errorIfDescriptorNotReadable(descriptor);

        Uint8List value = await descriptor.read();

        await _errorIfDisconnected(peripheral.id);

        return DescriptorResponse(descriptor, value);
      });

  Future<SimulatedDescriptor> _writeDescriptorForIdentifier(
    int descriptorIdentifier,
    Uint8List value,
    String transactionId,
  ) =>
      _saveCancelableOperation(transactionId, () async {
        SimulatedPeripheral peripheral =
            _findPeripheralWithDescriptorId(descriptorIdentifier);
        await _errorIfPeripheralNull(peripheral);
        await _errorIfNotConnected(peripheral.id);

        SimulatedDescriptor descriptor =
            peripheral.descriptor(descriptorIdentifier);
        await _errorIfDescriptorNotFound(descriptor);
        await _errorIfDescriptorNotWritable(descriptor);

        await descriptor.write(value);

        await _errorIfDisconnected(peripheral.id);

        return descriptor;
      });

  Future<SimulatedDescriptor> _writeDescriptorForCharacteristic(
    int characteristicIdentifier,
    String descriptorUuid,
    Uint8List value,
    String transactionId,
  ) =>
      _saveCancelableOperation(transactionId, () async {
        SimulatedPeripheral peripheral =
            _findPeripheralWithCharacteristicId(characteristicIdentifier);
        await _errorIfPeripheralNull(peripheral);
        await _errorIfNotConnected(peripheral.id);

        SimulatedCharacteristic characteristic =
            peripheral.characteristic(characteristicIdentifier);

        await _errorIfCharacteristicIsNull(
          characteristic,
          characteristicIdentifier.toString(),
        );

        SimulatedDescriptor descriptor =
            characteristic.descriptorByUuid(descriptorUuid);

        await _errorIfDescriptorNotFound(descriptor);
        await _errorIfDescriptorNotWritable(descriptor);

        await descriptor.write(value);

        await _errorIfDisconnected(peripheral.id);

        return descriptor;
      });

  Future<SimulatedDescriptor> _writeDescriptorForService(
    int serviceIdentifier,
    String characteristicUuid,
    String descriptorUuid,
    Uint8List value,
    String transactionId,
  ) =>
      _saveCancelableOperation(transactionId, () async {
        SimulatedPeripheral peripheral =
            _findPeripheralWithServiceId(serviceIdentifier);
        await _errorIfPeripheralNull(peripheral);
        await _errorIfNotConnected(peripheral.id);

        SimulatedService service = peripheral.service(serviceIdentifier);

        SimulatedCharacteristic characteristic =
            service.characteristicByUuid(characteristicUuid);

        await _errorIfCharacteristicIsNull(
          characteristic,
          characteristicUuid,
        );

        SimulatedDescriptor descriptor =
            characteristic.descriptorByUuid(descriptorUuid);

        await _errorIfDescriptorNotFound(descriptor);
        await _errorIfDescriptorNotWritable(descriptor);

        await descriptor.write(value);

        await _errorIfDisconnected(peripheral.id);

        return descriptor;
      });

  Future<SimulatedDescriptor> _writeDescriptorForDevice(
    String deviceIdentifier,
    String serviceUuid,
    String characteristicUuid,
    String descriptorUuid,
    Uint8List value,
    String transactionId,
  ) =>
      _saveCancelableOperation(transactionId, () async {
        SimulatedPeripheral peripheral = _peripherals[deviceIdentifier];
        await _errorIfPeripheralNull(peripheral);
        await _errorIfNotConnected(peripheral.id);

        SimulatedCharacteristic characteristic = peripheral
            .getCharacteristicForService(serviceUuid, characteristicUuid);

        await _errorIfCharacteristicIsNull(
          characteristic,
          characteristicUuid,
        );

        SimulatedDescriptor descriptor =
            characteristic.descriptorByUuid(descriptorUuid);

        await _errorIfDescriptorNotFound(descriptor);
        await _errorIfDescriptorNotWritable(descriptor);

        await descriptor.write(value);

        await _errorIfDisconnected(peripheral.id);

        return descriptor;
      });
}
