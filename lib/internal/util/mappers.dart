part of internal;

Map<String, dynamic> mapToCharacteristicJson(
  String peripheralId,
  SimulatedCharacteristic characteristic,
  Uint8List value,
) =>
    <String, dynamic>{
      Metadata.deviceIdentifier: peripheralId,
      Metadata.characteristicId: characteristic.id,
      Metadata.characteristicUuid: characteristic.uuid,
      Metadata.value: value,
      Metadata.serviceUuid: characteristic.service.uuid,
      Metadata.serviceId: characteristic.service.id,
      Metadata.isReadable: characteristic.isReadable,
      Metadata.isWritableWithResponse: characteristic.isWritableWithResponse,
      Metadata.isWritableWithoutResponse:
          characteristic.isWritableWithoutResponse,
      Metadata.isNotifiable: characteristic.isNotifiable,
      Metadata.isNotifying: characteristic.isNotifying,
      Metadata.isIndicatable: characteristic.isIndicatable,
    };

Map<String, dynamic> mapToDescriptorJson(
  String peripheralId,
  SimulatedDescriptor descriptor, {
  Uint8List value,
}) =>
    <String, dynamic>{
      Metadata.deviceIdentifier: peripheralId,
      Metadata.serviceUuid: descriptor.characteristic.service.uuid,
      Metadata.serviceId: descriptor.characteristic.service.id,
      Metadata.characteristicUuid: descriptor.characteristic.uuid,
      Metadata.characteristicId: descriptor.characteristic.id,
      Metadata.descriptorUuid: descriptor.uuid,
      Metadata.descriptorId: descriptor.id,
      Metadata.value: value,
    };
