part of internal;

Map<String, dynamic> mapToCharacteristicJson(
  String peripheralId,
  SimulatedCharacteristic characteristic,
  Uint8List value, {
  bool serializeDescriptors = false,
}) {
  var characteristicMap = <String, dynamic>{
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
  if (serializeDescriptors) {
    characteristicMap.putIfAbsent(
      Metadata.descriptors,
      () => characteristic
          .descriptors()
          .map(
            (descriptor) => mapToDescriptorJson(
                DescriptorResponse(peripheralId, descriptor, null)),
          )
          .toList(),
    );
  }

  return characteristicMap;
}

Map<String, dynamic> mapToDescriptorJson(
  DescriptorResponse response,
) =>
    <String, dynamic>{
      Metadata.deviceIdentifier: response.peripheralId,
      Metadata.serviceUuid: response.descriptor.characteristic.service.uuid,
      Metadata.serviceId: response.descriptor.characteristic.service.id,
      Metadata.characteristicUuid: response.descriptor.characteristic.uuid,
      Metadata.characteristicId: response.descriptor.characteristic.id,
      Metadata.descriptorUuid: response.descriptor.uuid,
      Metadata.descriptorId: response.descriptor.id,
      Metadata.value: response.value,
    };
