part of internal;

class CharacteristicResponse {
  SimulatedCharacteristic characteristic;
  Uint8List value;

  CharacteristicResponse(this.characteristic, this.value);
}

class DescriptorResponse {
  final String peripheralId;
  final SimulatedDescriptor descriptor;
  final Uint8List value;

  DescriptorResponse(this.peripheralId, this.descriptor, this.value);
}
